import 'dart:async';

import '../data/datasources/local_credits_datasource.dart';
import '../domain/enums/subscription_tier.dart';

class SubscriptionManager {
  final LocalCreditsDataSource _dataSource;
  Timer? _quotaTimer;
  Timer? _expiryTimer;

  SubscriptionManager(this._dataSource);

  Future<void> initialize() async {
    await _checkSubscriptionExpiry();
    await _checkMonthlyQuotaReset();
    _startPeriodicChecks();
  }

  Future<void> _checkSubscriptionExpiry() async {
    final profile = await _dataSource.getOrCreateProfile();

    if (profile.subscriptionTier == SubscriptionTier.free.name) return;

    if (profile.subscriptionExpiry == null) return;

    if (DateTime.now().isAfter(profile.subscriptionExpiry!)) {
      await _dataSource.setSubscriptionTier(SubscriptionTier.free);
    }
  }

  Future<void> _checkMonthlyQuotaReset() async {
    final profile = await _dataSource.getOrCreateProfile();
    final now = DateTime.now();
    final lastReset = profile.monthlyAnalysesResetDate;

    if (lastReset.month != now.month || lastReset.year != now.year) {
      await _dataSource.resetMonthlyUsage();
    }
  }

  void _startPeriodicChecks() {
    _quotaTimer?.cancel();
    _expiryTimer?.cancel();

    _quotaTimer = Timer.periodic(
      const Duration(hours: 6),
      (_) => _checkMonthlyQuotaReset(),
    );

    _expiryTimer = Timer.periodic(
      const Duration(hours: 1),
      (_) => _checkSubscriptionExpiry(),
    );
  }

  void dispose() {
    _quotaTimer?.cancel();
    _expiryTimer?.cancel();
  }
}
