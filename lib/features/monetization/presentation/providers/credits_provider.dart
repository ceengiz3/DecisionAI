import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/local_credits_datasource.dart';
import '../../data/repositories/credits_repository.dart';
import '../../domain/enums/subscription_tier.dart';
import '../../domain/models/user_credits.dart';
import '../../services/ad_service.dart';
import '../../services/local_purchase_verifier.dart';
import '../../services/purchase_service.dart';
import '../../services/subscription_manager.dart';

final localCreditsDataSourceProvider =
    Provider<LocalCreditsDataSource>((ref) {
  return LocalCreditsDataSource();
});

final creditsRepositoryProvider = Provider<CreditsRepository>((ref) {
  return CreditsRepository(ref.watch(localCreditsDataSourceProvider));
});

final userCreditsProvider =
    FutureProvider.autoDispose<UserCredits>((ref) async {
  final repo = ref.watch(creditsRepositoryProvider);
  return repo.getUserCredits();
});

final subscriptionTierProvider =
    FutureProvider.autoDispose<SubscriptionTier>((ref) async {
  final repo = ref.watch(creditsRepositoryProvider);
  return repo.getSubscriptionTier();
});

final adServiceProvider = Provider<AdService>((ref) {
  final repo = ref.watch(creditsRepositoryProvider);
  final service = AdService(repo);
  ref.onDispose(() => service.dispose());
  service.initialize();
  return service;
});

final purchaseVerifierProvider = Provider<LocalPurchaseVerifier>((ref) {
  return LocalPurchaseVerifier();
});

final purchaseServiceProvider = Provider<PurchaseService>((ref) {
  final verifier = ref.watch(purchaseVerifierProvider);
  final repo = ref.watch(creditsRepositoryProvider);
  final service = PurchaseService(verifier: verifier);

  service.setOnPurchaseVerified((verification) {
    repo.setVerifiedSubscription(
      tier: verification.verifiedTier,
      expiryDate: verification.expiryDate ?? DateTime.now().add(const Duration(days: 30)),
    );
    ref.invalidate(userCreditsProvider);
    ref.invalidate(subscriptionTierProvider);
  });

  ref.onDispose(() => service.dispose());
  service.initialize();
  return service;
});

final subscriptionManagerProvider = Provider<SubscriptionManager>((ref) {
  final dataSource = ref.watch(localCreditsDataSourceProvider);
  final manager = SubscriptionManager(dataSource);
  ref.onDispose(() => manager.dispose());
  manager.initialize();
  return manager;
});
