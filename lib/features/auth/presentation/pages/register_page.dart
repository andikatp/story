import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:story/core/common/widgets/dropdown_flag.dart';
import 'package:story/core/constants/app_sizes.dart';
import 'package:story/core/extensions/extension.dart';
import 'package:story/core/res/colours.dart';
import 'package:story/core/services/router.dart';
import 'package:story/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:story/features/auth/presentation/widgets/back_button_widget.dart';
import 'package:story/features/auth/presentation/widgets/input_field.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    String? nameValidator(String? value) {
      if (value == null || value.isEmpty) {
        return 'NameValidatorNull'.tr();
      }
      if (value.contains(RegExp(r'\d'))) {
        return 'NameValidatorValid'.tr();
      }
      return null;
    }

    String? emailValidator(String? value) {
      if (value == null || value.isEmpty) {
        return 'EmailValidatorNull'.tr();
      }
      const emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
      final regex = RegExp(emailPattern);
      if (!regex.hasMatch(value)) {
        return 'EmailValidatorValid'.tr();
      }
      return null;
    }

    void registerHandler() {
      FocusManager.instance.primaryFocus?.unfocus();
      if (formKey.currentState!.validate()) {
        final name = nameController.text.trim();
        final email = emailController.text.trim();
        final password = passwordController.text.trim();
        context
            .read<AuthBloc>()
            .add(RegisterEvent(name: name, email: email, password: password));
      }
    }

    void goToLogin() => context.pushNamed(Routes.login.name);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('RegisterAppBar')),
        leading: const Padding(
          padding: EdgeInsets.only(left: 12),
          child: BackButtonWidget(),
        ),
        actions: [
          Padding(
            padding: REdgeInsets.only(right: 20),
            child: const DropdownFlag(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          minimum: REdgeInsets.all(32),
          child: Form(
            key: formKey,
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is Registered) {
                  context.messengger.clearSnackBars();
                  context.messengger.showSnackBar(
                    SnackBar(
                      backgroundColor: Colours.primaryColor,
                      behavior: SnackBarBehavior.floating,
                      content: Text(
                        'RegistrationComplete'.tr(),
                        textAlign: TextAlign.center,
                        style: context.bodySmall.copyWith(
                          color: Colours.backgroundColor,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  );
                  context.pushNamed(Routes.login.name);
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    GeneralInputField(
                      type: TextInputType.name,
                      controller: nameController,
                      label: 'RegisterName'.tr(),
                      icon: Icons.account_box_outlined,
                      validator: nameValidator,
                    ),
                    Gap.h20,
                    GeneralInputField(
                      type: TextInputType.emailAddress,
                      controller: emailController,
                      label: 'E-mail',
                      icon: Icons.mail_outlined,
                      validator: emailValidator,
                    ),
                    Gap.h20,
                    PasswordInputField(controller: passwordController),
                    Gap.h28,
                    ElevatedButton(
                      onPressed: state is AuthLoading ? null : registerHandler,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(70),
                      ),
                      child: state is AuthLoading
                          ? const CupertinoActivityIndicator()
                          : const Text('Register').tr(),
                    ),
                    Gap.h20,
                    if (state is AuthError)
                      Text(
                        state.message,
                        style: context.bodySmall
                            .copyWith(fontSize: 14.sp, color: Colors.red),
                      ),
                    Gap.h60,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'RegisterToLogin'.tr(),
                          style: context.bodySmall.copyWith(fontSize: 14.sp),
                        ),
                        TextButton(
                          onPressed: goToLogin,
                          child: Text(
                            'Login'.tr(),
                            style: context.bodySmall.copyWith(
                              fontSize: 14.sp,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
