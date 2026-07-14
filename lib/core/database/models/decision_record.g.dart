// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'decision_record.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDecisionRecordCollection on Isar {
  IsarCollection<DecisionRecord> get decisionRecords => this.collection();
}

final DecisionRecordSchema = CollectionSchema(
  name: r'DecisionRecord',
  id: int.parse('3623363144586890648'),
  properties: {
    r'confidenceScore': PropertySchema(
      id: 0,
      name: r'confidenceScore',
      type: IsarType.double,
    ),
    r'cons': PropertySchema(
      id: 1,
      name: r'cons',
      type: IsarType.stringList,
    ),
    r'consJson': PropertySchema(
      id: 2,
      name: r'consJson',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 3,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'description': PropertySchema(
      id: 4,
      name: r'description',
      type: IsarType.string,
    ),
    r'model': PropertySchema(
      id: 5,
      name: r'model',
      type: IsarType.string,
    ),
    r'pros': PropertySchema(
      id: 6,
      name: r'pros',
      type: IsarType.stringList,
    ),
    r'prosJson': PropertySchema(
      id: 7,
      name: r'prosJson',
      type: IsarType.string,
    ),
    r'recommendation': PropertySchema(
      id: 8,
      name: r'recommendation',
      type: IsarType.string,
    ),
    r'summary': PropertySchema(
      id: 9,
      name: r'summary',
      type: IsarType.string,
    ),
    r'title': PropertySchema(
      id: 10,
      name: r'title',
      type: IsarType.string,
    )
  },
  estimateSize: _decisionRecordEstimateSize,
  serialize: _decisionRecordSerialize,
  deserialize: _decisionRecordDeserialize,
  deserializeProp: _decisionRecordDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _decisionRecordGetId,
  getLinks: _decisionRecordGetLinks,
  attach: _decisionRecordAttach,
  version: '3.1.0+1',
);

int _decisionRecordEstimateSize(
  DecisionRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.cons.length * 3;
  {
    for (var i = 0; i < object.cons.length; i++) {
      final value = object.cons[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.consJson.length * 3;
  bytesCount += 3 + object.description.length * 3;
  bytesCount += 3 + object.model.length * 3;
  bytesCount += 3 + object.pros.length * 3;
  {
    for (var i = 0; i < object.pros.length; i++) {
      final value = object.pros[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.prosJson.length * 3;
  bytesCount += 3 + object.recommendation.length * 3;
  bytesCount += 3 + object.summary.length * 3;
  {
    final value = object.title;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _decisionRecordSerialize(
  DecisionRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.confidenceScore);
  writer.writeStringList(offsets[1], object.cons);
  writer.writeString(offsets[2], object.consJson);
  writer.writeDateTime(offsets[3], object.createdAt);
  writer.writeString(offsets[4], object.description);
  writer.writeString(offsets[5], object.model);
  writer.writeStringList(offsets[6], object.pros);
  writer.writeString(offsets[7], object.prosJson);
  writer.writeString(offsets[8], object.recommendation);
  writer.writeString(offsets[9], object.summary);
  writer.writeString(offsets[10], object.title);
}

DecisionRecord _decisionRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DecisionRecord();
  object.confidenceScore = reader.readDouble(offsets[0]);
  object.consJson = reader.readString(offsets[2]);
  object.createdAt = reader.readDateTime(offsets[3]);
  object.description = reader.readString(offsets[4]);
  object.id = id;
  object.model = reader.readString(offsets[5]);
  object.prosJson = reader.readString(offsets[7]);
  object.recommendation = reader.readString(offsets[8]);
  object.summary = reader.readString(offsets[9]);
  object.title = reader.readStringOrNull(offsets[10]);
  return object;
}

P _decisionRecordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readStringList(offset) ?? []) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readStringList(offset) ?? []) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _decisionRecordGetId(DecisionRecord object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _decisionRecordGetLinks(DecisionRecord object) {
  return [];
}

void _decisionRecordAttach(
    IsarCollection<dynamic> col, Id id, DecisionRecord object) {
  object.id = id;
}

extension DecisionRecordQueryWhereSort
    on QueryBuilder<DecisionRecord, DecisionRecord, QWhere> {
  QueryBuilder<DecisionRecord, DecisionRecord, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DecisionRecordQueryWhere
    on QueryBuilder<DecisionRecord, DecisionRecord, QWhereClause> {
  QueryBuilder<DecisionRecord, DecisionRecord, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension DecisionRecordQueryFilter
    on QueryBuilder<DecisionRecord, DecisionRecord, QFilterCondition> {
  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      confidenceScoreEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'confidenceScore',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      confidenceScoreGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'confidenceScore',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      confidenceScoreLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'confidenceScore',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      confidenceScoreBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'confidenceScore',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      consElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cons',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      consElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cons',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      consElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cons',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      consElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cons',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      consElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cons',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      consElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cons',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      consElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cons',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      consElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cons',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      consElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cons',
        value: '',
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      consElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cons',
        value: '',
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      consLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cons',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      consIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cons',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      consIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cons',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      consLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cons',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      consLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cons',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      consLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cons',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      consJsonEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'consJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      consJsonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'consJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      consJsonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'consJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      consJsonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'consJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      consJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'consJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      consJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'consJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      consJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'consJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      consJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'consJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      consJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'consJson',
        value: '',
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      consJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'consJson',
        value: '',
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      descriptionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      descriptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      descriptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      descriptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      descriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      descriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      modelEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'model',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      modelGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'model',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      modelLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'model',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      modelBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'model',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      modelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'model',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      modelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'model',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      modelContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'model',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      modelMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'model',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      modelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'model',
        value: '',
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      modelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'model',
        value: '',
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      prosElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pros',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      prosElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pros',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      prosElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pros',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      prosElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pros',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      prosElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'pros',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      prosElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'pros',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      prosElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'pros',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      prosElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'pros',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      prosElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pros',
        value: '',
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      prosElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'pros',
        value: '',
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      prosLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pros',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      prosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pros',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      prosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pros',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      prosLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pros',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      prosLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pros',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      prosLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pros',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      prosJsonEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'prosJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      prosJsonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'prosJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      prosJsonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'prosJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      prosJsonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'prosJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      prosJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'prosJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      prosJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'prosJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      prosJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'prosJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      prosJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'prosJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      prosJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'prosJson',
        value: '',
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      prosJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'prosJson',
        value: '',
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      recommendationEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recommendation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      recommendationGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'recommendation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      recommendationLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'recommendation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      recommendationBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'recommendation',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      recommendationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'recommendation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      recommendationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'recommendation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      recommendationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'recommendation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      recommendationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'recommendation',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      recommendationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recommendation',
        value: '',
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      recommendationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'recommendation',
        value: '',
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      summaryEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'summary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      summaryGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'summary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      summaryLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'summary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      summaryBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'summary',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      summaryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'summary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      summaryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'summary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      summaryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'summary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      summaryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'summary',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      summaryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'summary',
        value: '',
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      summaryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'summary',
        value: '',
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      titleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      titleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'title',
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      titleEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      titleGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      titleLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      titleBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }
}

extension DecisionRecordQueryObject
    on QueryBuilder<DecisionRecord, DecisionRecord, QFilterCondition> {}

extension DecisionRecordQueryLinks
    on QueryBuilder<DecisionRecord, DecisionRecord, QFilterCondition> {}

extension DecisionRecordQuerySortBy
    on QueryBuilder<DecisionRecord, DecisionRecord, QSortBy> {
  QueryBuilder<DecisionRecord, DecisionRecord, QAfterSortBy>
      sortByConfidenceScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confidenceScore', Sort.asc);
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterSortBy>
      sortByConfidenceScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confidenceScore', Sort.desc);
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterSortBy> sortByConsJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consJson', Sort.asc);
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterSortBy>
      sortByConsJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consJson', Sort.desc);
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterSortBy>
      sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterSortBy>
      sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterSortBy> sortByModel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'model', Sort.asc);
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterSortBy> sortByModelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'model', Sort.desc);
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterSortBy> sortByProsJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prosJson', Sort.asc);
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterSortBy>
      sortByProsJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prosJson', Sort.desc);
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterSortBy>
      sortByRecommendation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recommendation', Sort.asc);
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterSortBy>
      sortByRecommendationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recommendation', Sort.desc);
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterSortBy> sortBySummary() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'summary', Sort.asc);
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterSortBy>
      sortBySummaryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'summary', Sort.desc);
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension DecisionRecordQuerySortThenBy
    on QueryBuilder<DecisionRecord, DecisionRecord, QSortThenBy> {
  QueryBuilder<DecisionRecord, DecisionRecord, QAfterSortBy>
      thenByConfidenceScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confidenceScore', Sort.asc);
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterSortBy>
      thenByConfidenceScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confidenceScore', Sort.desc);
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterSortBy> thenByConsJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consJson', Sort.asc);
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterSortBy>
      thenByConsJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consJson', Sort.desc);
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterSortBy>
      thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterSortBy>
      thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterSortBy> thenByModel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'model', Sort.asc);
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterSortBy> thenByModelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'model', Sort.desc);
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterSortBy> thenByProsJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prosJson', Sort.asc);
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterSortBy>
      thenByProsJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prosJson', Sort.desc);
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterSortBy>
      thenByRecommendation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recommendation', Sort.asc);
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterSortBy>
      thenByRecommendationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recommendation', Sort.desc);
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterSortBy> thenBySummary() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'summary', Sort.asc);
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterSortBy>
      thenBySummaryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'summary', Sort.desc);
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension DecisionRecordQueryWhereDistinct
    on QueryBuilder<DecisionRecord, DecisionRecord, QDistinct> {
  QueryBuilder<DecisionRecord, DecisionRecord, QDistinct>
      distinctByConfidenceScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'confidenceScore');
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QDistinct> distinctByCons() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cons');
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QDistinct> distinctByConsJson(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'consJson', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QDistinct> distinctByModel(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'model', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QDistinct> distinctByPros() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pros');
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QDistinct> distinctByProsJson(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'prosJson', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QDistinct>
      distinctByRecommendation({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recommendation',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QDistinct> distinctBySummary(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'summary', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DecisionRecord, DecisionRecord, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }
}

extension DecisionRecordQueryProperty
    on QueryBuilder<DecisionRecord, DecisionRecord, QQueryProperty> {
  QueryBuilder<DecisionRecord, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DecisionRecord, double, QQueryOperations>
      confidenceScoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'confidenceScore');
    });
  }

  QueryBuilder<DecisionRecord, List<String>, QQueryOperations> consProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cons');
    });
  }

  QueryBuilder<DecisionRecord, String, QQueryOperations> consJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'consJson');
    });
  }

  QueryBuilder<DecisionRecord, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<DecisionRecord, String, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<DecisionRecord, String, QQueryOperations> modelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'model');
    });
  }

  QueryBuilder<DecisionRecord, List<String>, QQueryOperations> prosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pros');
    });
  }

  QueryBuilder<DecisionRecord, String, QQueryOperations> prosJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'prosJson');
    });
  }

  QueryBuilder<DecisionRecord, String, QQueryOperations>
      recommendationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recommendation');
    });
  }

  QueryBuilder<DecisionRecord, String, QQueryOperations> summaryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'summary');
    });
  }

  QueryBuilder<DecisionRecord, String?, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }
}
