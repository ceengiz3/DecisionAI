import '../enums/subscription_tier.dart';

class PurchaseState {
  final bool isPurchasing;
  final bool hasActiveSubscription;
  final SubscriptionTier activeTier;
  final DateTime? expiryDate;
  final String? error;

  const PurchaseState({
    this.isPurchasing = false,
    this.hasActiveSubscription = false,
    this.activeTier = SubscriptionTier.free,
    this.expiryDate,
    this.error,
  });

  PurchaseState copyWith({
    bool? isPurchasing,
    bool? hasActiveSubscription,
    SubscriptionTier? activeTier,
    DateTime? expiryDate,
    String? error,
    bool clearError = false,
  }) {
    return PurchaseState(
      isPurchasing: isPurchasing ?? this.isPurchasing,
      hasActiveSubscription: hasActiveSubscription ?? this.hasActiveSubscription,
      activeTier: activeTier ?? this.activeTier,
      expiryDate: expiryDate ?? this.expiryDate,
      error: clearError ? null : (error ?? this.error),
    );
  }
}
