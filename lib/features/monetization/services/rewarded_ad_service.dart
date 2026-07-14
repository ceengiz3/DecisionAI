import '../data/repositories/credits_repository.dart';

abstract class RewardedAdService {
  Future<bool> showRewardedAd();
  bool get isAdAvailable;
}

class RewardedAdServiceImpl implements RewardedAdService {
  final CreditsRepository _creditsRepository;

  RewardedAdServiceImpl(this._creditsRepository);

  @override
  bool get isAdAvailable => true;

  @override
  Future<bool> showRewardedAd() async {
    // Architecture only: real AdMob integration will replace this
    // In production, this would show a rewarded ad via google_mobile_ads
    // and award credits on completion
    await Future.delayed(const Duration(milliseconds: 500));
    await _creditsRepository.addCredits(5);
    return true;
  }
}
