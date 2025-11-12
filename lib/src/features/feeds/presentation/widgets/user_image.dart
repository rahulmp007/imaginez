

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imaginez/src/features/auth/domain/entity/user.dart';
import 'package:imaginez/src/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:imaginez/src/features/auth/presentation/bloc/auth/auth_state.dart';

class UserImage extends StatelessWidget {
  final double radius;

  const UserImage({super.key, this.radius = 24});

  @override
  Widget build(BuildContext context) => BlocBuilder<AuthBloc, AuthState>(
    builder: (context, state) {
      User? user;
      if (state is Authenticated) {
        user = state.user;
      }

      final photoUrl = user?.photoUrl.isNotEmpty ?? false
          ? user!.photoUrl
          : null;

      return CircleAvatar(
        radius: radius,
        backgroundColor: Colors.white,
        child: CircleAvatar(
          radius: radius - 2,
          backgroundColor: Colors.grey.shade200,
          child: photoUrl != null
              ? ClipOval(
                  child: Image.network(
                    photoUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // Show default icon if image fails
                      return Icon(
                        Icons.person,
                        size: radius,
                        color: Colors.grey.shade600,
                      );
                    },
                  ),
                )
              : Icon(Icons.person, size: radius, color: Colors.grey.shade600),
        ),
      );
    },
  );
}
