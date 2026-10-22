import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.keyboardType,
    this.obscureText = false,
    this.controller,
    this.validator,
  });

  final String hintText;
  final Widget prefixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    const borderColor = Color(0xFF2563EB);

    final field = TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      style: const TextStyle(
        color: Color(0xFF2E2E2E),
        fontFamily: 'Nunito',
        fontSize: 14,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color(0xFF2E2E2E),
          fontFamily: 'Nunito',
          fontSize: 14,
        ),
        filled: true,
        fillColor: Colors.white,
        isDense: true,
        contentPadding: EdgeInsets.zero,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 16, right: 10),
          child: SizedBox(width: 20, height: 20, child: prefixIcon),
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 46,
          maxWidth: 46,
          minHeight: 46,
          maxHeight: 46,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: borderColor, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: borderColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: borderColor, width: 1),
        ),
      ),
    );

    return SizedBox(
      width: double.infinity,
      height: validator == null ? 48 : null,
      child: field,
    );
  }
}
