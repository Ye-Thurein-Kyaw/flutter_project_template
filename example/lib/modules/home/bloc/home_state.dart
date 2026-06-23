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
