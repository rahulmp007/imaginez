import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:imaginez/src/app/app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imaginez/src/app/bloc_observer.dart';
import 'package:imaginez/src/app/startup/bloc/app_startup_bloc.dart';
import 'package:imaginez/src/app/startup/bloc/app_startup_event.dart';
import 'package:imaginez/src/core/network/connectivity/bloc/network_bloc.dart';
import 'package:imaginez/src/core/service/hive_service.dart';
import 'package:imaginez/src/features/auth/domain/usecases/auth_user_changed..dart';
import 'package:imaginez/src/features/auth/domain/usecases/get_current_user.dart';
import 'package:imaginez/src/features/auth/domain/usecases/logout_user.dart';
import 'package:imaginez/src/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:imaginez/src/injection/service_locator.dart';

Future initializer() async {
  Bloc.observer = AppBlocObserver();
  await setupLocator();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AppStartupBloc>(
          create: (context) =>
              AppStartupBloc(hiveService: sl<HiveService>())
                ..add(InitializeApp()),
        ),
        BlocProvider(create: (context) => sl<NetworkBloc>()),
        BlocProvider(
          create: (context) => AuthBloc(
            getCurrentUser: sl<GetCurrentUser>(),
            logoutUser: sl<LogoutUser>(),
            observeAuthState: sl<ObserveAuthState>(),
          ),
        ),
      ],
      child: const Imagines(),
    ),
  );
}
