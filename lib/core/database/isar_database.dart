import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'models/app_setting.dart';
import 'models/decision_record.dart';
import 'models/user_profile.dart';

abstract final class IsarDatabase {
  IsarDatabase._();

  static Isar? _instance;

  static Future<Isar> getInstance() async {
    if (_instance != null) return _instance!;
    final dir = await getApplicationDocumentsDirectory();
    _instance = await Isar.open(
      [AppSettingSchema, DecisionRecordSchema, UserProfileSchema],
      directory: dir.path,
    );
    return _instance!;
  }

  static Future<void> close() async {
    await _instance?.close();
    _instance = null;
  }

  static Future<void> saveDecision(DecisionRecord record) async {
    final isar = await getInstance();
    await isar.writeTxn(() async {
      await isar.decisionRecords.put(record);
    });
  }
}
