class UserCredits {
  final String userId;
  final int credits;
  final int monthlyAnalysesUsed;
  final int monthlyAnalysesLimit;
  final bool isUnlimited;

  const UserCredits({
    required this.userId,
    required this.credits,
    required this.monthlyAnalysesUsed,
    required this.monthlyAnalysesLimit,
    required this.isUnlimited,
  });

  int get remainingMonthlyAnalyses {
    if (isUnlimited) return -1;
    return monthlyAnalysesLimit - monthlyAnalysesUsed;
  }

  bool get canAnalyze {
    if (isUnlimited) return true;
    return credits > 0 && remainingMonthlyAnalyses > 0;
  }

  bool get canExportPdf => !isUnlimited;

  bool get hasAds => !isUnlimited;
}
