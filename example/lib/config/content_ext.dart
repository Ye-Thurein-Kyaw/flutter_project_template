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
