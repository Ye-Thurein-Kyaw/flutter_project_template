import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/locale_config/locale_cubit.dart';
import 'config/routes.dart';
import 'config/shared_pref.dart';
import 'config/theme_config/theme_cubit.dart';
import 'config/theme_config/theme_helper.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey(debugLabel: 'Main Navigator');

Future<void> main() async {
  final Preferences pref = Preferences();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await pref.initPreferences();
  ThemeMode themeMode = pref.getDarkMode();
  final savedLocale = pref.getLocale();
  final localeParts = savedLocale.split('-');
  final initialLocale = Locale(
    localeParts.first,
    localeParts.length > 1 ? localeParts[1] : '',
  );

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('my', 'MM')],
      path: 'languages',
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ThemeCubit(themeMode)),
          BlocProvider(create: (context) => LocaleCubit(initialLocale)),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp.router(
          themeMode: themeMode,
          theme: kLightTheme,
          darkTheme: kDarkTheme,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          routerConfig: Routes.routes,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          builder: (BuildContext context, Widget? child) {
            final MediaQueryData mediaQuery = MediaQuery.of(context);
            final double currentTextScale = mediaQuery.textScaler.scale(1);
            final double clampedTextScale = currentTextScale.clamp(0.8, 1.1);

            if ((clampedTextScale - currentTextScale).abs() < 0.001) {
              return child!;
            }

            return MediaQuery(
              data: mediaQuery.copyWith(textScaler: TextScaler.linear(clampedTextScale)),
              child: child!,
            );
          },
        );
      },
    );
  }
}

