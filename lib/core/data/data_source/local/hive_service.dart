import 'package:hive/hive.dart';

class HiveService {
  Future<void> save<T>(
    String boxName,
    String key,
    T item,
  ) async {
    final box = await Hive.openBox(boxName);
    await box.put(key, item);
  }

  Future<List<T>> get<T>(
    String boxName,
  ) async {
    final box = await Hive.openBox(boxName);
    final ids = box.keys;
    var values = <T>[];
    for (var id in ids) {
      values.add(box.get(id));
    }
    return values;
  }

  Future<void> delete<T>(
    String boxName,
    String key,
  ) async {
    final box = await Hive.openBox(boxName);
    await box.delete(key);
    print(box.keys);
  }
}
