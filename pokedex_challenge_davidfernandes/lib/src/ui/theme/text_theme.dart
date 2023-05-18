import 'package:flutter/material.dart';

class PKTextWidget extends StatelessWidget {
  final String data;
  final TextStyle style;
  const PKTextWidget({super.key, required this.data, required this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: style,
    );
  }
}
