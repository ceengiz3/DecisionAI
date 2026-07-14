import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/local_credits_datasource.dart';
import '../../data/repositories/credits_repository.dart';
import '../../domain/enums/subscription_tier.dart';
import '../../domain/models/user_credits.dart';

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
