import 'package:flutter/material.dart';
import '../../../core/i18n/app_strings.dart';

class TopicModeSwitch extends StatelessWidget {
  final bool useCustomTopic;
  final VoidCallback onUseExisting;
  final VoidCallback onCreateNew;
  final AppStrings t;

  const TopicModeSwitch({
    super.key,
    required this.useCustomTopic,
    required this.onUseExisting,
    required this.onCreateNew,
    required this.t,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ChoiceChip(
            label: Text(t.useExistingTopic),
            selected: !useCustomTopic,
            onSelected: (_) => onUseExisting(),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ChoiceChip(
            label: Text(t.createNewTopic),
            selected: useCustomTopic,
            onSelected: (_) => onCreateNew(),
          ),
        ),
      ],
    );
  }
}
