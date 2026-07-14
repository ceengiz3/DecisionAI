import 'package:flutter/material.dart';

import '../../../../l10n/l10n.dart';

class HistoryFilterSort extends StatelessWidget {
  final Set<String> availableModels;
  final String? selectedModel;
  final bool sortAscending;
  final ValueChanged<String?> onModelChanged;
  final VoidCallback onSortToggle;

  const HistoryFilterSort({
    super.key,
    required this.availableModels,
    required this.selectedModel,
    required this.sortAscending,
    required this.onModelChanged,
    required this.onSortToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        if (availableModels.isNotEmpty)
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildChip(theme, colorScheme, context.l10n.historyAll, null),
                  ...availableModels.map(
                    (model) => _buildChip(theme, colorScheme, model, model),
                  ),
                ],
              ),
            ),
          ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: onSortToggle,
          icon: Icon(
            sortAscending
                ? Icons.arrow_upward_rounded
                : Icons.arrow_downward_rounded,
            size: 20,
          ),
          tooltip: sortAscending
              ? context.l10n.historyOldestFirst
              : context.l10n.historyNewestFirst,
          style: IconButton.styleFrom(
            backgroundColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChip(
    ThemeData theme,
    ColorScheme colorScheme,
    String label,
    String? value,
  ) {
    final isSelected = selectedModel == value;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        selected: isSelected,
        label: Text(label),
        onSelected: (_) => onModelChanged(value),
        visualDensity: VisualDensity.compact,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
