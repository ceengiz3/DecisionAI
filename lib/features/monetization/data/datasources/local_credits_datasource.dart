import 'package:isar/isar.dart';

import '../../../../core/database/isar_database.dart';
import '../../../../core/database/models/user_profile.dart';
import '../../domain/enums/subscription_tier.dart';

class LocalCreditsDataSource {
  Future<UserProfile> getOrCreateProfile() async {
    final isar = await IsarDatabase.getInstance();
    final profile = await isar.userProfiles.where().findFirst();
    if (profile != null) return profile;
    final newProfile = UserProfile()
      ..userId = _generateUserId()
      ..credits = 10
      ..subscriptionTier = SubscriptionTier.free.name
      ..createdAt = DateTime.now()
      ..monthlyAnalysesResetDate = DateTime.now();
    await isar.writeTxn(() async {
      await isar.userProfiles.put(newProfile);
    });
    return newProfile;
  }

  Future<void> spendCredit() async {
    final isar = await IsarDatabase.getInstance();
    final profile = await getOrCreateProfile();
    if (profile.credits > 0) {
      await isar.writeTxn(() async {
        profile.credits -= 1;
        profile.monthlyAnalysesUsed += 1;
        await isar.userProfiles.put(profile);
      });
    }
  }

  Future<void> addCredits(int amount) async {
    final isar = await IsarDatabase.getInstance();
    final profile = await getOrCreateProfile();
    await isar.writeTxn(() async {
      profile.credits += amount;
      await isar.userProfiles.put(profile);
    });
  }

  Future<void> setSubscriptionTier(SubscriptionTier tier) async {
    final isar = await IsarDatabase.getInstance();
    final profile = await getOrCreateProfile();
    await isar.writeTxn(() async {
      profile.subscriptionTier = tier.name;
      if (tier != SubscriptionTier.free) {
        profile.subscriptionExpiry =
            DateTime.now().add(const Duration(days: 30));
      } else {
        profile.subscriptionExpiry = null;
      }
      await isar.userProfiles.put(profile);
    });
  }

  Future<void> setVerifiedSubscription({
    required SubscriptionTier tier,
    required DateTime expiryDate,
  }) async {
    final isar = await IsarDatabase.getInstance();
    final profile = await getOrCreateProfile();
    await isar.writeTxn(() async {
      profile.subscriptionTier = tier.name;
      profile.subscriptionExpiry = expiryDate;
      await isar.userProfiles.put(profile);
    });
  }

  Future<bool> isSubscriptionExpired() async {
    final profile = await getOrCreateProfile();
    if (profile.subscriptionTier == SubscriptionTier.free.name) return false;
    if (profile.subscriptionExpiry == null) return true;
    return DateTime.now().isAfter(profile.subscriptionExpiry!);
  }

  Future<void> resetMonthlyUsage() async {
    final isar = await IsarDatabase.getInstance();
    final profile = await getOrCreateProfile();
    await isar.writeTxn(() async {
      profile.monthlyAnalysesUsed = 0;
      profile.monthlyAnalysesResetDate = DateTime.now();
      await isar.userProfiles.put(profile);
    });
  }

  Future<void> incrementAdsWatched() async {
    final isar = await IsarDatabase.getInstance();
    final profile = await getOrCreateProfile();
    await isar.writeTxn(() async {
      profile.totalAdsWatched += 1;
      await isar.userProfiles.put(profile);
    });
  }

  Future<UserProfile> refreshProfile() async {
    return getOrCreateProfile();
  }

  String _generateUserId() {
    final now = DateTime.now().microsecondsSinceEpoch;
    final random = (now * 1103515245 + 12345) % 2147483648;
    return 'user_${random.toRadixString(16)}_${now.toRadixString(16)}';
  }
}
