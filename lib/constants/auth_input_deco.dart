
import 'package:flutter/material.dart';

import 'common_size.dart';

InputDecoration textInputDeco(String text) {
  return InputDecoration(
      focusedBorder: activeInputBorder(),
      filled: true,
      fillColor: Colors.grey.shade100,
      hintText: text,
      errorBorder: errorInputBorder(),
      focusedErrorBorder: errorInputBorder(),
      enabledBorder: activeInputBorder());
}

OutlineInputBorder errorInputBorder() {
  return OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.redAccent,
      ),
      borderRadius: BorderRadius.circular(common_s_gap));
}

OutlineInputBorder activeInputBorder() {
  return OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.shade300,
      ),
      borderRadius: BorderRadius.circular(common_s_gap));
}