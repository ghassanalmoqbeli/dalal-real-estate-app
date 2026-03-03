import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';
import 'package:dallal_proj/features/details_page/presentation/manager/report_adv_cubit/report_adv_cubit.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/adv_details_appbar/details_app_bar.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/adv_details_appbar/ico_switch.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/adv_details_body.dart';
import 'package:dallal_proj/core/widgets/helpers/show_snack_bar.dart';
import 'package:dallal_proj/core/utils/functions/get_me_data.dart';
import 'package:dallal_proj/core/widgets/loadable_body.dart';
import 'package:dallal_proj/core/widgets/unfocus_ontap.dart';
import 'package:dallal_proj/core/widgets/page_padding.dart';
import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class AdvDetailsPage extends StatelessWidget {
  const AdvDetailsPage({super.key, required this.detailsEntity});

  final ShowDetailsEntity detailsEntity;
  @override
  Widget build(BuildContext context) {
    return UnfocusOntap(
      child: Scaffold(
        appBar: DetailsAppBar(
          svgIco:
              detailsEntity.isPended
                  ? const SizedBox()
                  : IcoSwitch(
                    isOn: detailsEntity.isMineDet,
                    adID: detailsEntity.advId,
                    onSubmit: (reportValues) {
                      var user = getMeData();
                      BlocProvider.of<ReportAdvCubit>(
                        context,
                      ).reportAdv(reportValues.toReportReqModel(user!.uToken!));
                      Navigator.of(context).pop();
                    },
                    onValuesChanged: (values) {},
                  ),
        ),
        body: PagePadding(
          fract: 0.034,
          child: BlocConsumer<ReportAdvCubit, ReportAdvState>(
            listener: (context, state) {
              if (state is ReportAdvFailure) {
                showAppSnackBar(context, message: state.errMsg);
              }
              if (state is ReportAdvSuccess) {
                showAppSnackBar(
                  context,
                  message:
                      state.response.message ?? 'Adv Reported Successfully',
                  backgroundColor: kPrimColO,
                );
              }
            },
            builder:
                (context, state) => LoadableBody(
                  isLoading: state is ReportAdvLoading,
                  child: AdvDetailsBody(detailsEntity: detailsEntity),
                ),
          ),
        ),
      ),
    );
  }
}
