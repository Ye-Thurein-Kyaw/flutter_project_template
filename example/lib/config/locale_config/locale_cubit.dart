import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared_pref.dart';

class LocaleCubit extends Cubit<Locale> {
  final Preferences _pref = Preferences();

  LocaleCubit(super.initialLocale);

  void changeLocale(Locale locale, BuildContext context) {
    context.setLocale(locale);
    _pref.setLocale('${locale.languageCode}-${locale.countryCode}');
    emit(locale);
  }
}
