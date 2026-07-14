enum SubscriptionTier {
  free,
  premium,
  pro;

  String get displayName {
    switch (this) {
      case SubscriptionTier.free:
        return 'Free';
      case SubscriptionTier.premium:
        return 'Premium';
      case SubscriptionTier.pro:
        return 'Pro';
    }
  }

  int get monthlyAnalysisLimit {
    switch (this) {
      case SubscriptionTier.free:
        return 10;
      case SubscriptionTier.premium:
        return 300;
      case SubscriptionTier.pro:
        return -1; // unlimited
    }
  }

  bool get hasPdfExport {
    switch (this) {
      case SubscriptionTier.free:
        return false;
      case SubscriptionTier.premium:
        return true;
      case SubscriptionTier.pro:
        return true;
    }
  }

  bool get hasAds {
    switch (this) {
      case SubscriptionTier.free:
        return true;
      case SubscriptionTier.premium:
        return false;
      case SubscriptionTier.pro:
        return false;
    }
  }

  bool get priorityAi {
    switch (this) {
      case SubscriptionTier.free:
        return false;
      case SubscriptionTier.premium:
        return false;
      case SubscriptionTier.pro:
        return true;
    }
  }

  bool get premiumModels {
    switch (this) {
      case SubscriptionTier.free:
        return false;
      case SubscriptionTier.premium:
        return false;
      case SubscriptionTier.pro:
        return true;
    }
  }

  bool get unlimitedPdf {
    switch (this) {
      case SubscriptionTier.free:
        return false;
      case SubscriptionTier.premium:
        return false;
      case SubscriptionTier.pro:
        return true;
    }
  }

  bool get isUnlimited => this == SubscriptionTier.pro;

  static SubscriptionTier fromString(String value) {
    return SubscriptionTier.values.firstWhere(
      (t) => t.name == value,
      orElse: () => SubscriptionTier.free,
    );
  }
}
