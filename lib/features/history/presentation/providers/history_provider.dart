import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../../../core/database/isar_provider.dart';
import '../../../../core/database/models/decision_record.dart';

class HistoryNotifier extends AsyncNotifier<List<DecisionRecord>> {
  String _searchQuery = '';
  String? _modelFilter;
  bool _sortAscending = false;

  String get searchQuery => _searchQuery;
  String? get modelFilter => _modelFilter;
  bool get sortAscending => _sortAscending;

  @override
  Future<List<DecisionRecord>> build() async {
    final isar = await ref.watch(isarProvider.future);
    final records = await isar.decisionRecords.where().findAll();
    return _processRecords(records);
  }

  List<DecisionRecord> _processRecords(List<DecisionRecord> records) {
    var result = records;

    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      result =
          result
              .where(
                (r) =>
                    (r.title?.toLowerCase().contains(query) ?? false) ||
                    r.description.toLowerCase().contains(query),
              )
              .toList();
    }

    if (_modelFilter != null) {
      result = result.where((r) => r.model == _modelFilter).toList();
    }

    if (_sortAscending) {
      result.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    } else {
      result.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    }

    return result;
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    ref.invalidateSelf();
  }

  void setModelFilter(String? model) {
    _modelFilter = model;
    ref.invalidateSelf();
  }

  void toggleSortOrder() {
    _sortAscending = !_sortAscending;
    ref.invalidateSelf();
  }

  Future<void> deleteRecord(Id id) async {
    final isar = await ref.watch(isarProvider.future);
    await isar.writeTxn(() async {
      await isar.decisionRecords.delete(id);
    });
    ref.invalidateSelf();
  }
}

final historyProvider =
    AsyncNotifierProvider<HistoryNotifier, List<DecisionRecord>>(
      () => HistoryNotifier(),
    );

final availableModelsProvider = FutureProvider<Set<String>>((ref) async {
  final isar = await ref.watch(isarProvider.future);
  final records = await isar.decisionRecords.where().findAll();
  return records.map((r) => r.model).toSet();
});
