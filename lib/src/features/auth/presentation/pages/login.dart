import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:imaginez/src/core/routing/route_paths.dart';
import 'package:imaginez/src/features/auth/domain/usecases/logout_user.dart';
import 'package:imaginez/src/features/auth/domain/usecases/save_user.dart';
import 'package:imaginez/src/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:imaginez/src/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:imaginez/src/features/auth/presentation/bloc/auth/auth_event.dart';
import 'package:imaginez/src/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:imaginez/src/features/auth/presentation/bloc/login/login_event.dart';
import 'package:imaginez/src/features/auth/presentation/bloc/login/login_state.dart';
import 'package:imaginez/src/injection/service_locator.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: BlocProvider(
      create: (context) => LoginBloc(
        signInWithGoogle: sl<SignInWithGoogle>(),
        saveUser: sl<SaveUser>(),
        logoutUser: sl<LogoutUser>(),
      ),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6A11CB), Color(0xFF2575FC)], // Purple → Blue
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: LayoutBuilder(
                builder: (context, constraints) => Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Welcome Back 👋',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Login to continue',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 32),
                        BlocListener<LoginBloc, LoginState>(
                          listener: (context, state) {
                            if (state.user != null) {
                              context.read<AuthBloc>().add(CheckAuthStatus());
                              context.go(RoutePaths.home);
                            }
                          },
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: const BorderSide(color: Colors.grey),
                              ),
                              elevation: 2,
                            ),
                            icon: const Icon(Icons.email_rounded),
                            label: const Text(
                              'Sign in with Google',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            onPressed: () async {
                              context.read<LoginBloc>().add(
                                GoogleLoginRequested(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          BlocBuilder<LoginBloc, LoginState>(
            buildWhen: (previous, current) =>
                previous.isSigningIn != current.isSigningIn,
            builder: (context, state) {
              if (!state.isSigningIn)
                return const SizedBox.shrink(); // 👈 hide when false

              // 👇 show when true
              return Positioned(
                bottom: 20,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Please wait. Signing you in',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Transform.scale(
                        scale: 0.4,
                        child: const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    ),
  );
}
