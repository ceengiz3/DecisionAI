import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

Future<bool> saveBytesToFile(Uint8List bytes, String fileName) async {
  try {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$fileName');
    await file.writeAsBytes(bytes);
    return true;
  } catch (_) {
    return false;
  }
}
