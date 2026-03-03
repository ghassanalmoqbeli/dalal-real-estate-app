// // import 'package:dallal_proj/core/entities/adv_card_entity.dart';
// // import 'package:dallal_proj/core/errors/failure.dart';
// // import 'package:dallal_proj/features/main_page/domain/repos/main_page_repo.dart';
// // import 'package:dartz/dartz.dart';

// // class FetchAllAdvsUseCase {
// //   final MainPageRepo mainPageRepo;

// //   FetchAllAdvsUseCase(this.mainPageRepo);

// //   Future<Either<Failure, List<AdvCardEntity>>> call() {
// //     return mainPageRepo.fetchAllAdvs();
// //   }
// // }

// import 'package:dallal_proj/core/entities/adv_card_entity.dart';
// import 'package:dallal_proj/core/errors/failure.dart';
// import 'package:dallal_proj/core/use_cases/use_case.dart';
// import 'package:dallal_proj/features/main_page/domain/repos/main_page_repo.dart';
// import 'package:dartz/dartz.dart';

// class FetchAllAdvsUseCase extends UseCase<List<AdvCardEntity>, NoParam> {
//   final MainPageRepo mainPageRepo;

//   FetchAllAdvsUseCase(this.mainPageRepo);

//   @override
//   Future<Either<Failure, List<AdvCardEntity>>> call([NoParam? param]) async {
//     return await mainPageRepo.fetchAllAdvs();
//   }
// }
