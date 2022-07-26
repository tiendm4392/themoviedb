import 'package:flutter/material.dart';
import 'package:testapp/constans.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    Key? key,
    required this.showPassword,
    required this.controller,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  final bool showPassword;
  final TextEditingController controller;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 4),
      child: TextField(
        obscureText: !showPassword,
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: title,
          suffixIcon: IconButton(
            icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}