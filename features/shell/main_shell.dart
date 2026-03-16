import 'package:flutter/material.dart';
import '../../core/i18n/app_strings.dart';
import '../dictation/pages/dictation_page.dart';
import '../flashcard/pages/flashcard_page.dart';
import '../home/pages/home_page.dart';
import '../settings/pages/settings_page.dart';
import '../shadowing/pages/shadowing_page.dart';

class MainShell extends StatefulWidget {
  final bool isVietnamese;
  final VoidCallback onToggleLanguage;

  const MainShell({
    super.key,
    required this.isVietnamese,
    required this.onToggleLanguage,
  });

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final t = AppStrings(widget.isVietnamese);

    final pages = [
      HomePage(isVietnamese: widget.isVietnamese),
      FlashcardPage(isVietnamese: widget.isVietnamese),
      DictationPage(isVietnamese: widget.isVietnamese),
      ShadowingPage(isVietnamese: widget.isVietnamese),
      SettingsPage(
        isVietnamese: widget.isVietnamese,
        onToggleLanguage: widget.onToggleLanguage,
      ),
    ];

    final titles = [t.home, t.flashcard, t.dictation, t.shadowing, t.settings];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          titles[_currentIndex],
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: t.home,
          ),
          NavigationDestination(
            icon: const Icon(Icons.style_outlined),
            selectedIcon: const Icon(Icons.style),
            label: t.flashcard,
          ),
          NavigationDestination(
            icon: const Icon(Icons.keyboard_outlined),
            selectedIcon: const Icon(Icons.keyboard),
            label: t.dictation,
          ),
          NavigationDestination(
            icon: const Icon(Icons.mic_none_outlined),
            selectedIcon: const Icon(Icons.mic),
            label: t.shadowing,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings),
            label: t.settings,
          ),
        ],
      ),
    );
  }
}
