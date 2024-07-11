// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPlanCollection on Isar {
  IsarCollection<Plan> get plans => this.collection();
}

const PlanSchema = CollectionSchema(
  name: r'Plan',
  id: 8143067535675439181,
  properties: {
    r'color': PropertySchema(
      id: 0,
      name: r'color',
      type: IsarType.long,
    ),
    r'hours': PropertySchema(
      id: 1,
      name: r'hours',
      type: IsarType.long,
    ),
    r'isDone': PropertySchema(
      id: 2,
      name: r'isDone',
      type: IsarType.bool,
    ),
    r'isGoal': PropertySchema(
      id: 3,
      name: r'isGoal',
      type: IsarType.bool,
    ),
    r'leftHours': PropertySchema(
      id: 4,
      name: r'leftHours',
      type: IsarType.long,
    ),
    r'leftMins': PropertySchema(
      id: 5,
      name: r'leftMins',
      type: IsarType.long,
    ),
    r'leftSecs': PropertySchema(
      id: 6,
      name: r'leftSecs',
      type: IsarType.long,
    ),
    r'mins': PropertySchema(
      id: 7,
      name: r'mins',
      type: IsarType.long,
    ),
    r'name': PropertySchema(
      id: 8,
      name: r'name',
      type: IsarType.string,
    ),
    r'progress': PropertySchema(
      id: 9,
      name: r'progress',
      type: IsarType.float,
    ),
    r'secs': PropertySchema(
      id: 10,
      name: r'secs',
      type: IsarType.long,
    )
  },
  estimateSize: _planEstimateSize,
  serialize: _planSerialize,
  deserialize: _planDeserialize,
  deserializeProp: _planDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _planGetId,
  getLinks: _planGetLinks,
  attach: _planAttach,
  version: '3.1.0+1',
);

int _planEstimateSize(
  Plan object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _planSerialize(
  Plan object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.color);
  writer.writeLong(offsets[1], object.hours);
  writer.writeBool(offsets[2], object.isDone);
  writer.writeBool(offsets[3], object.isGoal);
  writer.writeLong(offsets[4], object.leftHours);
  writer.writeLong(offsets[5], object.leftMins);
  writer.writeLong(offsets[6], object.leftSecs);
  writer.writeLong(offsets[7], object.mins);
  writer.writeString(offsets[8], object.name);
  writer.writeFloat(offsets[9], object.progress);
  writer.writeLong(offsets[10], object.secs);
}

Plan _planDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Plan();
  object.color = reader.readLong(offsets[0]);
  object.hours = reader.readLong(offsets[1]);
  object.id = id;
  object.isDone = reader.readBool(offsets[2]);
  object.isGoal = reader.readBool(offsets[3]);
  object.leftHours = reader.readLong(offsets[4]);
  object.leftMins = reader.readLong(offsets[5]);
  object.leftSecs = reader.readLong(offsets[6]);
  object.mins = reader.readLong(offsets[7]);
  object.name = reader.readString(offsets[8]);
  object.progress = reader.readFloat(offsets[9]);
  object.secs = reader.readLong(offsets[10]);
  return object;
}

P _planDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readFloat(offset)) as P;
    case 10:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _planGetId(Plan object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _planGetLinks(Plan object) {
  return [];
}

void _planAttach(IsarCollection<dynamic> col, Id id, Plan object) {
  object.id = id;
}

extension PlanQueryWhereSort on QueryBuilder<Plan, Plan, QWhere> {
  QueryBuilder<Plan, Plan, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PlanQueryWhere on QueryBuilder<Plan, Plan, QWhereClause> {
  QueryBuilder<Plan, Plan, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Plan, Plan, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Plan, Plan, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Plan, Plan, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Plan, Plan, QAfterWhereClause> idBetween(
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

extension PlanQueryFilter on QueryBuilder<Plan, Plan, QFilterCondition> {
  QueryBuilder<Plan, Plan, QAfterFilterCondition> colorEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'color',
        value: value,
      ));
    });
  }

  QueryBuilder<Plan, Plan, QAfterFilterCondition> colorGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'color',
        value: value,
      ));
    });
  }

  QueryBuilder<Plan, Plan, QAfterFilterCondition> colorLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'color',
        value: value,
      ));
    });
  }

  QueryBuilder<Plan, Plan, QAfterFilterCondition> colorBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'color',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Plan, Plan, QAfterFilterCondition> hoursEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hours',
        value: value,
      ));
    });
  }

  QueryBuilder<Plan, Plan, QAfterFilterCondition> hoursGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hours',
        value: value,
      ));
    });
  }

  QueryBuilder<Plan, Plan, QAfterFilterCondition> hoursLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hours',
        value: value,
      ));
    });
  }

  QueryBuilder<Plan, Plan, QAfterFilterCondition> hoursBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hours',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Plan, Plan, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Plan, Plan, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Plan, Plan, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Plan, Plan, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Plan, Plan, QAfterFilterCondition> isDoneEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDone',
        value: value,
      ));
    });
  }

  QueryBuilder<Plan, Plan, QAfterFilterCondition> isGoalEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isGoal',
        value: value,
      ));
    });
  }

  QueryBuilder<Plan, Plan, QAfterFilterCondition> leftHoursEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'leftHours',
        value: value,
      ));
    });
  }

  QueryBuilder<Plan, Plan, QAfterFilterCondition> leftHoursGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'leftHours',
        value: value,
      ));
    });
  }

  QueryBuilder<Plan, Plan, QAfterFilterCondition> leftHoursLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'leftHours',
        value: value,
      ));
    });
  }

  QueryBuilder<Plan, Plan, QAfterFilterCondition> leftHoursBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'leftHours',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Plan, Plan, QAfterFilterCondition> leftMinsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'leftMins',
        value: value,
      ));
    });
  }

  QueryBuilder<Plan, Plan, QAfterFilterCondition> leftMinsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'leftMins',
        value: value,
      ));
    });
  }

  QueryBuilder<Plan, Plan, QAfterFilterCondition> leftMinsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'leftMins',
        value: value,
      ));
    });
  }

  QueryBuilder<Plan, Plan, QAfterFilterCondition> leftMinsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'leftMins',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Plan, Plan, QAfterFilterCondition> leftSecsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'leftSecs',
        value: value,
      ));
    });
  }

  QueryBuilder<Plan, Plan, QAfterFilterCondition> leftSecsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'leftSecs',
        value: value,
      ));
    });
  }

  QueryBuilder<Plan, Plan, QAfterFilterCondition> leftSecsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'leftSecs',
        value: value,
      ));
    });
  }

  QueryBuilder<Plan, Plan, QAfterFilterCondition> leftSecsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'leftSecs',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Plan, Plan, QAfterFilterCondition> minsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mins',
        value: value,
      ));
    });
  }

  QueryBuilder<Plan, Plan, QAfterFilterCondition> minsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mins',
        value: value,
      ));
    });
  }

  QueryBuilder<Plan, Plan, QAfterFilterCondition> minsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mins',
        value: value,
      ));
    });
  }

  QueryBuilder<Plan, Plan, QAfterFilterCondition> minsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mins',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Plan, Plan, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plan, Plan, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plan, Plan, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plan, Plan, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plan, Plan, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plan, Plan, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plan, Plan, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plan, Plan, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Plan, Plan, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Plan, Plan, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Plan, Plan, QAfterFilterCondition> progressEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'progress',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Plan, Plan, QAfterFilterCondition> progressGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'progress',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Plan, Plan, QAfterFilterCondition> progressLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'progress',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Plan, Plan, QAfterFilterCondition> progressBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'progress',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Plan, Plan, QAfterFilterCondition> secsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'secs',
        value: value,
      ));
    });
  }

  QueryBuilder<Plan, Plan, QAfterFilterCondition> secsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'secs',
        value: value,
      ));
    });
  }

  QueryBuilder<Plan, Plan, QAfterFilterCondition> secsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'secs',
        value: value,
      ));
    });
  }

  QueryBuilder<Plan, Plan, QAfterFilterCondition> secsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'secs',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PlanQueryObject on QueryBuilder<Plan, Plan, QFilterCondition> {}

extension PlanQueryLinks on QueryBuilder<Plan, Plan, QFilterCondition> {}

extension PlanQuerySortBy on QueryBuilder<Plan, Plan, QSortBy> {
  QueryBuilder<Plan, Plan, QAfterSortBy> sortByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.asc);
    });
  }

  QueryBuilder<Plan, Plan, QAfterSortBy> sortByColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.desc);
    });
  }

  QueryBuilder<Plan, Plan, QAfterSortBy> sortByHours() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hours', Sort.asc);
    });
  }

  QueryBuilder<Plan, Plan, QAfterSortBy> sortByHoursDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hours', Sort.desc);
    });
  }

  QueryBuilder<Plan, Plan, QAfterSortBy> sortByIsDone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDone', Sort.asc);
    });
  }

  QueryBuilder<Plan, Plan, QAfterSortBy> sortByIsDoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDone', Sort.desc);
    });
  }

  QueryBuilder<Plan, Plan, QAfterSortBy> sortByIsGoal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGoal', Sort.asc);
    });
  }

  QueryBuilder<Plan, Plan, QAfterSortBy> sortByIsGoalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGoal', Sort.desc);
    });
  }

  QueryBuilder<Plan, Plan, QAfterSortBy> sortByLeftHours() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftHours', Sort.asc);
    });
  }

  QueryBuilder<Plan, Plan, QAfterSortBy> sortByLeftHoursDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftHours', Sort.desc);
    });
  }

  QueryBuilder<Plan, Plan, QAfterSortBy> sortByLeftMins() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftMins', Sort.asc);
    });
  }

  QueryBuilder<Plan, Plan, QAfterSortBy> sortByLeftMinsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftMins', Sort.desc);
    });
  }

  QueryBuilder<Plan, Plan, QAfterSortBy> sortByLeftSecs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftSecs', Sort.asc);
    });
  }

  QueryBuilder<Plan, Plan, QAfterSortBy> sortByLeftSecsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftSecs', Sort.desc);
    });
  }

  QueryBuilder<Plan, Plan, QAfterSortBy> sortByMins() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mins', Sort.asc);
    });
  }

  QueryBuilder<Plan, Plan, QAfterSortBy> sortByMinsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mins', Sort.desc);
    });
  }

  QueryBuilder<Plan, Plan, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Plan, Plan, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Plan, Plan, QAfterSortBy> sortByProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progress', Sort.asc);
    });
  }

  QueryBuilder<Plan, Plan, QAfterSortBy> sortByProgressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progress', Sort.desc);
    });
  }

  QueryBuilder<Plan, Plan, QAfterSortBy> sortBySecs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secs', Sort.asc);
    });
  }

  QueryBuilder<Plan, Plan, QAfterSortBy> sortBySecsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secs', Sort.desc);
    });
  }
}

extension PlanQuerySortThenBy on QueryBuilder<Plan, Plan, QSortThenBy> {
  QueryBuilder<Plan, Plan, QAfterSortBy> thenByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.asc);
    });
  }

  QueryBuilder<Plan, Plan, QAfterSortBy> thenByColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.desc);
    });
  }

  QueryBuilder<Plan, Plan, QAfterSortBy> thenByHours() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hours', Sort.asc);
    });
  }

  QueryBuilder<Plan, Plan, QAfterSortBy> thenByHoursDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hours', Sort.desc);
    });
  }

  QueryBuilder<Plan, Plan, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Plan, Plan, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Plan, Plan, QAfterSortBy> thenByIsDone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDone', Sort.asc);
    });
  }

  QueryBuilder<Plan, Plan, QAfterSortBy> thenByIsDoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDone', Sort.desc);
    });
  }

  QueryBuilder<Plan, Plan, QAfterSortBy> thenByIsGoal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGoal', Sort.asc);
    });
  }

  QueryBuilder<Plan, Plan, QAfterSortBy> thenByIsGoalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGoal', Sort.desc);
    });
  }

  QueryBuilder<Plan, Plan, QAfterSortBy> thenByLeftHours() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftHours', Sort.asc);
    });
  }

  QueryBuilder<Plan, Plan, QAfterSortBy> thenByLeftHoursDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftHours', Sort.desc);
    });
  }

  QueryBuilder<Plan, Plan, QAfterSortBy> thenByLeftMins() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftMins', Sort.asc);
    });
  }

  QueryBuilder<Plan, Plan, QAfterSortBy> thenByLeftMinsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftMins', Sort.desc);
    });
  }

  QueryBuilder<Plan, Plan, QAfterSortBy> thenByLeftSecs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftSecs', Sort.asc);
    });
  }

  QueryBuilder<Plan, Plan, QAfterSortBy> thenByLeftSecsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leftSecs', Sort.desc);
    });
  }

  QueryBuilder<Plan, Plan, QAfterSortBy> thenByMins() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mins', Sort.asc);
    });
  }

  QueryBuilder<Plan, Plan, QAfterSortBy> thenByMinsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mins', Sort.desc);
    });
  }

  QueryBuilder<Plan, Plan, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Plan, Plan, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Plan, Plan, QAfterSortBy> thenByProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progress', Sort.asc);
    });
  }

  QueryBuilder<Plan, Plan, QAfterSortBy> thenByProgressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'progress', Sort.desc);
    });
  }

  QueryBuilder<Plan, Plan, QAfterSortBy> thenBySecs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secs', Sort.asc);
    });
  }

  QueryBuilder<Plan, Plan, QAfterSortBy> thenBySecsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'secs', Sort.desc);
    });
  }
}

extension PlanQueryWhereDistinct on QueryBuilder<Plan, Plan, QDistinct> {
  QueryBuilder<Plan, Plan, QDistinct> distinctByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'color');
    });
  }

  QueryBuilder<Plan, Plan, QDistinct> distinctByHours() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hours');
    });
  }

  QueryBuilder<Plan, Plan, QDistinct> distinctByIsDone() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDone');
    });
  }

  QueryBuilder<Plan, Plan, QDistinct> distinctByIsGoal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isGoal');
    });
  }

  QueryBuilder<Plan, Plan, QDistinct> distinctByLeftHours() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'leftHours');
    });
  }

  QueryBuilder<Plan, Plan, QDistinct> distinctByLeftMins() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'leftMins');
    });
  }

  QueryBuilder<Plan, Plan, QDistinct> distinctByLeftSecs() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'leftSecs');
    });
  }

  QueryBuilder<Plan, Plan, QDistinct> distinctByMins() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mins');
    });
  }

  QueryBuilder<Plan, Plan, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Plan, Plan, QDistinct> distinctByProgress() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'progress');
    });
  }

  QueryBuilder<Plan, Plan, QDistinct> distinctBySecs() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'secs');
    });
  }
}

extension PlanQueryProperty on QueryBuilder<Plan, Plan, QQueryProperty> {
  QueryBuilder<Plan, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Plan, int, QQueryOperations> colorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'color');
    });
  }

  QueryBuilder<Plan, int, QQueryOperations> hoursProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hours');
    });
  }

  QueryBuilder<Plan, bool, QQueryOperations> isDoneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDone');
    });
  }

  QueryBuilder<Plan, bool, QQueryOperations> isGoalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isGoal');
    });
  }

  QueryBuilder<Plan, int, QQueryOperations> leftHoursProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'leftHours');
    });
  }

  QueryBuilder<Plan, int, QQueryOperations> leftMinsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'leftMins');
    });
  }

  QueryBuilder<Plan, int, QQueryOperations> leftSecsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'leftSecs');
    });
  }

  QueryBuilder<Plan, int, QQueryOperations> minsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mins');
    });
  }

  QueryBuilder<Plan, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Plan, double, QQueryOperations> progressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'progress');
    });
  }

  QueryBuilder<Plan, int, QQueryOperations> secsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'secs');
    });
  }
}
