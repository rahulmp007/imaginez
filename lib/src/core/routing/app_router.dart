import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imaginez/src/app/presentation/page/splash.dart';
import 'package:imaginez/src/features/auth/presentation/pages/login.dart';
import 'package:imaginez/src/features/auth/presentation/pages/profile.dart';
import 'package:imaginez/src/features/auth/presentation/widgets/auth_aware.dart';
import 'package:imaginez/src/features/feeds/presentation/pages/generate.dart';
import 'package:imaginez/src/features/feeds/presentation/pages/feeds.dart';

import 'route_paths.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RoutePaths.splash,
    redirect: (context, state) {
      // Add redirect logic based on auth state

      // final isAuthenticated = context.read<AuthBloc>().state.isAuthenticated;

      // If authenticated and trying to access auth pages, redirect to home
      // if (isAuthenticated && isAuthPath) {
      //   return RoutePaths.home;
      // }

      // If not authenticated and trying to access protected pages, redirect to login
      // if (!isAuthenticated && !isAuthPath) {
      //   return RoutePaths.login;
      // }

      return null; // No redirect
    },
    errorBuilder: (context, state) => const Scaffold(body: SizedBox()),

    routes: [
      GoRoute(
        path: RoutePaths.splash,
        builder: (context, state) => const Splash(),
      ),
      GoRoute(
        path: RoutePaths.auth,
        builder: (context, state) => const AuthAwareWidget(),
      ),

      GoRoute(
        path: RoutePaths.login,
        builder: (context, state) => const Login(),
      ),
      GoRoute(
        path: RoutePaths.home,
        builder: (context, state) => const PromptsFeed(),
      ),
      GoRoute(
        path: RoutePaths.profile,
        builder: (context, state) => const Profile(),
      ),
      GoRoute(
        path: RoutePaths.generate,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const Generate(),
          transitionDuration: const Duration(milliseconds: 350),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final tween = Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).chain(CurveTween(curve: Curves.easeOut));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
      ),
    ],
  );
}
