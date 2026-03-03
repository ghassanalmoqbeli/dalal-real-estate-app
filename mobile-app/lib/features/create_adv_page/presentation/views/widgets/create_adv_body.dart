import 'package:dallal_proj/core/components/app_bottom_sheets/bottom_sheet_holder.dart';
import 'package:dallal_proj/core/components/app_bottom_sheets/filter_b_s/filter_funcs.dart';
import 'package:dallal_proj/core/components/app_bottom_sheets/log_required_b_s/show_log_required_b_s.dart';
import 'package:dallal_proj/core/widgets/loadable_body.dart';
import 'package:dallal_proj/features/ai_price_prediction/presentation/views/widgets/dynamic_ai_form.dart';
import 'package:dallal_proj/features/create_adv_page/data/models/cr_adv_req_model.dart';
import 'package:dallal_proj/features/create_adv_page/presentation/manager/create_ad_orcstr/create_ad_orcstr_cubit.dart';
import 'package:dallal_proj/features/create_adv_page/presentation/views/widgets/cr_adv_helper.dart';
import 'package:dallal_proj/features/create_adv_page/presentation/views/widgets/items/cr_adv_body_form.dart';
import 'package:dallal_proj/core/utils/functions/is_accessible_user.dart';
import 'package:dallal_proj/core/utils/functions/get_city_value.dart';
import 'package:dallal_proj/core/widgets/helpers/show_snack_bar.dart';
import 'package:dallal_proj/core/utils/functions/get_me_data.dart';
import 'package:dallal_proj/core/constants/app_defs.dart';
import 'package:dallal_proj/core/utils/app_router.dart';
import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

class CrAdvBody extends StatefulWidget {
  const CrAdvBody({super.key, required this.title});
  final String title;

  @override
  State<CrAdvBody> createState() => _CrAdvBodyState();
}

class _CrAdvBodyState extends State<CrAdvBody> {
  late String title;
  final ValueNotifier<String> selectedOpt = ValueNotifier(kDefOfferOpt);
  final ValueNotifier<String> selectedOptB = ValueNotifier(kDefNegotOpt);
  final GlobalKey<FormState> formKey = GlobalKey();
  List<String> _selectedImagesBase64 = [];
  late String _type;

  String _advTitle = '';
  String _city = '';
  String _area = '';
  String _locationText = '';
  String _googleMapUrl = '';
  String _floors = '';
  String _partsString = '';
  String _price = '';
  String _currency = '';
  String _extraDetails = '';
  double? _latitude;
  double? _longitude;
  String _rooms = '';
  String _livingRooms = '';
  String _bathrooms = '';
  String _kitchens = '';

  @override
  void dispose() {
    selectedOpt.dispose();
    selectedOptB.dispose();
    super.dispose();
  }

  @override
  void initState() {
    title = CrAdvHelper.getLastWord(widget.title);
    _type = DictHelper.translate(
      kOTsRev,
      CrAdvHelper.getLastWord(widget.title),
    );
    super.initState();
  }

  void _onImagesChanged(List<String> base64Images) {
    setState(() {
      _selectedImagesBase64 = base64Images;
    });

    // Here you can:
    // 1. Store in your request model
    // 2. Validate if needed
    // 3. Prepare for API submission

    log('Number of images selected: ${base64Images.length}');
    if (base64Images.isNotEmpty) {
      log('First image base64 length: ${base64Images[0].length}');
    }
  }

  AdvertisementRequestModel? _createRequestModel() {
    var userData = getMeData();
    final userToken = userData!.uToken;

    int? parsedFloors;
    if (_floors.isNotEmpty) {
      parsedFloors = int.tryParse(_floors);
    }

    final isNegotiable = selectedOptB.value == 'نعم';

    // Create the model
    return AdvertisementRequestModel(
      userToken: userToken!,
      imagesBase64: _selectedImagesBase64,
      title: _advTitle,
      offerType: DictHelper.translate(kOTsRev, selectedOpt.value),
      city: _city.isEmpty ? 'sanaa' : _city,
      type: _type,
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

  @override
  Widget build(BuildContext context) {
    final double textFwidth = (Funcs.respInfWp(50, context) / 2);
    final double adrFwidth = Funcs.respInfWp(40, context);
    final double sectFwidth = (Funcs.respInfWp(70, context) / 4);

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: BlocConsumer<CreateAdOrcstrCubit, CreateAdOrcstrState>(
            listener: (context, state) {
              if (state is CreateAdOrcstrSuccess) {
                GoRouter.of(context).push(AppRouter.kAdvHasBeenSentPage);
              } else if (state is CreateAdOrcstrPartialSuccess) {
                GoRouter.of(context).push(AppRouter.kAdvHasBeenSentPage);
                showAppSnackBar(
                  context,
                  message:
                      'تم إنشاء الإعلان بنجاح جزئيا. قد تكون هنالك مشكلة ما بالوسائط',
                  backgroundColor: kPrimColO,
                );
              }
              if (state is CreateAdOrcstrFailure) {
                showAppSnackBar(
                  context,
                  message: 'فشل إنشاء الإعلان: ${state.error}',
                );
              }
            },
            builder:
                (context, state) => LoadableBody(
                  loadableChild:
                      state is CreateAdOrcstrLoading
                          ? _buildProgressIndicator(state)
                          : null,
                  isLoading: state is CreateAdOrcstrLoading,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 40,
                    ),
                    child: Form(
                      key: formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: CrAdvBodyForm(
                        imgOnTap: () {},
                        adrOnChange: (value) {
                          setState(() {
                            _advTitle = value;
                          });
                        },
                        adrFwidth: adrFwidth,
                        ctOnSelected: (value) {
                          setState(() {
                            _city = value ?? '';
                          });
                        },
                        areaOnChange: (value) {
                          setState(() {
                            _area = value;
                          });
                        },
                        textFwidth: textFwidth,
                        locOnChange: (value) {
                          setState(() {
                            _locationText = value;
                          });
                        },
                        mapOnChange: (value) {
                          setState(() {
                            _googleMapUrl = value;
                          });
                        },
                        gglOnTap: () {},
                        selectedOpt: selectedOpt,
                        offerOnTapped: (value) => selectedOpt.value = value,
                        flrsOnChange: (value) {
                          setState(() {
                            _floors = value;
                          });
                        },
                        onBathroomsChanged: (value) {
                          setState(() {
                            _bathrooms = value;
                          });
                        },
                        onKichensChanged: (value) {
                          setState(() {
                            _kitchens = value;
                          });
                        },
                        onLivingroomsChanged: (value) {
                          setState(() {
                            _livingRooms = value;
                          });
                        },
                        onRoomsChanged: (value) {
                          setState(() {
                            _rooms = value;
                          });
                        },
                        popOnCompleted: (value) {
                          setState(() {
                            _partsString = value;
                          });
                        },
                        title: title,
                        sectFwidth: sectFwidth,
                        crnOnSelected: (value) {
                          setState(() {
                            _currency =
                                value == null || value.isEmpty ? 'YER' : value;
                          });
                        },
                        priceOnChanged: (value) {
                          setState(() {
                            _price = value;
                          });
                        },
                        selectedOptB: selectedOptB,
                        negotOnTapped: (value) => selectedOptB.value = value,
                        mdetsOnChanged: (value) {
                          setState(() {
                            _extraDetails = value;
                          });
                        },
                        aiOnpressed: () {
                          if (isAccessibleUser()) {
                            if (formKey.currentState!.validate()) {
                              // Prepare data for AI prediction
                              final cityForAi = _city.isEmpty ? 'Sanaa' : _city;
                              final areaNameForAi = _locationText;
                              final propertyTypeForAi = _type;
                              final dealTypeForAi = DictHelper.translate(
                                kOTsRev,
                                selectedOpt.value,
                              );
                              final areaM2ForAi = int.tryParse(_area) ?? 100;
                              // Set defaults based on property type
                              final isLand = propertyTypeForAi == 'land';
                              final isShop = propertyTypeForAi == 'shop';
                              final roomsForAi =
                                  isLand || isShop
                                      ? 0
                                      : (int.tryParse(_rooms) ?? 1);
                              final bathsForAi =
                                  isLand || isShop
                                      ? 0
                                      : (int.tryParse(_bathrooms) ?? 1);
                              final floorsForAi =
                                  isLand ? 0 : (int.tryParse(_floors) ?? 1);
                              final currencyForAi =
                                  _currency.isEmpty ? 'YER' : _currency;

                              log('🤖 AI Prediction Request:');
                              log('City: $cityForAi');
                              log('Area Name: $areaNameForAi');
                              log('Property Type: $propertyTypeForAi');
                              log('Deal Type: $dealTypeForAi');
                              log('Area M2: $areaM2ForAi');
                              log('Rooms: $roomsForAi');
                              log('Baths: $bathsForAi');
                              log('Floors: $floorsForAi');
                              log('Currency: $currencyForAi');

                              Fltr.callBottomSheet(
                                context,
                                child: BSFormHolder(
                                  form: DynamicAIForm(
                                    city: cityForAi,
                                    areaName: areaNameForAi,
                                    propertyType: propertyTypeForAi,
                                    dealType: dealTypeForAi,
                                    areaM2: areaM2ForAi,
                                    rooms: roomsForAi,
                                    baths: bathsForAi,
                                    floors: floorsForAi,
                                    currency: currencyForAi,
                                  ),
                                ),
                              );
                            }
                          } else {
                            showLoginRequiredBottomSheet(context);
                          }
                        },
                        postOnpressed: () {
                          if (isAccessibleUser()) {
                            if (formKey.currentState!.validate()) {
                              // Validate at least one image exists
                              if (_selectedImagesBase64.isEmpty) {
                                showAppSnackBar(
                                  context,
                                  message: 'يجب إضافة صورة واحدة على الأقل',
                                  backgroundColor: Colors.red,
                                );
                                return;
                              }
                              // Now you have _selectedImagesBase64 ready for your API
                              log(
                                'Posting with ${_selectedImagesBase64.length} images',
                              );
                              final reqModel = _createRequestModel();
                              log(
                                'request model is here : ${reqModel!.toJson()}',
                              );
                              BlocProvider.of<CreateAdOrcstrCubit>(
                                context,
                              ).createAdWithMedia(reqModel);
                            }
                          } else {
                            showLoginRequiredBottomSheet(context);
                          }
                        },
                        onImagesChanged: _onImagesChanged,
                      ),
                    ),
                  ),
                ),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressIndicator(CreateAdOrcstrLoading state) {
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
