import 'dart:developer';

import 'package:dallal_proj/core/components/app_btns/col_btn.dart';
import 'package:dallal_proj/core/utils/functions/get_me_data.dart';
import 'package:dallal_proj/core/widgets/custom_app_bar.dart';
import 'package:dallal_proj/core/widgets/helpers/lan_detector.dart';
import 'package:dallal_proj/core/widgets/helpers/show_snack_bar.dart';
import 'package:dallal_proj/core/widgets/loadable_body.dart';
import 'package:dallal_proj/core/widgets/page_padding.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/v_p_item.dart';
import 'package:dallal_proj/features/edit_personal_info/presentation/manager/edit_personal_info_cubit/edit_personal_info_cubit.dart';
import 'package:dallal_proj/features/login_page/data/models/set_profile_req_model.dart';
import 'package:dallal_proj/features/login_page/domain/entities/loggedin_user_entity.dart';
import 'package:dallal_proj/features/login_page/presentation/views/add_profile_item.dart.dart';
import 'package:dallal_proj/features/register_page/presentation/views/widgets/register_body_items/register_full_name_input.dart';
import 'package:dallal_proj/features/register_page/presentation/views/widgets/register_body_items/register_phone_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditPersonalInfoPage extends StatelessWidget {
  const EditPersonalInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackButton: true,
        title: 'تعديل البيانات الشخصية',
      ),
      body: PagePadding(
        child: BlocConsumer<EditPersonalInfoCubit, EditPersonalInfoState>(
          listener: (context, state) {
            if (state is EditPersonalInfoFailure) {
              showAppSnackBar(context, message: state.errMsg);
            }
            if (state is EditPersonalInfoSuccess) {
              Navigator.of(context).pop(true);
            }
          },
          builder: (context, state) {
            return LoadableBody(
              isLoading: state is EditPersonalInfoLoading,
              child: const EditPersonalInfoBody(),
            );
          },
        ),
      ),
    );
  }
}

class EditPersonalInfoBody extends StatefulWidget {
  const EditPersonalInfoBody({super.key});

  @override
  State<EditPersonalInfoBody> createState() => _EditPersonalInfoBodyState();
}

class _EditPersonalInfoBodyState extends State<EditPersonalInfoBody> {
  final GlobalKey<FormState> formKey = GlobalKey();

  final LoggedinUserEntity? _user = getMeData();
  late TextDirection _fnameDir;
  late TextAlign _fnameAl;

  String? _base64Image = '';
  String? _userName = '';
  String? _whatsapp = '';
  TextEditingController? _nameController;
  TextEditingController? _whatsappController;

  @override
  initState() {
    super.initState();
    _fnameDir = TextDirection.rtl;
    _fnameAl = TextAlign.right;
    _userName = _user!.uName;
    _whatsapp = _user.uWhatsapp;
    _base64Image = _user.uProfileImage;
    _nameController = TextEditingController(text: _userName);
    _whatsappController = TextEditingController(text: _whatsapp);
  }

  @override
  dispose() {
    _nameController?.dispose();
    _whatsappController?.dispose();
    super.dispose();
  }

  _setImage(String? base64Image) {
    setState(() {
      _base64Image = base64Image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            VPItem(
              tSpc: 20,
              bSpc: 40,
              child: AddProfileItem(
                size: 200,
                initialImageUrl: _user?.uProfileImage,
                onImageChanged: (base64Image) {
                  _setImage(base64Image);
                  log(
                    'Profile image selected: ${base64Image?.substring(0, 20)}...',
                  );
                },
              ),
            ),
            VPItem(
              tSpc: 0,
              bSpc: 0,
              child: RegisterFullNameInput(
                controller: _nameController,
                onChanged: (value) {
                  _fnameDir = LanDetector.detectDir(text: value);
                  _fnameAl = LanDetector.detectAlign(text: value);
                  _userName = value;
                  setState(() {}); // fine here, inside input callback
                },
                tAln: _fnameAl,
                tDir: _fnameDir,
              ),
            ),
            VPItem(
              bSpc: 40,
              child: RegisterPhoneInput(
                onChanged: (number) => _whatsapp = number,
                phoneController: _whatsappController!,
              ),
            ),
            VPItem(
              bSpc: 40,
              child: ColBtn(
                txt: 'حفظ التعديلات',
                onPressed: () {
                  BlocProvider.of<EditPersonalInfoCubit>(
                    context,
                  ).editPersonalInfo(
                    UserProfileModel(
                      name: _userName,
                      profileImage: _base64Image,
                      whatsapp: _whatsapp,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
