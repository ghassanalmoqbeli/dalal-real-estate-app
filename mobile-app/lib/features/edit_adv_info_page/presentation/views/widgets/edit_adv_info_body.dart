import 'package:dallal_proj/core/components/app_bottom_sheets/log_required_b_s/show_log_required_b_s.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/entities/media_entity/media_entity.dart';
import 'package:dallal_proj/core/widgets/loadable_body.dart';
import 'package:dallal_proj/features/create_adv_page/presentation/views/widgets/cr_adv_helper.dart';
import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';
import 'package:dallal_proj/features/edit_adv_info_page/data/models/edit_advertisement_request_model.dart';
import 'package:dallal_proj/features/edit_adv_info_page/presentation/edit_ad_orcstr_cubit/edit_ad_orcstr_cubit.dart';
import 'package:dallal_proj/features/edit_adv_info_page/presentation/views/widgets/items/edit_adv_body_form.dart';
import 'package:dallal_proj/core/utils/functions/is_accessible_user.dart';
import 'package:dallal_proj/core/utils/functions/get_city_value.dart';
import 'package:dallal_proj/core/widgets/helpers/show_snack_bar.dart';
import 'package:dallal_proj/core/utils/functions/get_me_data.dart';
import 'package:dallal_proj/core/constants/app_defs.dart';
import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

class EditAdvBody extends StatefulWidget {
  const EditAdvBody({super.key, required this.detailsEntity});
  final ShowDetailsEntity detailsEntity;

  @override
  State<EditAdvBody> createState() => _EditAdvBodyState();
}

class _EditAdvBodyState extends State<EditAdvBody> {
  late ShowDetailsEntity _details;

  // Form key
  final GlobalKey<FormState> formKey = GlobalKey();

  // Radio options
  late ValueNotifier<String> selectedOpt; // Offer type
  late ValueNotifier<String> selectedOptB; // Negotiable

  // Track existing images (from server - URLs) and their IDs
  List<MediaEntity> _existingMedia = [];
  List<int> _mediaIdsToDelete = [];

  // Track new images (base64 strings to be uploaded)
  List<String> _newImagesBase64 = [];

  // Form fields - initialized from entity
  late String _advTitle;
  late String _city;
  late String _area;
  late String _locationText;
  late String _googleMapUrl;
  late String _floors;
  late String _price;
  late String _currency;
  late String _extraDetails;
  late String _rooms;
  late String _livingRooms;
  late String _bathrooms;
  late String _kitchens;
  double? _latitude;
  double? _longitude;

  @override
  void initState() {
    super.initState();
    _details = widget.detailsEntity;
    _initializeFromEntity();
  }

  void _initializeFromEntity() {
    // Initialize radio options based on entity
    selectedOpt = ValueNotifier(_details.offerType);
    selectedOptB = ValueNotifier(_details.isNegot ? kYes : kNo);

    // Initialize existing media
    _existingMedia = List.from(_details.imgs ?? []);

    // Initialize text fields from entity
    _advTitle = _details.titleDet;
    _city = _details.city;
    _area = _details.area;
    _locationText = _details.location;
    _googleMapUrl = _details.mapLink ?? '';
    _floors = _details.flrCount ?? '';
    _rooms = _details.romCount ?? '';
    _livingRooms = _details.halCount ?? '';
    _bathrooms = _details.bthCount ?? '';
    _kitchens = _details.kchCount ?? '';
    _extraDetails = _details.extraDetails ?? '';

    final priceParts = _details.priceDet.split(' ');
    _price = priceParts.isNotEmpty ? priceParts.last : '';
    _currency = priceParts.isNotEmpty ? priceParts.first : '';
  }

  @override
  void dispose() {
    selectedOpt.dispose();
    selectedOptB.dispose();
    super.dispose();
  }

  /// Called when user removes an existing image (from server)
  void _onExistingImageRemoved(int mediaId) {
    setState(() {
      _mediaIdsToDelete.add(mediaId);
      _existingMedia.removeWhere(
        (media) => int.tryParse(media.mediaId ?? '') == mediaId,
      );
    });
    log(
      'Marked media $mediaId for deletion. Total to delete: ${_mediaIdsToDelete.length}',
    );
  }

  /// Called when user picks new images
  void _onNewImagesChanged(List<String> base64Images) {
    setState(() {
      _newImagesBase64 = base64Images;
    });
    log('New images selected: ${base64Images.length}');
  }

  EditAdvertisementRequestModel? _createRequestModel() {
    var userData = getMeData();
    final userToken = userData!.uToken;

    int? parsedFloors;
    if (_floors.isNotEmpty) {
      parsedFloors = int.tryParse(_floors);
    }

    final isNegotiable = selectedOptB.value == kYes;

    return EditAdvertisementRequestModel(
      currentDetails: _details,
      userToken: userToken!,
      advertisementId: _details.advId,
      title: _advTitle,
      offerType: DictHelper.translate(kOTsRev, selectedOpt.value),
      city:
          _city.isEmpty ? DictHelper.translate(kOTsRev, _details.city) : _city,
      type: DictHelper.translate(kOTsRev, _details.sectionDet),
      locationText: _locationText,
      price: _price,
      currency: _currency.isEmpty ? 'YER' : _currency,
      negotiable: isNegotiable,
      area: _area,
      googleMapUrl: _googleMapUrl.isNotEmpty ? _googleMapUrl : null,
      extraDetails: _extraDetails.isNotEmpty ? _extraDetails : null,
      rooms: _rooms,
      livingRooms: _livingRooms,
      bathrooms: _bathrooms,
      kitchens: _kitchens,
      floors: parsedFloors,
      latitude: _latitude,
      longitude: _longitude,
    );
  }

  void _submitEdit() {
    if (!isAccessibleUser()) {
      showLoginRequiredBottomSheet(context);
      return;
    }

    if (!formKey.currentState!.validate()) {
      return;
    }

    if (_existingMedia.isEmpty && _newImagesBase64.isEmpty) {
      showAppSnackBar(
        context,
        message: 'يجب إضافة صورة واحدة على الأقل',
        backgroundColor: Colors.red,
      );
      return;
    }

    final reqModel = _createRequestModel();
    if (reqModel == null) return;

    var userData = getMeData();
    final userToken = userData!.uToken!;

    log('Submitting edit:');
    log('- Media to delete: $_mediaIdsToDelete');
    log('- New images count: ${_newImagesBase64.length}');
    log('- Request: ${reqModel.toJson()}');

    BlocProvider.of<EditAdOrcstrCubit>(context).editAdWithMedia(
      request: reqModel,
      mediaIdsToDelete: _mediaIdsToDelete,
      newMediaBase64List: _newImagesBase64,
      token: userToken,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double textFwidth = (Funcs.respInfWp(50, context) / 2);
    final double adrFwidth = Funcs.respInfWp(40, context);
    final double sectFwidth = (Funcs.respInfWp(70, context) / 4);

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: BlocConsumer<EditAdOrcstrCubit, EditAdOrcstrState>(
            listener: (context, state) {
              if (state is EditAdOrcstrSuccess) {
                GoRouter.of(context).pop(true);
              } else if (state is EditAdOrcstrPartialSuccess) {
                GoRouter.of(context).pop(true);
                showAppSnackBar(
                  context,
                  message: state.message,
                  backgroundColor: Colors.orange,
                );
              } else if (state is EditAdOrcstrFailure) {
                showAppSnackBar(
                  context,
                  message: 'فشل التحديث: ${state.error}',
                  backgroundColor: Colors.red,
                );
              }
            },
            builder:
                (context, state) => LoadableBody(
                  loadableChild:
                      state is EditAdOrcstrLoading
                          ? _buildProgressIndicator(state)
                          : null,
                  isLoading: state is EditAdOrcstrLoading,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 40,
                    ),
                    child: Form(
                      key: formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: EditAdvBodyForm(
                        // Initial values from entity
                        initialTitle: _details.titleDet,
                        initialCity: DictHelper.translate(
                          kOTsRev,
                          _details.city,
                        ),
                        initialArea: _details.area,
                        initialLocation: _details.location,
                        initialMapLink: _details.mapLink ?? '',
                        initialFloors: _details.flrCount ?? '',
                        initialRooms: _details.romCount ?? '',
                        initialLivingRooms: _details.halCount ?? '',
                        initialBathrooms: _details.bthCount ?? '',
                        initialKitchens: _details.kchCount ?? '',
                        initialPrice: _price,
                        initialCurrency: _currency,
                        initialExtraDetails: _details.extraDetails ?? '',
                        // Existing media
                        existingMedia: _existingMedia,
                        onExistingImageRemoved: _onExistingImageRemoved,
                        // New images
                        onNewImagesChanged: _onNewImagesChanged,
                        // Form callbacks
                        adrOnChange: (value) {
                          setState(() => _advTitle = value);
                        },
                        adrFwidth: adrFwidth,
                        ctOnSelected: (value) {
                          setState(() => _city = value ?? _details.city);
                        },
                        areaOnChange: (value) {
                          setState(() => _area = value);
                        },
                        textFwidth: textFwidth,
                        locOnChange: (value) {
                          setState(() => _locationText = value);
                        },
                        mapOnChange: (value) {
                          setState(() => _googleMapUrl = value);
                        },
                        gglOnTap: () {},
                        selectedOpt: selectedOpt,
                        offerOnTapped: (value) => selectedOpt.value = value,
                        flrsOnChange: (value) {
                          setState(() => _floors = value);
                        },
                        onBathroomsChanged: (value) {
                          setState(() => _bathrooms = value);
                        },
                        onKitchensChanged: (value) {
                          setState(() => _kitchens = value);
                        },
                        onLivingRoomsChanged: (value) {
                          setState(() => _livingRooms = value);
                        },
                        onRoomsChanged: (value) {
                          setState(() => _rooms = value);
                        },
                        title: CrAdvHelper.getLastWord(_details.sectionDet),
                        sectFwidth: sectFwidth,
                        crnOnSelected: (value) {
                          setState(() {
                            _currency =
                                value == null || value.isEmpty ? 'YER' : value;
                          });
                        },
                        priceOnChanged: (value) {
                          setState(() => _price = value);
                        },
                        selectedOptB: selectedOptB,
                        negotOnTapped: (value) => selectedOptB.value = value,
                        mdetsOnChanged: (value) {
                          setState(() => _extraDetails = value);
                        },
                        updateOnPressed: _submitEdit,
                      ),
                    ),
                  ),
                ),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressIndicator(EditAdOrcstrLoading state) {
    return Positioned.fill(
      child: Container(
        color: Colors.black26,
        child: Center(
          child: Card(
            margin: const EdgeInsets.all(32),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LinearProgressIndicator(
                    color: kPrimColG,
                    value:
                        state.totalMedia > 0
                            ? (state.currentMedia) / state.totalMedia
                            : null,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.step,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (state.totalMedia > 0) ...[
                    const SizedBox(height: 8),
                    Text(
                      '${state.currentMedia}/${state.totalMedia}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
