// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_rule_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetNotificationRuleModelCollection on Isar {
  IsarCollection<NotificationRuleModel> get notificationRuleModels =>
      this.collection();
}

const NotificationRuleModelSchema = CollectionSchema(
  name: r'NotificationRuleModel',
  id: 830454104416838453,
  properties: {
    r'bypassDnd': PropertySchema(
      id: 0,
      name: r'bypassDnd',
      type: IsarType.bool,
    ),
    r'colorTag': PropertySchema(
      id: 1,
      name: r'colorTag',
      type: IsarType.string,
      enumMap: _NotificationRuleModelcolorTagEnumValueMap,
    ),
    r'content': PropertySchema(
      id: 2,
      name: r'content',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 3,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'durationCount': PropertySchema(
      id: 4,
      name: r'durationCount',
      type: IsarType.long,
    ),
    r'durationUnit': PropertySchema(
      id: 5,
      name: r'durationUnit',
      type: IsarType.string,
      enumMap: _NotificationRuleModeldurationUnitEnumValueMap,
    ),
    r'endDate': PropertySchema(
      id: 6,
      name: r'endDate',
      type: IsarType.dateTime,
    ),
    r'fixedTimesMinutes': PropertySchema(
      id: 7,
      name: r'fixedTimesMinutes',
      type: IsarType.longList,
    ),
    r'intervalEvery': PropertySchema(
      id: 8,
      name: r'intervalEvery',
      type: IsarType.long,
    ),
    r'intervalUnit': PropertySchema(
      id: 9,
      name: r'intervalUnit',
      type: IsarType.string,
      enumMap: _NotificationRuleModelintervalUnitEnumValueMap,
    ),
    r'intervalWindowEndMinutes': PropertySchema(
      id: 10,
      name: r'intervalWindowEndMinutes',
      type: IsarType.long,
    ),
    r'intervalWindowStartMinutes': PropertySchema(
      id: 11,
      name: r'intervalWindowStartMinutes',
      type: IsarType.long,
    ),
    r'isForever': PropertySchema(
      id: 12,
      name: r'isForever',
      type: IsarType.bool,
    ),
    r'lastTriggeredAt': PropertySchema(
      id: 13,
      name: r'lastTriggeredAt',
      type: IsarType.dateTime,
    ),
    r'nextTriggerAt': PropertySchema(
      id: 14,
      name: r'nextTriggerAt',
      type: IsarType.dateTime,
    ),
    r'randomCount': PropertySchema(
      id: 15,
      name: r'randomCount',
      type: IsarType.long,
    ),
    r'randomWindowEndMinutes': PropertySchema(
      id: 16,
      name: r'randomWindowEndMinutes',
      type: IsarType.long,
    ),
    r'randomWindowStartMinutes': PropertySchema(
      id: 17,
      name: r'randomWindowStartMinutes',
      type: IsarType.long,
    ),
    r'recurrenceType': PropertySchema(
      id: 18,
      name: r'recurrenceType',
      type: IsarType.string,
      enumMap: _NotificationRuleModelrecurrenceTypeEnumValueMap,
    ),
    r'repetitionType': PropertySchema(
      id: 19,
      name: r'repetitionType',
      type: IsarType.string,
      enumMap: _NotificationRuleModelrepetitionTypeEnumValueMap,
    ),
    r'scheduleEvery': PropertySchema(
      id: 20,
      name: r'scheduleEvery',
      type: IsarType.long,
    ),
    r'scheduleUnit': PropertySchema(
      id: 21,
      name: r'scheduleUnit',
      type: IsarType.string,
      enumMap: _NotificationRuleModelscheduleUnitEnumValueMap,
    ),
    r'selectedDaysOfWeek': PropertySchema(
      id: 22,
      name: r'selectedDaysOfWeek',
      type: IsarType.longList,
    ),
    r'selectedMonthDays': PropertySchema(
      id: 23,
      name: r'selectedMonthDays',
      type: IsarType.objectList,
      target: r'MonthDaysRepetition',
    ),
    r'startDate': PropertySchema(
      id: 24,
      name: r'startDate',
      type: IsarType.dateTime,
    ),
    r'title': PropertySchema(
      id: 25,
      name: r'title',
      type: IsarType.string,
    ),
    r'totalOccurrences': PropertySchema(
      id: 26,
      name: r'totalOccurrences',
      type: IsarType.long,
    )
  },
  estimateSize: _notificationRuleModelEstimateSize,
  serialize: _notificationRuleModelSerialize,
  deserialize: _notificationRuleModelDeserialize,
  deserializeProp: _notificationRuleModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {r'MonthDaysRepetition': MonthDaysRepetitionSchema},
  getId: _notificationRuleModelGetId,
  getLinks: _notificationRuleModelGetLinks,
  attach: _notificationRuleModelAttach,
  version: '3.1.0+1',
);

int _notificationRuleModelEstimateSize(
  NotificationRuleModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.colorTag;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  {
    final value = object.content;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.durationUnit;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  {
    final value = object.fixedTimesMinutes;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  {
    final value = object.intervalUnit;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  bytesCount += 3 + object.recurrenceType.name.length * 3;
  bytesCount += 3 + object.repetitionType.name.length * 3;
  {
    final value = object.scheduleUnit;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  {
    final value = object.selectedDaysOfWeek;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  {
    final list = object.selectedMonthDays;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[MonthDaysRepetition]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += MonthDaysRepetitionSchema.estimateSize(
              value, offsets, allOffsets);
        }
      }
    }
  }
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _notificationRuleModelSerialize(
  NotificationRuleModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.bypassDnd);
  writer.writeString(offsets[1], object.colorTag?.name);
  writer.writeString(offsets[2], object.content);
  writer.writeDateTime(offsets[3], object.createdAt);
  writer.writeLong(offsets[4], object.durationCount);
  writer.writeString(offsets[5], object.durationUnit?.name);
  writer.writeDateTime(offsets[6], object.endDate);
  writer.writeLongList(offsets[7], object.fixedTimesMinutes);
  writer.writeLong(offsets[8], object.intervalEvery);
  writer.writeString(offsets[9], object.intervalUnit?.name);
  writer.writeLong(offsets[10], object.intervalWindowEndMinutes);
  writer.writeLong(offsets[11], object.intervalWindowStartMinutes);
  writer.writeBool(offsets[12], object.isForever);
  writer.writeDateTime(offsets[13], object.lastTriggeredAt);
  writer.writeDateTime(offsets[14], object.nextTriggerAt);
  writer.writeLong(offsets[15], object.randomCount);
  writer.writeLong(offsets[16], object.randomWindowEndMinutes);
  writer.writeLong(offsets[17], object.randomWindowStartMinutes);
  writer.writeString(offsets[18], object.recurrenceType.name);
  writer.writeString(offsets[19], object.repetitionType.name);
  writer.writeLong(offsets[20], object.scheduleEvery);
  writer.writeString(offsets[21], object.scheduleUnit?.name);
  writer.writeLongList(offsets[22], object.selectedDaysOfWeek);
  writer.writeObjectList<MonthDaysRepetition>(
    offsets[23],
    allOffsets,
    MonthDaysRepetitionSchema.serialize,
    object.selectedMonthDays,
  );
  writer.writeDateTime(offsets[24], object.startDate);
  writer.writeString(offsets[25], object.title);
  writer.writeLong(offsets[26], object.totalOccurrences);
}

NotificationRuleModel _notificationRuleModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = NotificationRuleModel(
    bypassDnd: reader.readBool(offsets[0]),
    colorTag: _NotificationRuleModelcolorTagValueEnumMap[
        reader.readStringOrNull(offsets[1])],
    content: reader.readStringOrNull(offsets[2]),
    durationCount: reader.readLongOrNull(offsets[4]),
    durationUnit: _NotificationRuleModeldurationUnitValueEnumMap[
        reader.readStringOrNull(offsets[5])],
    endDate: reader.readDateTimeOrNull(offsets[6]),
    fixedTimesMinutes: reader.readLongList(offsets[7]),
    intervalEvery: reader.readLongOrNull(offsets[8]),
    intervalUnit: _NotificationRuleModelintervalUnitValueEnumMap[
        reader.readStringOrNull(offsets[9])],
    intervalWindowEndMinutes: reader.readLongOrNull(offsets[10]),
    intervalWindowStartMinutes: reader.readLongOrNull(offsets[11]),
    isForever: reader.readBool(offsets[12]),
    lastTriggeredAt: reader.readDateTimeOrNull(offsets[13]),
    nextTriggerAt: reader.readDateTimeOrNull(offsets[14]),
    randomCount: reader.readLongOrNull(offsets[15]),
    randomWindowEndMinutes: reader.readLongOrNull(offsets[16]),
    randomWindowStartMinutes: reader.readLongOrNull(offsets[17]),
    recurrenceType: _NotificationRuleModelrecurrenceTypeValueEnumMap[
            reader.readStringOrNull(offsets[18])] ??
        RecurrenceType.specific,
    repetitionType: _NotificationRuleModelrepetitionTypeValueEnumMap[
            reader.readStringOrNull(offsets[19])] ??
        RepetitionType.oneTime,
    scheduleEvery: reader.readLongOrNull(offsets[20]),
    scheduleUnit: _NotificationRuleModelscheduleUnitValueEnumMap[
        reader.readStringOrNull(offsets[21])],
    selectedDaysOfWeek: reader.readLongList(offsets[22]),
    selectedMonthDays: reader.readObjectList<MonthDaysRepetition>(
      offsets[23],
      MonthDaysRepetitionSchema.deserialize,
      allOffsets,
      MonthDaysRepetition(),
    ),
    startDate: reader.readDateTime(offsets[24]),
    title: reader.readString(offsets[25]),
    totalOccurrences: reader.readLongOrNull(offsets[26]),
  );
  object.createdAt = reader.readDateTime(offsets[3]);
  object.id = id;
  return object;
}

P _notificationRuleModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (_NotificationRuleModelcolorTagValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (_NotificationRuleModeldurationUnitValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    case 6:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 7:
      return (reader.readLongList(offset)) as P;
    case 8:
      return (reader.readLongOrNull(offset)) as P;
    case 9:
      return (_NotificationRuleModelintervalUnitValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    case 10:
      return (reader.readLongOrNull(offset)) as P;
    case 11:
      return (reader.readLongOrNull(offset)) as P;
    case 12:
      return (reader.readBool(offset)) as P;
    case 13:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 14:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 15:
      return (reader.readLongOrNull(offset)) as P;
    case 16:
      return (reader.readLongOrNull(offset)) as P;
    case 17:
      return (reader.readLongOrNull(offset)) as P;
    case 18:
      return (_NotificationRuleModelrecurrenceTypeValueEnumMap[
              reader.readStringOrNull(offset)] ??
          RecurrenceType.specific) as P;
    case 19:
      return (_NotificationRuleModelrepetitionTypeValueEnumMap[
              reader.readStringOrNull(offset)] ??
          RepetitionType.oneTime) as P;
    case 20:
      return (reader.readLongOrNull(offset)) as P;
    case 21:
      return (_NotificationRuleModelscheduleUnitValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    case 22:
      return (reader.readLongList(offset)) as P;
    case 23:
      return (reader.readObjectList<MonthDaysRepetition>(
        offset,
        MonthDaysRepetitionSchema.deserialize,
        allOffsets,
        MonthDaysRepetition(),
      )) as P;
    case 24:
      return (reader.readDateTime(offset)) as P;
    case 25:
      return (reader.readString(offset)) as P;
    case 26:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _NotificationRuleModelcolorTagEnumValueMap = {
  r'green': r'green',
  r'blue': r'blue',
  r'cyan': r'cyan',
  r'red': r'red',
  r'yellow': r'yellow',
  r'purple': r'purple',
  r'pink': r'pink',
  r'orange': r'orange',
};
const _NotificationRuleModelcolorTagValueEnumMap = {
  r'green': ColorTag.green,
  r'blue': ColorTag.blue,
  r'cyan': ColorTag.cyan,
  r'red': ColorTag.red,
  r'yellow': ColorTag.yellow,
  r'purple': ColorTag.purple,
  r'pink': ColorTag.pink,
  r'orange': ColorTag.orange,
};
const _NotificationRuleModeldurationUnitEnumValueMap = {
  r'day': r'day',
  r'week': r'week',
  r'month': r'month',
  r'year': r'year',
};
const _NotificationRuleModeldurationUnitValueEnumMap = {
  r'day': ScheduleUnit.day,
  r'week': ScheduleUnit.week,
  r'month': ScheduleUnit.month,
  r'year': ScheduleUnit.year,
};
const _NotificationRuleModelintervalUnitEnumValueMap = {
  r'minute': r'minute',
  r'hour': r'hour',
};
const _NotificationRuleModelintervalUnitValueEnumMap = {
  r'minute': IntervalUnit.minute,
  r'hour': IntervalUnit.hour,
};
const _NotificationRuleModelrecurrenceTypeEnumValueMap = {
  r'specific': r'specific',
  r'random': r'random',
  r'interval': r'interval',
};
const _NotificationRuleModelrecurrenceTypeValueEnumMap = {
  r'specific': RecurrenceType.specific,
  r'random': RecurrenceType.random,
  r'interval': RecurrenceType.interval,
};
const _NotificationRuleModelrepetitionTypeEnumValueMap = {
  r'oneTime': r'oneTime',
  r'repetitive': r'repetitive',
};
const _NotificationRuleModelrepetitionTypeValueEnumMap = {
  r'oneTime': RepetitionType.oneTime,
  r'repetitive': RepetitionType.repetitive,
};
const _NotificationRuleModelscheduleUnitEnumValueMap = {
  r'day': r'day',
  r'week': r'week',
  r'month': r'month',
  r'year': r'year',
};
const _NotificationRuleModelscheduleUnitValueEnumMap = {
  r'day': ScheduleUnit.day,
  r'week': ScheduleUnit.week,
  r'month': ScheduleUnit.month,
  r'year': ScheduleUnit.year,
};

Id _notificationRuleModelGetId(NotificationRuleModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _notificationRuleModelGetLinks(
    NotificationRuleModel object) {
  return [];
}

void _notificationRuleModelAttach(
    IsarCollection<dynamic> col, Id id, NotificationRuleModel object) {
  object.id = id;
}

extension NotificationRuleModelQueryWhereSort
    on QueryBuilder<NotificationRuleModel, NotificationRuleModel, QWhere> {
  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension NotificationRuleModelQueryWhere on QueryBuilder<NotificationRuleModel,
    NotificationRuleModel, QWhereClause> {
  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterWhereClause>
      idBetween(
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

extension NotificationRuleModelQueryFilter on QueryBuilder<
    NotificationRuleModel, NotificationRuleModel, QFilterCondition> {
  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> bypassDndEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bypassDnd',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> colorTagIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'colorTag',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> colorTagIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'colorTag',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> colorTagEqualTo(
    ColorTag? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'colorTag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> colorTagGreaterThan(
    ColorTag? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'colorTag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> colorTagLessThan(
    ColorTag? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'colorTag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> colorTagBetween(
    ColorTag? lower,
    ColorTag? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'colorTag',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> colorTagStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'colorTag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> colorTagEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'colorTag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
          QAfterFilterCondition>
      colorTagContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'colorTag',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
          QAfterFilterCondition>
      colorTagMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'colorTag',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> colorTagIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'colorTag',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> colorTagIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'colorTag',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> contentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'content',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> contentIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'content',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> contentEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> contentGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> contentLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> contentBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'content',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> contentStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> contentEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
          QAfterFilterCondition>
      contentContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
          QAfterFilterCondition>
      contentMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'content',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> contentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'content',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> contentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'content',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> createdAtGreaterThan(
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

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> createdAtLessThan(
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

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> createdAtBetween(
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

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> durationCountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'durationCount',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> durationCountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'durationCount',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> durationCountEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'durationCount',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> durationCountGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'durationCount',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> durationCountLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'durationCount',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> durationCountBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'durationCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> durationUnitIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'durationUnit',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> durationUnitIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'durationUnit',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> durationUnitEqualTo(
    ScheduleUnit? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'durationUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> durationUnitGreaterThan(
    ScheduleUnit? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'durationUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> durationUnitLessThan(
    ScheduleUnit? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'durationUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> durationUnitBetween(
    ScheduleUnit? lower,
    ScheduleUnit? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'durationUnit',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> durationUnitStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'durationUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> durationUnitEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'durationUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
          QAfterFilterCondition>
      durationUnitContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'durationUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
          QAfterFilterCondition>
      durationUnitMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'durationUnit',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> durationUnitIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'durationUnit',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> durationUnitIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'durationUnit',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> endDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'endDate',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> endDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'endDate',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> endDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endDate',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> endDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'endDate',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> endDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'endDate',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> endDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'endDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> fixedTimesMinutesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fixedTimesMinutes',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> fixedTimesMinutesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fixedTimesMinutes',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> fixedTimesMinutesElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fixedTimesMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> fixedTimesMinutesElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fixedTimesMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> fixedTimesMinutesElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fixedTimesMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> fixedTimesMinutesElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fixedTimesMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> fixedTimesMinutesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'fixedTimesMinutes',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> fixedTimesMinutesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'fixedTimesMinutes',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> fixedTimesMinutesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'fixedTimesMinutes',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> fixedTimesMinutesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'fixedTimesMinutes',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> fixedTimesMinutesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'fixedTimesMinutes',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> fixedTimesMinutesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'fixedTimesMinutes',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> idLessThan(
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

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> idBetween(
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

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> intervalEveryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'intervalEvery',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> intervalEveryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'intervalEvery',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> intervalEveryEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'intervalEvery',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> intervalEveryGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'intervalEvery',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> intervalEveryLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'intervalEvery',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> intervalEveryBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'intervalEvery',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> intervalUnitIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'intervalUnit',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> intervalUnitIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'intervalUnit',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> intervalUnitEqualTo(
    IntervalUnit? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'intervalUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> intervalUnitGreaterThan(
    IntervalUnit? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'intervalUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> intervalUnitLessThan(
    IntervalUnit? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'intervalUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> intervalUnitBetween(
    IntervalUnit? lower,
    IntervalUnit? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'intervalUnit',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> intervalUnitStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'intervalUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> intervalUnitEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'intervalUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
          QAfterFilterCondition>
      intervalUnitContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'intervalUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
          QAfterFilterCondition>
      intervalUnitMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'intervalUnit',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> intervalUnitIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'intervalUnit',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> intervalUnitIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'intervalUnit',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> intervalWindowEndMinutesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'intervalWindowEndMinutes',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> intervalWindowEndMinutesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'intervalWindowEndMinutes',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> intervalWindowEndMinutesEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'intervalWindowEndMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> intervalWindowEndMinutesGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'intervalWindowEndMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> intervalWindowEndMinutesLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'intervalWindowEndMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> intervalWindowEndMinutesBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'intervalWindowEndMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> intervalWindowStartMinutesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'intervalWindowStartMinutes',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> intervalWindowStartMinutesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'intervalWindowStartMinutes',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> intervalWindowStartMinutesEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'intervalWindowStartMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> intervalWindowStartMinutesGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'intervalWindowStartMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> intervalWindowStartMinutesLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'intervalWindowStartMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> intervalWindowStartMinutesBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'intervalWindowStartMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> isForeverEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isForever',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> lastTriggeredAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastTriggeredAt',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> lastTriggeredAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastTriggeredAt',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> lastTriggeredAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastTriggeredAt',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> lastTriggeredAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastTriggeredAt',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> lastTriggeredAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastTriggeredAt',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> lastTriggeredAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastTriggeredAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> nextTriggerAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nextTriggerAt',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> nextTriggerAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nextTriggerAt',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> nextTriggerAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nextTriggerAt',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> nextTriggerAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nextTriggerAt',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> nextTriggerAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nextTriggerAt',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> nextTriggerAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nextTriggerAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> randomCountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'randomCount',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> randomCountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'randomCount',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> randomCountEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'randomCount',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> randomCountGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'randomCount',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> randomCountLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'randomCount',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> randomCountBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'randomCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> randomWindowEndMinutesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'randomWindowEndMinutes',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> randomWindowEndMinutesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'randomWindowEndMinutes',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> randomWindowEndMinutesEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'randomWindowEndMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> randomWindowEndMinutesGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'randomWindowEndMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> randomWindowEndMinutesLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'randomWindowEndMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> randomWindowEndMinutesBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'randomWindowEndMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> randomWindowStartMinutesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'randomWindowStartMinutes',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> randomWindowStartMinutesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'randomWindowStartMinutes',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> randomWindowStartMinutesEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'randomWindowStartMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> randomWindowStartMinutesGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'randomWindowStartMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> randomWindowStartMinutesLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'randomWindowStartMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> randomWindowStartMinutesBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'randomWindowStartMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> recurrenceTypeEqualTo(
    RecurrenceType value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recurrenceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> recurrenceTypeGreaterThan(
    RecurrenceType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'recurrenceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> recurrenceTypeLessThan(
    RecurrenceType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'recurrenceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> recurrenceTypeBetween(
    RecurrenceType lower,
    RecurrenceType upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'recurrenceType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> recurrenceTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'recurrenceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> recurrenceTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'recurrenceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
          QAfterFilterCondition>
      recurrenceTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'recurrenceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
          QAfterFilterCondition>
      recurrenceTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'recurrenceType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> recurrenceTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recurrenceType',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> recurrenceTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'recurrenceType',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> repetitionTypeEqualTo(
    RepetitionType value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'repetitionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> repetitionTypeGreaterThan(
    RepetitionType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'repetitionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> repetitionTypeLessThan(
    RepetitionType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'repetitionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> repetitionTypeBetween(
    RepetitionType lower,
    RepetitionType upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'repetitionType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> repetitionTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'repetitionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> repetitionTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'repetitionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
          QAfterFilterCondition>
      repetitionTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'repetitionType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
          QAfterFilterCondition>
      repetitionTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'repetitionType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> repetitionTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'repetitionType',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> repetitionTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'repetitionType',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> scheduleEveryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'scheduleEvery',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> scheduleEveryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'scheduleEvery',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> scheduleEveryEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'scheduleEvery',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> scheduleEveryGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'scheduleEvery',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> scheduleEveryLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'scheduleEvery',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> scheduleEveryBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'scheduleEvery',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> scheduleUnitIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'scheduleUnit',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> scheduleUnitIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'scheduleUnit',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> scheduleUnitEqualTo(
    ScheduleUnit? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'scheduleUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> scheduleUnitGreaterThan(
    ScheduleUnit? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'scheduleUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> scheduleUnitLessThan(
    ScheduleUnit? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'scheduleUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> scheduleUnitBetween(
    ScheduleUnit? lower,
    ScheduleUnit? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'scheduleUnit',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> scheduleUnitStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'scheduleUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> scheduleUnitEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'scheduleUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
          QAfterFilterCondition>
      scheduleUnitContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'scheduleUnit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
          QAfterFilterCondition>
      scheduleUnitMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'scheduleUnit',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> scheduleUnitIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'scheduleUnit',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> scheduleUnitIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'scheduleUnit',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> selectedDaysOfWeekIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'selectedDaysOfWeek',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> selectedDaysOfWeekIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'selectedDaysOfWeek',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> selectedDaysOfWeekElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'selectedDaysOfWeek',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> selectedDaysOfWeekElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'selectedDaysOfWeek',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> selectedDaysOfWeekElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'selectedDaysOfWeek',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> selectedDaysOfWeekElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'selectedDaysOfWeek',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> selectedDaysOfWeekLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selectedDaysOfWeek',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> selectedDaysOfWeekIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selectedDaysOfWeek',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> selectedDaysOfWeekIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selectedDaysOfWeek',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> selectedDaysOfWeekLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selectedDaysOfWeek',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> selectedDaysOfWeekLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selectedDaysOfWeek',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> selectedDaysOfWeekLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selectedDaysOfWeek',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> selectedMonthDaysIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'selectedMonthDays',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> selectedMonthDaysIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'selectedMonthDays',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> selectedMonthDaysLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selectedMonthDays',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> selectedMonthDaysIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selectedMonthDays',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> selectedMonthDaysIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selectedMonthDays',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> selectedMonthDaysLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selectedMonthDays',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> selectedMonthDaysLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selectedMonthDays',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> selectedMonthDaysLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selectedMonthDays',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> startDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startDate',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> startDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startDate',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> startDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startDate',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> startDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> titleEqualTo(
    String value, {
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

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> titleGreaterThan(
    String value, {
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

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> titleLessThan(
    String value, {
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

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
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

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> titleStartsWith(
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

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> titleEndsWith(
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

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
          QAfterFilterCondition>
      titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
          QAfterFilterCondition>
      titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> totalOccurrencesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'totalOccurrences',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> totalOccurrencesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'totalOccurrences',
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> totalOccurrencesEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalOccurrences',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> totalOccurrencesGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalOccurrences',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> totalOccurrencesLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalOccurrences',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
      QAfterFilterCondition> totalOccurrencesBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalOccurrences',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension NotificationRuleModelQueryObject on QueryBuilder<
    NotificationRuleModel, NotificationRuleModel, QFilterCondition> {
  QueryBuilder<NotificationRuleModel, NotificationRuleModel,
          QAfterFilterCondition>
      selectedMonthDaysElement(FilterQuery<MonthDaysRepetition> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'selectedMonthDays');
    });
  }
}

extension NotificationRuleModelQueryLinks on QueryBuilder<NotificationRuleModel,
    NotificationRuleModel, QFilterCondition> {}

extension NotificationRuleModelQuerySortBy
    on QueryBuilder<NotificationRuleModel, NotificationRuleModel, QSortBy> {
  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByBypassDnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bypassDnd', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByBypassDndDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bypassDnd', Sort.desc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByColorTag() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorTag', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByColorTagDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorTag', Sort.desc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.desc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByDurationCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationCount', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByDurationCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationCount', Sort.desc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByDurationUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationUnit', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByDurationUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationUnit', Sort.desc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByEndDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.desc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByIntervalEvery() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intervalEvery', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByIntervalEveryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intervalEvery', Sort.desc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByIntervalUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intervalUnit', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByIntervalUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intervalUnit', Sort.desc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByIntervalWindowEndMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intervalWindowEndMinutes', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByIntervalWindowEndMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intervalWindowEndMinutes', Sort.desc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByIntervalWindowStartMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intervalWindowStartMinutes', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByIntervalWindowStartMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intervalWindowStartMinutes', Sort.desc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByIsForever() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isForever', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByIsForeverDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isForever', Sort.desc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByLastTriggeredAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTriggeredAt', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByLastTriggeredAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTriggeredAt', Sort.desc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByNextTriggerAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextTriggerAt', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByNextTriggerAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextTriggerAt', Sort.desc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByRandomCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'randomCount', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByRandomCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'randomCount', Sort.desc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByRandomWindowEndMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'randomWindowEndMinutes', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByRandomWindowEndMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'randomWindowEndMinutes', Sort.desc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByRandomWindowStartMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'randomWindowStartMinutes', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByRandomWindowStartMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'randomWindowStartMinutes', Sort.desc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByRecurrenceType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurrenceType', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByRecurrenceTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurrenceType', Sort.desc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByRepetitionType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repetitionType', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByRepetitionTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repetitionType', Sort.desc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByScheduleEvery() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleEvery', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByScheduleEveryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleEvery', Sort.desc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByScheduleUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleUnit', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByScheduleUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleUnit', Sort.desc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByStartDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.desc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByTotalOccurrences() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalOccurrences', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      sortByTotalOccurrencesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalOccurrences', Sort.desc);
    });
  }
}

extension NotificationRuleModelQuerySortThenBy
    on QueryBuilder<NotificationRuleModel, NotificationRuleModel, QSortThenBy> {
  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByBypassDnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bypassDnd', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByBypassDndDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bypassDnd', Sort.desc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByColorTag() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorTag', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByColorTagDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorTag', Sort.desc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.desc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByDurationCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationCount', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByDurationCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationCount', Sort.desc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByDurationUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationUnit', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByDurationUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationUnit', Sort.desc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByEndDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDate', Sort.desc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByIntervalEvery() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intervalEvery', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByIntervalEveryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intervalEvery', Sort.desc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByIntervalUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intervalUnit', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByIntervalUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intervalUnit', Sort.desc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByIntervalWindowEndMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intervalWindowEndMinutes', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByIntervalWindowEndMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intervalWindowEndMinutes', Sort.desc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByIntervalWindowStartMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intervalWindowStartMinutes', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByIntervalWindowStartMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intervalWindowStartMinutes', Sort.desc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByIsForever() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isForever', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByIsForeverDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isForever', Sort.desc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByLastTriggeredAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTriggeredAt', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByLastTriggeredAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastTriggeredAt', Sort.desc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByNextTriggerAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextTriggerAt', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByNextTriggerAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nextTriggerAt', Sort.desc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByRandomCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'randomCount', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByRandomCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'randomCount', Sort.desc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByRandomWindowEndMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'randomWindowEndMinutes', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByRandomWindowEndMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'randomWindowEndMinutes', Sort.desc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByRandomWindowStartMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'randomWindowStartMinutes', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByRandomWindowStartMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'randomWindowStartMinutes', Sort.desc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByRecurrenceType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurrenceType', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByRecurrenceTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurrenceType', Sort.desc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByRepetitionType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repetitionType', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByRepetitionTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'repetitionType', Sort.desc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByScheduleEvery() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleEvery', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByScheduleEveryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleEvery', Sort.desc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByScheduleUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleUnit', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByScheduleUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduleUnit', Sort.desc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByStartDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startDate', Sort.desc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByTotalOccurrences() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalOccurrences', Sort.asc);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QAfterSortBy>
      thenByTotalOccurrencesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalOccurrences', Sort.desc);
    });
  }
}

extension NotificationRuleModelQueryWhereDistinct
    on QueryBuilder<NotificationRuleModel, NotificationRuleModel, QDistinct> {
  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QDistinct>
      distinctByBypassDnd() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bypassDnd');
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QDistinct>
      distinctByColorTag({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'colorTag', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QDistinct>
      distinctByContent({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'content', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QDistinct>
      distinctByDurationCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'durationCount');
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QDistinct>
      distinctByDurationUnit({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'durationUnit', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QDistinct>
      distinctByEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endDate');
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QDistinct>
      distinctByFixedTimesMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fixedTimesMinutes');
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QDistinct>
      distinctByIntervalEvery() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'intervalEvery');
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QDistinct>
      distinctByIntervalUnit({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'intervalUnit', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QDistinct>
      distinctByIntervalWindowEndMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'intervalWindowEndMinutes');
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QDistinct>
      distinctByIntervalWindowStartMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'intervalWindowStartMinutes');
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QDistinct>
      distinctByIsForever() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isForever');
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QDistinct>
      distinctByLastTriggeredAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastTriggeredAt');
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QDistinct>
      distinctByNextTriggerAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nextTriggerAt');
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QDistinct>
      distinctByRandomCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'randomCount');
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QDistinct>
      distinctByRandomWindowEndMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'randomWindowEndMinutes');
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QDistinct>
      distinctByRandomWindowStartMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'randomWindowStartMinutes');
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QDistinct>
      distinctByRecurrenceType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recurrenceType',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QDistinct>
      distinctByRepetitionType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'repetitionType',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QDistinct>
      distinctByScheduleEvery() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'scheduleEvery');
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QDistinct>
      distinctByScheduleUnit({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'scheduleUnit', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QDistinct>
      distinctBySelectedDaysOfWeek() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'selectedDaysOfWeek');
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QDistinct>
      distinctByStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startDate');
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QDistinct>
      distinctByTitle({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NotificationRuleModel, NotificationRuleModel, QDistinct>
      distinctByTotalOccurrences() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalOccurrences');
    });
  }
}

extension NotificationRuleModelQueryProperty on QueryBuilder<
    NotificationRuleModel, NotificationRuleModel, QQueryProperty> {
  QueryBuilder<NotificationRuleModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<NotificationRuleModel, bool, QQueryOperations>
      bypassDndProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bypassDnd');
    });
  }

  QueryBuilder<NotificationRuleModel, ColorTag?, QQueryOperations>
      colorTagProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'colorTag');
    });
  }

  QueryBuilder<NotificationRuleModel, String?, QQueryOperations>
      contentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'content');
    });
  }

  QueryBuilder<NotificationRuleModel, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<NotificationRuleModel, int?, QQueryOperations>
      durationCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'durationCount');
    });
  }

  QueryBuilder<NotificationRuleModel, ScheduleUnit?, QQueryOperations>
      durationUnitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'durationUnit');
    });
  }

  QueryBuilder<NotificationRuleModel, DateTime?, QQueryOperations>
      endDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endDate');
    });
  }

  QueryBuilder<NotificationRuleModel, List<int>?, QQueryOperations>
      fixedTimesMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fixedTimesMinutes');
    });
  }

  QueryBuilder<NotificationRuleModel, int?, QQueryOperations>
      intervalEveryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'intervalEvery');
    });
  }

  QueryBuilder<NotificationRuleModel, IntervalUnit?, QQueryOperations>
      intervalUnitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'intervalUnit');
    });
  }

  QueryBuilder<NotificationRuleModel, int?, QQueryOperations>
      intervalWindowEndMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'intervalWindowEndMinutes');
    });
  }

  QueryBuilder<NotificationRuleModel, int?, QQueryOperations>
      intervalWindowStartMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'intervalWindowStartMinutes');
    });
  }

  QueryBuilder<NotificationRuleModel, bool, QQueryOperations>
      isForeverProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isForever');
    });
  }

  QueryBuilder<NotificationRuleModel, DateTime?, QQueryOperations>
      lastTriggeredAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastTriggeredAt');
    });
  }

  QueryBuilder<NotificationRuleModel, DateTime?, QQueryOperations>
      nextTriggerAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nextTriggerAt');
    });
  }

  QueryBuilder<NotificationRuleModel, int?, QQueryOperations>
      randomCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'randomCount');
    });
  }

  QueryBuilder<NotificationRuleModel, int?, QQueryOperations>
      randomWindowEndMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'randomWindowEndMinutes');
    });
  }

  QueryBuilder<NotificationRuleModel, int?, QQueryOperations>
      randomWindowStartMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'randomWindowStartMinutes');
    });
  }

  QueryBuilder<NotificationRuleModel, RecurrenceType, QQueryOperations>
      recurrenceTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recurrenceType');
    });
  }

  QueryBuilder<NotificationRuleModel, RepetitionType, QQueryOperations>
      repetitionTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'repetitionType');
    });
  }

  QueryBuilder<NotificationRuleModel, int?, QQueryOperations>
      scheduleEveryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'scheduleEvery');
    });
  }

  QueryBuilder<NotificationRuleModel, ScheduleUnit?, QQueryOperations>
      scheduleUnitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'scheduleUnit');
    });
  }

  QueryBuilder<NotificationRuleModel, List<int>?, QQueryOperations>
      selectedDaysOfWeekProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'selectedDaysOfWeek');
    });
  }

  QueryBuilder<NotificationRuleModel, List<MonthDaysRepetition>?,
      QQueryOperations> selectedMonthDaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'selectedMonthDays');
    });
  }

  QueryBuilder<NotificationRuleModel, DateTime, QQueryOperations>
      startDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startDate');
    });
  }

  QueryBuilder<NotificationRuleModel, String, QQueryOperations>
      titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<NotificationRuleModel, int?, QQueryOperations>
      totalOccurrencesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalOccurrences');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const MonthDaysRepetitionSchema = Schema(
  name: r'MonthDaysRepetition',
  id: -3125652146444602797,
  properties: {
    r'selectedDaysOfMonth': PropertySchema(
      id: 0,
      name: r'selectedDaysOfMonth',
      type: IsarType.longList,
    ),
    r'selectedMonth': PropertySchema(
      id: 1,
      name: r'selectedMonth',
      type: IsarType.long,
    )
  },
  estimateSize: _monthDaysRepetitionEstimateSize,
  serialize: _monthDaysRepetitionSerialize,
  deserialize: _monthDaysRepetitionDeserialize,
  deserializeProp: _monthDaysRepetitionDeserializeProp,
);

int _monthDaysRepetitionEstimateSize(
  MonthDaysRepetition object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.selectedDaysOfMonth;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  return bytesCount;
}

void _monthDaysRepetitionSerialize(
  MonthDaysRepetition object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLongList(offsets[0], object.selectedDaysOfMonth);
  writer.writeLong(offsets[1], object.selectedMonth);
}

MonthDaysRepetition _monthDaysRepetitionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MonthDaysRepetition();
  object.selectedDaysOfMonth = reader.readLongList(offsets[0]);
  object.selectedMonth = reader.readLongOrNull(offsets[1]);
  return object;
}

P _monthDaysRepetitionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongList(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension MonthDaysRepetitionQueryFilter on QueryBuilder<MonthDaysRepetition,
    MonthDaysRepetition, QFilterCondition> {
  QueryBuilder<MonthDaysRepetition, MonthDaysRepetition, QAfterFilterCondition>
      selectedDaysOfMonthIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'selectedDaysOfMonth',
      ));
    });
  }

  QueryBuilder<MonthDaysRepetition, MonthDaysRepetition, QAfterFilterCondition>
      selectedDaysOfMonthIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'selectedDaysOfMonth',
      ));
    });
  }

  QueryBuilder<MonthDaysRepetition, MonthDaysRepetition, QAfterFilterCondition>
      selectedDaysOfMonthElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'selectedDaysOfMonth',
        value: value,
      ));
    });
  }

  QueryBuilder<MonthDaysRepetition, MonthDaysRepetition, QAfterFilterCondition>
      selectedDaysOfMonthElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'selectedDaysOfMonth',
        value: value,
      ));
    });
  }

  QueryBuilder<MonthDaysRepetition, MonthDaysRepetition, QAfterFilterCondition>
      selectedDaysOfMonthElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'selectedDaysOfMonth',
        value: value,
      ));
    });
  }

  QueryBuilder<MonthDaysRepetition, MonthDaysRepetition, QAfterFilterCondition>
      selectedDaysOfMonthElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'selectedDaysOfMonth',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MonthDaysRepetition, MonthDaysRepetition, QAfterFilterCondition>
      selectedDaysOfMonthLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selectedDaysOfMonth',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<MonthDaysRepetition, MonthDaysRepetition, QAfterFilterCondition>
      selectedDaysOfMonthIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selectedDaysOfMonth',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<MonthDaysRepetition, MonthDaysRepetition, QAfterFilterCondition>
      selectedDaysOfMonthIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selectedDaysOfMonth',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MonthDaysRepetition, MonthDaysRepetition, QAfterFilterCondition>
      selectedDaysOfMonthLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selectedDaysOfMonth',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<MonthDaysRepetition, MonthDaysRepetition, QAfterFilterCondition>
      selectedDaysOfMonthLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selectedDaysOfMonth',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MonthDaysRepetition, MonthDaysRepetition, QAfterFilterCondition>
      selectedDaysOfMonthLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'selectedDaysOfMonth',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<MonthDaysRepetition, MonthDaysRepetition, QAfterFilterCondition>
      selectedMonthIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'selectedMonth',
      ));
    });
  }

  QueryBuilder<MonthDaysRepetition, MonthDaysRepetition, QAfterFilterCondition>
      selectedMonthIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'selectedMonth',
      ));
    });
  }

  QueryBuilder<MonthDaysRepetition, MonthDaysRepetition, QAfterFilterCondition>
      selectedMonthEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'selectedMonth',
        value: value,
      ));
    });
  }

  QueryBuilder<MonthDaysRepetition, MonthDaysRepetition, QAfterFilterCondition>
      selectedMonthGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'selectedMonth',
        value: value,
      ));
    });
  }

  QueryBuilder<MonthDaysRepetition, MonthDaysRepetition, QAfterFilterCondition>
      selectedMonthLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'selectedMonth',
        value: value,
      ));
    });
  }

  QueryBuilder<MonthDaysRepetition, MonthDaysRepetition, QAfterFilterCondition>
      selectedMonthBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'selectedMonth',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MonthDaysRepetitionQueryObject on QueryBuilder<MonthDaysRepetition,
    MonthDaysRepetition, QFilterCondition> {}
