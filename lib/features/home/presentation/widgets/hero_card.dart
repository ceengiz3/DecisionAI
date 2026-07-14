import 'package:flutter/material.dart';

import '../../../../l10n/l10n.dart';

class HeroCard extends StatelessWidget {
  const HeroCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l = context.l10n;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(28, 28, 28, 28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primaryContainer,
            colorScheme.tertiaryContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              Icons.auto_awesome_rounded,
              color: colorScheme.primary,
              size: 28,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            l.homeHeroTitle,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w800,
              color: colorScheme.onPrimaryContainer,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            l.homeHeroSubtitle,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onPrimaryContainer.withValues(alpha: 0.8),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Icon(
                Icons.analytics_rounded,
                size: 16,
                color: colorScheme.onPrimaryContainer.withValues(alpha: 0.6),
              ),
              const SizedBox(width: 6),
              Text(
                l.homeHeroBadge,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colorScheme.onPrimaryContainer.withValues(alpha: 0.6),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
