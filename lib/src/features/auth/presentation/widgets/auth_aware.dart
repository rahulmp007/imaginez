import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:imaginez/src/core/routing/route_paths.dart';
import 'package:imaginez/src/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:imaginez/src/features/auth/presentation/bloc/auth/auth_state.dart';
import 'package:imaginez/src/features/auth/presentation/pages/login.dart';

class AuthAwareWidget extends StatelessWidget {
  const AuthAwareWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (prev, curr) => prev.runtimeType != curr.runtimeType,
      listener: (context, state) {
        final router = GoRouter.of(context);
        final currentPath = router.state.fullPath;
        log('🔄 AuthAware → $state');

        if (state is Authenticated && currentPath != RoutePaths.home) {
          router.go(RoutePaths.home);
        } else if (state is Unauthenticated &&
            currentPath != RoutePaths.login) {
          router.go(RoutePaths.login);
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state is Unauthenticated) {
            return const Login();
          } else if (state is Authenticated) {
            return const Scaffold(body: SizedBox.shrink());
          } else if (state is AuthError) {
            return Scaffold(body: Center(child: Text(state.message)));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
