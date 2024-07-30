import 'package:get/get.dart';
import 'package:teater_jkt/api/urls.dart';
import '../model/user_model.dart';
import 'token_service.dart';

class UserService extends GetConnect {
  final TokenService tokenService = TokenService();

  @override
  void onInit() {
    httpClient.addRequestModifier<void>((request) {
      final token = tokenService.getToken();
      print(' token get $token');
      if (token != null) {
        request.headers['X-API-TOKEN'] = token; // Menggunakan kunci 'X-API-TOKEN'
      }
      return request;
    });
    super.onInit();
  }

   Future<UserModel?> getCurrentUser() async {
    try {
      String? token = tokenService.getToken();
      print('Token ini bisa: $token');
      if (token == null) {
        print('Token is null. User needs to login.');
        Get.snackbar('Error', 'Token is missing. Please login again.');
        return null;
      }

      final response = await get(Url.getCurrentUsers);
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.body['data']);
      } else {
        print('Failed to fetch user data: ${response.statusCode} - ${response.statusText}');
        return null;
      }
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }

  Future<UserModel?> getUserById(int id) async {
    try {
      final response = await get('${Url.baseUrl}/users/$id');

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.body['data']);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> updateUser(int id, UserModel user) async {
    try {
      final response = await patch('${Url.baseUrl}/users/$id', user.toJson());

      return response.statusCode == 200;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // Future<bool> deleteUser(int id) async {
  //   try {
  //     final response = await delete('${Url.baseUrl}/users/$id');

  //     return response.statusCode == 200;
  //   } catch (e) {
  //     print(e);
  //     return false;
  //   }
  // }

  Future<bool> logout() async {
    try {
      final response = await delete(Url.logout);

      return response.statusCode == 200;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
