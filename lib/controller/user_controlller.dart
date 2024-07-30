import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teater_jkt/model/contact_model.dart';
import 'package:teater_jkt/repository/user_repo.dart';
import 'package:teater_jkt/screens/Login.dart';
import 'package:teater_jkt/services/token_service.dart';
import '../model/user_model.dart';
import '../services/user_service.dart';

class UserController extends GetxController {
  final UserRepo userRepo = UserRepo();
  final UserService userService = Get.put(UserService());
  final tokenService = TokenService();

  var isLoading = false.obs;
  var userModel = UserModel().obs;
  var contactModel = ContactModel().obs;
  var rememberMe = false.obs;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<bool> login() async {
    if (formKey.currentState?.validate() ?? false) {
      isLoading(true);
      try {
        final result = await userRepo.loginWithUsername(
          username: usernameController.text,
          password: passwordController.text,
        );
        
        if (result != null) {
          userModel(result);
          Get.snackbar('Success', 'Login Successful');
          return true;
        }
      } catch (e) {
        print("Error: $e");
        Get.snackbar('Error', 'Login Failed');
      } finally {
        isLoading(false);
      }
    }
    return false;
  }

 Future<void> getCurrentUser() async {
    isLoading(true);
    try {
      var token = await tokenService.getToken();
      print('bisa cuy $token');
      final result = await userService.getCurrentUser();
      
      print("Current user: $result");
      if (result != null) {
        userModel(result);
      } else {
        Get.snackbar('Error', 'Failed to fetch user data');
      }
    } catch (e) {
      print("Error: $e");
      Get.snackbar('Error', 'Failed to fetch user data');
    } finally {
      isLoading(false);
    }
  }

  Future<void> getUserById(int id) async {
    isLoading(true);
    try {
      final result = await userService.getUserById(id);
      if (result != null) {
        userModel(result);
      } else {
        Get.snackbar('Error', 'Failed to fetch user data');
      }
    } catch (e) {
      print("Error: $e");
      Get.snackbar('Error', 'Failed to fetch user data');
    } finally {
      isLoading(false);
    }
  }

  // Future<void> createUser(UserModel user) async {
  //   isLoading(true);
  //   try {
  //     final success = await apiService.createUser(user);
  //     if (success) {
  //       Get.snackbar('Success', 'User Created Successfully');
  //     } else {
  //       Get.snackbar('Error', 'Failed to create user');
  //     }
  //   } catch (e) {
  //     print("Error: $e");
  //     Get.snackbar('Error', 'Failed to create user');
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  Future<void> updateUser(int id, UserModel user) async {
    isLoading(true);
    try {
      final success = await userService.updateUser(id, user);
      if (success) {
        Get.snackbar('Success', 'User Updated Successfully');
      } else {
        Get.snackbar('Error', 'Failed to update user');
      }
    } catch (e) {
      print("Error: $e");
      Get.snackbar('Error', 'Failed to update user');
    } finally {
      isLoading(false);
    }
  }

  // Future<void> deleteUser(int id) async {
  //   isLoading(true);
  //   try {
  //     final success = await userService.deleteUser(id);
  //     if (success) {
  //       Get.snackbar('Success', 'User Deleted Successfully');
  //     } else {
  //       Get.snackbar('Error', 'Failed to delete user');
  //     }
  //   } catch (e) {
  //     print("Error: $e");
  //     Get.snackbar('Error', 'Failed to delete user');
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  Future<void> logout() async {
    isLoading(true);
    try {
      final success = await userService.logout();
      if (success) {
        Get.offAll(() => Login());
        Get.snackbar('Success', 'User Logout Successfully');
      } else {
        Get.snackbar('Error', 'Failed to delete user');
      }
    } catch (e) {
      print("Error: $e");
      Get.snackbar('Error', 'Failed to delete user');
    } finally {
      isLoading(false);
    }
  }
  
}
