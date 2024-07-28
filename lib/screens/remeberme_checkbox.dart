import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RememberMeCheckbox extends StatelessWidget {
  final RxBool rememberMe;

  const RememberMeCheckbox({super.key, required this.rememberMe});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Checkbox(
                value: rememberMe.value,
                onChanged: (bool? value) {
                  rememberMe(value ?? false);
                },
              ),
              const Text(
                'Remember Me',
                style: TextStyle(color: Color(0xFFf96d6d)),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              // Handle "Forgot Password?" button press
            },
            child: const Text(
              'Forgot Password?',
              style: TextStyle(color: Color(0xFFf96d6d)),
            ),
          ),
        ],
      );
    });
  }
}
