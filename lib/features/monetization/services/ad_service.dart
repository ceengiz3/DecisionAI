import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../data/repositories/credits_repository.dart';

class AdService {
  final CreditsRepository _creditsRepository;

  RewardedAd? _rewardedAd;
  bool _isLoading = false;
  bool _isShowing = false;

  final ValueNotifier<bool> isAdAvailable = ValueNotifier(false);
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<String?> errorMessage = ValueNotifier(null);

  AdService(this._creditsRepository);

  Future<void> initialize() async {
    try {
      await MobileAds.instance.initialize();
      await _loadAd();
    } catch (e) {
      errorMessage.value = 'AdMob initialization failed: $e';
    }
  }

  Future<void> _loadAd() async {
    if (_isLoading) return;

    _isLoading = true;
    isLoading.value = true;

    try {
      await _rewardedAd?.dispose();
      _rewardedAd = null;

      await RewardedAd.load(
        adUnitId: _adUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) {
            _rewardedAd = ad;
            _isLoading = false;
            isLoading.value = false;
            isAdAvailable.value = true;
            errorMessage.value = null;

            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) {
                _isShowing = false;
                _loadAd();
              },
              onAdFailedToShowFullScreenContent: (ad, error) {
                _isShowing = false;
                errorMessage.value = 'Ad failed to show: ${error.message}';
                _loadAd();
              },
              onAdShowedFullScreenContent: (ad) {
                _isShowing = true;
              },
            );
          },
          onAdFailedToLoad: (error) {
            _rewardedAd = null;
            _isLoading = false;
            isLoading.value = false;
            isAdAvailable.value = false;
            errorMessage.value = 'Ad failed to load: ${error.message}';
            Future.delayed(const Duration(seconds: 30), _loadAd);
          },
        ),
      );
    } catch (e) {
      _isLoading = false;
      isLoading.value = false;
      errorMessage.value = 'Ad loading error: $e';
    }
  }

  Future<bool> showRewardedAd() async {
    if (_rewardedAd == null || _isShowing) {
      await _loadAd();
      return false;
    }

    _rewardedAd!.show(
      onUserEarnedReward: (ad, reward) async {
        await _creditsRepository.addCredits(5);
      },
    );

    return true;
  }

  void dispose() {
    _rewardedAd?.dispose();
    _rewardedAd = null;
    isAdAvailable.dispose();
    isLoading.dispose();
    errorMessage.dispose();
  }
}

String get _adUnitId {
  if (defaultTargetPlatform == TargetPlatform.android) {
    return 'ca-app-pub-3940256099942544/5224354917';
  }
  if (defaultTargetPlatform == TargetPlatform.iOS) {
    return 'ca-app-pub-3940256099942544/1712485313';
  }
  return 'unused';
}
