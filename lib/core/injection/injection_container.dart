import 'package:commerce_flutter_app/features/domain/usecases/domain_selection_usecase/domain_selection_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/auth/auth_cubit.dart';
import 'package:commerce_flutter_app/services/cache_fake.dart';
import 'package:commerce_flutter_app/services/local_storage_service.dart';
import 'package:commerce_flutter_app/services/network_fake.dart';
import 'package:commerce_flutter_app/services/secure_storage_fake.dart';
import 'package:get_it/get_it.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

final sl = GetIt.instance;

Future<void> initInjectionContainer() async {
  sl

    //login
    ..registerLazySingleton(() => AuthCubit())
    ..registerLazySingleton<IAccountService>(() => AccountService(
          clientService: sl(),
          cacheService: sl(),
          networkService: sl(),
        ))
    ..registerLazySingleton<IAuthenticationService>(() => AuthenticationService(
          sessionService: sl(),
          clientService: sl(),
          cacheService: sl(),
          networkService: sl(),
        ))
    ..registerLazySingleton<ISessionService>(() => SessionService(
          clientService: sl(),
          cacheService: sl(),
          networkService: sl(),
        ))
    ..registerLazySingleton<IMobileSpireContentService>(
        () => MobileSpireContentService(
              clientService: sl(),
              cacheService: sl(),
              networkService: sl(),
            ))
    ..registerLazySingleton<IClientService>(() =>
        ClientService(localStorageService: sl(), secureStorageService: sl()))

    //product page
    ..registerLazySingleton<ICacheService>(() => FakeCacheService())
    ..registerLazySingleton<INetworkService>(() => FakeNetworkService(true))
    ..registerLazySingleton<ISecureStorageService>(
        () => FakeSecureStorageService())
    ..registerLazySingleton<ILocalStorageService>(() => LocalStorageService())

    //domain selection
    ..registerLazySingleton<DomainSelectionUsecase>(
        () => DomainSelectionUsecase())
    ..registerLazySingleton<ISettingsService>(() => SettingsService(
          cacheService: sl(),
          clientService: sl(),
          networkService: sl(),
        ))
    ..registerLazySingleton<IAdminClientService>(() => AdminClientService(
          localStorageService: sl(),
          secureStorageService: sl(),
        ));
}
