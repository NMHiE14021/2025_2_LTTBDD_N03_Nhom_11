import 'package:flutter/material.dart';
import '../../../core/i18n/app_strings.dart';
import '../widgets/activity_tile.dart';
import '../widgets/module_card.dart';
import '../widgets/stat_card.dart';
import '../widgets/welcome_banner.dart';

class HomePage extends StatelessWidget {
  final bool isVietnamese;

  const HomePage({super.key, required this.isVietnamese});

  @override
  Widget build(BuildContext context) {
    final t = AppStrings(isVietnamese);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WelcomeBanner(t: t),
          const SizedBox(height: 16),
          Text(
            t.todayOverview,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: StatCard(value: '12', label: t.lessons),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: StatCard(value: '85', label: t.minutes),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: StatCard(value: '7', label: t.streak),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: StatCard(value: '68%', label: t.completed),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            t.featuredModules,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 12),
          ModuleCard(
            title: t.flashcard,
            description: t.flashcardDesc,
            icon: Icons.style,
            color: const Color(0xFFE8EEFF),
          ),
          const SizedBox(height: 12),
          ModuleCard(
            title: t.dictation,
            description: t.dictationDesc,
            icon: Icons.headphones,
            color: const Color(0xFFE8FFF4),
          ),
          const SizedBox(height: 12),
          ModuleCard(
            title: t.shadowing,
            description: t.shadowingDesc,
            icon: Icons.mic,
            color: const Color(0xFFFFF1E8),
          ),
          const SizedBox(height: 20),
          Text(
            t.recentActivities,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 12),
          ActivityTile(
            title: isVietnamese
                ? 'Bạn đã hoàn thành 8 flashcard chủ đề Speaking'
                : 'You completed 8 flashcards in Speaking topic',
            time: '08:45',
          ),
          ActivityTile(
            title: isVietnamese
                ? 'Bạn vừa luyện 1 bài Dictation'
                : 'You just finished 1 Dictation lesson',
            time: '10:10',
          ),
          ActivityTile(
            title: isVietnamese
                ? 'Bạn đã xem báo cáo Shadowing'
                : 'You reviewed your Shadowing analysis',
            time: '14:20',
          ),
        ],
      ),
    );
  }
}
