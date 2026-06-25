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
