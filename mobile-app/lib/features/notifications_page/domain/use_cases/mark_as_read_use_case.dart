import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/use_cases/use_case2.dart';
import 'package:dallal_proj/features/notifications_page/data/models/mark_as_read_req_model.dart';
import 'package:dallal_proj/features/notifications_page/data/models/mark_as_read_response.dart';
import 'package:dallal_proj/features/notifications_page/domain/repos/notifications_page_repo.dart';
import 'package:dartz/dartz.dart';

class MarkAsReadUseCase
    extends UseCase2<MarkAsReadResponse, MarkAsReadReqModel> {
  final NotificationsPageRepo notificationsPageRepo;

  MarkAsReadUseCase({required this.notificationsPageRepo});

  @override
  Future<Either<Failure, MarkAsReadResponse>> call(
    MarkAsReadReqModel reqModel,
  ) async {
    return await notificationsPageRepo.markAsRead(reqModel);
  }
}
