import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/fake.dart';

class FakeSecureStorageService extends Fake implements ISecureStorageService {
  final Map<String, String?> _store = {};

  @override
  Future<String?> load(String key) async => _store[key];

  @override
  Future<void> remove(String key) async {
    _store.remove(key);
  }

  @override
  Future<void> save(String key, String value) async {
    _store[key] = value;
  }
}
