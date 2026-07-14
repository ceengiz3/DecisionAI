import 'package:flutter/material.dart';

class HistorySearchBar extends StatelessWidget {
  final String query;
  final ValueChanged<String> onChanged;

  const HistorySearchBar({
    super.key,
    required this.query,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return TextField(
      controller: TextEditingController.fromValue(
        TextEditingValue(text: query),
      ),
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Search decisions...',
        hintStyle: TextStyle(
          color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
        ),
        prefixIcon: Icon(
          Icons.search_rounded,
          color: colorScheme.onSurfaceVariant,
        ),
        suffixIcon:
            query.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear_rounded, size: 20),
                    onPressed: () => onChanged(''),
                  )
                : null,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
      ),
    );
  }
}
