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
    return 'Item $id';
  }
}
