import 'package:dallal_proj/core/constants/app_defs.dart';
import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/widgets/helpers/lan_detector.dart';
import 'package:dallal_proj/core/widgets/helpers/show_snack_bar.dart';
import 'package:dallal_proj/core/widgets/helpers/widgets_helper.dart';
import 'package:dallal_proj/features/register_page/data/models/register_model.dart';
import 'package:dallal_proj/features/register_page/presentation/manager/register_user_cubit/register_user_cubit.dart';
import 'package:dallal_proj/temp_try.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:dallal_proj/core/utils/app_router.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/v_p_item.dart';
import 'package:dallal_proj/features/preregister/presentation/views/widgets/register_btn.dart';
import 'package:dallal_proj/features/register_page/presentation/views/widgets/reg_to_log_leading_line.dart';
import 'package:dallal_proj/features/register_page/presentation/views/widgets/register_body_items/register_date_picker.dart';
import 'package:dallal_proj/features/register_page/presentation/views/widgets/register_body_items/register_full_name_input.dart';
import 'package:dallal_proj/features/register_page/presentation/views/widgets/register_body_items/register_pass_input.dart';
import 'package:dallal_proj/features/register_page/presentation/views/widgets/register_body_items/register_phone_input.dart';
import 'package:dallal_proj/features/register_page/presentation/views/widgets/register_body_items/register_radio_form.dart';

class RegisterBody extends StatefulWidget {
  const RegisterBody({super.key});

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _phController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _whController = TextEditingController();
  final ValueNotifier<String> _selectedOption = ValueNotifier(kDefRegRadOption);
  final ValueNotifier<bool> _visibilityNotifier = ValueNotifier(true);
  TextDirection _fnameDir = TextDirection.rtl;
  TextAlign _fnameAl = TextAlign.right;
  late String name, phone1, outdate, phone2, pass;
  @override
  void initState() {
    name = '';
    outdate = '';
    phone1 = '';
    phone2 = '';
    pass = '';
    super.initState();
  }

  @override
  void dispose() {
    _dateController.dispose();
    _phController.dispose();
    _passController.dispose();
    _whController.dispose();
    _visibilityNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // String name, phone1, outdate, phone2, pass;
    return BlocConsumer<RegisterUserCubit, RegisterUserState>(
      listener: (context, state) {
        if (state is RegisterUserSuccess) {
          showAppSnackBar(
            context,
            message: state.response.message ?? 'Registration successful!',
            backgroundColor: kPrimColG,
          );
          context.go(
            AppRouter.kVerifyMsgPage,
            extra: VerifyMsgViewModel(
              phone: phone1,
              type: VerifyMsgType.verifyUser,
            ),
          );
        }

        if (state is RegisterUserFailure) {
          showAppSnackBar(context, message: state.errMsg);
        }
      },
      builder: (context, state) {
        if (state is RegisterUserLoading) {
          return const Center(
            child: CircularProgressIndicator(color: kPrimColG),
          );
        }

        return Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            child: Column(
              children: [
                RegisterFullNameInput(
                  onChanged: (value) {
                    _fnameDir = LanDetector.detectDir(text: value);
                    _fnameAl = LanDetector.detectAlign(text: value);
                    name = value;
                    setState(() {}); // fine here, inside input callback
                  },
                  tAln: _fnameAl,
                  tDir: _fnameDir,
                ),
                RegisterDatePicker(
                  dateController: _dateController,
                  onDateSelected: (date) {
                    outdate = WidH.date2str(date);
                  },
                ),
                RegisterPhoneInput(
                  onChanged: (number) => phone1 = number,
                  phoneController: _phController,
                ),
                RegisterRadioForm(
                  phoneController: _whController,
                  selectedOption: _selectedOption,
                  onChanged: (number) => phone2 = number,
                ),
                RegisterPassInput(
                  onChanged: (value) => pass = value,
                  pController: _passController,
                  visibilityNotifier: _visibilityNotifier,
                ),
                RegisterBtn(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      BlocProvider.of<RegisterUserCubit>(context).registerUser(
                        RegisterModel(name, outdate, phone1, pass, phone2),
                      );
                    }
                  },
                ),
                const VPItem(tSpc: 20, bSpc: 60, child: RegToLogLeadingLine()),
              ],
            ),
          ),
        );
      },
    );
  }
}
