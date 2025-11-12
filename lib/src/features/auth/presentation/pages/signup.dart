// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:prompthub/src/features/auth/application/validators/auth_validators.dart';
// import 'package:prompthub/src/features/auth/domain/usecases/signup_user.dart';
// import 'package:prompthub/src/features/auth/presentation/bloc/signup/signup_bloc.dart';
// import 'package:prompthub/src/features/auth/presentation/bloc/signup/signup_event.dart';
// import 'package:prompthub/src/features/auth/presentation/bloc/signup/signup_state.dart';
// import 'package:prompthub/src/features/auth/presentation/pages/login.dart';
// import 'package:prompthub/src/injection/service_locator.dart';

// class SignUp extends StatefulWidget {
//   const SignUp({super.key});

//   @override
//   State<SignUp> createState() => _SignUpState();
// }

// class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {
//   final _formKey = GlobalKey<FormState>();

//   void _submit() async {
//     if (!_formKey.currentState!.validate()) return;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final mq = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
//               ),
//             ),
//           ),

//           Positioned(
//             top: -mq.width * 0.25,
//             right: -mq.width * 0.2,
//             child: Container(
//               width: mq.width * 0.6,
//               height: mq.width * 0.6,
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.06),
//                 shape: BoxShape.circle,
//               ),
//             ),
//           ),

//           Center(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
//               child: ConstrainedBox(
//                 constraints: BoxConstraints(maxWidth: 520),
//                 child: Card(
//                   elevation: 16,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   color: Colors.white.withOpacity(0.96),
//                   child: Padding(
//                     padding: const EdgeInsets.all(24.0),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Row(
//                           children: [
//                             Container(
//                               padding: const EdgeInsets.all(10),
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 gradient: const LinearGradient(
//                                   colors: [
//                                     Color(0xFF89F7FE),
//                                     Color(0xFF66A6FF),
//                                   ],
//                                 ),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.black.withOpacity(0.1),
//                                     blurRadius: 8,
//                                     offset: Offset(0, 4),
//                                   ),
//                                 ],
//                               ),
//                               child: const Icon(
//                                 Icons.shopping_bag_rounded,
//                                 color: Colors.white,
//                                 size: 28,
//                               ),
//                             ),
//                             const SizedBox(width: 12),
//                             const Expanded(
//                               child: Text(
//                                 'Create account',
//                                 style: TextStyle(
//                                   fontSize: 22,
//                                   fontWeight: FontWeight.w700,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),

//                         const SizedBox(height: 18),

//                         const Text(
//                           'Join prompthub — manage products, orders and more. It only takes a minute.',
//                           style: TextStyle(
//                             fontSize: 13.5,
//                             color: Colors.black87,
//                           ),
//                         ),

//                         const SizedBox(height: 18),

//                         Form(
//                           key: _formKey,
//                           child: BlocProvider(
//                             create: (context) =>
//                                 SignupBloc(signupUser: sl<SignupUser>()),

//                             child: Column(
//                               children: [
//                                 // Name
//                                 BlocBuilder<SignupBloc, SignupState>(
//                                   builder: (context, state) {
//                                     return TextFormField(
//                                       onChanged: (value) {
//                                         context.read<SignupBloc>().add(
//                                           NameChanged(value: value),
//                                         );
//                                       },
//                                       textInputAction: TextInputAction.next,
//                                       decoration: InputDecoration(
//                                         hintText: 'Full Name',
//                                         prefixIcon: Icon(Icons.person),
//                                         filled: true,
//                                         errorText: mapNameError(state.fullname),

//                                         fillColor: Colors.white.withOpacity(
//                                           0.9,
//                                         ),
//                                         contentPadding:
//                                             const EdgeInsets.symmetric(
//                                               vertical: 18,
//                                               horizontal: 16,
//                                             ),
//                                         border: OutlineInputBorder(
//                                           borderRadius: BorderRadius.circular(
//                                             14,
//                                           ),
//                                           borderSide: BorderSide.none,
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 ),

//                                 const SizedBox(height: 12),

//                                 BlocBuilder<SignupBloc, SignupState>(
//                                   builder: (context, state) {
//                                     return TextFormField(
//                                       onChanged: (value) {
//                                         context.read<SignupBloc>().add(
//                                           EmailChanged(value: value),
//                                         );
//                                       },
//                                       keyboardType: TextInputType.emailAddress,
//                                       textInputAction: TextInputAction.next,
//                                       decoration: InputDecoration(
//                                         hintText: 'Email',
//                                         prefixIcon: Icon(Icons.email),
//                                         filled: true,
//                                         errorText: mapEmailError(state.email),
//                                         fillColor: Colors.white.withOpacity(
//                                           0.9,
//                                         ),
//                                         contentPadding:
//                                             const EdgeInsets.symmetric(
//                                               vertical: 18,
//                                               horizontal: 16,
//                                             ),
//                                         border: OutlineInputBorder(
//                                           borderRadius: BorderRadius.circular(
//                                             14,
//                                           ),
//                                           borderSide: BorderSide.none,
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 ),

//                                 const SizedBox(height: 12),

//                                 BlocBuilder<SignupBloc, SignupState>(
//                                   builder: (context, state) {
//                                     return TextFormField(
//                                       onChanged: (value) {
//                                         context.read<SignupBloc>().add(
//                                           PasswordChanged(value: value),
//                                         );
//                                       },
//                                       obscureText: !state.isPasswordVisible,
//                                       textInputAction: TextInputAction.done,
//                                       decoration: InputDecoration(
//                                         hintText: 'Password',
//                                         prefixIcon: Icon(Icons.lock_outline),
//                                         filled: true,
//                                         errorText: mapPasswordError(
//                                           state.password,
//                                         ),
//                                         suffixIcon: IconButton(
//                                           onPressed: () {
//                                             context.read<SignupBloc>().add(
//                                               TogglePasswordVisibility(),
//                                             );
//                                           },
//                                           icon: Icon(
//                                             !state.isPasswordVisible
//                                                 ? Icons.visibility_off
//                                                 : Icons.visibility,
//                                           ),
//                                         ),

//                                         fillColor: Colors.white.withOpacity(
//                                           0.9,
//                                         ),
//                                         contentPadding:
//                                             const EdgeInsets.symmetric(
//                                               vertical: 18,
//                                               horizontal: 16,
//                                             ),
//                                         border: OutlineInputBorder(
//                                           borderRadius: BorderRadius.circular(
//                                             14,
//                                           ),
//                                           borderSide: BorderSide.none,
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 ),

//                                 const SizedBox(height: 18),

//                                 Row(
//                                   children: const [
//                                     Expanded(
//                                       child: Text(
//                                         'By continuing you agree to our Terms & Privacy Policy.',
//                                         style: TextStyle(
//                                           fontSize: 12.0,
//                                           color: Colors.black54,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),

//                                 const SizedBox(height: 18),

//                                 // Submit
//                                 BlocListener<SignupBloc, SignupState>(
//                                   listener: (context, state) {
//                                     if (state.user != null) {
//                                       Navigator.pushReplacement(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) => Login(),
//                                         ),
//                                       );
//                                     }
//                                   },
//                                   child: BlocBuilder<SignupBloc, SignupState>(
//                                     builder: (context, state) {
//                                       return SizedBox(
//                                         width: double.infinity,
//                                         height: 54,
//                                         child: ElevatedButton(
//                                           onPressed: state.canSubmit
//                                               ? () {
//                                                   FocusScope.of(
//                                                     context,
//                                                   ).unfocus();
//                                                   context
//                                                       .read<SignupBloc>()
//                                                       .add(
//                                                         SignupRequested(
//                                                           name:
//                                                               state
//                                                                   .fullname
//                                                                   ?.value
//                                                                   .getOrElse(
//                                                                     () => '',
//                                                                   ) ??
//                                                               '',
//                                                           email:
//                                                               state.email?.value
//                                                                   .getOrElse(
//                                                                     () => '',
//                                                                   ) ??
//                                                               '',
//                                                           password:
//                                                               state
//                                                                   .password
//                                                                   ?.value
//                                                                   .getOrElse(
//                                                                     () => '',
//                                                                   ) ??
//                                                               '',
//                                                         ),
//                                                       );
//                                                 }
//                                               : () {
//                                                   log(state.toString());
//                                                 },
//                                           style: ElevatedButton.styleFrom(
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(12),
//                                             ),
//                                             elevation: 6,
//                                             padding: EdgeInsets.zero,
//                                           ),
//                                           child: Ink(
//                                             decoration: BoxDecoration(
//                                               gradient: const LinearGradient(
//                                                 colors: [
//                                                   Color(0xFF667EEA),
//                                                   Color(0xFF764BA2),
//                                                 ],
//                                               ),
//                                               borderRadius:
//                                                   BorderRadius.circular(12),
//                                             ),
//                                             child: Container(
//                                               alignment: Alignment.center,
//                                               child: state.isSubmitting
//                                                   ? SizedBox(
//                                                       width: 20,
//                                                       height: 20,
//                                                       child: Transform.scale(
//                                                         scale: 0.5,
//                                                         child:
//                                                             CircularProgressIndicator(
//                                                               strokeWidth: 4,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                       ),
//                                                     )
//                                                   : const Text(
//                                                       'Create account',
//                                                       style: TextStyle(
//                                                         fontSize: 16,
//                                                         color: Colors.white,
//                                                         fontWeight:
//                                                             FontWeight.w600,
//                                                       ),
//                                                     ),
//                                             ),
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ),

//                                 const SizedBox(height: 14),

//                                 // Sign in link
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     const Text(
//                                       'Already have an account?',
//                                       style: TextStyle(color: Colors.black54),
//                                     ),
//                                     TextButton(
//                                       onPressed: () =>
//                                           Navigator.pushReplacement(
//                                             context,
//                                             MaterialPageRoute(
//                                               builder: (context) => Login(),
//                                             ),
//                                           ),
//                                       child: const Text('Sign in'),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
