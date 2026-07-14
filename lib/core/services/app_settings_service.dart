import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import '../database/isar_database.dart';
import '../database/models/app_setting.dart';

class AppSettingsService {
  Future<Isar?> _getIsar() async {
    try {
      return await IsarDatabase.getInstance();
    } catch (_) {
      return null;
    }
  }

  Future<String?> getSetting(String key) async {
    try {
      final isar = await _getIsar();
      if (isar == null) return null;
      final setting =
          await isar.appSettings.filter().keyEqualTo(key).findFirst();
      return setting?.value;
    } catch (_) {
      return null;
    }
  }

  Future<void> setSetting(String key, String value) async {
    try {
      final isar = await _getIsar();
      if (isar == null) return;
      await isar.writeTxn(() async {
        final existing =
            await isar.appSettings.filter().keyEqualTo(key).findFirst();
        if (existing != null) {
          existing.value = value;
          await isar.appSettings.put(existing);
        } else {
          final setting = AppSetting()..key = key..value = value;
          await isar.appSettings.put(setting);
        }
      });
    } catch (_) {}
  }

  Future<ThemeMode> getThemeMode() async {
    final value = await getSetting('theme_mode');
    if (value == null) return ThemeMode.system;
    return ThemeMode.values.where((m) => m.name == value).firstOrNull ??
        ThemeMode.system;
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await setSetting('theme_mode', mode.name);
  }

  Future<String> getDefaultModel() async {
    final value = await getSetting('default_model');
    return value ?? 'GPT-4o';
  }

  Future<void> setDefaultModel(String model) async {
    await setSetting('default_model', model);
  }
}
