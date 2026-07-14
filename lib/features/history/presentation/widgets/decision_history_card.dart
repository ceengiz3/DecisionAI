import 'package:flutter/material.dart';

import '../../../../core/database/models/decision_record.dart';

class DecisionHistoryCard extends StatelessWidget {
  final DecisionRecord record;
  final VoidCallback onTap;

  const DecisionHistoryCard({
    super.key,
    required this.record,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final confidenceColor =
        record.confidenceScore >= 0.8
            ? const Color(0xFF2E7D32)
            : record.confidenceScore >= 0.6
                ? const Color(0xFFE65100)
                : const Color(0xFFC62828);

    final month = record.createdAt.month.toString().padLeft(2, '0');
    final day = record.createdAt.day.toString().padLeft(2, '0');
    final year = record.createdAt.year.toString();
    final hour = record.createdAt.hour.toString().padLeft(2, '0');
    final minute = record.createdAt.minute.toString().padLeft(2, '0');

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      record.title ?? 'Untitled Decision',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: confidenceColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${(record.confidenceScore * 100).round()}%',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: confidenceColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              if (record.description.isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  record.description,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.auto_awesome_rounded,
                    size: 14,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    record.model,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Icon(
                    Icons.access_time_rounded,
                    size: 14,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '$month/$day/$year, $hour:$minute',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
