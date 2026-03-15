import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../core/data/app_state.dart';
import '../../../core/i18n/app_strings.dart';
import '../../../core/models/lesson_models.dart';

class FlashcardStudyPage extends StatefulWidget {
  final bool isVietnamese;
  final String topic;
  final FlashcardCollectionMode mode;

  const FlashcardStudyPage({
    super.key,
    required this.isVietnamese,
    required this.topic,
    required this.mode,
  });

  @override
  State<FlashcardStudyPage> createState() => _FlashcardStudyPageState();
}

class _FlashcardStudyPageState extends State<FlashcardStudyPage>
    with SingleTickerProviderStateMixin {
  int index = 0;
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animation = Tween<double>(begin: 0, end: math.pi).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _flip() {
    if (_controller.value > 0.5) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  void _changeCard(int value, int total) {
    final next = index + value;
    if (next < 0 || next >= total) return;
    if (_controller.value > 0) _controller.reverse();
    setState(() => index = next);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppStrings(widget.isVietnamese);

    return AnimatedBuilder(
      animation: AppState.instance,
      builder: (context, _) {
        final state = AppState.instance;
        final items = state.flashcardsByTopicAndMode(widget.topic, widget.mode);

        if (items.isEmpty) {
          return Scaffold(
            appBar: AppBar(title: Text(widget.topic)),
            body: Center(
              child: Text(
                widget.isVietnamese
                    ? 'Không có từ vựng phù hợp trong bộ này.'
                    : 'No matching vocabulary in this set.',
              ),
            ),
          );
        }

        if (index >= items.length) index = items.length - 1;

        final item = items[index];
        final isSaved = state.isSaved(item.word);
        final isMastered = state.isMastered(item.word);

        return Scaffold(
          appBar: AppBar(title: Text(widget.topic)),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildHeader(items.length, state),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.tonalIcon(
                        onPressed: () {
                          state.toggleSavedWord(item);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                isSaved ? t.removedFromSaved : t.addedToSaved,
                              ),
                            ),
                          );
                        },
                        icon: Icon(isSaved
                            ? Icons.bookmark
                            : Icons.bookmark_add_outlined),
                        label: Text(isSaved ? t.savedLabel : t.saveWord),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () {
                          state.toggleMasteredWord(item);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                isMastered
                                    ? t.markedAsReview
                                    : t.markedAsMastered,
                              ),
                            ),
                          );
                        },
                        icon: Icon(
                          isMastered
                              ? Icons.refresh_rounded
                              : Icons.check_circle_outline,
                        ),
                        label: Text(
                          isMastered ? t.unmasteredLabel : t.masteredLabel,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: _flip,
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, _) {
                      final angle = _animation.value;
                      final isFront = angle <= math.pi / 2;

                      return Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(angle),
                        child: isFront
                            ? _frontCard(
                                item, state.showPhonetic, isSaved, isMastered)
                            : Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()..rotateY(math.pi),
                                child: _backCard(item, t),
                              ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                LinearProgressIndicator(
                  value: (index + 1) / items.length,
                  minHeight: 10,
                  borderRadius: BorderRadius.circular(10),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: index == 0
                            ? null
                            : () => _changeCard(-1, items.length),
                        icon: const Icon(Icons.arrow_back),
                        label: Text(t.previous),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: index == items.length - 1
                            ? null
                            : () => _changeCard(1, items.length),
                        icon: const Icon(Icons.arrow_forward),
                        label: Text(t.next),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(int total, AppState state) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF3FF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: _headerItem(
                      widget.isVietnamese ? 'Tiến độ' : 'Progress',
                      '${index + 1}/$total')),
              Expanded(
                  child: _headerItem(widget.isVietnamese ? 'Đã lưu' : 'Saved',
                      '${state.savedCount}')),
              Expanded(
                  child: _headerItem(
                      widget.isVietnamese ? 'Đã thuộc' : 'Mastered',
                      '${state.masteredCount}')),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            widget.isVietnamese
                ? 'Chạm vào thẻ để lật'
                : 'Tap the card to flip',
            style: TextStyle(color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }

  Widget _headerItem(String label, String value) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.grey.shade700)),
      ],
    );
  }

  Widget _frontCard(
    FlashcardItem item,
    bool showPhonetic,
    bool isSaved,
    bool isMastered,
  ) {
    return Container(
      height: 320,
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isMastered
              ? const [Color(0xFF17925E), Color(0xFF35B57B)]
              : const [Color(0xFF5B7CFA), Color(0xFF8CA3FF)],
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _badge(item.topic),
              const Spacer(),
              if (isSaved) const Icon(Icons.bookmark, color: Colors.white),
            ],
          ),
          const Spacer(),
          Text(
            item.word,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.w800,
            ),
          ),
          if (showPhonetic) ...[
            const SizedBox(height: 10),
            Text(
              item.phonetic,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 20,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _backCard(FlashcardItem item, AppStrings t) {
    return Container(
      height: 320,
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t.meaning, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          Text(item.meaning, style: const TextStyle(fontSize: 18, height: 1.5)),
          const SizedBox(height: 18),
          Text(t.example, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          Text(item.example, style: const TextStyle(fontSize: 16, height: 1.5)),
        ],
      ),
    );
  }

  Widget _badge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
      ),
    );
  }
}
