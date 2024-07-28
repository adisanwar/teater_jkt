import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teater_jkt/controller/LoginController.dart';
import 'package:teater_jkt/screens/Navigation_Menu.dart';
import 'package:teater_jkt/screens/Register.dart';
import 'package:teater_jkt/screens/remeberme_checkbox.dart';
import 'package:teater_jkt/widget/form/FormTextField.dart';
import 'package:teater_jkt/widget/form/PrimaryButton.dart';
import 'package:teater_jkt/widget/form/ScondaryButton.dart';

class Login extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());

  Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: loginController.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  FormTextField(
                    label: 'Username',
                    controller: loginController.usernameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20,),
                  FormTextField(
                    label: 'Password',
                    controller: loginController.passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  RememberMeCheckbox(
                    rememberMe: loginController.rememberMe,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                  width: double.infinity,
                    child:
                    // PrimaryButton(
                    //
                    //     labelbtn: "Login",
                    //     onPressed: () {
                    //       Get.off(() => const NavigationMenu(),
                    //           transition: Transition.rightToLeft);
                    //     }),
                    Obx(() {
                      if (loginController.isLoading.value) {
                        return const CircularProgressIndicator();
                      } else {
                        return Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: PrimaryButton(
                                  labelbtn: "Login",
                                  onPressed: ()
                                  async {
                                    final result = await loginController.login();
                                    if (result) {
                                      Get.off(() => const NavigationMenu(), transition: Transition.rightToLeft);
                                    } else {
                                      Get.snackbar('Error', 'Login Failed. Please try again.');
                                    }
                                  },
                                  ),
                            ),
                          ],
                        );
                      }
                    }),
                  ),

                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: SecondaryButton(
                      label: "Create Account",
                      onPressed: () {
                        Get.to(() => Register(),
                            transition: Transition.rightToLeft);
                      },
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
