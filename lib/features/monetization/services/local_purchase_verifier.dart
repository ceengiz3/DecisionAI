import '../domain/enums/subscription_tier.dart';
import 'purchase_verifier.dart';

class LocalPurchaseVerifier implements PurchaseVerifier {
  @override
  Future<VerificationResult> verifyPurchase({
    required String productId,
    required String receiptData,
    required String transactionId,
  }) async {
    final tier = SubscriptionTier.fromProductId(productId);

    if (tier == SubscriptionTier.free) {
    return const VerificationResult(
      isValid: false,
      verifiedTier: SubscriptionTier.free,
      errorMessage: 'Invalid product ID',
    );
    }

    return VerificationResult(
      isValid: true,
      verifiedTier: tier,
      expiryDate: DateTime.now().add(const Duration(days: 30)),
    );
  }

  @override
  Future<VerificationResult> verifySubscriptionStatus({
    required SubscriptionTier tier,
    required String receiptData,
  }) async {
    if (receiptData.isEmpty) {
      return const VerificationResult(
        isValid: false,
        verifiedTier: SubscriptionTier.free,
      );
    }

    return VerificationResult(
      isValid: true,
      verifiedTier: tier,
      expiryDate: DateTime.now().add(const Duration(days: 30)),
    );
  }
}
