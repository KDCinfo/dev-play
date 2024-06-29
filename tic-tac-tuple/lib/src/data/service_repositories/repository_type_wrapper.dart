/// The `RepositoryTypeWrapper` class provides a way to pass multiple repositories
/// to the `MultiRepositoryProvider` widget while maintaining type safety.
///
///     # Implementation
///
///     [[ main.dart ]]
///
///     final repositories = [
///       RepositoryTypeWrapper<ScorebookRepository>(
///         repository: scorebookRepository,
///       ),
///     ];
///
///     # Usage
///
///     [[ app_repository_provider_wrapper.dart ]]
///
///     class AppRepositoryProviderWrapper<T extends AppBaseRepository> extends StatelessWidget {
///       const AppRepositoryProviderWrapper({ required this.repositories });
///
///       final List<RepositoryTypeWrapper<T>> repositories;
///
///       Widget build(BuildContext context) {
///         return MultiRepositoryProvider(
///           providers: [
///             for (final repositoryTypeWrapper in repositories)
///               RepositoryProvider(
///                 create: (context) => repositoryTypeWrapper.repository, // as ScorebookRepository,
///               ),
///
class RepositoryTypeWrapper<T> {
  const RepositoryTypeWrapper({required this.repository});

  final T repository;
}
