import 'package:flutter/material.dart';
import '../../../core/data/app_state.dart';
import '../../../core/i18n/app_strings.dart';
import 'add_vocabulary_page.dart';
import 'flashcard_study_page.dart';
import 'saved_vocabulary_page.dart';

class FlashcardPage extends StatefulWidget {
  final bool isVietnamese;

  const FlashcardPage({super.key, required this.isVietnamese});

  @override
  State<FlashcardPage> createState() => _FlashcardPageState();
}

class _FlashcardPageState extends State<FlashcardPage> {
  FlashcardCollectionMode selectedMode = FlashcardCollectionMode.all;

  @override
  Widget build(BuildContext context) {
    final t = AppStrings(widget.isVietnamese);

    return AnimatedBuilder(
      animation: AppState.instance,
      builder: (context, _) {
        final state = AppState.instance;
        final topics = state.topicsByMode(selectedMode);

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStats(state),
              const SizedBox(height: 16),
              _buildActions(context, t, state),
              const SizedBox(height: 20),
              Text(
                widget.isVietnamese
                    ? 'Chọn bộ từ cần học'
                    : 'Choose a vocabulary set',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              Text(
                widget.isVietnamese
                    ? 'Flashcard chỉ hiển thị sau khi bạn chọn một bộ từ.'
                    : 'Flashcards appear only after you choose a vocabulary set.',
                style: TextStyle(color: Colors.grey.shade700),
              ),
              const SizedBox(height: 16),
              _buildModeChips(t),
              const SizedBox(height: 16),
              if (topics.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Text(
                      widget.isVietnamese
                          ? 'Không có bộ từ phù hợp.'
                          : 'No matching vocabulary sets.',
                    ),
                  ),
                )
              else
                ...topics.map(
                  (topic) => _buildTopicCard(
                    context,
                    topic,
                    state.countByTopicAndMode(topic, selectedMode),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStats(AppState state) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF3FF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
              child: _statItem(widget.isVietnamese ? 'Tổng từ' : 'Total',
                  '${state.allFlashcards.length}')),
          Expanded(
              child: _statItem(widget.isVietnamese ? 'Đã lưu' : 'Saved',
                  '${state.savedCount}')),
          Expanded(
              child: _statItem(widget.isVietnamese ? 'Chưa thuộc' : 'Review',
                  '${state.reviewCount}')),
        ],
      ),
    );
  }
  Widget _statItem(String label, String value) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey.shade700),
        ),
      ],
    );
  }

  Widget _buildActions(BuildContext context, AppStrings t, AppState state) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      SavedVocabularyPage(isVietnamese: widget.isVietnamese),
                ),
              );
            },
            icon: const Icon(Icons.bookmarks_outlined),
            label: Text('${t.savedVocabulary} (${state.savedCount})'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: FilledButton.tonalIcon(
            onPressed: () async {
              final created = await Navigator.push<bool>(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      AddVocabularyPage(isVietnamese: widget.isVietnamese),
                ),
              );

              if (created == true && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(t.addVocabularySuccess)),
                );
              }
            },
            icon: const Icon(Icons.add),
            label: Text(t.addVocabularyShort),
          ),
        ),
      ],
    );
  }

  Widget _buildModeChips(AppStrings t) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ChoiceChip(
          label: Text(t.allWords),
          selected: selectedMode == FlashcardCollectionMode.all,
          onSelected: (_) =>
              setState(() => selectedMode = FlashcardCollectionMode.all),
        ),
        ChoiceChip(
          label: Text(t.savedLabel),
          selected: selectedMode == FlashcardCollectionMode.saved,
          onSelected: (_) =>
              setState(() => selectedMode = FlashcardCollectionMode.saved),
        ),
        ChoiceChip(
          label: Text(t.unmasteredLabel),
          selected: selectedMode == FlashcardCollectionMode.review,
          onSelected: (_) =>
              setState(() => selectedMode = FlashcardCollectionMode.review),
        ),
      ],
    );
  }

  Widget _buildTopicCard(BuildContext context, String topic, int count) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: const CircleAvatar(
            backgroundColor: Color(0xFFEEF3FF),
            child: Icon(Icons.style_outlined),
          ),
          title:
              Text(topic, style: const TextStyle(fontWeight: FontWeight.w700)),
          subtitle: Text(
            widget.isVietnamese ? '$count từ vựng' : '$count words',
          ),
          trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => FlashcardStudyPage(
                  isVietnamese: widget.isVietnamese,
                  topic: topic,
                  mode: selectedMode,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
