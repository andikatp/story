import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:story/core/common/widgets/dropdown_flag.dart';
import 'package:story/core/constants/app_sizes.dart';
import 'package:story/core/extensions/extension.dart';
import 'package:story/core/services/router.dart';
import 'package:story/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:story/features/auth/presentation/widgets/back_button_widget.dart';
import 'package:story/features/auth/presentation/widgets/input_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

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

    void goToRegister() => context.pushNamed(Routes.register.name);

    void loginHandler() {
      FocusManager.instance.primaryFocus?.unfocus();
      if (formKey.currentState!.validate()) {
        final email = emailController.text.trim();
        final password = passwordController.text.trim();
        context
            .read<AuthBloc>()
            .add(LoginEvent(email: email, password: password));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('LoginAppBar')),
        leading: Padding(
          padding: REdgeInsets.only(left: 12),
          child: const BackButtonWidget(),
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
            child: SizedBox(
              height: 0.79.sh,
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is LoggedIn) {
                    context
                        .read<AuthBloc>()
                        .add(SaveTokenEvent(token: state.user.token));
                    context.goNamed(Routes.dashboard.name);
                  }
                },
                builder: (context, state) {
                  return Column(
                    children: [
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
                        onPressed: state is AuthLoading ? null : loginHandler,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(70),
                        ),
                        child: state is AuthLoading
                            ? const CupertinoActivityIndicator()
                            : const Text('Login').tr(),
                      ),
                      Gap.h20,
                      if (state is AuthError)
                        Text(
                          state.message,
                          style: context.bodySmall
                              .copyWith(fontSize: 14.sp, color: Colors.red),
                        ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'LoginToRegister'.tr(),
                            style: context.bodySmall.copyWith(fontSize: 14.sp),
                          ),
                          TextButton(
                            onPressed: goToRegister,
                            child: Text(
                              'Register'.tr(),
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
      ),
    );
  }
}
