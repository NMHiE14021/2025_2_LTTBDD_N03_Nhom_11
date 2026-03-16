import 'package:flutter/material.dart';

class ScoreBar extends StatelessWidget {
  final String label;
  final double value;

  const ScoreBar({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final percent = (value * 100).toStringAsFixed(0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            Text('$percent%'),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: value,
          minHeight: 10,
          borderRadius: BorderRadius.circular(12),
        ),
      ],
    );
  }
}
