import 'package:flutter/material.dart';
import '../../../core/i18n/app_strings.dart';

class SavedHeader extends StatelessWidget {
  final AppStrings t;
  final int savedCount;
  final int reviewCount;
  final int masteredCount;

  const SavedHeader({
    super.key,
    required this.t,
    required this.savedCount,
    required this.reviewCount,
    required this.masteredCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF5B7CFA), Color(0xFF8CA3FF)],
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.reviewSavedWords,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            t.savedPageHint,
            style: const TextStyle(color: Colors.white70, height: 1.5),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _MiniStat(
                  label: t.savedVocabulary,
                  value: '$savedCount',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _MiniStat(label: t.reviewLabel, value: '$reviewCount'),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _MiniStat(
                  label: t.masteredOnly,
                  value: '$masteredCount',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String label;
  final String value;

  const _MiniStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.16),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
