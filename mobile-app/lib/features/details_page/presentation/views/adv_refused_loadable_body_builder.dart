import 'package:dallal_proj/core/widgets/helpers/show_snack_bar.dart';
import 'package:dallal_proj/core/widgets/loadable_body.dart';
import 'package:dallal_proj/features/details_page/domain/entities/show_details_entity.dart';
import 'package:dallal_proj/features/details_page/presentation/views/widgets/adv_refused_body.dart';
import 'package:dallal_proj/features/my_account_page/presentation/manager/delete_adv_cubit/delete_adv_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdvRefusedLoadableBodyBuilder extends StatelessWidget {
  const AdvRefusedLoadableBodyBuilder({super.key, required this.detailsEntity});
  final ShowDetailsEntity detailsEntity;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteAdvCubit, DeleteAdvState>(
      listener: (context, state) {
        if (state is DeleteAdvFailure) {
          showAppSnackBar(context, message: 'فشل حذف الإعلان ياغالي');
        }
        if (state is DeleteAdvSuccess) {
          Navigator.of(context).pop(true);
        }
      },
      builder: (context, state) {
        return LoadableBody(
          isLoading: state is DeleteAdvLoading,
          child: AdvRefusedBody(detailsEntity: detailsEntity),
        );
      },
    );
  }
}
