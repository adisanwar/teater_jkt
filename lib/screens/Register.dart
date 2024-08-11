import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teater_jkt/controller/RegisterController.dart';
import 'package:teater_jkt/screens/Login.dart';
import 'package:teater_jkt/widget/form/FormTextField.dart';
import 'package:teater_jkt/widget/form/PasswordFormField.dart';
import 'package:teater_jkt/widget/form/PrimaryButton.dart';

class Register extends StatelessWidget {
  Register({super.key});

  final RegisterController registerController = Get.put(RegisterController());
  final RxBool _obscureText = true.obs;
  final RxBool _obscureTextConfirm = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: registerController.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Register',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FormTextField(
                    label: 'Username',
                    controller: registerController.usernameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FormTextField(
                    label: 'Name',
                    controller: registerController.nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => PaswordForm(
                      label: "Enter Password",
                      obscureText: _obscureText.value,
                      controller: registerController.passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      onVisibilityToggle: () {
                        _obscureText.value = !_obscureText.value;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => PaswordForm(
                      label: "Re-Enter Password",
                      obscureText: _obscureTextConfirm.value,
                      controller: registerController
                          .confirmPasswordController, // Menggunakan controller yang berbeda
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value !=
                            registerController.confirmPasswordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      onVisibilityToggle: () {
                        _obscureTextConfirm.value = !_obscureTextConfirm.value;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Obx(() {
                      if (registerController.isLoading.value) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: PrimaryButton(
                                onPressed: () async {
                                  final result =
                                      await registerController.register();
                                  if (result) {
                                    Get.to(() => Login(),
                                        transition: Transition.leftToRight);
                                  } else {
                                    Get.snackbar('Error',
                                        'Registration Failed. Please try again.');
                                  }
                                },
                                labelbtn: "Create Account",
                              ),
                            ),
                          ],
                        );
                      }
                    }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () {
                      Get.offAll(() => Login(),
                          transition: Transition.leftToRight);
                    },
                    child: const Text(
                      'Have an account? Log in',
                      style: TextStyle(color: Color(0xFFf96d6d)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
