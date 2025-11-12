import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:imaginez/src/core/network/api_client.dart';
import 'package:imaginez/src/core/service/hive_service.dart';
import 'package:imaginez/src/core/service/local_storage.dart';
import 'package:imaginez/src/features/auth/data/data_sources/auth_remote_source.dart';
import 'package:imaginez/src/features/auth/data/data_sources/auth_local_source.dart';
import 'package:imaginez/src/features/auth/data/repository/auth_repository_impl.dart';
import 'package:imaginez/src/features/auth/domain/repository/auth_repository.dart';
import 'package:imaginez/src/features/auth/domain/usecases/auth_user_changed..dart';
import 'package:imaginez/src/features/auth/domain/usecases/get_current_user.dart';
import 'package:imaginez/src/features/auth/domain/usecases/login_user.dart';
import 'package:imaginez/src/features/auth/domain/usecases/logout_user.dart';
import 'package:imaginez/src/features/auth/domain/usecases/save_user.dart';
import 'package:imaginez/src/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:imaginez/src/features/feeds/data/datatsources/prompts_api_source.dart';
import 'package:imaginez/src/features/feeds/data/repository/prompt_repo_impl.dart';
import 'package:imaginez/src/features/feeds/domain/repository/prompt_repo.dart';
import 'package:imaginez/src/features/feeds/domain/usecases/get_prompts.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  // sl.registerLazySingleton<Connectivity>(() => Connectivity());
  // sl.registerLazySingleton<InternetConnectionChecker>(
  //   () => InternetConnectionChecker.createInstance(),
  // );

  // sl.registerLazySingleton<ConnectivityService>(
  //   () => ConnectivityServiceImpl(
  //     checker: sl<InternetConnectionChecker>(),
  //     connectivity: sl<Connectivity>(),
  //   ),
  // );
  // sl.registerLazySingleton(
  //   () => NetworkBloc(connectivityService: sl<ConnectivityService>()),
  // );

  /// api client
  sl.registerLazySingleton<ApiClient>(ApiClient.new);

  sl.registerLazySingleton<HiveService>(HiveService.new);

  /// local data source : categories
  sl.registerLazySingleton<GetPrompts>(
    () => GetPrompts(promptRepo: sl<PromptRepo>()),
  );

  sl.registerLazySingleton<PromptRepo>(
    () => PromptRepoImpl(apiSource: sl<PromptsApiSource>()),
  );

  sl.registerLazySingleton<PromptsApiSource>(
    () => PromptsApiSource(client: sl<ApiClient>()),
  );

  sl.registerLazySingleton<LocalStorageService>(LocalStorageService.new);

  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  sl.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn.instance);

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      firebaseAuth: sl<FirebaseAuth>(),
      googleSignIn: sl<GoogleSignIn>(),
      client: sl<ApiClient>(),
    ),
  );

  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(localStorage: sl<LocalStorageService>()),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      api: sl<AuthRemoteDataSource>(),
      local: sl<AuthLocalDataSource>(),
    ),
  );

  sl.registerLazySingleton<GetCurrentUser>(
    () => GetCurrentUser(repository: sl<AuthRepository>()),
  );

  sl.registerLazySingleton<LogoutUser>(
    () => LogoutUser(repository: sl<AuthRepository>()),
  );

  sl.registerLazySingleton<ObserveAuthState>(
    () => ObserveAuthState(repository: sl<AuthRepository>()),
  );

  sl.registerLazySingleton<LoginUser>(
    () => LoginUser(repository: sl<AuthRepository>()),
  );

  sl.registerLazySingleton<SaveUser>(
    () => SaveUser(repository: sl<AuthRepository>()),
  );

  // usecase
  sl.registerLazySingleton<SignInWithGoogle>(
    () => SignInWithGoogle(repository: sl<AuthRepository>()),
  );
}
