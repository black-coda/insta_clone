import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insta_clone/state/auth/providers/auth_state_provider.dart';
import 'package:insta_clone/views/components/constant/string.dart';
import 'package:insta_clone/views/constant/app_colors.dart';
import 'package:insta_clone/views/login/divider.dart';
import 'package:insta_clone/views/login/google_button.dart';
import 'package:insta_clone/views/login/login_view_register_links.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.appName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              Text(Strings.welcomeToAppName,
                  style: Theme.of(context).textTheme.displaySmall),
              const DividerWithMargin(),
              Text(
                Strings.logIntoYourAccount,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(height: 1.5),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: ref.read(authStateProvider.notifier).loginWithGoogle,
                style: TextButton.styleFrom(
                    backgroundColor: AppColors.loginButtonColor,
                    foregroundColor: AppColors.loginButtonTextColor),
                child: const GoogleButton(),
              ),
              const DividerWithMargin(),
              const LoginViewRegisterLink()
            ],
          ),
        ),
      ),
    );
  }
}
