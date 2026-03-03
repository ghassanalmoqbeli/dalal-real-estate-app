import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:flutter/material.dart';

class MoreBodyItemHolder extends StatelessWidget {
  const MoreBodyItemHolder({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: Funcs.respWidth(fract: 0.036, context: context),
                  ),
                  child: child,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
