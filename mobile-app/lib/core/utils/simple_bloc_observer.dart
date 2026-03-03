import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    log('The Bloc State Has Changed! Look! : ${change.toString()}');
    super.onChange(bloc, change);
  }
}
