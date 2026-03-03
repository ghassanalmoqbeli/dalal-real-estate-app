import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class LoadableBody extends StatelessWidget {
  const LoadableBody({
    super.key,
    required this.isLoading,
    required this.child,
    this.loadableChild,
  });

  final bool isLoading;
  final Widget child;
  final Widget? loadableChild;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AbsorbPointer(
          absorbing: isLoading,
          child: Opacity(opacity: isLoading ? 0.5 : 1.0, child: child),
        ),
        if (isLoading)
          loadableChild ??
              const Center(child: CircularProgressIndicator(color: kPrimColG)),
      ],
    );
  }
}
