import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:teater_jkt/api/urls.dart';
import 'package:teater_jkt/services/token_service.dart';
import '../model/user_model.dart';

class UserRepo extends GetConnect {
  final storage = GetStorage();
  final TokenService tokenService = TokenService();

  Future<UserModel?> loginWithUsername({
    required String username,
    required String password,
  }) async {
    var data = {
      'username': username,
      'password': password,
    };

   try {
      final response = await GetConnect().post(Url.login, data);

      if (response.statusCode == 200) {
        final loginModel = UserModel.fromJson(response.body['data']);
        final token = loginModel.token;
        if (token != null) {
          tokenService.saveToken(token);
          print("Token saved: $token");
        } else {
          print("Token is null");
        }
        return loginModel;
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      print("Error during login: $e");
      rethrow;
    }
  }
  
  String? getToken() {
    return storage.read('token');
  }
}