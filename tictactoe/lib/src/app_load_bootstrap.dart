import 'dart:async';

import 'package:base_services/base_services.dart';

import 'package:dev_play_tictactoe/src/src.dart';

class BootParameters {
  const BootParameters({
    this.isProd = false,
  });

  // isProd
  final bool isProd;
}

class BootstrapLoader {
  const BootstrapLoader(this.params);

  final BootParameters params;

  Future<void> start() async {
    /// APIs
    ///
    final sharedPrefsApi = await SharedPrefsApi.init();
    final secureStorageApi = FlutterSecureStorageApi();

    /// Services and Repositories
    ///
    final storageApi = StorageServiceImpl(
      localStorageApi: sharedPrefsApi,
      localSecureStorageApi: secureStorageApi,
      canPrint: !params.isProd,
    );

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
          child: MyApp(),
        ),
      ),
    );
  }
}
