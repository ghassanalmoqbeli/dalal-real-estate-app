import 'package:dallal_proj/core/constants/app_defs.dart';
import 'package:dallal_proj/core/utils/functions/get_city_value.dart';
import 'package:dallal_proj/core/widgets/custom_app_bar.dart';
import 'package:dallal_proj/features/sections_page/domain/entities/section_list_entity.dart';
import 'package:dallal_proj/features/selected_section_page/presentation/views/widgets/selected_sect_body.dart';
import 'package:flutter/material.dart';

class SelectedSectPage extends StatelessWidget {
  const SelectedSectPage({super.key, required this.sectionListEntity});
  final SectionListEntity sectionListEntity;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
      child: Scaffold(
        appBar: CustomAppBar(
          title: DictHelper.translate(
            kPTSs,
            sectionListEntity.sectionName ?? '',
          ),
        ),
        body: SelectedSectionBody(sectionListEntity: sectionListEntity),
      ),
    );
  }
}
