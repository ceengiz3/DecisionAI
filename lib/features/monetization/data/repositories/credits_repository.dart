import '../../domain/enums/subscription_tier.dart';
import '../../domain/models/user_credits.dart';
import '../datasources/local_credits_datasource.dart';

class CreditsRepository {
  final LocalCreditsDataSource _dataSource;

  CreditsRepository(this._dataSource);

  Future<UserCredits> getUserCredits() async {
    final profile = await _dataSource.getOrCreateProfile();
    final tier = SubscriptionTier.fromString(profile.subscriptionTier);
    return UserCredits(
      userId: profile.userId,
      credits: profile.credits,
      monthlyAnalysesUsed: profile.monthlyAnalysesUsed,
      monthlyAnalysesLimit: tier.monthlyAnalysisLimit,
      isUnlimited: tier.isUnlimited,
    );
  }

  Future<bool> consumeCredit() async {
    final credits = await getUserCredits();
    if (!credits.canAnalyze) return false;
    await _dataSource.spendCredit();
    return true;
  }

  Future<void> addCredits(int amount) async {
    await _dataSource.addCredits(amount);
  }

  Future<SubscriptionTier> getSubscriptionTier() async {
    final profile = await _dataSource.getOrCreateProfile();
    return SubscriptionTier.fromString(profile.subscriptionTier);
  }

  Future<void> setSubscriptionTier(SubscriptionTier tier) async {
    await _dataSource.setSubscriptionTier(tier);
  }
}
