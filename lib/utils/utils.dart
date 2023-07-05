import 'package:flutter/material.dart';

class utils {
  static void fieldChange(
      BuildContext context, FocusNode current, FocusNode nextNode) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextNode);
  }
}
