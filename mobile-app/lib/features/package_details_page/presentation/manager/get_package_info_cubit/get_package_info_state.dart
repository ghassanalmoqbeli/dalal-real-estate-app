part of 'get_package_info_cubit.dart';

@immutable
sealed class GetPackageInfoState {}

final class GetPackageInfoInitial extends GetPackageInfoState {}

final class GetPackageInfoLoading extends GetPackageInfoState {}

final class GetPackageInfoSuccess extends GetPackageInfoState {
  final PckgInfModel package;

  GetPackageInfoSuccess({required this.package});
}

final class GetPackageInfoFailure extends GetPackageInfoState {
  final String errMsg;

  GetPackageInfoFailure({required this.errMsg});
}
