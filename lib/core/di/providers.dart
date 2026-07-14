import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_constants.dart';
import '../network/dio_client.dart';
import '../network/network_info.dart';
import '../router/app_router.dart';
import '../services/analysis_service.dart';
import '../services/api_key_storage.dart';

final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient(baseUrl: AppConstants.baseUrl);
});

final dioProvider = Provider<Dio>((ref) {
  return ref.watch(dioClientProvider).dio;
});

final networkInfoProvider = Provider<NetworkInfo>((ref) {
  return NetworkInfoImpl();
});

final goRouterProvider = Provider<GoRouter>((ref) {
  return AppRouter.router;
});

final apiKeyStorageProvider = Provider<ApiKeyStorage>((ref) {
  return ApiKeyStorage();
});

final analysisServiceProvider = Provider<AnalysisService>((ref) {
  return AnalysisService();
});
