import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/database/models/decision_record.dart';
import '../../../../core/di/providers.dart';
import '../../../../core/router/routes.dart';
import 'decision_card.dart';

class RecentDecisionsSection extends ConsumerWidget {
  final Animation<double> parentAnimation;

  const RecentDecisionsSection({
    super.key,
    required this.parentAnimation,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final recordsAsync = ref.watch(recentDecisionsProvider);

    return recordsAsync.when(
      data: (records) => _buildContent(context, theme, colorScheme, records),
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
    );
  }

  Widget _buildContent(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
    List<DecisionRecord> records,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Decisions',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            TextButton(
              onPressed: () => context.go(AppRoutes.history),
              child: Text(
                'View All',
                style: TextStyle(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (records.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Center(
              child: Text(
                'No decisions yet. Start a new analysis!',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          )
        else
          ...List.generate(records.length, (index) {
            final cardIntervalStart = 0.3 + (index * 0.1);
            final cardIntervalEnd = cardIntervalStart + 0.2;
            final cardAnimation = Tween<double>(
              begin: 0,
              end: 1,
            ).animate(
              CurvedAnimation(
                parent: parentAnimation,
                curve: Interval(
                  cardIntervalStart,
                  cardIntervalEnd,
                  curve: Curves.easeOutCubic,
                ),
              ),
            );
            return AnimatedBuilder(
              animation: cardAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: cardAnimation.value,
                  child: Transform.translate(
                    offset: Offset(0, 20 * (1 - cardAnimation.value)),
                    child: child,
                  ),
                );
              },
              child: DecisionCard(
                record: records[index],
                index: index,
              ),
            );
          }),
      ],
    );
  }
}
