import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class CustomInput extends StatefulWidget {
  final String? hintText;
  final IconData? icon;
  final TextEditingController? controller;
  final double? height;
  final String? borderCol;
  final double? borderRadius;
  final TextInputType? type;
  final Color? backgroundColor;
  final Widget? suffix;
  final String? defaultValue;
  final bool isPassword;
  bool? isPasswordVisible;

  final validator;
  final onSaved;

  CustomInput({
    super.key,
    this.hintText,
    this.icon,
    this.controller,
    this.borderCol,
    this.borderRadius,
    this.suffix,
    this.type,
    this.backgroundColor,
    this.height,
    this.defaultValue,
    this.onSaved,
    this.validator,
    this.isPassword = false,
    this.isPasswordVisible = false,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? 42,
      child: TextFormField(
        keyboardType: widget.type ?? TextInputType.text,
        controller: widget.controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: widget.isPassword ? !widget.isPasswordVisible! : false,
        validator: widget.validator,
        onSaved: widget.onSaved,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          prefixIcon: widget.icon != null
              ? Padding(
                  padding: const EdgeInsets.all(15),
                  child: Icon(
                    widget.icon,
                    color: Colors.black,
                  ),
                )
              : null,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 5),
            borderSide: const BorderSide(
              color: Colors.black,
            ),
          ),
          fillColor: widget.backgroundColor ?? Colors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 5),
            borderSide: const BorderSide(
              /* color: Colors.black, */
              color: Colors.white,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 5),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 5),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Colors.black.withOpacity(0.5),
          ),
          suffixIcon: widget.isPassword
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.isPasswordVisible = !widget.isPasswordVisible!;
                    });
                  },
                  child: Icon(
                    color: AppColors.primaryColor,
                    widget.isPasswordVisible!
                        ? Icons.remove_red_eye_outlined
                        : Icons.visibility_off_outlined,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
