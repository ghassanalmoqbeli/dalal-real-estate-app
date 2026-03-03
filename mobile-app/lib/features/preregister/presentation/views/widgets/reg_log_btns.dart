import 'package:dallal_proj/core/widgets/symmetric_pads/h_p_item.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/v_p_item.dart';
import 'package:dallal_proj/core/widgets/two_item_widgets/two_itm_col.dart';
import 'package:dallal_proj/core/widgets/two_item_widgets/two_itm_row.dart';
import 'package:dallal_proj/core/components/app_btns/models/x_b_size.dart';
import 'package:dallal_proj/features/preregister/presentation/views/widgets/guest_btn.dart';
import 'package:dallal_proj/features/preregister/presentation/views/widgets/login_btn.dart';
import 'package:dallal_proj/features/preregister/presentation/views/widgets/register_btn.dart';
import 'package:flutter/material.dart';

class RegLogBtns extends StatelessWidget {
  const RegLogBtns({
    super.key,
    required this.onLogin,
    required this.onRegister,
    required this.onGuest,
  });
  final void Function()? onLogin, onRegister, onGuest;
  @override
  Widget build(BuildContext context) {
    return TwoItmCol(
      topChild: VPItem(
        bSpc: 15,
        child: TwoItmRow(
          mXAlign: MainAxisAlignment.center,
          leftChild: HPItem(rSpc: 13, child: LoginBtn(onPressed: onLogin)),
          rightChild: RegisterBtn(
            onPressed: onRegister,
            size: const XBSize(width: 177),
          ),
        ),
      ),
      btmChild: GuestBtn(onPressed: onGuest),
    );
  }
}
