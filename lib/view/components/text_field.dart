import 'package:contact_scan/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget(
      {Key? key,
      this.controller,
      this.labelText,
      this.validator,
      this.hintText,
      this.callback,
      this.length,
      this.isObscureText,
      this.passwordButton,
      required this.inputType,
      this.enabled,
      this.inputFormatters,
      this.autovalidateMode,
      this.onChanged})
      : super(key: key);

  final TextEditingController? controller;
  final String? labelText;
  final int? length;
  final String? Function(String?)? validator;
  final VoidCallback? callback;
  final bool? isObscureText;
  final String? hintText;
  final Widget? passwordButton;
  final TextInputType inputType;
  final AutovalidateMode? autovalidateMode;
  final List<TextInputFormatter>? inputFormatters;
  bool? enabled = true;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: autovalidateMode,
      inputFormatters: inputFormatters,
      controller: controller,
      maxLength: length,
      validator: validator,
      obscureText: isObscureText!,
      enabled: enabled,
      style: TextStyle(
        color: AppColors.black,
        fontSize: 16,
      ),
      keyboardType: inputType,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.white,
        suffixIcon: passwordButton,
        labelText: labelText,
        contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: AppColors.gray70, width: 2)),
        hintText: hintText,
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: AppColors.red, width: 2)),
        hintStyle: TextStyle(color: AppColors.grayA5),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: AppColors.gray70, width: 2)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: AppColors.gray70, width: 2)),
      ),
    );
  }
}
