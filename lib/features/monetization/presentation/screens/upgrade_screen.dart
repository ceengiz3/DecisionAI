import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/l10n.dart';
import '../../domain/enums/subscription_tier.dart';
import '../../services/purchase_service.dart';
import '../providers/credits_provider.dart';

class UpgradeScreen extends ConsumerWidget {
  const UpgradeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l = context.l10n;
    final currentTierAsync = ref.watch(subscriptionTierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l.upgradeTitle),
      ),
      body: currentTierAsync.when(
        data: (currentTier) => _buildContent(
          context, ref, theme, colorScheme, currentTier,
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => _buildContent(
          context, ref, theme, colorScheme, SubscriptionTier.free,
        ),
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
    final purchaseService = ref.watch(purchaseServiceProvider);
    final purchaseState = purchaseService.purchaseState.value;
    final isPurchasing = purchaseState.isPurchasing;
    final l = context.l10n;

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
                    l.upgradeChoosePlan,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l.upgradeSubtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  if (purchaseState.error != null) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: colorScheme.errorContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.error_outline, size: 18, color: colorScheme.onErrorContainer),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              purchaseState.error!,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colorScheme.onErrorContainer,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  _PlanCard(
                    tier: SubscriptionTier.free,
                    price: 'Free',
                    isCurrent: currentTier == SubscriptionTier.free,
                    features: [
                      l.freeTierFeature1,
                      l.freeTierFeature2,
                      l.freeTierFeature3,
                    ],
                    limitations: [
                      l.freeTierLimit1,
                      l.freeTierLimit2,
                    ],
                    colorScheme: colorScheme,
                    theme: theme,
                    onSelect: () {},
                    isPurchasing: isPurchasing,
                  ),
                  const SizedBox(height: 16),
                  _PlanCard(
                    tier: SubscriptionTier.premium,
                    price: l.premiumTierPrice,
                    isCurrent: currentTier == SubscriptionTier.premium,
                    features: [
                      l.premiumTierFeature1,
                      l.premiumTierFeature2,
                      l.premiumTierFeature3,
                      l.premiumTierFeature4,
                    ],
                    colorScheme: colorScheme,
                    theme: theme,
                    onSelect: currentTier == SubscriptionTier.premium
                        ? null
                        : () => _purchase(ref, SubscriptionTier.premium),
                    isPurchasing: isPurchasing,
                  ),
                  const SizedBox(height: 16),
                  _PlanCard(
                    tier: SubscriptionTier.pro,
                    price: l.proTierPrice,
                    isCurrent: currentTier == SubscriptionTier.pro,
                    features: [
                      l.proTierFeature1,
                      l.proTierFeature2,
                      l.proTierFeature3,
                      l.proTierFeature4,
                    ],
                    colorScheme: colorScheme,
                    theme: theme,
                    isPro: true,
                    onSelect: currentTier == SubscriptionTier.pro
                        ? null
                        : () => _purchase(ref, SubscriptionTier.pro),
                    isPurchasing: isPurchasing,
                  ),
                  const SizedBox(height: 20),
                  _RestoreButton(
                    purchaseService: purchaseService,
                    isPurchasing: isPurchasing,
                    theme: theme,
                    colorScheme: colorScheme,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _purchase(WidgetRef ref, SubscriptionTier tier) async {
    final service = ref.read(purchaseServiceProvider);
    await service.purchaseSubscription(tier);
  }
}

class _RestoreButton extends StatelessWidget {
  final PurchaseService purchaseService;
  final bool isPurchasing;
  final ThemeData theme;
  final ColorScheme colorScheme;

  const _RestoreButton({
    required this.purchaseService,
    required this.isPurchasing,
    required this.theme,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton.icon(
        onPressed: isPurchasing
            ? null
            : () => purchaseService.restorePurchases(),
        icon: Icon(
          Icons.restore_rounded,
          size: 18,
          color: isPurchasing
              ? colorScheme.onSurfaceVariant.withValues(alpha: 0.4)
              : colorScheme.primary,
        ),
        label: Text(
          context.l10n.upgradeRestore,
          style: theme.textTheme.bodySmall?.copyWith(
            color: isPurchasing
                ? colorScheme.onSurfaceVariant.withValues(alpha: 0.4)
                : colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
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
  final bool isPurchasing;

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
    this.isPurchasing = false,
  });

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;

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
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accentBg,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(icon, size: 24, color: accent),
                ),
                const SizedBox(width: 14),
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
                      l.upgradeBestValue,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: accent,
                        fontWeight: FontWeight.w800,
                        fontSize: 10,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),
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
            const SizedBox(height: 20),
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
                      child: Text(l.upgradeCurrentPlan),
                    )
                  : FilledButton(
                      onPressed: isPurchasing ? null : onSelect,
                      style: FilledButton.styleFrom(
                        backgroundColor: accent,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: isPurchasing
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(
                              tier == SubscriptionTier.free
                                  ? l.upgradeDowngrade
                                  : l.upgradeSubscribe,
                            ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
