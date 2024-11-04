import 'package:flutter/material.dart';

extension RemoveAll on String {
  String removeAll(Iterable<String> values) => values.fold(
        this,
        (previousValue, value) => previousValue.replaceAll(value, ""),
      );
}
