import 'package:flutter/material.dart';

class WaveformDemo extends StatelessWidget {
  const WaveformDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final bars = [18.0, 28.0, 14.0, 34.0, 20.0, 26.0, 40.0, 22.0, 30.0, 16.0];

    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F5FB),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: bars
            .map(
              (h) => Container(
                width: 10,
                height: h,
                decoration: BoxDecoration(
                  color: const Color(0xFF5B7CFA),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
