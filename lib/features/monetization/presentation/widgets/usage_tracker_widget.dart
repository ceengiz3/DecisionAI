import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/enums/subscription_tier.dart';
import '../../domain/models/user_credits.dart';
import '../providers/credits_provider.dart';

class UsageTrackerWidget extends ConsumerWidget {
  const UsageTrackerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final creditsAsync = ref.watch(userCreditsProvider);
    final tierAsync = ref.watch(subscriptionTierProvider);

    return creditsAsync.when(
      data: (credits) => tierAsync.when(
        data: (tier) => _buildContent(context, ref, credits, tier),
        loading: () => _buildSkeleton(context),
        error: (_, _) => const SizedBox.shrink(),
      ),
      loading: () => _buildSkeleton(context),
      error: (_, _) => const SizedBox.shrink(),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    UserCredits credits,
    SubscriptionTier tier,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _Badge(theme: theme, colorScheme: colorScheme, tier: tier),
          const SizedBox(width: 8),
          if (!credits.isUnlimited) ...[
            _Stat(
              icon: Icons.monetization_on_outlined,
              value: '${credits.credits}',
              label: 'cr',
              theme: theme,
              colorScheme: colorScheme,
            ),
            const SizedBox(width: 8),
            Container(
              width: 1,
              height: 16,
              color: colorScheme.outlineVariant,
            ),
            const SizedBox(width: 8),
            _Stat(
              icon: Icons.analytics_outlined,
              value: credits.remainingMonthlyAnalyses == 0
                  ? '0'
                  : '${credits.remainingMonthlyAnalyses}',
              label: 'mo',
              theme: theme,
              colorScheme: colorScheme,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSkeleton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .surfaceContainerHighest
            .withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .onSurfaceVariant
                  .withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 40,
            height: 12,
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .onSurfaceVariant
                  .withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final ThemeData theme;
  final ColorScheme colorScheme;
  final SubscriptionTier tier;

  const _Badge({
    required this.theme,
    required this.colorScheme,
    required this.tier,
  });

  @override
  Widget build(BuildContext context) {
    final (Color bg, Color fg, IconData icon, String label) = switch (tier) {
      SubscriptionTier.free => (
        colorScheme.secondaryContainer,
        colorScheme.onSecondaryContainer,
        Icons.person_outline_rounded,
        'Free',
      ),
      SubscriptionTier.premium => (
        colorScheme.primaryContainer,
        colorScheme.onPrimaryContainer,
        Icons.star_rounded,
        'Premium',
      ),
      SubscriptionTier.pro => (
        colorScheme.tertiaryContainer,
        colorScheme.onTertiaryContainer,
        Icons.diamond_rounded,
        'Pro',
      ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: fg),
          const SizedBox(width: 4),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: fg,
              fontWeight: FontWeight.w700,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final ThemeData theme;
  final ColorScheme colorScheme;

  const _Stat({
    required this.icon,
    required this.value,
    required this.label,
    required this.theme,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: colorScheme.onSurfaceVariant),
        const SizedBox(width: 3),
        Text(
          value,
          style: theme.textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(width: 2),
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            fontSize: 10,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
