import 'package:dallal_proj/core/errors/failure.dart';
import 'package:dallal_proj/core/use_cases/use_case.dart';
import 'package:dallal_proj/features/notifications_page/data/models/unread_count_response.dart';
import 'package:dallal_proj/features/notifications_page/domain/repos/notifications_page_repo.dart';
import 'package:dartz/dartz.dart';

class GetUnreadCountUseCase extends UseCase<UnreadCountResponse, String> {
  final NotificationsPageRepo notificationsPageRepo;

  GetUnreadCountUseCase({required this.notificationsPageRepo});

  @override
  Future<Either<Failure, UnreadCountResponse>> call([String? token]) async {
    return await notificationsPageRepo.getUnreadCount(token ?? '');
  }
}
