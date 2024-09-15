import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum SecureKey { userId, token, notificationTopic}

class SecureStorageService {
  final _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );


  Future<String?> secureRead(SecureKey key) async {
    String? value = await _storage.read(key: key.name);

    return value;
  }


  Future<void> secureDelete(SecureKey key) async {
    await _storage.delete(key: key.name);
  }

  Future<void> secureWrite(
      {required SecureKey key, required String value}) async {
    await _storage.write(key: key.name, value: value);
  }


}
