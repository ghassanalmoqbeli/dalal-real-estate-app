import 'package:dallal_proj/core/widgets/named_logo.dart';
import 'package:dallal_proj/features/preview/presentation/views/widgets/next_btn.dart';
import 'package:dallal_proj/features/preview/presentation/views/widgets/pvp_text.dart';
import 'package:flutter/material.dart';

class PreviewBody extends StatelessWidget {
  const PreviewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Spacer(flex: 2),
        NamedLogo(),
        Spacer(flex: 1),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 27.0),
          child: PvpText(),
        ),
        SizedBox(height: 50),
        Spacer(flex: 2),
        Padding(
          padding: EdgeInsets.only(left: 8.0, bottom: 16.0),
          child: Align(alignment: Alignment.centerLeft, child: NextBtn()),
        ),
      ],
    );
  }
}
