import 'package:flutter/material.dart';
import 'package:insta_clone/views/components/constant/string.dart';
import 'package:insta_clone/views/components/rich_text/base_text.dart';
import 'package:insta_clone/views/components/rich_text/ric_text_widgte.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginViewRegisterLink extends StatelessWidget {
  const LoginViewRegisterLink({super.key});

  @override
  Widget build(BuildContext context) {
    return RichTextWidget(
      styleAll: Theme.of(context).textTheme.titleMedium?.copyWith(height: 1.5),
      texts: [
        BaseText.plain(text: Strings.dontHaveAnAccount),
        BaseText.plain(text: Strings.signUpOn),
        BaseText.link(
          text: Strings.google,
          onTapped: () {
            launchUrl(Uri.parse(Strings.googleSignupUrl));
          },
        )
      ],
    );
  }
}
