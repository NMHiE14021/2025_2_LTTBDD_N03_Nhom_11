import 'package:flutter/material.dart';
import '../../../core/data/mock_data.dart';
import '../../../core/i18n/app_strings.dart';
import '../widgets/dictation_lesson_card.dart';
import '../widgets/result_row.dart';

class DictationPage extends StatefulWidget {
  final bool isVietnamese;

  const DictationPage({super.key, required this.isVietnamese});

  @override
  State<DictationPage> createState() => _DictationPageState();
}

class _DictationPageState extends State<DictationPage> {
  int selectedIndex = 0;
  final TextEditingController answerController = TextEditingController();

  @override
  void dispose() {
    answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppStrings(widget.isVietnamese);
    final lesson = MockData.dictationLessons[selectedIndex];

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.chooseLesson,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<int>(
            value: selectedIndex,
            decoration: const InputDecoration(),
            items: List.generate(
              MockData.dictationLessons.length,
              (index) => DropdownMenuItem(
                value: index,
                child: Text(MockData.dictationLessons[index].title),
              ),
            ),
            onChanged: (value) {
              setState(() {
                selectedIndex = value ?? 0;
              });
            },
          ),
          const SizedBox(height: 16),
          DictationLessonCard(lesson: lesson, t: t),
          const SizedBox(height: 16),
          Text(
            t.typeAnswer,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: answerController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: widget.isVietnamese
                  ? 'Nhập câu bạn nghe được ở đây...'
                  : 'Type the sentence you hear here...',
            ),
          ),
          const SizedBox(height: 16),
          Text(
            t.tips,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: lesson.keywords
                .map(
                  (e) => Chip(
                    label: Text(e),
                    avatar: const Icon(Icons.lightbulb_outline, size: 18),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.checkResult,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ResultRow(label: t.accuracy, value: '84%'),
                  const SizedBox(height: 10),
                  ResultRow(
                    label: widget.isVietnamese
                        ? 'Từ khóa nhận diện'
                        : 'Detected keywords',
                    value: '3/4',
                  ),
                  const SizedBox(height: 10),
                  ResultRow(
                    label: widget.isVietnamese
                        ? 'Câu mẫu'
                        : 'Reference sentence',
                    value: lesson.sentence,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
