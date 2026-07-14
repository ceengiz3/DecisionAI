import 'dart:convert';
import 'package:isar/isar.dart';

part 'decision_record.g.dart';

@collection
class DecisionRecord {
  Id id = Isar.autoIncrement;
  String? title;
  late String description;
  late String model;
  double confidenceScore = 0;
  late String recommendation;
  late String prosJson;
  late String consJson;
  late String summary;
  DateTime createdAt = DateTime.now();
  String risksJson = '[]';
  String? bestChoice;
  String? reasoning;

  List<String> get pros =>
      prosJson.isEmpty ? [] : List<String>.from(jsonDecode(prosJson));

  List<String> get cons =>
      consJson.isEmpty ? [] : List<String>.from(jsonDecode(consJson));

  List<String> get risks =>
      risksJson.isEmpty ? [] : List<String>.from(jsonDecode(risksJson));
}
