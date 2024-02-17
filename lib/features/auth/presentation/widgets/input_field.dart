import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:story/core/extensions/extension.dart';

class GeneralInputField extends StatelessWidget {
  const GeneralInputField({
    required this.controller,
    required this.icon,
    required this.label,
    required this.type,
    required this.validator,
    super.key,
  });

  final IconData icon;
  final TextInputType type;
  final TextEditingController controller;
  final String label;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 12.h,
      children: [
        Text(
          label,
          style: context.labelMedium,
        ),
        TextFormField(
          style: context.bodyMedium,
          controller: controller,
          keyboardType: type,
          decoration: InputDecoration(
            contentPadding: REdgeInsets.all(20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(const Radius.circular(12).r),
            ),
            hintText: label,
            prefixIcon: Icon(icon),
          ),
          validator: validator,
        ),
      ],
    );
  }
}

class PasswordInputField extends StatefulWidget {
  const PasswordInputField({required this.controller, super.key});

  final TextEditingController controller;

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool isShowPassword = true;

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'PasswordValidatorNull'.tr();
    }
    if (value.length < 7) {
      return 'PasswordValidatorValid'.tr();
    }
    final letter = RegExp('[a-zA-Z]');
    final number = RegExp('[0-9]');
    // final specialChar = RegExp(r'[!@#\$%^&*(),.?":{}|<>]');

    if (!letter.hasMatch(value) || !number.hasMatch(value)
        // || !specialChar.hasMatch(value) **works but dont want to use it**
        ) {
      return 'PasswordValidatorValidNumber'.tr();
    }
    return null;
  }

  void showPasswordHandler() =>
      setState(() => isShowPassword = !isShowPassword);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 12.h,
      children: [
        Text(
          'Password',
          style: context.labelMedium,
        ),
        TextFormField(
          style: context.bodyMedium,
          keyboardType: TextInputType.visiblePassword,
          controller: widget.controller,
          obscureText: isShowPassword,
          decoration: InputDecoration(
            contentPadding: REdgeInsets.all(20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(const Radius.circular(12).r),
            ),
            prefixIcon: const Icon(Icons.key_rounded),
            hintText: 'Password',
            suffixIcon: IconButton(
              onPressed: showPasswordHandler,
              icon: Icon(
                isShowPassword ? Icons.visibility_off : Icons.remove_red_eye,
              ),
            ),
            errorMaxLines: 2,
          ),
          validator: validator,
        ),
      ],
    );
  }
}
