import 'package:flutter/material.dart';

import '../mock_data.dart';
import 'decision_card.dart';

class RecentDecisionsSection extends StatelessWidget {
  final Animation<double> parentAnimation;

  const RecentDecisionsSection({
    super.key,
    required this.parentAnimation,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

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
              onPressed: () {},
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
        ...List.generate(mockDecisions.length, (index) {
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
              decision: mockDecisions[index],
              index: index,
            ),
          );
        }),
      ],
    );
  }
}
