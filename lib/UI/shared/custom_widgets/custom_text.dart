import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    Key? key,
    required this.content,
    this.fontSize,
  }) : super(key: key);
  final String content;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          content,
          style:
              TextStyle(fontSize: fontSize ?? 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
