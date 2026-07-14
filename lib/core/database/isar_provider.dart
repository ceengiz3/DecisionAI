import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import 'isar_database.dart';

final isarProvider = FutureProvider<Isar>((ref) async {
  final isar = await IsarDatabase.getInstance();
  ref.onDispose(() => IsarDatabase.close());
  return isar;
});
