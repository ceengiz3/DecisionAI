import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/providers.dart';
import '../../../../core/domain/enums/ai_provider_type.dart';

class ApiKeySettingsScreen extends ConsumerStatefulWidget {
  const ApiKeySettingsScreen({super.key});

  @override
  ConsumerState<ApiKeySettingsScreen> createState() =>
      _ApiKeySettingsScreenState();
}

class _ApiKeySettingsScreenState
    extends ConsumerState<ApiKeySettingsScreen> {
  final _controllers = <AiProviderType, TextEditingController>{};
  bool _saved = false;

  @override
  void initState() {
    super.initState();
    for (final type in AiProviderType.values) {
      _controllers[type] = TextEditingController();
    }
    _loadKeys();
  }

  Future<void> _loadKeys() async {
    final storage = ref.read(apiKeyStorageProvider);
    for (final type in AiProviderType.values) {
      final key = await storage.getApiKey(type);
      if (key != null) {
        _controllers[type]?.text = key;
      }
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _saveAll() async {
    final storage = ref.read(apiKeyStorageProvider);
    for (final type in AiProviderType.values) {
      final value = _controllers[type]?.text ?? '';
      if (value.isNotEmpty) {
        await storage.saveApiKey(type, value);
      }
    }
    setState(() => _saved = true);
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('API Keys')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth =
              constraints.maxWidth > 600 ? 600.0 : constraints.maxWidth;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: SizedBox(
                width: maxWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Enter your API keys for each provider. Keys are stored securely on your device.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ...AiProviderType.values.map((type) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  _iconFor(type),
                                  size: 20,
                                  color: _colorFor(type),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  type.displayName,
                                  style: theme.textTheme.titleSmall
                                      ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _controllers[type],
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Enter ${type.displayName} API key',
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 12),
                    FilledButton.icon(
                      onPressed: _saveAll,
                      icon: const Icon(Icons.save_rounded),
                      label: const Text('Save Keys'),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    if (_saved)
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(
                          'Keys saved successfully.',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
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
