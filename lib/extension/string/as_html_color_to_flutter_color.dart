import 'package:flutter/material.dart';
import 'package:insta_clone/extension/string/remove_all.dart';


extension AsHtmlColorToFlutterColor on String{
  Color htmlColorToFlutterColor()=> Color(
    int.parse(
      this.removeAll(["0x","#"]).padLeft(8, "ff"), radix: 16
    )
  );
}