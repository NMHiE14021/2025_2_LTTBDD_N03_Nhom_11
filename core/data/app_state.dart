import 'package:flutter/foundation.dart';
import '../models/lesson_models.dart';
import 'mock_data.dart';

enum FlashcardCollectionMode {
  all,
  saved,
  review,
}

class AppState extends ChangeNotifier {
  AppState._() {
    _flashcards = List<FlashcardItem>.from(MockData.flashcards);
  }

  static final AppState instance = AppState._();

  late List<FlashcardItem> _flashcards;
  final Set<String> _savedWords = <String>{};
  final Set<String> _masteredWords = <String>{};

  List<FlashcardItem> get allFlashcards => List.unmodifiable(_flashcards);

  bool isSaved(String word) => _savedWords.contains(word);
  bool isMastered(String word) => _masteredWords.contains(word);

  List<FlashcardItem> get savedFlashcards {
    return _flashcards
        .where((item) => _savedWords.contains(item.word))
        .toList();
  }

  List<FlashcardItem> get masteredFlashcards {
    return _flashcards
        .where((item) => _masteredWords.contains(item.word))
        .toList();
  }

  List<FlashcardItem> get reviewFlashcards {
    return _flashcards.where((item) {
      return _savedWords.contains(item.word) &&
          !_masteredWords.contains(item.word);
    }).toList();
  }

  int get savedCount => _savedWords.length;
  int get masteredCount => _masteredWords.length;
  int get reviewCount => reviewFlashcards.length;

  List<String> get topics {
    final values = _flashcards.map((e) => e.topic).toSet().toList();
    values.sort();
    return values;
  }

  List<FlashcardItem> flashcardsByTopic(String topic) {
    return _flashcards.where((item) => item.topic == topic).toList();
  }

  List<FlashcardItem> flashcardsByMode(FlashcardCollectionMode mode) {
    switch (mode) {
      case FlashcardCollectionMode.all:
        return List<FlashcardItem>.from(_flashcards);
      case FlashcardCollectionMode.saved:
        return savedFlashcards;
      case FlashcardCollectionMode.review:
        return reviewFlashcards;
    }
  }

  List<FlashcardItem> flashcardsByTopicAndMode(
    String topic,
    FlashcardCollectionMode mode,
  ) {
    return flashcardsByMode(mode).where((item) => item.topic == topic).toList();
  }

  List<String> topicsByMode(FlashcardCollectionMode mode) {
    final values = flashcardsByMode(mode).map((e) => e.topic).toSet().toList();
    values.sort();
    return values;
  }

  int countByTopicAndMode(String topic, FlashcardCollectionMode mode) {
    return flashcardsByTopicAndMode(topic, mode).length;
  }

  void addVocabulary({
    required String word,
    required String phonetic,
    required String meaning,
    required String example,
    required String topic,
    bool autoSave = true,
  }) {
    final normalizedWord = word.trim();
    final normalizedPhonetic = phonetic.trim();
    final normalizedMeaning = meaning.trim();
    final normalizedExample = example.trim();
    final normalizedTopic = topic.trim();

    final newItem = FlashcardItem(
      word: normalizedWord,
      phonetic: normalizedPhonetic,
      meaning: normalizedMeaning,
      example: normalizedExample,
      topic: normalizedTopic,
    );

    _flashcards = [..._flashcards, newItem];

    if (autoSave) {
      _savedWords.add(normalizedWord);
    }

    notifyListeners();
  }

  bool containsWord(String word) {
    return _flashcards.any(
      (item) => item.word.toLowerCase() == word.trim().toLowerCase(),
    );
  }

  void toggleSavedWord(FlashcardItem item) {
    if (_savedWords.contains(item.word)) {
      _savedWords.remove(item.word);
      _masteredWords.remove(item.word);
    } else {
      _savedWords.add(item.word);
    }
    notifyListeners();
  }

  void toggleMasteredWord(FlashcardItem item) {
    if (_masteredWords.contains(item.word)) {
      _masteredWords.remove(item.word);
    } else {
      _savedWords.add(item.word);
      _masteredWords.add(item.word);
    }
    notifyListeners();
  }

  void removeSavedWord(String word) {
    _savedWords.remove(word);
    _masteredWords.remove(word);
    notifyListeners();
  }

  // Personal information
  String fullName = 'Ngô Minh Hiếu';
  String studentId = '23010656';
  String className = 'CNTT K17';
  String email = '23010656@st.phenikaa-uni.edu.vn';
  String learningGoal = 'Improve speaking and pronunciation';
  String note = '.';

  // Learning preferences
  int dailyGoalMinutes = 20;
  String learningLevel = 'A2';
  bool remindersEnabled = true;
  bool showPhonetic = true;
  bool autoPlaySample = false;

  void updateProfile({
    required String fullName,
    required String studentId,
    required String className,
    required String email,
    required String learningGoal,
    required String note,
  }) {
    this.fullName = fullName.trim();
    this.studentId = studentId.trim();
    this.className = className.trim();
    this.email = email.trim();
    this.learningGoal = learningGoal.trim();
    this.note = note.trim();
    notifyListeners();
  }

  void updatePreferences({
    required int dailyGoalMinutes,
    required String learningLevel,
    required bool remindersEnabled,
    required bool showPhonetic,
    required bool autoPlaySample,
  }) {
    this.dailyGoalMinutes = dailyGoalMinutes;
    this.learningLevel = learningLevel;
    this.remindersEnabled = remindersEnabled;
    this.showPhonetic = showPhonetic;
    this.autoPlaySample = autoPlaySample;
    notifyListeners();
  }

  void resetPreferences() {
    dailyGoalMinutes = 20;
    learningLevel = 'A2';
    remindersEnabled = true;
    showPhonetic = true;
    autoPlaySample = false;
    notifyListeners();
  }
}
