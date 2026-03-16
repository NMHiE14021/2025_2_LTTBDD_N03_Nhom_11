import 'package:flutter/material.dart';
import '../../../core/data/app_state.dart';
import '../../../core/i18n/app_strings.dart';
import '../widgets/add_vocabulary_intro_card.dart';
import '../widgets/topic_mode_switch.dart';

class AddVocabularyPage extends StatefulWidget {
  final bool isVietnamese;

  const AddVocabularyPage({super.key, required this.isVietnamese});

  @override
  State<AddVocabularyPage> createState() => _AddVocabularyPageState();
}

class _AddVocabularyPageState extends State<AddVocabularyPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController wordController;
  late final TextEditingController phoneticController;
  late final TextEditingController meaningController;
  late final TextEditingController exampleController;
  late final TextEditingController customTopicController;

  String? selectedTopic;
  bool useCustomTopic = false;
  bool autoSave = true;

  @override
  void initState() {
    super.initState();
    wordController = TextEditingController();
    phoneticController = TextEditingController();
    meaningController = TextEditingController();
    exampleController = TextEditingController();
    customTopicController = TextEditingController();

    final topics = AppState.instance.topics;
    selectedTopic = topics.isNotEmpty ? topics.first : null;
  }

  @override
  void dispose() {
    wordController.dispose();
    phoneticController.dispose();
    meaningController.dispose();
    exampleController.dispose();
    customTopicController.dispose();
    super.dispose();
  }

  void _saveVocabulary() {
    final t = AppStrings(widget.isVietnamese);
    final state = AppState.instance;

    if (!_formKey.currentState!.validate()) return;

    final topic = useCustomTopic
        ? customTopicController.text.trim()
        : (selectedTopic ?? '');

    if (topic.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.topicRequired),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (state.containsWord(wordController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.wordAlreadyExists),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    state.addVocabulary(
      word: wordController.text,
      phonetic: phoneticController.text,
      meaning: meaningController.text,
      example: exampleController.text,
      topic: topic,
      autoSave: autoSave,
    );

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppStrings(widget.isVietnamese);
    final topics = AppState.instance.topics;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          t.addVocabulary,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AddVocabularyIntroCard(t: t),
            const SizedBox(height: 18),
            Form(
              key: _formKey,
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: wordController,
                        decoration: InputDecoration(
                          labelText: t.wordLabel,
                          prefixIcon: const Icon(Icons.spellcheck),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return t.wordRequired;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: phoneticController,
                        decoration: InputDecoration(
                          labelText: t.phoneticLabel,
                          prefixIcon: const Icon(
                            Icons.record_voice_over_outlined,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return t.phoneticRequired;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: meaningController,
                        decoration: InputDecoration(
                          labelText: t.meaning,
                          prefixIcon: const Icon(Icons.translate_outlined),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return t.meaningRequired;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: exampleController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: t.example,
                          alignLabelWithHint: true,
                          prefixIcon: const Padding(
                            padding: EdgeInsets.only(bottom: 40),
                            child: Icon(Icons.notes_outlined),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return t.exampleRequired;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 18),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          t.topic,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TopicModeSwitch(
                        useCustomTopic: useCustomTopic,
                        onUseExisting: () {
                          setState(() {
                            useCustomTopic = false;
                          });
                        },
                        onCreateNew: () {
                          setState(() {
                            useCustomTopic = true;
                          });
                        },
                        t: t,
                      ),
                      const SizedBox(height: 12),
                      if (!useCustomTopic)
                        DropdownButtonFormField<String>(
                          value: selectedTopic,
                          decoration: InputDecoration(
                            labelText: t.chooseTopic,
                            prefixIcon: const Icon(Icons.folder_open_outlined),
                          ),
                          items: topics
                              .map(
                                (topic) => DropdownMenuItem(
                                  value: topic,
                                  child: Text(topic),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedTopic = value;
                            });
                          },
                        )
                      else
                        TextFormField(
                          controller: customTopicController,
                          decoration: InputDecoration(
                            labelText: t.newTopicLabel,
                            prefixIcon: const Icon(
                              Icons.create_new_folder_outlined,
                            ),
                          ),
                          validator: (value) {
                            if (useCustomTopic &&
                                (value == null || value.trim().isEmpty)) {
                              return t.topicRequired;
                            }
                            return null;
                          },
                        ),
                      const SizedBox(height: 12),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        value: autoSave,
                        onChanged: (value) {
                          setState(() {
                            autoSave = value;
                          });
                        },
                        title: Text(t.autoSaveWord),
                        subtitle: Text(
                          widget.isVietnamese
                              ? 'Tự động thêm từ vào danh sách ôn tập sau khi tạo'
                              : 'Automatically add this word to the review list after saving',
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          onPressed: _saveVocabulary,
                          icon: const Icon(Icons.save_outlined),
                          label: Text(t.saveNewVocabulary),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
