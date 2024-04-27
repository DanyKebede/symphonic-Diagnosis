import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.tcontroller,
    required this.icon,
    required this.hintText,
    required this.validator,
  });

  final TextEditingController tcontroller;
  final IconData icon;
  final String hintText;
  final FormFieldValidator<String>? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: tcontroller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 20),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 17.0),
          child: Icon(
            icon,
            color: const Color.fromRGBO(204, 204, 204, 1),
            size: 32,
          ),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color.fromRGBO(139, 139, 139, 1),
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
          borderSide: const BorderSide(
            color: Color.fromRGBO(112, 79, 56, 1),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
          borderSide: const BorderSide(
            color: Color.fromRGBO(112, 79, 56, 1),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
          borderSide: const BorderSide(
            color: Color.fromRGBO(112, 79, 56, 1),
          ),
        ),
      ),
      validator: validator,
    );
  }
}
