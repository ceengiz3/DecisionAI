import 'package:flutter/material.dart';

class HeroCard extends StatelessWidget {
  const HeroCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
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
              color: colorScheme.primary.withAlpha(50),
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
            'Make Smarter\nDecisions',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w800,
              color: colorScheme.onPrimaryContainer,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Leverage AI-powered analysis to evaluate options and make confident, data-driven choices.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onPrimaryContainer.withAlpha(180),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Icon(
                Icons.analytics_rounded,
                size: 16,
                color: colorScheme.onPrimaryContainer.withAlpha(150),
              ),
              const SizedBox(width: 6),
              Text(
                'Powered by advanced analysis',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colorScheme.onPrimaryContainer.withAlpha(150),
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
