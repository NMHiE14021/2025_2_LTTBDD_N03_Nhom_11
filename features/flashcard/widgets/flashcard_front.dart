import 'package:flutter/material.dart';
import 'card_badge.dart';

class FlashcardFront extends StatelessWidget {
  final String word;
  final String phonetic;
  final String topic;
  final bool isVietnamese;
  final bool showPhonetic;
  final bool isSaved;
  final bool isMastered;

  const FlashcardFront({
    super.key,
    required this.word,
    required this.phonetic,
    required this.topic,
    required this.isVietnamese,
    required this.showPhonetic,
    required this.isSaved,
    required this.isMastered,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 340,
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isMastered
              ? const [Color(0xFF17925E), Color(0xFF35B57B)]
              : const [Color(0xFF5B7CFA), Color(0xFF8CA3FF)],
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A5B7CFA),
            blurRadius: 24,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.10),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: -10,
            bottom: -30,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CardBadge(text: topic),
                  const Spacer(),
                  if (isSaved) const Icon(Icons.bookmark, color: Colors.white),
                ],
              ),
              const SizedBox(height: 18),
              if (isMastered)
                CardBadge(
                  text: isVietnamese ? 'Đã thuộc' : 'Mastered',
                  dark: true,
                ),
              const Spacer(),
              Text(
                word,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              if (showPhonetic)
                Text(
                  phonetic,
                  style: const TextStyle(color: Colors.white70, fontSize: 18),
                ),
              const Spacer(),
              Text(
                isVietnamese
                    ? 'Chạm để xem nghĩa và ví dụ'
                    : 'Tap to view meaning and example',
                style: const TextStyle(color: Colors.white70, fontSize: 15),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
