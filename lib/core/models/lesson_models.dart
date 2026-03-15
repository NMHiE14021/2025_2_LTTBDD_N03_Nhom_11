class FlashcardItem {
  final String word;
  final String phonetic;
  final String meaning;
  final String example;
  final String topic;

  const FlashcardItem({
    required this.word,
    required this.phonetic,
    required this.meaning,
    required this.example,
    required this.topic,
  });
}

class DictationLesson {
  final String title;
  final String level;
  final String audioLength;
  final String sentence;
  final List<String> keywords;

  const DictationLesson({
    required this.title,
    required this.level,
    required this.audioLength,
    required this.sentence,
    required this.keywords,
  });
}

class ShadowingLesson {
  final String title;
  final String speaker;
  final String duration;
  final String transcript;
  final double pronunciation;
  final double intonation;
  final double fluency;

  const ShadowingLesson({
    required this.title,
    required this.speaker,
    required this.duration,
    required this.transcript,
    required this.pronunciation,
    required this.intonation,
    required this.fluency,
  });
}