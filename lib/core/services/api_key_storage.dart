import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../domain/enums/ai_provider_type.dart';

class ApiKeyStorage {
  final FlutterSecureStorage _storage;

  ApiKeyStorage()
    : _storage = const FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
      );

  String _keyFor(AiProviderType type) => 'api_key_${type.name}';

  Future<void> saveApiKey(AiProviderType type, String key) async {
    await _storage.write(key: _keyFor(type), value: key);
  }

  Future<String?> getApiKey(AiProviderType type) async {
    return _storage.read(key: _keyFor(type));
  }

  Future<bool> hasApiKey(AiProviderType type) async {
    final key = await getApiKey(type);
    return key != null && key.isNotEmpty;
  }

  Future<void> deleteApiKey(AiProviderType type) async {
    await _storage.delete(key: _keyFor(type));
  }
}
