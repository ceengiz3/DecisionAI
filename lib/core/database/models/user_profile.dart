import 'package:isar/isar.dart';

part 'user_profile.g.dart';

@collection
class UserProfile {
  Id id = Isar.autoIncrement;

  late String userId;

  int credits = 10;

  late String subscriptionTier;

  DateTime? subscriptionExpiry;

  int totalAdsWatched = 0;

  DateTime createdAt = DateTime.now();

  int monthlyAnalysesUsed = 0;

  DateTime monthlyAnalysesResetDate = DateTime.now();
}
