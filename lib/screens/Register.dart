import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teater_jkt/controller/RegisterController.dart';
import 'package:teater_jkt/screens/Login.dart';
import 'package:teater_jkt/widget/form/FormTextField.dart';
import 'package:teater_jkt/widget/form/PrimaryButton.dart';

class Register extends StatelessWidget {
  Register({super.key});

  final RegisterController registerController = Get.put(RegisterController());
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
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
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
                      FormTextField(
                        label: 'Enter Password',
                        controller: registerController.passwordController,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FormTextField(
                        label: 'Re-Enter Password',
                        controller: registerController.passwordController,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Obx(() {
                          if (registerController.isLoading.value) {
                            return const CircularProgressIndicator();
                          } else {
                            return PrimaryButton(
                                onPressed: () async {
                                  final result =
                                      await registerController.register();
                                  if (result) {
                                    Get.to(() => Login(),
                                        transition: Transition.leftToRight);
                                  } else {
                                    print(result);
                                    Get.snackbar('Error',
                                        'Registration Failed. Please try again.');
                                  }

                                  // Get.to(() => const Login(), transition: Transition.rightToLeft);
                                  // // Tampilkan Snackbar
                                  // Get.snackbar(
                                  //   'Berhasil',
                                  //   'Silahkan Login Bro',
                                  //   snackPosition: SnackPosition.TOP,
                                  //   backgroundColor: Colors.green[400],
                                  //   colorText: Colors.white,
                                  // );
                                },
                                labelbtn: "Create Account");
                          }
                        }),
                      ),
                      SizedBox(
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
                    ]),
              ),
            )),
      ),
    );
  }
}
