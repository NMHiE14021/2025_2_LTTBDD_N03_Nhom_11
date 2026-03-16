import 'package:flutter/material.dart';
import '../../../core/data/mock_data.dart';
import '../../../core/i18n/app_strings.dart';
import '../widgets/score_bar.dart';
import '../widgets/waveform_demo.dart';

class ShadowingPage extends StatefulWidget {
  final bool isVietnamese;

  const ShadowingPage({super.key, required this.isVietnamese});

  @override
  State<ShadowingPage> createState() => _ShadowingPageState();
}

class _ShadowingPageState extends State<ShadowingPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final t = AppStrings(widget.isVietnamese);
    final lesson = MockData.shadowingLessons[selectedIndex];

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField<int>(
            value: selectedIndex,
            items: List.generate(
              MockData.shadowingLessons.length,
              (index) => DropdownMenuItem(
                value: index,
                child: Text(MockData.shadowingLessons[index].title),
              ),
            ),
            onChanged: (value) {
              setState(() {
                selectedIndex = value ?? 0;
              });
            },
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lesson.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text('${lesson.speaker} • ${lesson.duration}'),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.play_arrow),
                          label: Text(t.playSample),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.mic),
                          label: Text(t.startRecord),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  const WaveformDemo(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            t.transcript,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
          ),
          const SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Text(
                lesson.transcript,
                style: const TextStyle(height: 1.6),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            t.speakingAnalysis,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
          ),
          const SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  ScoreBar(label: t.pronunciation, value: lesson.pronunciation),
                  const SizedBox(height: 14),
                  ScoreBar(label: t.intonation, value: lesson.intonation),
                  const SizedBox(height: 14),
                  ScoreBar(label: t.fluency, value: lesson.fluency),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
