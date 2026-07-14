import '../domain/enums/subscription_tier.dart';

abstract class PurchaseVerifier {
  Future<VerificationResult> verifyPurchase({
    required String productId,
    required String receiptData,
    required String transactionId,
  });

  Future<VerificationResult> verifySubscriptionStatus({
    required SubscriptionTier tier,
    required String receiptData,
  });
}

class VerificationResult {
  final bool isValid;
  final SubscriptionTier verifiedTier;
  final DateTime? expiryDate;
  final String? errorMessage;

  const VerificationResult({
    required this.isValid,
    required this.verifiedTier,
    this.expiryDate,
    this.errorMessage,
  });
}
