import 'package:flutter/material.dart';

class FlashcardHeader extends StatelessWidget {
  final int currentIndex;
  final int total;
  final int savedCount;
  final int masteredCount;
  final bool isVietnamese;

  const FlashcardHeader({
    super.key,
    required this.currentIndex,
    required this.total,
    required this.savedCount,
    required this.masteredCount,
    required this.isVietnamese,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFEEF3FF), Color(0xFFF7F9FF)],
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          Expanded(
            child: _HeaderStat(
              label: isVietnamese ? 'Tiến độ' : 'Progress',
              value: '${currentIndex + 1}/$total',
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _HeaderStat(
              label: isVietnamese ? 'Đã lưu' : 'Saved',
              value: '$savedCount',
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _HeaderStat(
              label: isVietnamese ? 'Đã thuộc' : 'Mastered',
              value: '$masteredCount',
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderStat extends StatelessWidget {
  final String label;
  final String value;

  const _HeaderStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
