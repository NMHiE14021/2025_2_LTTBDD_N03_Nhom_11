import 'package:flutter/material.dart';
import '../../../core/i18n/app_strings.dart';

class WelcomeBanner extends StatelessWidget {
  final AppStrings t;

  const WelcomeBanner({super.key, required this.t});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF5B7CFA), Color(0xFF7A9BFF)],
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          const Expanded(
            child: CircleAvatar(
              radius: 42,
              backgroundColor: Colors.white24,
              child: Icon(Icons.school, color: Colors.white, size: 36),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.hello,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  t.subtitle,
                  style: const TextStyle(color: Colors.white, height: 1.4),
                ),
                const SizedBox(height: 16),
                FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF3C58CC),
                  ),
                  onPressed: () {},
                  child: Text(t.continueLearning),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
