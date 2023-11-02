import 'package:flutter/material.dart';
import 'package:local_test/core/constants/app_colors.dart';
import 'package:local_test/core/constants/app_text_styles.dart';

class TextInput extends StatefulWidget {
  const TextInput({
    super.key,
    required this.hintText,
    required this.controller,
    this.isError = false,
    this.obscureText = false,
  });

  final String hintText;
  final TextEditingController controller;
  final bool isError;
  final bool obscureText;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  bool _obscureText = false;
  OutlineInputBorder get border => OutlineInputBorder(
        gapPadding: 2.0,
        borderSide: const BorderSide(width: 2.0, color: AppColors.black),
        borderRadius: BorderRadius.circular(3659.95),
      );

  OutlineInputBorder get errorBorder => OutlineInputBorder(
        gapPadding: 2.0,
        borderSide: const BorderSide(width: 2.0, color: AppColors.redPrimary),
        borderRadius: BorderRadius.circular(3659.95),
      );

  Widget? get getSuffix => widget.obscureText
      ? InkWell(
          onTap: () => setState(() => _obscureText = !_obscureText),
          child: Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: Icon(
              _obscureText ? Icons.remove_red_eye : Icons.remove_red_eye,
            ),
          ),
        )
      : null;

  @override
  void initState() {
    _obscureText = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: AppTextStyles.s16,
      obscureText: _obscureText,
      decoration: InputDecoration(
        border: border,
        focusedBorder: border,
        enabledBorder: border,
        disabledBorder: border,
        errorBorder: errorBorder,
        focusedErrorBorder: errorBorder,
        contentPadding: EdgeInsets.zero,
        hintText: widget.hintText,
        hintStyle: AppTextStyles.s16.copyWith(color: AppColors.grey),
        errorText: widget.isError ? 'Error' : null,
        errorStyle: AppTextStyles.s16.copyWith(color: AppColors.redPrimary),
        suffixIconConstraints: const BoxConstraints(maxHeight: 16.0),
        suffixIcon: getSuffix,
        prefixIcon: const SizedBox(width: 12.0),
        counterText: '',
        filled: true,
        fillColor: AppColors.white,
      ),
    );
  }
}
