import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:imaginez/src/core/routing/route_paths.dart';
import 'package:imaginez/src/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:imaginez/src/features/auth/presentation/bloc/auth/auth_event.dart';
import 'package:imaginez/src/features/auth/presentation/bloc/auth/auth_state.dart';
import 'package:imaginez/src/features/feeds/presentation/widgets/user_image.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Unauthenticated) {
              context.go(RoutePaths.login);
            }
          },
          builder: (context, state) {
            if (state is AuthInitial || state is AuthLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is Authenticated) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const UserImage(radius: 55),
                  Text(
                    state.user.displayName.isNotEmpty
                        ? state.user.displayName
                        : 'Guest',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Text(
                        state.user.email,
                        style: Theme.of(
                          context,
                        ).textTheme.titleLarge?.copyWith(fontSize: 18),
                      ),
                      const SizedBox(width: 8),
                      if (state.user.isEmailVerified)
                        const Icon(
                          Icons.verified_outlined,
                          color: Colors.green,
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(48),
                    ),
                    onPressed: () {
                      context.read<AuthBloc>().add(LogoutRequested());
                    },
                    icon: const Icon(Icons.logout, size: 20),
                    label: const Text(
                      'Logout',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
