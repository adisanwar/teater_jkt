import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:teater_jkt/api/urls.dart';
import '../model/user_model.dart';

class RegisterRepo {
  final storage = GetStorage();

  Future<UserModel?> registerUser({
    required String name,
    required String username,
    required String password,
  }) async {
    var data = {
      'name': name,
      'username': username,
      'password': password,
    };

    try {
      final response = await GetConnect().post(Url.register, data);

      print("API Response Status Code: ${response.statusCode}");
      print("API Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final userModel = UserModel.fromJson(response.body);
        // Save the token separately for easy access
        storage.write('token', userModel.token);
        storage.write('user', userModel.toJson());
        return userModel;
      } else {
        throw Exception('Failed to register: ${response.statusText}');
      }
    } catch (e) {
      print("Error during registration: $e");
      rethrow;
    }
  }

  String? getToken() {
    return storage.read('token');
  }
}
