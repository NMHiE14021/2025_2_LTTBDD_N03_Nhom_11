import 'package:flutter/material.dart';
import '../../../core/data/app_state.dart';
import '../../../core/i18n/app_strings.dart';
import '../widgets/info_note_card.dart';
import '../widgets/profile_preview_card.dart';
import '../widgets/settings_section_title.dart';
import '../widgets/summary_line.dart';

class SettingsPage extends StatefulWidget {
  final bool isVietnamese;
  final VoidCallback onToggleLanguage;

  const SettingsPage({
    super.key,
    required this.isVietnamese,
    required this.onToggleLanguage,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final TextEditingController fullNameController;
  late final TextEditingController studentIdController;
  late final TextEditingController classNameController;
  late final TextEditingController emailController;
  late final TextEditingController learningGoalController;
  late final TextEditingController noteController;

  late int dailyGoalMinutes;
  late String learningLevel;
  late bool remindersEnabled;
  late bool showPhonetic;
  late bool autoPlaySample;

  @override
  void initState() {
    super.initState();
    final state = AppState.instance;

    fullNameController = TextEditingController(text: state.fullName);
    studentIdController = TextEditingController(text: state.studentId);
    classNameController = TextEditingController(text: state.className);
    emailController = TextEditingController(text: state.email);
    learningGoalController = TextEditingController(text: state.learningGoal);
    noteController = TextEditingController(text: state.note);

    dailyGoalMinutes = state.dailyGoalMinutes;
    learningLevel = state.learningLevel;
    remindersEnabled = state.remindersEnabled;
    showPhonetic = state.showPhonetic;
    autoPlaySample = state.autoPlaySample;
  }

  @override
  void dispose() {
    fullNameController.dispose();
    studentIdController.dispose();
    classNameController.dispose();
    emailController.dispose();
    learningGoalController.dispose();
    noteController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    final t = AppStrings(widget.isVietnamese);
    final state = AppState.instance;

    state.updateProfile(
      fullName: fullNameController.text,
      studentId: studentIdController.text,
      className: classNameController.text,
      email: emailController.text,
      learningGoal: learningGoalController.text,
      note: noteController.text,
    );

    state.updatePreferences(
      dailyGoalMinutes: dailyGoalMinutes,
      learningLevel: learningLevel,
      remindersEnabled: remindersEnabled,
      showPhonetic: showPhonetic,
      autoPlaySample: autoPlaySample,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(t.savedMessage),
        behavior: SnackBarBehavior.floating,
      ),
    );

    setState(() {});
  }

  void _resetPreferences() {
    final t = AppStrings(widget.isVietnamese);
    final state = AppState.instance;

    state.resetPreferences();

    setState(() {
      dailyGoalMinutes = state.dailyGoalMinutes;
      learningLevel = state.learningLevel;
      remindersEnabled = state.remindersEnabled;
      showPhonetic = state.showPhonetic;
      autoPlaySample = state.autoPlaySample;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(t.preferencesReset),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppStrings(widget.isVietnamese);

    return AnimatedBuilder(
      animation: AppState.instance,
      builder: (context, _) {
        final state = AppState.instance;

        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.settingsTitle,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 12),
              ProfilePreviewCard(
                fullName: fullNameController.text,
                studentId: studentIdController.text,
                className: classNameController.text,
                fallbackFullNameLabel: t.fullName,
                fallbackStudentIdLabel: t.studentId,
                fallbackClassNameLabel: t.className,
              ),
              const SizedBox(height: 16),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.language),
                  title: Text(
                    t.language,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text(
                    widget.isVietnamese ? t.vietnamese : t.english,
                  ),
                  trailing: Switch(
                    value: widget.isVietnamese,
                    onChanged: (_) => widget.onToggleLanguage(),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SettingsSectionTitle(title: t.personalInfo),
              const SizedBox(height: 10),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      TextField(
                        controller: fullNameController,
                        decoration: InputDecoration(
                          labelText: t.fullName,
                          prefixIcon: const Icon(Icons.person_outline),
                        ),
                        onChanged: (_) => setState(() {}),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: studentIdController,
                        decoration: InputDecoration(
                          labelText: t.studentId,
                          prefixIcon: const Icon(Icons.badge_outlined),
                        ),
                        onChanged: (_) => setState(() {}),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: classNameController,
                        decoration: InputDecoration(
                          labelText: t.className,
                          prefixIcon: const Icon(Icons.school_outlined),
                        ),
                        onChanged: (_) => setState(() {}),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: t.email,
                          prefixIcon: const Icon(Icons.email_outlined),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: learningGoalController,
                        decoration: InputDecoration(
                          labelText: t.learningGoal,
                          prefixIcon: const Icon(Icons.flag_outlined),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: noteController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          labelText: t.note,
                          alignLabelWithHint: true,
                          prefixIcon: const Padding(
                            padding: EdgeInsets.only(bottom: 64),
                            child: Icon(Icons.note_alt_outlined),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SettingsSectionTitle(title: t.learningPreferences),
              const SizedBox(height: 10),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${t.dailyGoal}: $dailyGoalMinutes ${t.minutesUnit}',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      Slider(
                        value: dailyGoalMinutes.toDouble(),
                        min: 5,
                        max: 60,
                        divisions: 11,
                        label: '$dailyGoalMinutes',
                        onChanged: (value) {
                          setState(() {
                            dailyGoalMinutes = value.round();
                          });
                        },
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: learningLevel,
                        decoration: InputDecoration(
                          labelText: t.learningLevel,
                          prefixIcon: const Icon(Icons.bar_chart_outlined),
                        ),
                        items: const [
                          DropdownMenuItem(value: 'A1', child: Text('A1')),
                          DropdownMenuItem(value: 'A2', child: Text('A2')),
                          DropdownMenuItem(value: 'B1', child: Text('B1')),
                          DropdownMenuItem(value: 'B2', child: Text('B2')),
                          DropdownMenuItem(
                            value: 'IELTS',
                            child: Text('IELTS'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            learningLevel = value ?? 'A2';
                          });
                        },
                      ),
                      const SizedBox(height: 12),
                      SwitchListTile(
                        value: remindersEnabled,
                        onChanged: (value) {
                          setState(() {
                            remindersEnabled = value;
                          });
                        },
                        title: Text(t.reminder),
                        subtitle: Text(
                          widget.isVietnamese
                              ? 'Nhắc học mỗi ngày (mô phỏng UI)'
                              : 'Daily study reminder (UI demo)',
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                      SwitchListTile(
                        value: showPhonetic,
                        onChanged: (value) {
                          setState(() {
                            showPhonetic = value;
                          });
                        },
                        title: Text(t.showPhoneticSetting),
                        subtitle: Text(
                          widget.isVietnamese
                              ? 'Ẩn/hiện phiên âm ở mặt trước flashcard'
                              : 'Show or hide phonetic text on flashcard front side',
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                      SwitchListTile(
                        value: autoPlaySample,
                        onChanged: (value) {
                          setState(() {
                            autoPlaySample = value;
                          });
                        },
                        title: Text(t.autoPlaySampleSetting),
                        subtitle: Text(
                          widget.isVietnamese
                              ? 'Tự phát âm mẫu khi mở bài'
                              : 'Automatically play sample audio when opening a lesson',
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                color: const Color(0xFFF4F7FF),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.personalSummary,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SummaryLine(
                        label: t.fullName,
                        value: fullNameController.text,
                      ),
                      SummaryLine(
                        label: t.learningGoal,
                        value: learningGoalController.text,
                      ),
                      SummaryLine(label: t.learningLevel, value: learningLevel),
                      SummaryLine(
                        label: t.dailyGoal,
                        value: '$dailyGoalMinutes ${t.minutesUnit}',
                      ),
                      SummaryLine(
                        label: t.savedWordsCount,
                        value: '${state.savedFlashcards.length}',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _resetPreferences,
                      icon: const Icon(Icons.refresh),
                      label: Text(t.resetPreferences),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: _saveProfile,
                      icon: const Icon(Icons.save_outlined),
                      label: Text(t.save),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              InfoNoteCard(text: t.settingsHint),
            ],
          ),
        );
      },
    );
  }
}
