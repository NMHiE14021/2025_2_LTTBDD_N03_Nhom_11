import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  final String text;
  final bool mastered;

  const StatusBadge({super.key, required this.text, required this.mastered});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: mastered ? const Color(0xFFE7F8EF) : const Color(0xFFEFF3FF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: mastered ? const Color(0xFF1F9D61) : const Color(0xFF3552C8),
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
