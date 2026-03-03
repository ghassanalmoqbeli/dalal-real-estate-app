import 'package:dallal_proj/core/constants/app_defs.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/entities/adv_card_entity/adv_card_entity.dart';
import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/utils/app_router.dart';
import 'package:dallal_proj/core/utils/service_locator.dart';
import 'package:dallal_proj/core/utils/simple_bloc_observer.dart';
import 'package:dallal_proj/features/login_page/domain/entities/loggedin_user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  setupServiceLocator();
  await Hive.initFlutter();
  Hive.registerAdapter(LoggedinUserEntityAdapter());
  Hive.registerAdapter(AdvCardEntityAdapter());

  await Hive.openBox<LoggedinUserEntity?>(kMeDataBox);
  await Hive.openBox<AdvCardEntity?>(kFeaturedAdvBox);
  await Hive.openBox<AdvCardEntity?>(kAllAdvBox);
  Bloc.observer = SimpleBlocObserver();
  runApp(const DallalProj());
}

class DallalProj extends StatelessWidget {
  const DallalProj({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: kDefFontFam,
        scaffoldBackgroundColor: kWhite,
      ),
    );
  }
}
