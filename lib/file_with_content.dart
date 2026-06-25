class FileWithContentClass {
  static final filesWithContent = {
    'lib/config/routes.dart': '''
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/theme_config/theme_cubit.dart';
import '../bloc/home_bloc.dart';
import '../cubit/home_cubit.dart';
import '../widget/home_bloc_item_list.dart';
import '../widget/home_cubit_item_list.dart';

class HomeScreen extends StatelessWidget {
  static const route = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0f1225) : const Color(0xFFF5F6FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tr('home'),
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : const Color(0xFF1a1f38),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        tr('welcome'),
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark ? Colors.grey : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1a1f38) : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: isDark
                          ? []
                          : [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                    ),
                    child: GestureDetector(
                      onTap: () => context.read<ThemeCubit>().toggleTheme(),
                      child: Icon(
                        isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                        color: isDark ? Colors.white : const Color(0xFF1a1f38),
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _QuickActionCard(isDark: isDark),
              const SizedBox(height: 20),
              _SectionHeader(
                title: 'Cubit Example',
                subtitle: 'Simple state management',
                icon: Icons.casino_rounded,
                isDark: isDark,
                onAction: () => context.read<HomeCubit>().loadData(),
              ),
              const SizedBox(height: 10),
              const HomeCubitItemList(),
              const SizedBox(height: 20),
              _SectionHeader(
                title: 'Bloc Example',
                subtitle: 'Event-driven state management',
                icon: Icons.account_tree_rounded,
                isDark: isDark,
                onAction: () => context.read<HomeBloc>().add(HomeLoadRequested()),
              ),
              const SizedBox(height: 10),
              const HomeBlocItemList(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final bool isDark;
  const _QuickActionCard({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [const Color(0xFF1a1f38), const Color(0xFF30385D)]
              : [const Color(0xFF005BAA), const Color(0xFF3d83ff)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quick Start',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Explore your dashboard today',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.rocket_launch_rounded, color: Colors.white, size: 28),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isDark;
  final VoidCallback onAction;
  const _SectionHeader({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isDark,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: (isDark ? const Color(0xFF3d83ff) : const Color(0xFF005BAA))
                .withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: isDark ? const Color(0xFF3d83ff) : const Color(0xFF005BAA),
            size: 22,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : const Color(0xFF1a1f38),
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? Colors.grey : Colors.grey,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: onAction,
          icon: Icon(
            Icons.refresh_rounded,
            color: isDark ? const Color(0xFF3d83ff) : const Color(0xFF005BAA),
          ),
        ),
      ],
    );
  }
}
      return _prefs.getString(key) as T?;
    } else if (T is int) {
      return _prefs.getInt(key) as T?;
    } else if (T is double) {
      return _prefs.getDouble(key) as T?;
    } else if (T is List<String>) {
      return _prefs.getStringList(key) as T?;
    }
    return null;
  }
  
  final String _isDarkMode = 'isDarkMode';

  ThemeMode getDarkMode() {
    final darkMode = _prefs.getBool(_isDarkMode) ?? false;
    return darkMode ? ThemeMode.dark : ThemeMode.light;
  }

  void setDarkMode(bool darkMode) {
    _prefs.setBool(_isDarkMode, darkMode);
  }

  final String _locale = 'locale';

  String getLocale() {
    return _prefs.getString(_locale) ?? 'en-US';
  }

  void setLocale(String locale) {
    _prefs.setString(_locale, locale);
  }
}
enum PrefKey {  
  firstRun('first_run'),
  locale('locale'),;
  
  final String key;
  const PrefKey(this.key);
  }
''',
    'lib/config/theme_config/theme_cubit.dart': '''
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
''',
    'lib/config/theme_config/theme_helper.dart': '''
import 'package:flutter/material.dart';

bool isDarkTheme(BuildContext context) => Theme.of(context).brightness == Brightness.dark;

ThemeData kLightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF005BAA),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFD7E9FF),
    onPrimaryContainer: Color(0xFF003A65),
    secondary: Color(0xFF3d83ff),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFDCE5FF),
    onSecondaryContainer: Color(0xFF103A8D),
    tertiary: Color(0xFF6B5CA8),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFEBDDFF),
    onTertiaryContainer: Color(0xFF25184D),
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF1a1f38),
    outline: Color(0xFFD8DCE6),
    error: Color(0xFFB3261E),
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    bodyMedium: TextStyle(fontSize: 14),
    bodySmall: TextStyle(fontSize: 12),
  ),
);

ThemeData kDarkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF3d83ff),
    onPrimary: Color(0xFF002A72),
    primaryContainer: Color(0xFF0F4AA1),
    onPrimaryContainer: Color(0xFFD7E9FF),
    secondary: Color(0xFF82A8FF),
    onSecondary: Color(0xFF0C214D),
    secondaryContainer: Color(0xFF27468E),
    onSecondaryContainer: Color(0xFFDCE5FF),
    tertiary: Color(0xFFC8B7FF),
    onTertiary: Color(0xFF35265F),
    tertiaryContainer: Color(0xFF4D3C84),
    onTertiaryContainer: Color(0xFFEBDDFF),
    surface: Color(0xFF1a1f38),
    onSurface: Color(0xFFF5F7FF),
    outline: Color(0xFF30385D),
    error: Color(0xFFFF6B6B),
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    bodyMedium: TextStyle(fontSize: 14),
    bodySmall: TextStyle(fontSize: 12),
  ),
);
''',
    'lib/config/content_ext.dart': '''
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension ContextExt on BuildContext {
  void back<T extends Object?>([T? result]) {
    return Navigator.of(this).pop(result);
  }

  /// Navigates to the specified route and clears the navigation stack.
  ///
  /// This method navigates to a new route identified by the [routeName] and
  /// clears the entire navigation stack, meaning that the back button will not
  /// take the user to the previous page. Instead, it will exit the app or close
  /// the screen (depending on the platform).
  ///
  /// ```dart
  /// navigateAndClearStack(Routes.home);
  /// ```
  ///
  /// [routeName]: The name of the route to navigate to.
  /// [arguments]: Optional arguments to pass to the new route.
  void navigateAndClearStack(String routeName, {Object? arguments}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      while (Navigator.of(this).canPop()) {
        back();
      }
      pushReplacementNamed(routeName, extra: arguments);
    });
  }

  /// Navigates to the specified route and adds it to the navigation stack.
  ///
  /// This method navigates to a new route identified by the [routeName] and
  /// pushes it onto the navigation stack. This allows the user to return to
  /// the previous screen using the back button.
  ///
  /// ```dart
  /// navigateWithPush(Routes.home, arguments: someArgument);
  /// ```
  ///
  /// [routeName]: The name of the route to navigate to.
  /// [arguments]: Optional arguments to pass to the new route.
  ///
  /// Returns a [Future] that completes to the result value passed to [pop]
  /// when the new route is removed from the stack.
  Future<T?> navigateWithPush<T extends Object?>(String routeName, {Object? arguments}) {
    return pushNamed(routeName, extra: arguments);
  }

  /// Navigates to the specified route safely after the current frame is built.
  ///
  /// This method ensures that navigation occurs **after the widget tree has been fully built**
  /// by wrapping the navigation call inside `WidgetsBinding.instance.addPostFrameCallback`.
  /// This prevents potential issues such as:
  ///
  /// - **"Looking up a deactivated widget’s ancestor" error** (occurs when navigating while a widget is still being built).
  /// - **"setState() called during build" error** (happens when navigation is triggered inside a widget's `build` method).
  ///
  /// It is useful when navigation needs to be triggered **within `initState()` or inside widget lifecycle methods**.
  ///
  /// Example usage:
  /// ```dart
  /// safeNavigateWithPush(Routes.details, arguments: someArgument);
  /// ```
  ///
  /// [routeName]: The name of the route to navigate to.
  /// [arguments]: Optional arguments to pass to the new route.
  ///
  /// Returns a [Future] that completes to the result value passed to [pop]
  /// when the new route is removed from the stack.
  Future<T?> safeNavigateWithPush<T extends Object?>(String routeName, {Object? arguments}) {
    Completer<T?> completer = Completer<T?>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      completer.complete(pushNamed<T>(routeName, extra: arguments));
    });

    return completer.future;
  }

  void navigateAndRemoveStack(String routeName, {Object? arguments}) {
    goNamed(routeName, extra: arguments);
  }
}
''',
    'lib/models/api_response.dart': '''
enum HttpStatusCode {
  success(200),
  badRequest(400),
  unauthorized(401),
  forbidden(403),
  notFound(404),
  requestTimeout(408),
  unprocessableEntity(422),
  internalServerError(500),
  badGateway(502),
  serviceUnavailable(503),
  networkError(0), // No internet or connectivity issue
  unknownError(-1); // Unknown error

  final int code;
  const HttpStatusCode(this.code);

  // Convert from status code to ApiStatus
  static HttpStatusCode fromCode(int code) {
    return HttpStatusCode.values.firstWhere(
          (status) => status.code == code,
      orElse: () => HttpStatusCode.unknownError,
    );
  }
}

class ApiResponse {
  final dynamic data;
  final HttpStatusCode statusCode;
  final String message;

  ApiResponse({required this.statusCode,  this.message = '', this.data});
}''',
    'lib/modules/splash/screen/splash_screen.dart': '''
import 'package:flutter/material.dart';
import '../../home/screen/home_screen.dart';
import '../../../config/content_ext.dart';

class Splash extends StatefulWidget {
  static const route = '/splash';
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        context.navigateAndRemoveStack(HomeScreen.route);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Center(
        child: Text(
          'Splash Screen',
          style: theme.textTheme.headlineLarge?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
''',
    'lib/modules/home/screen/home_screen.dart': '''
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/theme_config/theme_cubit.dart';
import '../bloc/home_bloc.dart';
import '../cubit/home_cubit.dart';
import '../widget/home_bloc_item_list.dart';
import '../widget/home_cubit_item_list.dart';

class HomeScreen extends StatelessWidget {
  static const route = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tr('home'),
                        style: textTheme.headlineLarge?.copyWith(color: colorScheme.onSurface),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        tr('welcome'),
                        style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface.withValues(alpha: 0.72)),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: colorScheme.outline),
                    ),
                    child: GestureDetector(
                      onTap: () => context.read<ThemeCubit>().toggleTheme(),
                      child: Icon(
                        theme.brightness == Brightness.dark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                        color: colorScheme.onSurface,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _QuickActionCard(colorScheme: colorScheme, textTheme: textTheme),
              const SizedBox(height: 20),
              _SectionHeader(
                title: 'Cubit Example',
                subtitle: 'Simple state management',
                icon: Icons.casino_rounded,
                colorScheme: colorScheme,
                textTheme: textTheme,
                onAction: () => context.read<HomeCubit>().loadData(),
              ),
              const SizedBox(height: 10),
              const HomeCubitItemList(),
              const SizedBox(height: 20),
              _SectionHeader(
                title: 'Bloc Example',
                subtitle: 'Event-driven state management',
                icon: Icons.account_tree_rounded,
                colorScheme: colorScheme,
                textTheme: textTheme,
                onAction: () => context.read<HomeBloc>().add(HomeLoadRequested()),
              ),
              const SizedBox(height: 10),
              const HomeBlocItemList(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final ColorScheme colorScheme;
  final TextTheme textTheme;
  const _QuickActionCard({required this.colorScheme, required this.textTheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorScheme.primary, colorScheme.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quick Start',
                  style: textTheme.titleMedium?.copyWith(color: colorScheme.surface),
                ),
                const SizedBox(height: 6),
                Text(
                  'Explore your dashboard today',
                  style: textTheme.bodySmall?.copyWith(color: colorScheme.surface.withValues(alpha: 0.78)),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: colorScheme.surface.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(Icons.rocket_launch_rounded, color: colorScheme.surface, size: 28),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final VoidCallback onAction;

  const _SectionHeader({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.colorScheme,
    required this.textTheme,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: colorScheme.primary,
            size: 22,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textTheme.titleMedium?.copyWith(color: colorScheme.onSurface),
              ),
              Text(
                subtitle,
                style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurface.withValues(alpha: 0.72)),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: onAction,
          icon: Icon(
            Icons.refresh_rounded,
            color: colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
''',
    'lib/modules/home/cubit/home_cubit.dart': '''
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repository/home_repository.dart';

  part 'home_state.dart';

/// {@template home_cubit}
/// A [Cubit] that manages the state of the Home screen.
///
/// **Cubit** is a simplified version of Bloc that uses a single state class
/// instead of separate event and state classes. It is ideal for simple state
/// management where you only need to react to UI callbacks (e.g., button
/// presses) and emit new states.
///
/// ### When to use Cubit vs Bloc:
/// - Use **Cubit** for simple state changes that don't require event
///   transformation, deduplication, or complex event handling. Examples:
///   theme switching, locale changes, toggles, counters.
/// - Use **Bloc** for more complex state logic where you need to track
///   distinct events, use event transformers, or when the state transitions
///   are complex enough to warrant separate event classes.
///
/// ### Usage:
/// ```dart
/// // Provide the Cubit at the widget level
/// BlocProvider(
///   create: (context) => HomeCubit(context.read<HomeRepository>()),
///   child: HomeScreen(),
/// )
///
/// // Access the Cubit in a widget
/// context.read<HomeCubit>().loadData();
///
/// // React to state changes
/// BlocBuilder<HomeCubit, HomeState>(
///   builder: (context, state) {
///     if (state.isLoading) {
///       return const CircularProgressIndicator();
///     }
///     return Text(state.data);
///   },
/// )
/// ```
/// {@endtemplate}
class HomeCubit extends Cubit<HomeState> {
  /// {@macro home_cubit}
  final HomeRepository _repository;

  HomeCubit(this._repository) : super(const HomeState());

  /// Loads sample data and updates the state.
  ///
  /// Demonstrates a simple async state transition using Cubit.
  /// In a real app, this would call a repository method.
  Future<void> loadData() async {
    emit(state.copyWith(isLoading: true));

    final items = await _repository.fetchItems();

    emit(state.copyWith(
      isLoading: false,
      items: items,
    ));
  }

  /// Adds a new item to the list.
  void addItem(String item) {
    emit(state.copyWith(items: [...state.items, item]));
  }

  /// Removes an item from the list by index.
  void removeItem(int index) {
    final updatedItems = List<String>.from(state.items);
    if (index >= 0 && index < updatedItems.length) {
      updatedItems.removeAt(index);
      emit(state.copyWith(items: updatedItems));
    }
  }
}
''',
    'lib/modules/home/cubit/home_state.dart': '''
part of 'home_cubit.dart';

/// State class for [HomeCubit].
///
/// Unlike Bloc which can have multiple state subclasses, Cubit typically
/// uses a single state class with computed properties to represent different
/// UI states (e.g., [isLoading], [hasData]).
class HomeState {
  final bool isLoading;
  final List<String> items;

  const HomeState({
    this.isLoading = false,
    this.items = const [],
  });

  bool get hasData => items.isNotEmpty;

  HomeState copyWith({
    bool? isLoading,
    List<String>? items,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      items: items ?? this.items,
    );
  }
}
''',
    'lib/modules/home/bloc/home_bloc.dart': '''
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

  import '../../../repository/home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

/// {@template home_bloc}
/// A [Bloc] that manages the Home screen's state using the Event-driven pattern.
///
/// **Bloc** uses a strict event-to-state architecture. Each user interaction
/// or system event is represented by a separate **Event** class, and each
/// state transition is represented by a **State** class. This provides:
///
/// - **Traceability**: Every state change can be traced back to a specific event.
/// - **Testability**: Blocs are easy to unit test — just add events and assert states.
/// - **Event Transformers**: You can debounce, throttle, or deduplicate events.
/// - **Complex Logic**: When state transitions depend on the type of event
///   (not just the current data), Bloc's pattern makes this explicit.
///
/// ### When to use Bloc vs Cubit:
/// - Use **Bloc** when state transitions are complex, when you need event
///   transformation (debounce/throttle), or when you want full traceability
///   of what triggered each state change.
/// - Use **Cubit** for simpler cases where you just need to emit states from
///   callbacks without the overhead of event classes.
///
/// ### Usage:
/// ```dart
/// // Provide the Bloc at the widget level
/// BlocProvider(
///   create: (context) => HomeBloc(context.read<HomeRepository>())..add(HomeLoadRequested()),
///   child: HomeScreen(),
/// )
///
/// // Add events from a widget
/// context.read<HomeBloc>().add(HomeRefreshRequested());
///
/// // React to specific state subclasses
/// BlocBuilder<HomeBloc, HomeState>(
///   builder: (context, state) {
///     if (state is HomeLoadInProgress) {
///       return const CircularProgressIndicator();
///     }
///     if (state is HomeLoadSuccess) {
///       return ListView(children: [...]);
///     }
///     if (state is HomeLoadFailure) {
///       return Text('Error: \${state.errorMessage}');
///     }
///     return const SizedBox.shrink();
///   },
/// )
/// ```
/// {@endtemplate}
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  /// {@macro home_bloc}
  final HomeRepository _repository;

  HomeBloc(this._repository) : super(const HomeInitial()) {
    on<HomeLoadRequested>(_onHomeLoadRequested);
    on<HomeRefreshRequested>(_onHomeRefreshRequested);
    on<HomeItemAdded>(_onHomeItemAdded);
    on<HomeItemRemoved>(_onHomeItemRemoved);
  }

  Future<void> _onHomeLoadRequested(
    HomeLoadRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoadInProgress());
    try {
      final items = await _repository.fetchItems();
      emit(HomeLoadSuccess(items: items));
    } catch (e) {
      emit(HomeLoadFailure(errorMessage: e.toString()));
    }
  }

  Future<void> _onHomeRefreshRequested(
    HomeRefreshRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoadInProgress());
    try {
      final items = await _repository.fetchItems();
      emit(HomeLoadSuccess(items: items));
    } catch (e) {
      emit(HomeLoadFailure(errorMessage: e.toString()));
    }
  }

  void _onHomeItemAdded(
    HomeItemAdded event,
    Emitter<HomeState> emit,
  ) {
    final currentState = state;
    if (currentState is HomeLoadSuccess) {
      emit(HomeLoadSuccess(items: [...currentState.items, event.item]));
    }
  }

  void _onHomeItemRemoved(
    HomeItemRemoved event,
    Emitter<HomeState> emit,
  ) {
    final currentState = state;
    if (currentState is HomeLoadSuccess) {
      final updatedItems = List<String>.from(currentState.items);
      if (event.index >= 0 && event.index < updatedItems.length) {
        updatedItems.removeAt(event.index);
        emit(HomeLoadSuccess(items: updatedItems));
      }
    }
  }
}
''',
    'lib/modules/home/bloc/home_event.dart': '''
part of 'home_bloc.dart';

/// Base class for all [HomeBloc] events.
///
/// Events represent user actions or system triggers that cause the Bloc
/// to produce new states. Each distinct action should be its own event
/// subclass, making the flow of data explicit and traceable.
abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

/// Event to request initial data load for the Home screen.
class HomeLoadRequested extends HomeEvent {}

/// Event to refresh/reload the Home screen data.
class HomeRefreshRequested extends HomeEvent {}

/// Event to add a new item to the list.
class HomeItemAdded extends HomeEvent {
  final String item;

  const HomeItemAdded(this.item);

  @override
  List<Object?> get props => [item];
}

/// Event to remove an item from the list by index.
class HomeItemRemoved extends HomeEvent {
  final int index;

  const HomeItemRemoved(this.index);

  @override
  List<Object?> get props => [index];
}
''',
    'lib/modules/home/bloc/home_state.dart': '''
part of 'home_bloc.dart';

/// Base class for all [HomeBloc] states.
///
/// Using sealed classes (or abstract base classes) for state allows
/// exhaustive pattern matching in the UI, ensuring every possible state
/// is handled.
abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any action is taken.
class HomeInitial extends HomeState {
  const HomeInitial();
}

/// Loading state while data is being fetched.
class HomeLoadInProgress extends HomeState {
  const HomeLoadInProgress();
}

/// Success state with loaded data.
class HomeLoadSuccess extends HomeState {
  final List<String> items;

  const HomeLoadSuccess({this.items = const []});

  @override
  List<Object?> get props => [items];
}

/// Failure state when an error occurs during data loading.
class HomeLoadFailure extends HomeState {
  final String errorMessage;

  const HomeLoadFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
''',
    'lib/modules/home/widget/home_cubit_item_list.dart': '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/home_cubit.dart';

/// A reusable list widget that uses [HomeCubit].
///
/// This widget demonstrates how a **Cubit-driven** widget works.
/// It reads state from [HomeCubit] and dispatches callbacks to remove items.
class HomeCubitItemList extends StatelessWidget {
  const HomeCubitItemList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!state.hasData) {
          return Center(
            child: Text(
              'No items yet',
              style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface.withValues(alpha: 0.72)),
            ),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.items.length,
          itemBuilder: (context, index) {
            return Card(
              color: colorScheme.surface,
              margin: const EdgeInsets.symmetric(vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: BorderSide(color: colorScheme.outline),
              ),
              child: ListTile(
                title: Text(
                  state.items[index],
                  style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface),
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    color: colorScheme.error,
                    size: 20,
                  ),
                  onPressed: () => context.read<HomeCubit>().removeItem(index),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
''',
    'lib/modules/home/widget/home_bloc_item_list.dart': '''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc.dart';

/// A reusable list widget that uses [HomeBloc].
///
/// This widget demonstrates how a **Bloc-driven** widget works.
/// It reacts to [HomeState] subclasses and dispatches [HomeEvent]s.
class HomeBlocItemList extends StatelessWidget {
  const HomeBlocItemList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoadInProgress) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is HomeLoadFailure) {
          return Center(
            child: Text(
              'Error: \${state.errorMessage}',
              style: textTheme.bodyMedium?.copyWith(color: colorScheme.error),
            ),
          );
        }

        if (state is HomeLoadSuccess) {
          if (state.items.isEmpty) {
            return Center(
              child: Text(
                'No items yet',
                style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface.withValues(alpha: 0.72)),
              ),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.items.length,
            itemBuilder: (context, index) {
              return Card(
                color: colorScheme.surface,
                margin: const EdgeInsets.symmetric(vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: BorderSide(color: colorScheme.outline),
                ),
                child: ListTile(
                  title: Text(
                    state.items[index],
                    style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete_outline_rounded,
                      color: colorScheme.error,
                      size: 20,
                    ),
                    onPressed: () => context.read<HomeBloc>().add(HomeItemRemoved(index)),
                  ),
                ),
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
''',
    'lib/repository/home_repository.dart': '''
/// {@template home_repository}
/// Repository class for the Home feature.
///
/// The **Repository pattern** separates data access logic from business logic.
/// A repository acts as a single source of truth for data, abstracting away
/// whether data comes from a local database, remote API, or cache.
///
/// ### Why use repositories:
/// - **Separation of concerns**: UI/Bloc/Cubit should not know about HTTP
///   clients or database implementations — they just call repository methods.
/// - **Testability**: Repositories can be mocked in tests, allowing Bloc/Cubit
///   unit tests to run without network calls.
/// - **Flexibility**: Swap out the data source (e.g., from API to local DB)
///   without changing any Bloc/Cubit code.
///
/// ### Usage:
/// ```dart
/// // In a Bloc or Cubit
/// class HomeCubit extends Cubit<HomeState> {
///   final HomeRepository _repository;
///
///   HomeCubit(this._repository) : super(const HomeState());
///
///   Future<void> loadData() async {
///     emit(state.copyWith(isLoading: true));
///     try {
///       final items = await _repository.fetchItems();
///       emit(state.copyWith(isLoading: false, items: items));
///     } catch (e) {
///       emit(state.copyWith(isLoading: false, error: e.toString()));
///     }
///   }
/// }
///
/// // Providing the repository
/// RepositoryProvider(
///   create: (context) => HomeRepository(),
///   child: BlocProvider(
///     create: (context) => HomeCubit(context.read<HomeRepository>()),
///     child: HomeScreen(),
///   ),
/// )
/// ```
/// {@endtemplate}
class HomeRepository {
  /// Fetches a list of items from the data source.
  ///
  /// In a real application, this method would call [ApiService] or a
  /// local database. For this template, it returns mock data.
  Future<List<String>> fetchItems() async {
    await Future.delayed(const Duration(seconds: 1));
    return ['Item A', 'Item B', 'Item C'];
  }

  /// Fetches a single item by its ID.
  Future<String> fetchItemById(int id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return 'Item \$id';
  }
}
''',
    'lib/services/api_service.dart': '''
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://example.com';

  ApiService();
  Future<http.Response> get(String endpoint) async {
    final url = Uri.parse(baseUrl + endpoint);
    final response = await http.get(url);
    return _handleResponse(response);
  }
  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse(baseUrl + endpoint);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  Future<http.Response> put(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse(baseUrl + endpoint);
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }
  Future<http.Response> delete(String endpoint) async {
    final url = Uri.parse(baseUrl + endpoint);
    final response = await http.delete(url);
    return _handleResponse(response);
  }

  Future<http.Response> uploadFile(String endpoint, File file, {String fieldName = 'file'}) async {
    final url = Uri.parse(baseUrl + endpoint);
    final request = http.MultipartRequest('POST', url);

    request.files.add(
      await http.MultipartFile.fromPath(fieldName, file.path),
    );

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    return _handleResponse(response);
  }

  http.Response _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response;
    } else {
      throw Exception('HTTP Error: False');
    }
  }
}
''',
    'languages/en-US.json': '''
{
  "welcome": "Welcome to the Home Page!",
  "home": "Home",
  "search": "Search",
  "profile": "Profile",
  "settings": "Settings",
  "change_language": "Change Language",
  "dark_mode": "Dark Mode",
  "light_mode": "Light Mode",
  "search_hint": "Search something...",
  "my_profile": "My Profile",
  "edit_profile": "Edit Profile",
  "notifications": "Notifications",
  "privacy": "Privacy Policy",
  "logout": "Logout",
  "language_en": "English",
  "language_my": "Myanmar",
  "select_language": "Select Language",
  "cancel": "Cancel"
}

''',
    'languages/my-MM.json': '''
{
  "welcome": "Home Page မှ ကြိုဆိုပါတယ်!",
  "home": "ပင်မ",
  "search": "ရှာဖွေရန်",
  "profile": "ကိုယ်ရေးအချက်အလက်",
  "settings": "ဆက်တင်",
  "change_language": "ဘာသာစကားပြောင်းရန်",
  "dark_mode": "အမှောင်မုဒ်",
  "light_mode": "အလင်းမုဒ်",
  "search_hint": "အခုပဲ ရှာဖွေလိုက်...",
  "my_profile": "ကျွန်တော့်ပရိုဖိုင်",
  "edit_profile": "ပရိုဖိုင်ပြင်ရန်",
  "notifications": "သတိပေးချက်",
  "privacy": "ကိုယ်ရေးအချက်အလက် မူဝါဒ",
  "logout": "ထွက်ရန်",
  "language_en": "English",
  "language_my": "မြန်မာ",
  "select_language": "ဘာသာစကားရွေးချယ်ရန်",
  "cancel": "ပယ်ဖျက်"
}

''',
    'lib/utils/extensions.dart': '''
import 'package:http_parser/http_parser.dart';

extension StringExtension on String? {
  bool get isNullOrEmpty {
    return this == null || this!.isEmpty || this == 'null';
  }

  bool get isPdf {
    return this?.toLowerCase().contains('pdf') ?? this?.contains('.pdf') ?? false;
  }
}

/// isNullOrEmpty Extensions for List
extension ListExtension on List<dynamic>? {
  bool get isNullOrEmpty {
    return this?.isEmpty ?? true;
  }
}

/// An extension that let us easily control over the DateTime.now();
extension MutableDateTime on DateTime {
  static DateTime? _customTime;

  static DateTime get current {
    return _customTime ?? DateTime.now();
  }

  static set customTime(DateTime customTime) {
    _customTime = customTime;
  }
}

extension GetMediaTypeFromFileExtension on String {
  MediaType getMediaType() {
    String mediaType = '';
    String attachType = split('.').last.toLowerCase();
    if (['png', 'jpg', 'jpeg'].contains(attachType)) {
      mediaType = 'image';
    }
    if (['pdf', 'doc', 'docx', 'msg'].contains(attachType)) {
      mediaType = 'application';
    }
    return MediaType(mediaType, attachType);
  }
}

extension DateTimeExtensions on DateTime {
  // Get the first day of the month
  DateTime get firstDayOfMonth {
    return DateTime(year, month, 1);
  }

  // Get the last day of the month
  DateTime get lastDayOfMonth {
    return DateTime(year, month + 1, 0);
  }
}
''',
    'lib/modules/main/screen/main_screen.dart': '''
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainScreen({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: colorScheme.onSurface.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(
                  icon: Icons.home_rounded,
                  label: tr('home'),
                  isSelected: navigationShell.currentIndex == 0,
                  colorScheme: colorScheme,
                  textTheme: textTheme,
                  onTap: () => navigationShell.goBranch(0),
                ),
                _NavItem(
                  icon: Icons.search_rounded,
                  label: tr('search'),
                  isSelected: navigationShell.currentIndex == 1,
                  colorScheme: colorScheme,
                  textTheme: textTheme,
                  onTap: () => navigationShell.goBranch(1),
                ),
                _NavItem(
                  icon: Icons.person_rounded,
                  label: tr('profile'),
                  isSelected: navigationShell.currentIndex == 2,
                  colorScheme: colorScheme,
                  textTheme: textTheme,
                  onTap: () => navigationShell.goBranch(2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.colorScheme,
    required this.textTheme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 20 : 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primary.withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? colorScheme.primary
                  : colorScheme.onSurface.withValues(alpha: 0.6),
              size: 24,
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
''',
    'lib/modules/search/screen/search_screen.dart': '''
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  static const route = '/search';

  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tr('search'),
                style: textTheme.headlineLarge?.copyWith(color: colorScheme.onSurface),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: colorScheme.outline),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: tr('search_hint'),
                    hintStyle: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface.withValues(alpha: 0.62)),
                    prefixIcon: Icon(Icons.search_rounded, color: colorScheme.primary),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.transparent,
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface),
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.search_rounded,
                        size: 80,
                        color: colorScheme.outline,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        tr('search_hint'),
                        style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface.withValues(alpha: 0.72)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
''',
    'lib/modules/profile/screen/profile_screen.dart': '''
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/locale_config/locale_cubit.dart';
import '../../../config/theme_config/theme_cubit.dart';

class ProfileScreen extends StatelessWidget {
  static const route = '/profile';

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tr('profile'),
                style: textTheme.headlineLarge?.copyWith(color: colorScheme.onSurface),
              ),
              const SizedBox(height: 24),
              _ProfileCard(colorScheme: colorScheme, textTheme: textTheme),
              const SizedBox(height: 20),
              _SettingsSection(colorScheme: colorScheme, textTheme: textTheme),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  const _ProfileCard({required this.colorScheme, required this.textTheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorScheme.primary, colorScheme.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.surface.withValues(alpha: 0.18),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.person_rounded, color: colorScheme.surface, size: 36),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr('my_profile'),
                  style: textTheme.titleLarge?.copyWith(color: colorScheme.surface),
                ),
                const SizedBox(height: 4),
                Text(
                  'user@example.com',
                  style: textTheme.bodyMedium?.copyWith(color: colorScheme.surface.withValues(alpha: 0.8)),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: colorScheme.surface.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.edit_rounded, color: colorScheme.surface, size: 20),
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  const _SettingsSection({required this.colorScheme, required this.textTheme});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            tr('settings'),
            style: textTheme.titleMedium?.copyWith(color: colorScheme.onSurface),
          ),
        ),
        _SettingsTile(
          icon: Icons.language_rounded,
          title: tr('change_language'),
          colorScheme: colorScheme,
          textTheme: textTheme,
          onTap: () => _showLanguageSheet(context),
        ),
        const SizedBox(height: 12),
        _SettingsTile(
          icon: Theme.of(context).brightness == Brightness.dark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
          title: Theme.of(context).brightness == Brightness.dark ? tr('light_mode') : tr('dark_mode'),
          colorScheme: colorScheme,
          textTheme: textTheme,
          onTap: () => context.read<ThemeCubit>().toggleTheme(),
        ),
        const SizedBox(height: 12),
        _SettingsTile(
          icon: Icons.notifications_rounded,
          title: tr('notifications'),
          colorScheme: colorScheme,
          textTheme: textTheme,
          onTap: () {},
        ),
        const SizedBox(height: 12),
        _SettingsTile(
          icon: Icons.privacy_tip_rounded,
          title: tr('privacy'),
          colorScheme: colorScheme,
          textTheme: textTheme,
          onTap: () {},
        ),
        const SizedBox(height: 24),
        _SettingsTile(
          icon: Icons.logout_rounded,
          title: tr('logout'),
          colorScheme: colorScheme,
          textTheme: textTheme,
          isDestructive: true,
          onTap: () {},
        ),
      ],
    );
  }

  void _showLanguageSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return const _LanguageSheet();
      },
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final bool isDestructive;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.colorScheme,
    required this.textTheme,
    this.isDestructive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final accentColor = isDestructive
        ? colorScheme.error
        : colorScheme.primary;

    return Material(
      color: colorScheme.surface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: accentColor, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  title,
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: isDestructive ? colorScheme.error : colorScheme.onSurface,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: colorScheme.onSurface.withValues(alpha: 0.55),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguageSheet extends StatelessWidget {
  const _LanguageSheet();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: colorScheme.outline,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Text(
            tr('select_language'),
            style: textTheme.titleLarge?.copyWith(color: colorScheme.onSurface),
          ),
          const SizedBox(height: 20),
          _LanguageOption(
            flag: '\\u{1F1FA}\\u{1F1F8}',
            label: tr('language_en'),
            locale: const Locale('en', 'US'),
          ),
          const SizedBox(height: 12),
          _LanguageOption(
            flag: '\\u{1F1F2}\\u{1F1F2}',
            label: tr('language_my'),
            locale: const Locale('my', 'MM'),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                tr('cancel'),
                style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface.withValues(alpha: 0.72)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String flag;
  final String label;
  final Locale locale;

  const _LanguageOption({
    required this.flag,
    required this.label,
    required this.locale,
  });

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale;
    final isSelected = currentLocale == locale;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Material(
      color: isSelected ? colorScheme.primary.withValues(alpha: 0.12) : colorScheme.surface,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: () {
          context.read<LocaleCubit>().changeLocale(locale, context);
          Navigator.pop(context);
        },
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: isSelected
                ? Border.all(color: colorScheme.primary, width: 1.5)
                : null,
          ),
          child: Row(
            children: [
              Text(flag, style: textTheme.titleLarge),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  label,
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected ? colorScheme.primary : colorScheme.onSurface,
                  ),
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle_rounded,
                  color: colorScheme.primary,
                  size: 22,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
''',
  };
}
