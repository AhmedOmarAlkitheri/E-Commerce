import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class GetstorageHelper {
  GetstorageHelper._();

  static GetstorageHelper? _instance_gs;
  GetStorage box = GetStorage();

  static GetstorageHelper get instance {
    _instance_gs ??= GetstorageHelper._();
    return _instance_gs!;
  }

  static Future<void> init(String bucketName) async {
    await GetStorage.init(bucketName);
    _instance_gs = GetstorageHelper._();
    _instance_gs!.box = GetStorage(bucketName);
  }

  writeToFile({required String key, Options? options, required dynamic value}) {
    return box.write(key, value);
  }

  readFromFile(String key) {
    return box.read(key);
  }

  remove(String key) {
    return box.remove(key);
  }

  removeAll() {
    box.erase();
  }
}
