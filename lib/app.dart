import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/shell/main_shell.dart';

class EnglishLearningApp extends StatefulWidget {
  const EnglishLearningApp({super.key});

  @override
  State<EnglishLearningApp> createState() => _EnglishLearningAppState();
}

class _EnglishLearningAppState extends State<EnglishLearningApp> {
  bool _isVietnamese = true;

  void _toggleLanguage() {
    setState(() {
      _isVietnamese = !_isVietnamese;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'English Learning UI',
      theme: AppTheme.lightTheme,
      home: MainShell(
        isVietnamese: _isVietnamese,
        onToggleLanguage: _toggleLanguage,
      ),
    );
  }
}
