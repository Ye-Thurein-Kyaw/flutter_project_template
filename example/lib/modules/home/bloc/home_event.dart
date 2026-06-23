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
