import 'package:dallal_proj/core/widgets/helpers/show_snack_bar.dart';
import 'package:dallal_proj/core/widgets/loadable_body.dart';
import 'package:dallal_proj/features/featuring_adv_page/presentation/manager/feature_the_adv_cubit/feature_the_adv_cubit.dart';
import 'package:dallal_proj/features/featuring_adv_page/presentation/views/widgets/featuring_adv_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeaturingAdvLoadableBodyBuilder extends StatelessWidget {
  const FeaturingAdvLoadableBodyBuilder({super.key, required this.adID});

  final String adID;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeatureTheAdvCubit, FeatureTheAdvState>(
      listener: (context, state) {
        if (state is FeatureTheAdvFailure) {
          showAppSnackBar(context, message: state.errMsg);
        }
        if (state is FeatureTheAdvSuccess) {
          Navigator.of(context).pop(true);
        }
      },
      builder: (context, state) {
        return LoadableBody(
          isLoading: state is FeatureTheAdvLoading,
          child: FeaturingAdvBody(adID: adID),
        );
      },
    );
  }
}
