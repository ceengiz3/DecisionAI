import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/enums/subscription_tier.dart';
import '../providers/credits_provider.dart';

class UpgradeScreen extends ConsumerWidget {
  const UpgradeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final currentTierAsync = ref.watch(subscriptionTierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upgrade Plan'),
      ),
      body: currentTierAsync.when(
        data: (currentTier) => _buildContent(context, ref, theme, colorScheme, currentTier),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => _buildContent(context, ref, theme, colorScheme, SubscriptionTier.free),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    ThemeData theme,
    ColorScheme colorScheme,
    SubscriptionTier currentTier,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth > 600 ? 600.0 : constraints.maxWidth;
        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
          child: Center(
            child: SizedBox(
              width: maxWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    'Choose Your Plan',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Unlock more analyses and premium features',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _PlanCard(
                    tier: SubscriptionTier.free,
                    price: 'Free',
                    isCurrent: currentTier == SubscriptionTier.free,
                    features: const [
                      '10 free analyses',
                      'Ads supported',
                      'Basic AI analysis',
                    ],
                    limitations: const [
                      'No PDF export',
                      'No priority AI',
                    ],
                    colorScheme: colorScheme,
                    theme: theme,
                    onSelect: () {},
                  ),
                  const SizedBox(height: 16),
                  _PlanCard(
                    tier: SubscriptionTier.premium,
                    price: '\$9.99/mo',
                    isCurrent: currentTier == SubscriptionTier.premium,
                    features: const [
                      '300 analyses/month',
                      'PDF export',
                      'No ads',
                      'Standard AI models',
                    ],
                    colorScheme: colorScheme,
                    theme: theme,
                    onSelect: currentTier == SubscriptionTier.premium
                        ? null
                        : () => _selectPlan(ref, SubscriptionTier.premium),
                  ),
                  const SizedBox(height: 16),
                  _PlanCard(
                    tier: SubscriptionTier.pro,
                    price: '\$19.99/mo',
                    isCurrent: currentTier == SubscriptionTier.pro,
                    features: const [
                      'Unlimited analyses',
                      'Unlimited PDF export',
                      'Priority AI processing',
                      'Future premium models',
                    ],
                    colorScheme: colorScheme,
                    theme: theme,
                    isPro: true,
                    onSelect: currentTier == SubscriptionTier.pro
                        ? null
                        : () => _selectPlan(ref, SubscriptionTier.pro),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _selectPlan(WidgetRef ref, SubscriptionTier tier) async {
    final repo = ref.read(creditsRepositoryProvider);
    await repo.setSubscriptionTier(tier);
    ref.invalidate(subscriptionTierProvider);
    ref.invalidate(userCreditsProvider);
  }
}

class _PlanCard extends StatelessWidget {
  final SubscriptionTier tier;
  final String price;
  final bool isCurrent;
  final List<String> features;
  final List<String>? limitations;
  final ColorScheme colorScheme;
  final ThemeData theme;
  final VoidCallback? onSelect;
  final bool isPro;

  const _PlanCard({
    required this.tier,
    required this.price,
    required this.isCurrent,
    required this.features,
    this.limitations,
    required this.colorScheme,
    required this.theme,
    this.onSelect,
    this.isPro = false,
  });

  @override
  Widget build(BuildContext context) {
    final (Color accent, Color accentBg, IconData icon) = switch (tier) {
      SubscriptionTier.free => (
        colorScheme.secondary,
        colorScheme.secondaryContainer.withValues(alpha: 0.3),
        Icons.person_outline_rounded,
      ),
      SubscriptionTier.premium => (
        colorScheme.primary,
        colorScheme.primaryContainer.withValues(alpha: 0.3),
        Icons.star_rounded,
      ),
      SubscriptionTier.pro => (
        colorScheme.tertiary,
        colorScheme.tertiaryContainer.withValues(alpha: 0.3),
        Icons.diamond_rounded,
      ),
    };

    return Card(
      elevation: isPro ? 2 : 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: isPro
            ? BorderSide(color: accent, width: 2)
            : BorderSide(color: colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: accentBg,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, size: 22, color: accent),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tier.displayName,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        price,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: accent,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isPro)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'BEST VALUE',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: accent,
                        fontWeight: FontWeight.w800,
                        fontSize: 10,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            ...features.map((f) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.check_circle_rounded,
                        size: 18,
                        color: colorScheme.primary,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          f,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            if (limitations != null) ...[
              const SizedBox(height: 8),
              ...limitations!.map((l) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.remove_circle_outline_rounded,
                          size: 18,
                          color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            l,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: isCurrent
                  ? OutlinedButton(
                      onPressed: null,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text('Current Plan'),
                    )
                  : FilledButton(
                      onPressed: onSelect,
                      style: FilledButton.styleFrom(
                        backgroundColor: accent,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        tier == SubscriptionTier.free
                            ? 'Downgrade'
                            : 'Subscribe',
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
