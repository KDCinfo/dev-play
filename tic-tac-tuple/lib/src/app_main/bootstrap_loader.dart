import 'dart:async';

import 'package:base_services/base_services.dart';

import 'package:dev_play_tictactuple/src/app_constants.dart';
import 'package:dev_play_tictactuple/src/app_main/app_main.dart';
import 'package:dev_play_tictactuple/src/data/service_repositories/service_repositories.dart';

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
