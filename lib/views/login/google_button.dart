import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:insta_clone/views/components/constant/string.dart';
import 'package:insta_clone/views/constant/app_colors.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(FontAwesomeIcons.google, color: AppColors.googleColor,),
          const SizedBox(width: 10.0,),
          const Text(Strings.google)
        ],
      ),
    );
  }
}


