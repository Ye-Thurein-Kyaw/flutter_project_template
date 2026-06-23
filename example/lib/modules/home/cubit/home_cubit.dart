import 'package:flutter_bloc/flutter_bloc.dart';

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
///   create: (context) => HomeCubit(),
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
  HomeCubit() : super(const HomeState());

  /// Loads sample data and updates the state.
  ///
  /// Demonstrates a simple async state transition using Cubit.
  /// In a real app, this would call a repository method.
  Future<void> loadData() async {
    emit(state.copyWith(isLoading: true));

    await Future.delayed(const Duration(seconds: 1));

    emit(state.copyWith(
      isLoading: false,
      items: ['Item 1', 'Item 2', 'Item 3'],
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
