import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:imaginez/src/app/startup/bloc/app_startup_bloc.dart';
import 'package:imaginez/src/app/startup/bloc/app_startup_state.dart';
import 'package:imaginez/src/core/routing/route_paths.dart';
import 'package:imaginez/src/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:imaginez/src/features/auth/presentation/bloc/auth/auth_event.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    log('IN SPLASH....');
    return Scaffold(
      body: BlocListener<AppStartupBloc, AppStartupState>(
        listener: (context, state) {
          if (state is AppStartupSuccess) {
            context.read<AuthBloc>().add(CheckAuthStatus());
            context.go(RoutePaths.auth);
          } else if (state is AppStartupFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Startup failed')));
          }
        },
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
