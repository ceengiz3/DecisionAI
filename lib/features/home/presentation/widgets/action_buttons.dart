import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/routes.dart';
import '../../../../l10n/l10n.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FilledButton.icon(
          onPressed: () => context.go(AppRoutes.newDecision),
          icon: const Icon(Icons.add_circle_outline_rounded),
          label: Text(l.homeNewDecision),
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 18),
            textStyle: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: () => context.go(AppRoutes.history),
          icon: Icon(
            Icons.history_rounded,
            color: colorScheme.primary,
          ),
          label: Text(
            l.homeDecisionHistory,
            style: TextStyle(color: colorScheme.primary),
          ),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 18),
            textStyle: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            side: BorderSide(color: colorScheme.outline),
          ),
        ),
      ],
    );
  }
}
