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
///       return Text('Error: ${state.errorMessage}');
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
