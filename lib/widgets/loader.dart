import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final Color? color;
  const Loader({this.color, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: CircularProgressIndicator(color: color,),
    );
  }
}
