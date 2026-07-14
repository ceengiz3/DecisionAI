import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../../../core/database/isar_provider.dart';
import '../../../../core/database/models/decision_record.dart';

final recentDecisionsProvider = FutureProvider<List<DecisionRecord>>((ref) async {
  final isar = await ref.watch(isarProvider.future);
  return isar.decisionRecords.where()
    .sortByCreatedAtDesc()
    .limit(5)
    .findAll();
});
