import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/di/providers.dart';
import '../../../../core/domain/enums/ai_provider_type.dart';


class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _keyControllers = <AiProviderType, TextEditingController>{};
  final _keyObscured = <AiProviderType, bool>{};

  @override
  void initState() {
    super.initState();
    for (final type in AiProviderType.values) {
      _keyControllers[type] = TextEditingController();
      _keyObscured[type] = true;
    }
    _loadKeys();
  }

  @override
  void dispose() {
    for (final c in _keyControllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _loadKeys() async {
    final storage = ref.read(apiKeyStorageProvider);
    for (final type in AiProviderType.values) {
      final key = await storage.getApiKey(type);
      if (key != null) {
        _keyControllers[type]?.text = key;
      }
    }
  }

  Future<void> _saveKey(AiProviderType type) async {
    final value = _keyControllers[type]?.text ?? '';
    if (value.trim().isEmpty) return;

    await ref.read(apiKeyStorageProvider).saveApiKey(type, value.trim());

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${type.displayName} key saved'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _deleteKey(AiProviderType type) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete API Key'),
        content: Text(
          'Remove ${type.displayName} API key?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    await ref.read(apiKeyStorageProvider).deleteApiKey(type);
    _keyControllers[type]?.clear();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${type.displayName} key deleted'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth =
              constraints.maxWidth > 600 ? 600.0 : constraints.maxWidth;
          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
            child: Center(
              child: SizedBox(
                width: maxWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const _SectionHeader(title: 'AI Model', icon: Icons.model_training_rounded),
                    const SizedBox(height: 8),
                    _DefaultModelCard(),
                    const SizedBox(height: 28),
                    const _SectionHeader(title: 'API Keys', icon: Icons.key_rounded),
                    const SizedBox(height: 8),
                    Text(
                      'Enter your API keys for each provider. Keys are stored securely on your device.',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...AiProviderType.values.map(
                      (type) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _ApiKeyCard(
                          type: type,
                          controller: _keyControllers[type]!,
                          obscured: _keyObscured[type] ?? true,
                          onToggleObscured: () =>
                              setState(() => _keyObscured[type] = !(_keyObscured[type] ?? true)),
                          onSave: () => _saveKey(type),
                          onDelete: () => _deleteKey(type),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    const _SectionHeader(title: 'Appearance', icon: Icons.palette_rounded),
                    const SizedBox(height: 8),
                    _DarkModeCard(),
                    const SizedBox(height: 28),
                    const _SectionHeader(title: 'About', icon: Icons.info_outline_rounded),
                    const SizedBox(height: 8),
                    _AboutCard(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;

  const _SectionHeader({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, size: 18, color: theme.colorScheme.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: theme.colorScheme.primary,
          ),
        ),
      ],
    );
  }
}

class _DefaultModelCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final currentModel = ref.watch(defaultModelProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Default AI Model',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Pre-selected model when creating a new decision',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest
                    .withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: theme.colorScheme.outlineVariant,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: currentModel,
                  isExpanded: true,
                  items: AiProviderType.values.map((type) {
                    return DropdownMenuItem(
                      value: type.displayName,
                      child: Row(
                        children: [
                          Icon(
                            _iconFor(type),
                            size: 18,
                            color: _colorFor(type),
                          ),
                          const SizedBox(width: 10),
                          Text(type.displayName),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      ref
                          .read(defaultModelProvider.notifier)
                          .setDefaultModel(value);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _iconFor(AiProviderType type) {
    switch (type) {
      case AiProviderType.openai:
        return Icons.auto_awesome_rounded;
      case AiProviderType.gemini:
        return Icons.explore_rounded;
      case AiProviderType.claude:
        return Icons.psychology_rounded;
      case AiProviderType.deepseek:
        return Icons.lightbulb_rounded;
    }
  }

  Color _colorFor(AiProviderType type) {
    switch (type) {
      case AiProviderType.openai:
        return Colors.teal;
      case AiProviderType.gemini:
        return Colors.blue;
      case AiProviderType.claude:
        return Colors.orange;
      case AiProviderType.deepseek:
        return Colors.purple;
    }
  }
}

class _ApiKeyCard extends StatelessWidget {
  final AiProviderType type;
  final TextEditingController controller;
  final bool obscured;
  final VoidCallback onToggleObscured;
  final VoidCallback onSave;
  final VoidCallback onDelete;

  const _ApiKeyCard({
    required this.type,
    required this.controller,
    required this.obscured,
    required this.onToggleObscured,
    required this.onSave,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final hasContent = controller.text.isNotEmpty;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: _colorFor(type).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    _iconFor(type),
                    size: 20,
                    color: _colorFor(type),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  type.displayName,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: controller,
              obscureText: obscured,
              decoration: InputDecoration(
                hintText: 'Enter your ${type.displayName} API key',
                hintStyle: TextStyle(
                  fontSize: 13,
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                ),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    obscured ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                    size: 20,
                  ),
                  onPressed: onToggleObscured,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: FilledButton.tonalIcon(
                    onPressed: hasContent ? onSave : null,
                    icon: const Icon(Icons.save_rounded, size: 18),
                    label: const Text('Save'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  height: 40,
                  child: OutlinedButton.icon(
                    onPressed: hasContent ? onDelete : null,
                    icon: const Icon(Icons.delete_outline_rounded, size: 18),
                    label: const Text('Delete'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: colorScheme.error,
                      side: BorderSide(color: colorScheme.error.withValues(alpha: 0.3)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _iconFor(AiProviderType type) {
    switch (type) {
      case AiProviderType.openai:
        return Icons.auto_awesome_rounded;
      case AiProviderType.gemini:
        return Icons.explore_rounded;
      case AiProviderType.claude:
        return Icons.psychology_rounded;
      case AiProviderType.deepseek:
        return Icons.lightbulb_rounded;
    }
  }

  Color _colorFor(AiProviderType type) {
    switch (type) {
      case AiProviderType.openai:
        return Colors.teal;
      case AiProviderType.gemini:
        return Colors.blue;
      case AiProviderType.claude:
        return Colors.orange;
      case AiProviderType.deepseek:
        return Colors.purple;
    }
  }
}

class _DarkModeCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final currentMode = ref.watch(themeModeProvider);

    Widget modeTile(ThemeMode mode, String label, IconData icon) {
      final selected = currentMode == mode;
      return InkWell(
        onTap: () => ref.read(themeModeProvider.notifier).setThemeMode(mode),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: selected
                ? theme.colorScheme.primaryContainer.withValues(alpha: 0.4)
                : null,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected
                  ? theme.colorScheme.primary.withValues(alpha: 0.4)
                  : theme.colorScheme.outlineVariant,
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: selected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
              if (selected)
                Icon(
                  Icons.check_circle_rounded,
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
            ],
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Theme',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            modeTile(ThemeMode.light, 'Light', Icons.light_mode_rounded),
            const SizedBox(height: 8),
            modeTile(ThemeMode.dark, 'Dark', Icons.dark_mode_rounded),
            const SizedBox(height: 8),
            modeTile(ThemeMode.system, 'System', Icons.settings_rounded),
          ],
        ),
      ),
    );
  }
}

class _AboutCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.auto_awesome_rounded,
                    color: colorScheme.onPrimaryContainer,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppConstants.appName,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Version ${AppConstants.appVersion}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.shield_rounded,
                    size: 16,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Your API keys are stored securely on your device using encrypted storage. '
                      'No data is collected or transmitted to third parties. '
                      'All AI analysis requests are sent directly to the chosen provider.',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
