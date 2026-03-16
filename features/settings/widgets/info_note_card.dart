import 'package:flutter/material.dart';

class InfoNoteCard extends StatelessWidget {
  final String text;

  const InfoNoteCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFF4F7FF),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.info_outline, color: Color(0xFF3552C8)),
            const SizedBox(width: 12),
            Expanded(child: Text(text, style: const TextStyle(height: 1.5))),
          ],
        ),
      ),
    );
  }
}
