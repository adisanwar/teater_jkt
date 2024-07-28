import 'package:get_storage/get_storage.dart';

class TokenService {
  final GetStorage _storage = GetStorage();

  void saveToken(String token) {
    _storage.write('token', token);
  }

  String? getToken() {
    return _storage.read('token');
  }

  void clearToken() {
    _storage.remove('token');
  }
}
