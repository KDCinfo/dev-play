/// This class acts as a base class for all repositories in
/// the app so they can be passed from the root level into both the
/// `AppProviderWrapperRepository` and `AppProviderWrapperBloc` widgets in [[main.dart]].
///
abstract class AppBaseRepository {
  void initRepository() {}
}
