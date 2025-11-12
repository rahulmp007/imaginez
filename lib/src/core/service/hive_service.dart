import 'dart:developer';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:imaginez/src/features/auth/data/models/user_model.dart';
// example model

class HiveService {
  Future<void> init() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      await Hive.initFlutter(dir.path);

      Hive.registerAdapter(UserModelAdapter());
    } on Exception catch (e) {
      log('hive init error: $e');
    }
  }
}
