import 'package:flutter/material.dart';

class InfoText extends StatelessWidget {
  final String label;
  final String value;

  const InfoText({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          color: Colors.black87,
          height: 1.6,
          fontSize: 15,
        ),
        children: [
          TextSpan(
            text: '$label: ',
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
          TextSpan(text: value),
        ],
      ),
    );
  }
}
