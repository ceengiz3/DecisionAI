import 'package:flutter/material.dart';

class ModelSelector extends StatelessWidget {
  final String selectedModel;
  final ValueChanged<String> onModelChanged;

  const ModelSelector({
    super.key,
    required this.selectedModel,
    required this.onModelChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'AI Model',
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: _models.map((model) {
            final isSelected = model.name == selectedModel;
            return ChoiceChip(
              selected: isSelected,
              label: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      model.icon,
                      size: 18,
                      color: isSelected
                          ? colorScheme.onPrimaryContainer
                          : colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 8),
                    Text(model.name),
                  ],
                ),
              ),
              selectedColor: colorScheme.primaryContainer,
              backgroundColor:
                  colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
              onSelected: (selected) {
                if (selected) onModelChanged(model.name);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

const List<_ModelOption> _models = [
  _ModelOption(name: 'GPT-4o', icon: Icons.auto_awesome_rounded),
  _ModelOption(name: 'Claude 3.5', icon: Icons.psychology_rounded),
  _ModelOption(name: 'Gemini Pro', icon: Icons.explore_rounded),
  _ModelOption(name: 'DeepSeek', icon: Icons.lightbulb_rounded),
];

class _ModelOption {
  final String name;
  final IconData icon;

  const _ModelOption({required this.name, required this.icon});
}
