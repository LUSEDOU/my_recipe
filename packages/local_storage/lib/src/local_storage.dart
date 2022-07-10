import 'package:hive_flutter/hive_flutter.dart';

/// {@template local_storage}
/// A local storage implemented with Hive package
/// {@endtemplate}
class LocalStorage {
  /// The storage
  late Box<dynamic> hiveBox;

  /// Open the storage
  Future<void> openBox([String boxName = 'RECIPE_CACHE']) async {
    hiveBox = await Hive.openBox(boxName);
  }

  /// Initialize the storage
  Future<void> init() async {
    await Hive.initFlutter();
    await openBox();
  }

  /// Remove the [key] from the storage
  Future<void> remove(String key) async 
      => hiveBox.delete(key);

  /// Get the associated value from the storage
  dynamic get(String key) => hiveBox.get(key);

  /// Returns all values in the storage
  dynamic getAll() => hiveBox.values.toList();

  /// If the storage contains the value
  bool has(String key) => hiveBox.containsKey(key);

  /// Write the key/value in the storage
  Future<void> write(String? key, dynamic data) 
      => hiveBox.put(key, data);

  /// Delete all the data in the storage
  Future<void> clear() => hiveBox.clear();

  /// Close the storage
  Future<void> close() => hiveBox.close();
}
