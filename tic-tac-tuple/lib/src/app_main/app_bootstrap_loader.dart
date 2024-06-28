import 'dart:async';

import 'package:base_services/base_services.dart';

import 'package:dev_play_tictactuple/src/src.dart';

class BootParameters {
  const BootParameters();
}

class AppBootstrapLoader {
  const AppBootstrapLoader(this.params);

  final BootParameters params;

  Future<void> start() async {
    /// APIs
    ///
    final sharedPrefsApi = await SharedPrefsApi.init();
    final secureStorageApi = FlutterSecureStorageApi();

    /// Services and Repositories
    ///
    final storageApi = StorageServiceProd(
      localStorageApi: sharedPrefsApi,
      localSecureStorageApi: secureStorageApi,
      canPrint: AppConstants.canPrint,
    );

    // storageApi.prefsClearAll();

    final scorebookRepository = ScorebookRepository(
      storageService: storageApi,
    );

    final repositories = [
      RepositoryTypeWrapper<ScorebookRepository>(
        repository: scorebookRepository,
      ),
    ];

    await appLoadBlocObserver(
      () => AppProviderWrapperRepository(
        repositories: repositories,
        child: const AppProviderWrapperBloc<AppBaseRepository>(
          child: AppWrapper(),
        ),
      ),
    );
  }
}
