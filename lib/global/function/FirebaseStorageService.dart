import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class FirebaseStorageService extends GetxController {
  static FirebaseStorageService get instance => Get.find();

  final _firebaseStorage = FirebaseStorage.instance;

  /// Upload Local Assets from IDE
  /// Returns a Uint8List containing image data.
  Future<Uint8List> getImageDataFromAssets(String path) async {
    try {
      final byteData = await rootBundle.load(path);
      final imageData = byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
      return imageData;
    } catch (e) {
      // Handle exceptions gracefully
      throw 'Error loading image data: $e';
    }
  }


static Widget? checkMultiRecordState<T>({
  required AsyncSnapshot<List<T>> snapshot,
  Widget? loader,
  Widget? error,
  Widget? nothingFound,
}) {
  if (snapshot.connectionState == ConnectionState.waiting) {
    if (loader != null) return loader;
    return const Center(child: CircularProgressIndicator());
  }

  if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
    if (nothingFound != null) return nothingFound;
    return const Center(child: Text('No Data Found!'));
  }

  if (snapshot.hasError) {
    if (error != null) return error;
    return const Center(child: Text('Something went wrong.'));
  }

  return null;
}
// Create a reference with an initial file path and name and retrieve the download URL.
static Future<String> getURLFromFilePathAndName(String path) async {
    try {
        if (path.isEmpty) return '';
        final ref = FirebaseStorage.instance.ref().child(path);
        final url = await ref.getDownloadURL();
        return url;
    } on FirebaseException catch (e) {
        throw e.message ?? 'Firebase error occurred';
    } on PlatformException catch (e) {
        throw e.message ?? 'Platform error occurred';
    } catch (e) {
        throw 'Something went wrong.';
    }
}
}
