import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/adv_details_header_sect/adv_details_title.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/adv_details_header_sect/adv_header_lbl.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/adv_details_header_sect/detail_date_text.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/adv_details_header_sect/details_btns.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/adv_details_header_sect/details_image_carousel.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/adv_details_body_items/f_advice_box.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/desc_holder_items/f_desc_box.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/user_contacts_items/f_contacts_box.dart';
import 'package:dallal_proj/core/components/app_btns/models/x_b_size.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/v_p_item.dart';
import 'package:dallal_proj/core/widgets/helpers/widgets_helper.dart';
import 'package:dallal_proj/core/constants/mock_models.dart';
import 'package:dallal_proj/core/widgets/helpers/s_bx.dart';
import 'package:dallal_proj/temp_try.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AdvDetailsBodyForm extends StatelessWidget {
  const AdvDetailsBodyForm({
    super.key,
    required this.detailsEntity,
    required this.isPended,
    this.onTapHdrLbl,
  });

  final ShowDetailsEntity detailsEntity;
  final bool isPended;
  final void Function()? onTapHdrLbl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SBx.rHsbx(50, context),
        VPItem(
          tSpc: 10,
          bSpc: 10,
          child: AdvHeaderLbl(
            detailsEntity: detailsEntity,
            isPended: isPended,
            onTap: onTapHdrLbl,
          ),
        ),
        AdvDetailsImgCarousel(
          imagePaths:
              detailsEntity.imgs?.map((e) => e.mediaUrl as String).toList(),
        ),
        VPItem(
          tSpc: 5,
          bSpc: 15,
          child: DetailDateText(date: WidH.str2date(detailsEntity.dateDet)),
        ), // DateTime.now())),
        VPItem(bSpc: 30, child: AdvDetailsTitle(txt: detailsEntity.titleDet)),
        if (!isPended)
          DetailsBtns(
            likeSize: const XBSize(width: 93, height: 37),
            advDetailsEntity: detailsEntity,
          ),
        VPItem(tSpc: 15, child: WidH.respSep(context)),
        VPItem(
          tSpc: 30,
          bSpc: 30,
          child: FContactBox(
            smsOnTap: () async {
              final smsUrl = Uri.parse('sms:967${detailsEntity.phoneNum}');
              if (await canLaunchUrl(smsUrl)) {
                await launchUrl(smsUrl);
              }
            },
            callOnTap: () async {
              final phoneUrl = Uri.parse(
                detailsEntity.linkToPhone ?? 'tel:967${detailsEntity.phoneNum}',
              );
              if (await canLaunchUrl(phoneUrl)) {
                await launchUrl(phoneUrl);
              }
            },
            whatsAppOnTap: () async {
              final whatsAppUrl = Uri.parse(
                detailsEntity.linkToWhatsApp ??
                    'https://wa.me/967${detailsEntity.whatsNum}',
              );
              if (await canLaunchUrl(whatsAppUrl)) {
                await launchUrl(
                  whatsAppUrl,
                  mode: LaunchMode.externalApplication,
                );
              }
            },
            user: UserModel(
              fName: detailsEntity.fName,
              img: detailsEntity.pfp,
              phoneNum: detailsEntity.phoneNum,
              whatsNum: detailsEntity.whatsNum,
            ),
          ),
        ),
        WidH.respSep(context),
        VPItem(
          tSpc: 30,
          bSpc: 30,
          child: FDescBox(detailsEntity: detailsEntity),
        ),
        WidH.respSep(context),
        const VPItem(bSpc: 40, child: FAdviceBox(advices: kAdvicesOLM)),
      ],
    );
  }
}
