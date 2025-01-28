import 'package:ezycourse/presentation/viewmodels/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../utils/style_utils.dart';
import '../../utils/color_constants.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final Color borderColor;
  final Function(String)? onChanged;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final AutovalidateMode? autovalidateMode;

  const CustomTextField({
    super.key,
    required this.controller,
    this.hintText = "",
    this.validator,
    this.borderColor = ColorConfig.whiteColor,
    this.onChanged,
    this.style,
    this.hintStyle,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      onChanged: widget.onChanged,
      autovalidateMode: widget.autovalidateMode,
      style: widget.style ?? textSize14w600.copyWith(color: ColorConfig.whiteColor),
      cursorColor: ColorConfig.whiteColor,
      decoration: InputDecoration(
        hintText: widget.hintText,
        fillColor: ColorConfig.filledTextFieldColor,
        hintStyle: widget.hintStyle ?? TextStyle(color: ColorConfig.hintColor),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 0.5, color: widget.borderColor),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: widget.borderColor),
          borderRadius: BorderRadius.circular(12),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: widget.borderColor),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: widget.borderColor),
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 7, vertical: 8),
      ),
    );
  }
}
