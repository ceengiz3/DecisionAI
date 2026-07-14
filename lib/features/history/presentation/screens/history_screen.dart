import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/database/models/decision_record.dart';
import '../../../../core/router/routes.dart';
import '../../../../l10n/l10n.dart';
import '../providers/history_provider.dart';
import '../widgets/decision_history_card.dart';
import '../widgets/empty_history_state.dart';
import '../widgets/history_filter_sort.dart';
import '../widgets/history_search_bar.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(historyProvider);
    final modelsAsync = ref.watch(availableModelsProvider);
    final notifier = ref.read(historyProvider.notifier);
    final l = context.l10n;

    return Scaffold(
      appBar: AppBar(title: Text(l.historyTitle)),
      body: historyAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (records) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: HistorySearchBar(
                query: notifier.searchQuery,
                onChanged: notifier.setSearchQuery,
              ),
            ),
            modelsAsync.when(
              data: (models) {
                if (models.isEmpty) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(left: 16, right: 8, bottom: 8),
                  child: HistoryFilterSort(
                    availableModels: models,
                    selectedModel: notifier.modelFilter,
                    sortAscending: notifier.sortAscending,
                    onModelChanged: notifier.setModelFilter,
                    onSortToggle: notifier.toggleSortOrder,
                  ),
                );
              },
              loading: () => const SizedBox.shrink(),
              error: (_, _) => const SizedBox.shrink(),
            ),
            Expanded(
              child: records.isEmpty
                  ? const EmptyHistoryState()
                  : _buildList(context, ref, records),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(
      BuildContext context, WidgetRef ref, List<DecisionRecord> records) {
    final colorScheme = Theme.of(context).colorScheme;
    final l = context.l10n;

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: records.length,
      itemBuilder: (context, index) {
        final record = records[index];
        return Dismissible(
          key: ValueKey(record.id),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 24),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: colorScheme.error,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(Icons.delete_rounded, color: colorScheme.onError),
          ),
          confirmDismiss: (direction) async {
            return await showDialog<bool>(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text(l.historyDeleteTitle),
                content: Text(l.historyDeleteMessage),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(false),
                    child: Text(l.historyCancel),
                  ),
                  FilledButton(
                    onPressed: () => Navigator.of(ctx).pop(true),
                    child: Text(l.historyDelete),
                  ),
                ],
              ),
            );
          },
          onDismissed: (_) {
            ref.read(historyProvider.notifier).deleteRecord(record.id);
          },
          child: DecisionHistoryCard(
            record: record,
            onTap: () => context.go(
              AppRoutes.analysisResult,
              extra: {'record': record},
            ),
          ),
        );
      },
    );
  }
}
