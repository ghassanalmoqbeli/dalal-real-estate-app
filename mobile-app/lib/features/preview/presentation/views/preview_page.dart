import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/features/preview/presentation/views/widgets/preview_body.dart';
import 'package:dallal_proj/features/preview/presentation/views/widgets/wall_paper.dart';
import 'package:flutter/material.dart';

class PreviewPage extends StatelessWidget {
  const PreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kTransP,
      body: WallPaper(child: PreviewBody()),
    );
  }
}
