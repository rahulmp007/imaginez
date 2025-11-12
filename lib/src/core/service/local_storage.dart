// lib/src/core/services/hive_services.dart
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorageService {
  /// Open a Hive box or return already opened
  Future<Box<E>> openBox<E>(String boxName) async {
    if (kDebugMode) log('Opening box [$boxName]');
    if (Hive.isBoxOpen(boxName)) return Hive.box<E>(boxName);
    return Hive.openBox<E>(boxName);
  }

  /// Check if box has any items
  Future<bool> hasLength<E>(String boxName) async {
    final box = await openBox<E>(boxName);
    if (kDebugMode) log('Box [$boxName] length: ${box.length}');
    return box.isNotEmpty;
  }

  /// Add a single item
  Future<void> add<E>(String boxName, E item) async {
    if (kDebugMode) log('Adding item [$item] to box [$boxName]');
    final box = await openBox<E>(boxName);
    await box.add(item);
  }

  /// Add multiple items
  Future<void> addAll<E>(String boxName, List<E> items) async {
    if (kDebugMode) log('Adding ${items.length} items to box [$boxName]');
    final box = await openBox<E>(boxName);
    await box.addAll(items);
  }

  /// Put item at key
  Future<void> put<E>(String boxName, dynamic key, E item) async {
    if (kDebugMode) log('Putting item [$item] at key [$key] in box [$boxName]');
    final box = await openBox<E>(boxName);
    await box.put(key, item);
  }

  /// Get item by key
  Future<E?> get<E>(String boxName, dynamic key) async {
    final box = await openBox<E>(boxName);
    if (kDebugMode) log('Getting item at key [$key] from box [$boxName]');
    return box.get(key);
  }

  /// Get all items
  Future<List<E>> getAll<E>(String boxName) async {
    final box = await openBox<E>(boxName);
    if (kDebugMode) log('Getting all items from box [$boxName]');
    return box.values.toList();
  }

  /// Delete item by key
  Future<void> delete<E>(String boxName, dynamic key) async {
    final box = await openBox<E>(boxName);
    if (box.isEmpty) return;
    if (kDebugMode) log('Deleting item at key [$key] from box [$boxName]');
    await box.delete(key);
  }

  /// Delete all boxes and local files
  Future<void> deleteAllBoxes() async {
    if (kDebugMode) log('Deleting all boxes');
    await Hive.deleteFromDisk();
    Hive.close();

    final dir = await getApplicationDocumentsDirectory();
    final localDb = Directory('${dir.path}/localdb');
    if (localDb.existsSync()) localDb.deleteSync(recursive: true);

    final tempDir = await getTemporaryDirectory();
    if (tempDir.existsSync()) tempDir.deleteSync(recursive: true);
  }
}
