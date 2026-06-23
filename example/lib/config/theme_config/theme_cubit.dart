import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared_pref.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit(super.themeMode);

  void toggleTheme() {
    if (state == ThemeMode.light) {
      emit(ThemeMode.dark);
      Preferences().setDarkMode(true);
    } else {
      emit(ThemeMode.light);
      Preferences().setDarkMode(false);
    }
  }
}
