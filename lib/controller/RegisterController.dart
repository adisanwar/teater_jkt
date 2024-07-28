import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teater_jkt/repository/register_repo.dart';
import '../model/user_model.dart';

class RegisterController extends GetxController {
  final RegisterRepo userRepo = RegisterRepo();

  var isLoading = false.obs;
  var userModel = UserModel().obs;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onClose() {
    nameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<bool> register() async {
    if (formKey.currentState?.validate() ?? false) {
      isLoading(true);
      try {
        print("Name: ${nameController.text}");
        print("Username: ${usernameController.text}");
        print("Password: ${passwordController.text}");

        final result = await userRepo.registerUser(
          name: nameController.text,
          username: usernameController.text,
          password: passwordController.text,
        );

        print("Register result: $result");

        if (result != null) {
          userModel(result);
          Get.snackbar('Success', 'Registration Successful');
          return true;
        }
      } catch (e) {
         print("Error: $e");
        Get.snackbar('Error', 'Registration Failed: ${e.toString()}');
      } finally {
        isLoading(false);
      }
    }
    return false;
  }

  String? get token => userRepo.getToken();
}
