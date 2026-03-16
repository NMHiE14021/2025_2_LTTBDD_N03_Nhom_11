import 'package:flutter/material.dart';
import '../../../core/i18n/app_strings.dart';
import '../../../core/models/lesson_models.dart';

class DictationLessonCard extends StatelessWidget {
  final DictationLesson lesson;
  final AppStrings t;

  const DictationLessonCard({super.key, required this.lesson, required this.t});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFFE8FFF4),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Icon(Icons.headphones, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lesson.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text('${lesson.level} • ${lesson.audioLength}'),
                  const SizedBox(height: 12),
                  FilledButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.play_arrow),
                    label: Text(t.audioPlayer),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
