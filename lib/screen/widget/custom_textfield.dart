import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController? textEditingController;
  final String hintText;
  final bool? isSearch;
  final IconData? suffixIcon;
  final VoidCallback? onPressed;
  final bool? isPassword;
  final bool? isEmail;
  final bool? isVisible;
  final String? Function(String? value)? validation;
  const CustomTextfield(
      {super.key,
      this.textEditingController,
      required this.hintText,
      this.isSearch,
      this.suffixIcon,
      this.onPressed,
      this.isPassword,
      this.isEmail,
      this.isVisible,
      this.validation});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validation ??
          (value) {
            if (value == null || value.isEmpty) {
              return "Textfield cannot be empty";
            } else if (isEmail == true) {
              final bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value);
              if (emailValid == false) {
                return "Email is not valid";
              }
            }
            return null;
          },
      controller: textEditingController,
      obscureText: isVisible ?? false,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 10),
            borderRadius: BorderRadius.circular(4.0)),
        filled: true,
        isDense: true,
         contentPadding: const EdgeInsets.all(12),
        fillColor: Colors.white,

        suffix: InkWell(onTap: onPressed, child: Icon(suffixIcon)),

        hintText: hintText,
      ),
    );
  }
}
