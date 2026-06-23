import 'dart:io';

import 'package:flutter_project_template/file_with_content.dart';

void main() {
  _runCommand('flutter pub add http');
  _runCommand('flutter pub add flutter_bloc');
  _runCommand('flutter pub add shared_preferences');
  _runCommand('flutter pub add go_router');
  _runCommand('flutter pub add http_parser');
  _runCommand('flutter pub add easy_localization');
  _runCommand('flutter pub add equatable');
  createBaseFolderStructure();
  updateMainDart();
  updatePubspecYaml();
}

void _runCommand(String command) {
  Process.run(command, [], runInShell: true).then((process) {
    if (process.exitCode == 0) {
      print('Command executed successfully');
    } else {
      print('Error executing command: ${process.stderr}');
    }
  });
}

void createBaseFolderStructure() {
  final baseDirectories = [
    Directory('lib/config'),
    Directory('lib/config/theme_config'),
    Directory('lib/config/locale_config'),
    Directory('lib/models'),
    Directory('lib/modules'),
    Directory('lib/modules/splash'),
    Directory('lib/modules/splash/screen'),
    Directory('lib/modules/home'),
    Directory('lib/modules/home/bloc'),
    Directory('lib/modules/home/cubit'),
    Directory('lib/modules/home/screen'),
    Directory('lib/modules/home/widget'),
    Directory('lib/modules/main/screen'),
    Directory('lib/modules/profile/screen'),
    Directory('lib/modules/search/screen'),
    Directory('lib/repository'),
    Directory('lib/services'),
    Directory('lib/utils'),
    Directory('lib/widgets'),
    Directory('languages'),
  ];

  for (var dir in baseDirectories) {
    if (!dir.existsSync()) {
      try {
        dir.createSync(recursive: true);
        print('Created folder: ${dir.path}');
      } catch (e) {
        print('Error creating directory ${dir.path}: $e');
      }
    }
  }

  // Files and their content
  FileWithContentClass.filesWithContent.forEach((filePath, content) {
    final file = File(filePath);
    try {
      file.writeAsStringSync(content);
      print('Created file: $filePath');
    } catch (e) {
      print('Error creating file $filePath: $e');
    }
  });
}

void updateMainDart() {
  const mainDartTemplate = '''
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('my', 'MM')],
      path: 'languages',
      child: BlocProvider(create: (context) => ThemeCubit(themeMode), child: const MyApp()),
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

''';

  final mainFile = File('lib/main.dart');
  try {
    mainFile.writeAsStringSync(mainDartTemplate);
    print('Updated main.dart');
  } catch (e) {
    print('Error updating main.dart: $e');
  }
}

void updatePubspecYaml() {
  final pubspecFile = File('pubspec.yaml');
  if (!pubspecFile.existsSync()) {
    print('pubspec.yaml not found');
    return;
  }

  String content = pubspecFile.readAsStringSync();

  if (!content.contains('# assets:')) {
    print('# assets: comment not found in pubspec.yaml');
    return;
  }

  content = content.replaceFirst('  # assets:', '  assets:\n    - languages/');

  try {
    pubspecFile.writeAsStringSync(content);
    print('Updated pubspec.yaml with assets section');
  } catch (e) {
    print('Error updating pubspec.yaml: $e');
  }
}
