// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types, experimental_member_use

extension GetScheduleModelCollection on Isar {
  IsarCollection<ScheduleModel> get scheduleModels => this.collection();
}

const ScheduleModelSchema = CollectionSchema(
  name: r'ScheduleModel',
  id: 453809397327065968,
  properties: {
    r'cancelledAt': PropertySchema(
      id: 0,
      name: r'cancelledAt',
      type: IsarType.dateTime,
    ),
    r'consumedAt': PropertySchema(
      id: 1,
      name: r'consumedAt',
      type: IsarType.dateTime,
    ),
    r'ruleId': PropertySchema(id: 2, name: r'ruleId', type: IsarType.long),
    r'status': PropertySchema(
      id: 3,
      name: r'status',
      type: IsarType.byte,
      enumMap: _ScheduleModelstatusEnumValueMap,
    ),
    r'triggerTime': PropertySchema(
      id: 4,
      name: r'triggerTime',
      type: IsarType.dateTime,
    ),
  },

  estimateSize: _scheduleModelEstimateSize,
  serialize: _scheduleModelSerialize,
  deserialize: _scheduleModelDeserialize,
  deserializeProp: _scheduleModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},

  getId: _scheduleModelGetId,
  getLinks: _scheduleModelGetLinks,
  attach: _scheduleModelAttach,
  version: '3.4.1',
);

int _scheduleModelEstimateSize(
  ScheduleModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _scheduleModelSerialize(
  ScheduleModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.cancelledAt);
  writer.writeDateTime(offsets[1], object.consumedAt);
  writer.writeLong(offsets[2], object.ruleId);
  writer.writeByte(offsets[3], object.status.index);
  writer.writeDateTime(offsets[4], object.triggerTime);
}

ScheduleModel _scheduleModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ScheduleModel(
    consumedAt: reader.readDateTimeOrNull(offsets[1]),
    ruleId: reader.readLong(offsets[2]),
    status:
        _ScheduleModelstatusValueEnumMap[reader.readByteOrNull(offsets[3])] ??
        ScheduleStatus.pending,
    triggerTime: reader.readDateTime(offsets[4]),
  );
  object.cancelledAt = reader.readDateTimeOrNull(offsets[0]);
  object.id = id;
  return object;
}

P _scheduleModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (_ScheduleModelstatusValueEnumMap[reader.readByteOrNull(offset)] ??
              ScheduleStatus.pending)
          as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _ScheduleModelstatusEnumValueMap = {
  'pending': 0,
  'consumed': 1,
  'cancelled': 2,
};
const _ScheduleModelstatusValueEnumMap = {
  0: ScheduleStatus.pending,
  1: ScheduleStatus.consumed,
  2: ScheduleStatus.cancelled,
};

Id _scheduleModelGetId(ScheduleModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _scheduleModelGetLinks(ScheduleModel object) {
  return [];
}

void _scheduleModelAttach(
  IsarCollection<dynamic> col,
  Id id,
  ScheduleModel object,
) {
  object.id = id;
}

extension ScheduleModelQueryWhereSort
    on QueryBuilder<ScheduleModel, ScheduleModel, QWhere> {
  QueryBuilder<ScheduleModel, ScheduleModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ScheduleModelQueryWhere
    on QueryBuilder<ScheduleModel, ScheduleModel, QWhereClause> {
  QueryBuilder<ScheduleModel, ScheduleModel, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterWhereClause> idNotEqualTo(
    Id id,
  ) {
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

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension ScheduleModelQueryFilter
    on QueryBuilder<ScheduleModel, ScheduleModel, QFilterCondition> {
  QueryBuilder<ScheduleModel, ScheduleModel, QAfterFilterCondition>
  cancelledAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'cancelledAt'),
      );
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterFilterCondition>
  cancelledAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'cancelledAt'),
      );
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterFilterCondition>
  cancelledAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'cancelledAt', value: value),
      );
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterFilterCondition>
  cancelledAtGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'cancelledAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterFilterCondition>
  cancelledAtLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'cancelledAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterFilterCondition>
  cancelledAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'cancelledAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterFilterCondition>
  consumedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'consumedAt'),
      );
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterFilterCondition>
  consumedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'consumedAt'),
      );
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterFilterCondition>
  consumedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'consumedAt', value: value),
      );
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterFilterCondition>
  consumedAtGreaterThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'consumedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterFilterCondition>
  consumedAtLessThan(DateTime? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'consumedAt',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterFilterCondition>
  consumedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'consumedAt',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterFilterCondition>
  idGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterFilterCondition>
  ruleIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'ruleId', value: value),
      );
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterFilterCondition>
  ruleIdGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'ruleId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterFilterCondition>
  ruleIdLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'ruleId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterFilterCondition>
  ruleIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'ruleId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterFilterCondition>
  statusEqualTo(ScheduleStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'status', value: value),
      );
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterFilterCondition>
  statusGreaterThan(ScheduleStatus value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'status',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterFilterCondition>
  statusLessThan(ScheduleStatus value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'status',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterFilterCondition>
  statusBetween(
    ScheduleStatus lower,
    ScheduleStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'status',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterFilterCondition>
  triggerTimeEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'triggerTime', value: value),
      );
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterFilterCondition>
  triggerTimeGreaterThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'triggerTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterFilterCondition>
  triggerTimeLessThan(DateTime value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'triggerTime',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterFilterCondition>
  triggerTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'triggerTime',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension ScheduleModelQueryObject
    on QueryBuilder<ScheduleModel, ScheduleModel, QFilterCondition> {}

extension ScheduleModelQueryLinks
    on QueryBuilder<ScheduleModel, ScheduleModel, QFilterCondition> {}

extension ScheduleModelQuerySortBy
    on QueryBuilder<ScheduleModel, ScheduleModel, QSortBy> {
  QueryBuilder<ScheduleModel, ScheduleModel, QAfterSortBy> sortByCancelledAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cancelledAt', Sort.asc);
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterSortBy>
  sortByCancelledAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cancelledAt', Sort.desc);
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterSortBy> sortByConsumedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consumedAt', Sort.asc);
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterSortBy>
  sortByConsumedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consumedAt', Sort.desc);
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterSortBy> sortByRuleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ruleId', Sort.asc);
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterSortBy> sortByRuleIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ruleId', Sort.desc);
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterSortBy> sortByTriggerTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'triggerTime', Sort.asc);
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterSortBy>
  sortByTriggerTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'triggerTime', Sort.desc);
    });
  }
}

extension ScheduleModelQuerySortThenBy
    on QueryBuilder<ScheduleModel, ScheduleModel, QSortThenBy> {
  QueryBuilder<ScheduleModel, ScheduleModel, QAfterSortBy> thenByCancelledAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cancelledAt', Sort.asc);
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterSortBy>
  thenByCancelledAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cancelledAt', Sort.desc);
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterSortBy> thenByConsumedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consumedAt', Sort.asc);
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterSortBy>
  thenByConsumedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'consumedAt', Sort.desc);
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterSortBy> thenByRuleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ruleId', Sort.asc);
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterSortBy> thenByRuleIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ruleId', Sort.desc);
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterSortBy> thenByTriggerTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'triggerTime', Sort.asc);
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QAfterSortBy>
  thenByTriggerTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'triggerTime', Sort.desc);
    });
  }
}

extension ScheduleModelQueryWhereDistinct
    on QueryBuilder<ScheduleModel, ScheduleModel, QDistinct> {
  QueryBuilder<ScheduleModel, ScheduleModel, QDistinct>
  distinctByCancelledAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cancelledAt');
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QDistinct> distinctByConsumedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'consumedAt');
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QDistinct> distinctByRuleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ruleId');
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QDistinct> distinctByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status');
    });
  }

  QueryBuilder<ScheduleModel, ScheduleModel, QDistinct>
  distinctByTriggerTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'triggerTime');
    });
  }
}

extension ScheduleModelQueryProperty
    on QueryBuilder<ScheduleModel, ScheduleModel, QQueryProperty> {
  QueryBuilder<ScheduleModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ScheduleModel, DateTime?, QQueryOperations>
  cancelledAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cancelledAt');
    });
  }

  QueryBuilder<ScheduleModel, DateTime?, QQueryOperations>
  consumedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'consumedAt');
    });
  }

  QueryBuilder<ScheduleModel, int, QQueryOperations> ruleIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ruleId');
    });
  }

  QueryBuilder<ScheduleModel, ScheduleStatus, QQueryOperations>
  statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<ScheduleModel, DateTime, QQueryOperations>
  triggerTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'triggerTime');
    });
  }
}
