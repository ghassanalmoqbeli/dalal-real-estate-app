import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/widgets/custom_app_bar.dart';
import 'package:dallal_proj/core/widgets/helpers/show_snack_bar.dart';
import 'package:dallal_proj/core/widgets/page_padding.dart';
import 'package:dallal_proj/features/package_details_page/presentation/manager/get_package_info_cubit/get_package_info_cubit.dart';
import 'package:dallal_proj/features/package_details_page/presentation/views/widgets/package_details_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PackageDetailsPage extends StatelessWidget {
  const PackageDetailsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: PagePadding(fract: 0.072, child: PackageDetailsBodyBuilder()),
    );
  }
}

class PackageDetailsBodyBuilder extends StatelessWidget {
  const PackageDetailsBodyBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetPackageInfoCubit, GetPackageInfoState>(
      listener: (context, state) {
        if (state is GetPackageInfoFailure) {
          showAppSnackBar(context, message: state.errMsg);
        }
      },
      builder: (context, state) {
        if (state is GetPackageInfoSuccess) {
          return PackageDetailsBody(package: state.package);
        } else if (state is GetPackageInfoLoading) {
          return const Center(
            child: CircularProgressIndicator(color: kPrimColG),
          );
        }
        return const Center(child: Text('خطأ ما قد حدث'));
      },
    );
  }
}
