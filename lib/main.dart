import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:imaginez/firebase_options.dart';
import 'package:imaginez/src/app/startup/initializer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializer();
}
