import 'package:flutter/material.dart';
import 'card_badge.dart';

class FlashcardBack extends StatelessWidget {
  final String meaningLabel;
  final String exampleLabel;
  final String meaning;
  final String example;
  final bool isVietnamese;
  final bool isMastered;

  const FlashcardBack({
    super.key,
    required this.meaningLabel,
    required this.exampleLabel,
    required this.meaning,
    required this.example,
    required this.isVietnamese,
    required this.isMastered,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 340,
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF162033), Color(0xFF2A3850)],
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 24,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CardBadge(
                text: isVietnamese ? 'Mặt sau' : 'Back side',
                dark: true,
              ),
              const Spacer(),
              if (isMastered)
                CardBadge(
                  text: isVietnamese ? 'Đã thuộc' : 'Mastered',
                  dark: true,
                ),
            ],
          ),
          const SizedBox(height: 22),
          Text(
            meaningLabel,
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            meaning,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            exampleLabel,
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            example,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              height: 1.6,
            ),
          ),
          const Spacer(),
          Text(
            isVietnamese
                ? 'Chạm lại để quay về mặt trước'
                : 'Tap again to return to the front',
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
