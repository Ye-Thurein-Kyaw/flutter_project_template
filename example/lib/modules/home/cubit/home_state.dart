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
