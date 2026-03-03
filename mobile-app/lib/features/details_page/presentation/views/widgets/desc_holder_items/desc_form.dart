import 'package:dallal_proj/core/constants/str_lists.dart';
import 'package:dallal_proj/core/widgets/helpers/s_bx.dart';
import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/desc_holder_items/desc_img_item.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/desc_item.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/desc_holder_items/details_desc_box.dart';
import 'package:flutter/material.dart';

class DescForm extends StatelessWidget {
  const DescForm({super.key, required this.detailsEntity});
  final ShowDetailsEntity detailsEntity;
  @override
  Widget build(BuildContext context) {
    return DetailDescBox(
      children: [
        DescItem(head: CLstr.descItmList[0], tail: detailsEntity.sectionDet),
        DescItem(head: CLstr.descItmList[1], tail: detailsEntity.city),
        DescItem(head: CLstr.descItmList[2], tail: '${detailsEntity.area} '),
        DescItem(head: CLstr.descItmList[3], tail: detailsEntity.offerType),
        DescItem(head: CLstr.descItmList[4], tail: detailsEntity.location),
        DescImgItem(head: CLstr.descItmList[5], link: null),
        DescItem(
          head: CLstr.descItmList[6],
          tail: detailsEntity.flrCount ?? '0',
        ),
        DescItem(
          head: CLstr.descItmList[7],
          tail: detailsEntity.romCount ?? '0',
        ),
        DescItem(
          head: CLstr.descItmList[8],
          tail: detailsEntity.halCount ?? '0',
        ),
        DescItem(
          head: CLstr.descItmList[9],
          tail: detailsEntity.kchCount ?? '0',
        ),
        DescItem(
          head: CLstr.descItmList[10],
          tail: detailsEntity.bthCount ?? '0',
        ),
        DescItem(head: CLstr.descItmList[11], tail: detailsEntity.priceDet),
        DescItem(
          head: CLstr.descItmList[12],
          tail: (detailsEntity.isNegot == true) ? 'نعم' : 'لا',
        ),
        DescItem(
          isH: false,
          head: CLstr.descItmList[13],
          tail: detailsEntity.extraDetails ?? '',
        ),
        SBx.h30,
      ],
    );
  }
}
