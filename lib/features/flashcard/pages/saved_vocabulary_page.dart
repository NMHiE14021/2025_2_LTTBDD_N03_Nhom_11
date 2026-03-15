import 'package:flutter/material.dart';
import '../../../core/data/app_state.dart';
import '../../../core/i18n/app_strings.dart';
import '../helpers/review_filter.dart';
import '../widgets/filter_chip_button.dart';
import '../widgets/info_text.dart';
import '../widgets/saved_header.dart';
import '../widgets/status_badge.dart';
import '../widgets/topic_chip.dart';
import 'add_vocabulary_page.dart';

class SavedVocabularyPage extends StatefulWidget {
  final bool isVietnamese;

  const SavedVocabularyPage({super.key, required this.isVietnamese});

  @override
  State<SavedVocabularyPage> createState() => _SavedVocabularyPageState();
}

class _SavedVocabularyPageState extends State<SavedVocabularyPage> {
  final TextEditingController searchController = TextEditingController();
  ReviewFilter selectedFilter = ReviewFilter.all;
  String selectedTopic = '';

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> _openAddPage() async {
    await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => AddVocabularyPage(isVietnamese: widget.isVietnamese),
      ),
    );
    setState(() {});
  }

  List getFilteredItems(AppState state, String query) {
    var items = state.savedFlashcards;

    if (selectedFilter == ReviewFilter.review) {
      items = state.reviewFlashcards;
    } else if (selectedFilter == ReviewFilter.mastered) {
      items = state.masteredFlashcards;
    }

    if (selectedTopic.isNotEmpty) {
      items = items.where((item) => item.topic == selectedTopic).toList();
    }

    if (query.isNotEmpty) {
      items = items.where((item) {
        return item.word.toLowerCase().contains(query) ||
            item.meaning.toLowerCase().contains(query) ||
            item.topic.toLowerCase().contains(query);
      }).toList();
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    final t = AppStrings(widget.isVietnamese);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          t.savedVocabulary,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: FilledButton.tonalIcon(
              onPressed: _openAddPage,
              icon: const Icon(Icons.add),
              label: Text(t.addVocabularyShort),
            ),
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: AppState.instance,
        builder: (context, _) {
          final state = AppState.instance;
          final query = searchController.text.trim().toLowerCase();
          final items = getFilteredItems(state, query);

          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SavedHeader(
                  t: t,
                  savedCount: state.savedCount,
                  reviewCount: state.reviewCount,
                  masteredCount: state.masteredCount,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: searchController,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: t.searchWord,
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  t.learningStatus,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    FilterChipButton(
                      label: t.allWords,
                      selected: selectedFilter == ReviewFilter.all,
                      onTap: () =>
                          setState(() => selectedFilter = ReviewFilter.all),
                    ),
                    FilterChipButton(
                      label: t.reviewLabel,
                      selected: selectedFilter == ReviewFilter.review,
                      onTap: () =>
                          setState(() => selectedFilter = ReviewFilter.review),
                    ),
                    FilterChipButton(
                      label: t.masteredOnly,
                      selected: selectedFilter == ReviewFilter.mastered,
                      onTap: () => setState(
                        () => selectedFilter = ReviewFilter.mastered,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Text(
                  t.filterByTopic,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    TopicChip(
                      label: t.allTopics,
                      selected: selectedTopic.isEmpty,
                      onTap: () => setState(() => selectedTopic = ''),
                    ),
                    ...state.topics.map(
                      (topic) => TopicChip(
                        label: topic,
                        selected: selectedTopic == topic,
                        onTap: () => setState(() => selectedTopic = topic),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                if (items.isEmpty)
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: const Color(0xFFEFF3FF),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: const Icon(
                              Icons.bookmark_border,
                              size: 34,
                              color: Color(0xFF4B67E8),
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            t.noSavedWords,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            t.noSavedWordsHint,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 16),
                          FilledButton.icon(
                            onPressed: _openAddPage,
                            icon: const Icon(Icons.add),
                            label: Text(t.addVocabularyShort),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  ...items.map((item) {
                    final isMastered = state.isMastered(item.word);

                    return Card(
                      elevation: 0,
                      margin: const EdgeInsets.only(bottom: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    item.word,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                                StatusBadge(
                                  text: isMastered
                                      ? t.masteredOnly
                                      : t.reviewLabel,
                                  mastered: isMastered,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                Chip(
                                  label: Text(item.topic),
                                  avatar: const Icon(
                                    Icons.local_offer_outlined,
                                    size: 18,
                                  ),
                                ),
                                if (state.showPhonetic)
                                  Chip(
                                    label: Text(item.phonetic),
                                    avatar: const Icon(
                                      Icons.record_voice_over_outlined,
                                      size: 18,
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            InfoText(label: t.meaning, value: item.meaning),
                            const SizedBox(height: 10),
                            InfoText(label: t.example, value: item.example),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: FilledButton.tonalIcon(
                                    onPressed: () {
                                      state.toggleMasteredWord(item);
                                    },
                                    icon: Icon(
                                      isMastered
                                          ? Icons.refresh_rounded
                                          : Icons.check_circle_outline,
                                    ),
                                    label: Text(
                                      isMastered
                                          ? t.unmasteredLabel
                                          : t.masteredLabel,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: () {
                                      state.removeSavedWord(item.word);
                                    },
                                    icon: const Icon(Icons.delete_outline),
                                    label: Text(t.removeSavedWord),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
              ],
            ),
          );
        },
      ),
    );
  }
}
