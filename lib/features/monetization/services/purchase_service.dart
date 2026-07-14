import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';

import '../domain/enums/subscription_tier.dart';
import 'purchase_verifier.dart';

class PurchaseService {
  final InAppPurchase _inAppPurchase;
  final PurchaseVerifier _verifier;

  StreamSubscription<List<PurchaseDetails>>? _subscription;

  final ValueNotifier<bool> isPurchasing = ValueNotifier(false);
  final ValueNotifier<PurchaseState> purchaseState =
      ValueNotifier(const PurchaseState());

  List<ProductDetails> _products = [];

  PurchaseService({
    required PurchaseVerifier verifier,
    InAppPurchase? inAppPurchase,
  }) : _inAppPurchase = inAppPurchase ?? InAppPurchase.instance,
       _verifier = verifier;

  PurchaseState get currentState => purchaseState.value;

  List<ProductDetails> get products => _products;

  Future<void> initialize() async {
    final available = await _inAppPurchase.isAvailable();
    if (!available) {
      purchaseState.value = purchaseState.value.copyWith(
        error: 'In-app purchases not available on this device',
      );
      return;
    }

    _subscription?.cancel();
    _subscription = _inAppPurchase.purchaseStream.listen(
      _onPurchaseUpdate,
      onError: (error) {
        purchaseState.value = purchaseState.value.copyWith(
          error: 'Purchase stream error: $error',
        );
      },
    );

    await _loadProducts();
  }

  Future<void> _loadProducts() async {
    final ids = <String>{
      SubscriptionTier.premium.productId,
      SubscriptionTier.pro.productId,
    };

    final response = await _inAppPurchase.queryProductDetails(ids);

    if (response.error != null) {
      purchaseState.value = purchaseState.value.copyWith(
        error: 'Failed to load products: ${response.error}',
      );
      return;
    }

    _products = response.productDetails;
  }

  Future<bool> purchaseSubscription(SubscriptionTier tier) async {
    if (tier == SubscriptionTier.free) return false;

    isPurchasing.value = true;
    purchaseState.value = purchaseState.value.copyWith(
      isPurchasing: true,
      clearError: true,
    );

    try {
      final product = _products.firstWhere(
        (p) => p.id == tier.productId,
        orElse: () => throw Exception('Product not found: ${tier.productId}'),
      );

      final purchaseParam = _buildPurchaseParam(product);
      final result = await _inAppPurchase.buyNonConsumable(
        purchaseParam: purchaseParam,
      );

      if (!result) {
        purchaseState.value = purchaseState.value.copyWith(
          error: 'Purchase was cancelled',
        );
        return false;
      }

      return true;
    } catch (e) {
      purchaseState.value = purchaseState.value.copyWith(
        error: 'Purchase failed: $e',
      );
      return false;
    } finally {
      isPurchasing.value = false;
      purchaseState.value = purchaseState.value.copyWith(
        isPurchasing: false,
      );
    }
  }

  PurchaseParam _buildPurchaseParam(ProductDetails product) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return GooglePlayPurchaseParam(
        productDetails: product,
        changeSubscriptionParam: null,
      );
    }

    return PurchaseParam(
      productDetails: product,
    );
  }

  Future<void> restorePurchases() async {
    purchaseState.value = purchaseState.value.copyWith(
      isPurchasing: true,
      clearError: true,
    );

    try {
      await _inAppPurchase.restorePurchases();
    } catch (e) {
      purchaseState.value = purchaseState.value.copyWith(
        error: 'Restore failed: $e',
      );
    } finally {
      purchaseState.value = purchaseState.value.copyWith(
        isPurchasing: false,
      );
    }
  }

  void _onPurchaseUpdate(List<PurchaseDetails> purchaseDetailsList) {
    for (final purchase in purchaseDetailsList) {
      _processPurchase(purchase);
    }
  }

  Future<void> _processPurchase(PurchaseDetails purchase) async {
    if (purchase.status == PurchaseStatus.purchased ||
        purchase.status == PurchaseStatus.restored) {
      final verification = await _verifyPurchase(purchase);

      if (verification.isValid) {
        purchaseState.value = purchaseState.value.copyWith(
          hasActiveSubscription: true,
          activeTier: verification.verifiedTier,
          expiryDate: verification.expiryDate,
        );

        if (_onPurchaseVerified != null) {
          _onPurchaseVerified!(verification);
        }
      }

      await _inAppPurchase.completePurchase(purchase);
    } else if (purchase.status == PurchaseStatus.error) {
      purchaseState.value = purchaseState.value.copyWith(
        error: purchase.error?.message ?? 'Purchase failed',
      );
    }
  }

  Future<VerificationResult> _verifyPurchase(
    PurchaseDetails purchase,
  ) async {
    final productId = purchase.productID;
    final receiptData = _getReceiptData(purchase);
    final transactionId = purchase.purchaseID ?? '';

    return _verifier.verifyPurchase(
      productId: productId,
      receiptData: receiptData,
      transactionId: transactionId,
    );
  }

  String _getReceiptData(PurchaseDetails purchase) {
    if (purchase is GooglePlayPurchaseDetails) {
      return purchase.verificationData.localVerificationData;
    }

    return purchase.verificationData.localVerificationData;
  }

  void Function(VerificationResult)? _onPurchaseVerified;

  void setOnPurchaseVerified(void Function(VerificationResult) callback) {
    _onPurchaseVerified = callback;
  }

  void dispose() {
    _subscription?.cancel();
    isPurchasing.dispose();
    purchaseState.dispose();
  }
}

class PurchaseState {
  final bool isPurchasing;
  final bool hasActiveSubscription;
  final SubscriptionTier activeTier;
  final DateTime? expiryDate;
  final String? error;

  const PurchaseState({
    this.isPurchasing = false,
    this.hasActiveSubscription = false,
    this.activeTier = SubscriptionTier.free,
    this.expiryDate,
    this.error,
  });

  PurchaseState copyWith({
    bool? isPurchasing,
    bool? hasActiveSubscription,
    SubscriptionTier? activeTier,
    DateTime? expiryDate,
    String? error,
    bool clearError = false,
  }) {
    return PurchaseState(
      isPurchasing: isPurchasing ?? this.isPurchasing,
      hasActiveSubscription: hasActiveSubscription ?? this.hasActiveSubscription,
      activeTier: activeTier ?? this.activeTier,
      expiryDate: expiryDate ?? this.expiryDate,
      error: clearError ? null : (error ?? this.error),
    );
  }
}
