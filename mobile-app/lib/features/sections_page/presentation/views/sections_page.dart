import 'package:dallal_proj/core/constants/mock_models.dart';
import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:dallal_proj/core/widgets/custom_app_bar.dart';
import 'package:dallal_proj/features/sections_page/presentation/views/widgets/sections_body.dart';
import 'package:flutter/material.dart';

class SectionsPage extends StatelessWidget {
  const SectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'الأقسام', showBackButton: false),
      body: Center(
        child: SizedBox(
          width: Funcs.respWidth(fract: 0.88, context: context),
          child: const SectionsBody(
            topLCell: kSectCardHouses,
            topRCell: kSectCardApts,
            btmLCell: kSectCardStores,
            btmRCell: kSectCardGrnds,
          ),
        ),
      ),
    );
  }
}
