import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_constants.dart';
import '../network/dio_client.dart';
import '../network/network_info.dart';
import '../router/app_router.dart';
import '../services/analysis_service.dart';
import '../services/api_key_storage.dart';
import '../services/app_settings_service.dart';

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

final appSettingsServiceProvider = Provider<AppSettingsService>((ref) {
  return AppSettingsService();
});

final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(
  ThemeModeNotifier.new,
);

class ThemeModeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    _load();
    return ThemeMode.system;
  }

  Future<void> _load() async {
    final service = ref.read(appSettingsServiceProvider);
    state = await service.getThemeMode();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    await ref.read(appSettingsServiceProvider).setThemeMode(mode);
  }
}

final defaultModelProvider = NotifierProvider<DefaultModelNotifier, String>(
  DefaultModelNotifier.new,
);

class DefaultModelNotifier extends Notifier<String> {
  @override
  String build() {
    _load();
    return 'GPT-4o';
  }

  Future<void> _load() async {
    final service = ref.read(appSettingsServiceProvider);
    state = await service.getDefaultModel();
  }

  Future<void> setDefaultModel(String model) async {
    state = model;
    await ref.read(appSettingsServiceProvider).setDefaultModel(model);
  }
}
