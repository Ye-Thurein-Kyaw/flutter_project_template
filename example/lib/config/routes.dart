import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../main.dart';
import '../modules/home/bloc/home_bloc.dart';
import '../modules/home/cubit/home_cubit.dart';
import '../modules/home/screen/home_screen.dart';
import '../modules/main/screen/main_screen.dart';
import '../modules/profile/screen/profile_screen.dart';
import '../modules/search/screen/search_screen.dart';
import '../modules/splash/screen/splash_screen.dart';
import '../repository/home_repository.dart';

class Routes {
  static final GoRouter routes = GoRouter(
    initialLocation: Splash.route,
    debugLogDiagnostics: true,
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        name: Splash.route,
        path: Splash.route,
        builder: (context, state) => const Splash(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: HomeScreen.route,
                path: HomeScreen.route,
                builder: (context, state) => RepositoryProvider(
                  create: (context) => HomeRepository(),
                  child: MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => HomeCubit(context.read<HomeRepository>()),
                      ),
                      BlocProvider(
                        create: (context) => HomeBloc(context.read<HomeRepository>()),
                      ),
                    ],
                    child: const HomeScreen(),
                  ),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: SearchScreen.route,
                path: SearchScreen.route,
                builder: (context, state) => const SearchScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                name: ProfileScreen.route,
                path: ProfileScreen.route,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
