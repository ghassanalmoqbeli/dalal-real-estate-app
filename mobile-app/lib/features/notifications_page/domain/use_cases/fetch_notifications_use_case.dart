import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/use_cases/use_case2.dart';
import 'package:dallal_proj/features/notifications_page/data/models/fetch_notifications_req_model.dart';
import 'package:dallal_proj/features/notifications_page/data/models/notifications_response.dart';
import 'package:dallal_proj/features/notifications_page/domain/repos/notifications_page_repo.dart';
import 'package:dartz/dartz.dart';

class FetchNotificationsUseCase
    extends UseCase2<NotificationsResponse, FetchNotificationsReqModel> {
  final NotificationsPageRepo notificationsPageRepo;

  FetchNotificationsUseCase({required this.notificationsPageRepo});

  @override
  Future<Either<Failure, NotificationsResponse>> call(
    FetchNotificationsReqModel reqModel,
  ) async {
    return await notificationsPageRepo.fetchNotifications(reqModel);
  }
}
