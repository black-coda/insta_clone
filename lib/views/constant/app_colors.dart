import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart' show Colors;
import 'package:insta_clone/extension/string/as_html_color_to_flutter_color.dart';
// import 'package:testingriverpod/extensions/string/as_html_color_to_color.dart';

@immutable
class AppColors {
  static final loginButtonColor = '#cfc9c2'.htmlColorToFlutterColor();
  static const loginButtonTextColor = Colors.black;
 static final googleColor = '#4285F4'.htmlColorToFlutterColor();
  static final facebookColor = '#3b5998'.htmlColorToFlutterColor();
  const AppColors._();
}
