// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schema.dart';

// ignore_for_file: type=lint
class $WorkoutTable extends Workout with TableInfo<$WorkoutTable, WorkoutData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, description, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout';
  @override
  VerificationContext validateIntegrity(Insertable<WorkoutData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $WorkoutTable createAlias(String alias) {
    return $WorkoutTable(attachedDatabase, alias);
  }
}

class WorkoutData extends DataClass implements Insertable<WorkoutData> {
  final int id;
  final String name;
  final String? description;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const WorkoutData(
      {required this.id,
      required this.name,
      this.description,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  WorkoutCompanion toCompanion(bool nullToAbsent) {
    return WorkoutCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory WorkoutData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  WorkoutData copyWith(
          {int? id,
          String? name,
          Value<String?> description = const Value.absent(),
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      WorkoutData(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  WorkoutData copyWithCompanion(WorkoutCompanion data) {
    return WorkoutData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutData &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class WorkoutCompanion extends UpdateCompanion<WorkoutData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const WorkoutCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  WorkoutCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<WorkoutData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  WorkoutCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? description,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt}) {
    return WorkoutCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $BlockTable extends Block with TableInfo<$BlockTable, BlockData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BlockTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _workoutIdMeta =
      const VerificationMeta('workoutId');
  @override
  late final GeneratedColumn<int> workoutId = GeneratedColumn<int>(
      'workout_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES workout (id)'));
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
      'order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _repeatCountMeta =
      const VerificationMeta('repeatCount');
  @override
  late final GeneratedColumn<int> repeatCount = GeneratedColumn<int>(
      'repeat_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, workoutId, order, repeatCount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'block';
  @override
  VerificationContext validateIntegrity(Insertable<BlockData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('workout_id')) {
      context.handle(_workoutIdMeta,
          workoutId.isAcceptableOrUnknown(data['workout_id']!, _workoutIdMeta));
    } else if (isInserting) {
      context.missing(_workoutIdMeta);
    }
    if (data.containsKey('order')) {
      context.handle(
          _orderMeta, order.isAcceptableOrUnknown(data['order']!, _orderMeta));
    } else if (isInserting) {
      context.missing(_orderMeta);
    }
    if (data.containsKey('repeat_count')) {
      context.handle(
          _repeatCountMeta,
          repeatCount.isAcceptableOrUnknown(
              data['repeat_count']!, _repeatCountMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BlockData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BlockData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      workoutId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}workout_id'])!,
      order: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order'])!,
      repeatCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}repeat_count'])!,
    );
  }

  @override
  $BlockTable createAlias(String alias) {
    return $BlockTable(attachedDatabase, alias);
  }
}

class BlockData extends DataClass implements Insertable<BlockData> {
  final int id;
  final String name;
  final int workoutId;
  final int order;
  final int repeatCount;
  const BlockData(
      {required this.id,
      required this.name,
      required this.workoutId,
      required this.order,
      required this.repeatCount});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['workout_id'] = Variable<int>(workoutId);
    map['order'] = Variable<int>(order);
    map['repeat_count'] = Variable<int>(repeatCount);
    return map;
  }

  BlockCompanion toCompanion(bool nullToAbsent) {
    return BlockCompanion(
      id: Value(id),
      name: Value(name),
      workoutId: Value(workoutId),
      order: Value(order),
      repeatCount: Value(repeatCount),
    );
  }

  factory BlockData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BlockData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      workoutId: serializer.fromJson<int>(json['workoutId']),
      order: serializer.fromJson<int>(json['order']),
      repeatCount: serializer.fromJson<int>(json['repeatCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'workoutId': serializer.toJson<int>(workoutId),
      'order': serializer.toJson<int>(order),
      'repeatCount': serializer.toJson<int>(repeatCount),
    };
  }

  BlockData copyWith(
          {int? id,
          String? name,
          int? workoutId,
          int? order,
          int? repeatCount}) =>
      BlockData(
        id: id ?? this.id,
        name: name ?? this.name,
        workoutId: workoutId ?? this.workoutId,
        order: order ?? this.order,
        repeatCount: repeatCount ?? this.repeatCount,
      );
  BlockData copyWithCompanion(BlockCompanion data) {
    return BlockData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      workoutId: data.workoutId.present ? data.workoutId.value : this.workoutId,
      order: data.order.present ? data.order.value : this.order,
      repeatCount:
          data.repeatCount.present ? data.repeatCount.value : this.repeatCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BlockData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('workoutId: $workoutId, ')
          ..write('order: $order, ')
          ..write('repeatCount: $repeatCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, workoutId, order, repeatCount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BlockData &&
          other.id == this.id &&
          other.name == this.name &&
          other.workoutId == this.workoutId &&
          other.order == this.order &&
          other.repeatCount == this.repeatCount);
}

class BlockCompanion extends UpdateCompanion<BlockData> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> workoutId;
  final Value<int> order;
  final Value<int> repeatCount;
  const BlockCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.workoutId = const Value.absent(),
    this.order = const Value.absent(),
    this.repeatCount = const Value.absent(),
  });
  BlockCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int workoutId,
    required int order,
    this.repeatCount = const Value.absent(),
  })  : name = Value(name),
        workoutId = Value(workoutId),
        order = Value(order);
  static Insertable<BlockData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? workoutId,
    Expression<int>? order,
    Expression<int>? repeatCount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (workoutId != null) 'workout_id': workoutId,
      if (order != null) 'order': order,
      if (repeatCount != null) 'repeat_count': repeatCount,
    });
  }

  BlockCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<int>? workoutId,
      Value<int>? order,
      Value<int>? repeatCount}) {
    return BlockCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      workoutId: workoutId ?? this.workoutId,
      order: order ?? this.order,
      repeatCount: repeatCount ?? this.repeatCount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (workoutId.present) {
      map['workout_id'] = Variable<int>(workoutId.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (repeatCount.present) {
      map['repeat_count'] = Variable<int>(repeatCount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BlockCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('workoutId: $workoutId, ')
          ..write('order: $order, ')
          ..write('repeatCount: $repeatCount')
          ..write(')'))
        .toString();
  }
}

class $StepTable extends Step with TableInfo<$StepTable, StepData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StepTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _stepTypeMeta =
      const VerificationMeta('stepType');
  @override
  late final GeneratedColumn<String> stepType = GeneratedColumn<String>(
      'step_type', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 4, maxTextLength: 8),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _blockIdMeta =
      const VerificationMeta('blockId');
  @override
  late final GeneratedColumn<int> blockId = GeneratedColumn<int>(
      'block_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES block (id)'));
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
      'order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _durationSecondsMeta =
      const VerificationMeta('durationSeconds');
  @override
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
      'duration_seconds', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _targetSpeedMeta =
      const VerificationMeta('targetSpeed');
  @override
  late final GeneratedColumn<double> targetSpeed = GeneratedColumn<double>(
      'target_speed', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _targetDistanceMeta =
      const VerificationMeta('targetDistance');
  @override
  late final GeneratedColumn<double> targetDistance = GeneratedColumn<double>(
      'target_distance', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _orderIndexMeta =
      const VerificationMeta('orderIndex');
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
      'order_index', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        stepType,
        blockId,
        order,
        durationSeconds,
        targetSpeed,
        targetDistance,
        orderIndex
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'step';
  @override
  VerificationContext validateIntegrity(Insertable<StepData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('step_type')) {
      context.handle(_stepTypeMeta,
          stepType.isAcceptableOrUnknown(data['step_type']!, _stepTypeMeta));
    } else if (isInserting) {
      context.missing(_stepTypeMeta);
    }
    if (data.containsKey('block_id')) {
      context.handle(_blockIdMeta,
          blockId.isAcceptableOrUnknown(data['block_id']!, _blockIdMeta));
    } else if (isInserting) {
      context.missing(_blockIdMeta);
    }
    if (data.containsKey('order')) {
      context.handle(
          _orderMeta, order.isAcceptableOrUnknown(data['order']!, _orderMeta));
    } else if (isInserting) {
      context.missing(_orderMeta);
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
          _durationSecondsMeta,
          durationSeconds.isAcceptableOrUnknown(
              data['duration_seconds']!, _durationSecondsMeta));
    } else if (isInserting) {
      context.missing(_durationSecondsMeta);
    }
    if (data.containsKey('target_speed')) {
      context.handle(
          _targetSpeedMeta,
          targetSpeed.isAcceptableOrUnknown(
              data['target_speed']!, _targetSpeedMeta));
    }
    if (data.containsKey('target_distance')) {
      context.handle(
          _targetDistanceMeta,
          targetDistance.isAcceptableOrUnknown(
              data['target_distance']!, _targetDistanceMeta));
    }
    if (data.containsKey('order_index')) {
      context.handle(
          _orderIndexMeta,
          orderIndex.isAcceptableOrUnknown(
              data['order_index']!, _orderIndexMeta));
    } else if (isInserting) {
      context.missing(_orderIndexMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StepData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StepData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      stepType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}step_type'])!,
      blockId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}block_id'])!,
      order: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order'])!,
      durationSeconds: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_seconds'])!,
      targetSpeed: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}target_speed']),
      targetDistance: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}target_distance']),
      orderIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order_index'])!,
    );
  }

  @override
  $StepTable createAlias(String alias) {
    return $StepTable(attachedDatabase, alias);
  }
}

class StepData extends DataClass implements Insertable<StepData> {
  final int id;
  final String name;
  final String stepType;
  final int blockId;
  final int order;
  final int durationSeconds;
  final double? targetSpeed;
  final double? targetDistance;
  final int orderIndex;
  const StepData(
      {required this.id,
      required this.name,
      required this.stepType,
      required this.blockId,
      required this.order,
      required this.durationSeconds,
      this.targetSpeed,
      this.targetDistance,
      required this.orderIndex});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['step_type'] = Variable<String>(stepType);
    map['block_id'] = Variable<int>(blockId);
    map['order'] = Variable<int>(order);
    map['duration_seconds'] = Variable<int>(durationSeconds);
    if (!nullToAbsent || targetSpeed != null) {
      map['target_speed'] = Variable<double>(targetSpeed);
    }
    if (!nullToAbsent || targetDistance != null) {
      map['target_distance'] = Variable<double>(targetDistance);
    }
    map['order_index'] = Variable<int>(orderIndex);
    return map;
  }

  StepCompanion toCompanion(bool nullToAbsent) {
    return StepCompanion(
      id: Value(id),
      name: Value(name),
      stepType: Value(stepType),
      blockId: Value(blockId),
      order: Value(order),
      durationSeconds: Value(durationSeconds),
      targetSpeed: targetSpeed == null && nullToAbsent
          ? const Value.absent()
          : Value(targetSpeed),
      targetDistance: targetDistance == null && nullToAbsent
          ? const Value.absent()
          : Value(targetDistance),
      orderIndex: Value(orderIndex),
    );
  }

  factory StepData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StepData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      stepType: serializer.fromJson<String>(json['stepType']),
      blockId: serializer.fromJson<int>(json['blockId']),
      order: serializer.fromJson<int>(json['order']),
      durationSeconds: serializer.fromJson<int>(json['durationSeconds']),
      targetSpeed: serializer.fromJson<double?>(json['targetSpeed']),
      targetDistance: serializer.fromJson<double?>(json['targetDistance']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'stepType': serializer.toJson<String>(stepType),
      'blockId': serializer.toJson<int>(blockId),
      'order': serializer.toJson<int>(order),
      'durationSeconds': serializer.toJson<int>(durationSeconds),
      'targetSpeed': serializer.toJson<double?>(targetSpeed),
      'targetDistance': serializer.toJson<double?>(targetDistance),
      'orderIndex': serializer.toJson<int>(orderIndex),
    };
  }

  StepData copyWith(
          {int? id,
          String? name,
          String? stepType,
          int? blockId,
          int? order,
          int? durationSeconds,
          Value<double?> targetSpeed = const Value.absent(),
          Value<double?> targetDistance = const Value.absent(),
          int? orderIndex}) =>
      StepData(
        id: id ?? this.id,
        name: name ?? this.name,
        stepType: stepType ?? this.stepType,
        blockId: blockId ?? this.blockId,
        order: order ?? this.order,
        durationSeconds: durationSeconds ?? this.durationSeconds,
        targetSpeed: targetSpeed.present ? targetSpeed.value : this.targetSpeed,
        targetDistance:
            targetDistance.present ? targetDistance.value : this.targetDistance,
        orderIndex: orderIndex ?? this.orderIndex,
      );
  StepData copyWithCompanion(StepCompanion data) {
    return StepData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      stepType: data.stepType.present ? data.stepType.value : this.stepType,
      blockId: data.blockId.present ? data.blockId.value : this.blockId,
      order: data.order.present ? data.order.value : this.order,
      durationSeconds: data.durationSeconds.present
          ? data.durationSeconds.value
          : this.durationSeconds,
      targetSpeed:
          data.targetSpeed.present ? data.targetSpeed.value : this.targetSpeed,
      targetDistance: data.targetDistance.present
          ? data.targetDistance.value
          : this.targetDistance,
      orderIndex:
          data.orderIndex.present ? data.orderIndex.value : this.orderIndex,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StepData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('stepType: $stepType, ')
          ..write('blockId: $blockId, ')
          ..write('order: $order, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('targetSpeed: $targetSpeed, ')
          ..write('targetDistance: $targetDistance, ')
          ..write('orderIndex: $orderIndex')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, stepType, blockId, order,
      durationSeconds, targetSpeed, targetDistance, orderIndex);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StepData &&
          other.id == this.id &&
          other.name == this.name &&
          other.stepType == this.stepType &&
          other.blockId == this.blockId &&
          other.order == this.order &&
          other.durationSeconds == this.durationSeconds &&
          other.targetSpeed == this.targetSpeed &&
          other.targetDistance == this.targetDistance &&
          other.orderIndex == this.orderIndex);
}

class StepCompanion extends UpdateCompanion<StepData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> stepType;
  final Value<int> blockId;
  final Value<int> order;
  final Value<int> durationSeconds;
  final Value<double?> targetSpeed;
  final Value<double?> targetDistance;
  final Value<int> orderIndex;
  const StepCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.stepType = const Value.absent(),
    this.blockId = const Value.absent(),
    this.order = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.targetSpeed = const Value.absent(),
    this.targetDistance = const Value.absent(),
    this.orderIndex = const Value.absent(),
  });
  StepCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String stepType,
    required int blockId,
    required int order,
    required int durationSeconds,
    this.targetSpeed = const Value.absent(),
    this.targetDistance = const Value.absent(),
    required int orderIndex,
  })  : name = Value(name),
        stepType = Value(stepType),
        blockId = Value(blockId),
        order = Value(order),
        durationSeconds = Value(durationSeconds),
        orderIndex = Value(orderIndex);
  static Insertable<StepData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? stepType,
    Expression<int>? blockId,
    Expression<int>? order,
    Expression<int>? durationSeconds,
    Expression<double>? targetSpeed,
    Expression<double>? targetDistance,
    Expression<int>? orderIndex,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (stepType != null) 'step_type': stepType,
      if (blockId != null) 'block_id': blockId,
      if (order != null) 'order': order,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
      if (targetSpeed != null) 'target_speed': targetSpeed,
      if (targetDistance != null) 'target_distance': targetDistance,
      if (orderIndex != null) 'order_index': orderIndex,
    });
  }

  StepCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? stepType,
      Value<int>? blockId,
      Value<int>? order,
      Value<int>? durationSeconds,
      Value<double?>? targetSpeed,
      Value<double?>? targetDistance,
      Value<int>? orderIndex}) {
    return StepCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      stepType: stepType ?? this.stepType,
      blockId: blockId ?? this.blockId,
      order: order ?? this.order,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      targetSpeed: targetSpeed ?? this.targetSpeed,
      targetDistance: targetDistance ?? this.targetDistance,
      orderIndex: orderIndex ?? this.orderIndex,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (stepType.present) {
      map['step_type'] = Variable<String>(stepType.value);
    }
    if (blockId.present) {
      map['block_id'] = Variable<int>(blockId.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    if (targetSpeed.present) {
      map['target_speed'] = Variable<double>(targetSpeed.value);
    }
    if (targetDistance.present) {
      map['target_distance'] = Variable<double>(targetDistance.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StepCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('stepType: $stepType, ')
          ..write('blockId: $blockId, ')
          ..write('order: $order, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('targetSpeed: $targetSpeed, ')
          ..write('targetDistance: $targetDistance, ')
          ..write('orderIndex: $orderIndex')
          ..write(')'))
        .toString();
  }
}

class $WorkoutHistoryTable extends WorkoutHistory
    with TableInfo<$WorkoutHistoryTable, WorkoutHistoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutHistoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _workoutIdMeta =
      const VerificationMeta('workoutId');
  @override
  late final GeneratedColumn<int> workoutId = GeneratedColumn<int>(
      'workout_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES workout (id)'));
  static const VerificationMeta _completedAtMeta =
      const VerificationMeta('completedAt');
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
      'completed_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _distanceMeta =
      const VerificationMeta('distance');
  @override
  late final GeneratedColumn<double> distance = GeneratedColumn<double>(
      'distance', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _durationMeta =
      const VerificationMeta('duration');
  @override
  late final GeneratedColumn<int> duration = GeneratedColumn<int>(
      'duration', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, workoutId, completedAt, distance, duration];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_history';
  @override
  VerificationContext validateIntegrity(Insertable<WorkoutHistoryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('workout_id')) {
      context.handle(_workoutIdMeta,
          workoutId.isAcceptableOrUnknown(data['workout_id']!, _workoutIdMeta));
    } else if (isInserting) {
      context.missing(_workoutIdMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
          _completedAtMeta,
          completedAt.isAcceptableOrUnknown(
              data['completed_at']!, _completedAtMeta));
    }
    if (data.containsKey('distance')) {
      context.handle(_distanceMeta,
          distance.isAcceptableOrUnknown(data['distance']!, _distanceMeta));
    }
    if (data.containsKey('duration')) {
      context.handle(_durationMeta,
          duration.isAcceptableOrUnknown(data['duration']!, _durationMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutHistoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutHistoryData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      workoutId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}workout_id'])!,
      completedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}completed_at'])!,
      distance: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}distance']),
      duration: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration']),
    );
  }

  @override
  $WorkoutHistoryTable createAlias(String alias) {
    return $WorkoutHistoryTable(attachedDatabase, alias);
  }
}

class WorkoutHistoryData extends DataClass
    implements Insertable<WorkoutHistoryData> {
  final int id;
  final int workoutId;
  final DateTime completedAt;
  final double? distance;
  final int? duration;
  const WorkoutHistoryData(
      {required this.id,
      required this.workoutId,
      required this.completedAt,
      this.distance,
      this.duration});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['workout_id'] = Variable<int>(workoutId);
    map['completed_at'] = Variable<DateTime>(completedAt);
    if (!nullToAbsent || distance != null) {
      map['distance'] = Variable<double>(distance);
    }
    if (!nullToAbsent || duration != null) {
      map['duration'] = Variable<int>(duration);
    }
    return map;
  }

  WorkoutHistoryCompanion toCompanion(bool nullToAbsent) {
    return WorkoutHistoryCompanion(
      id: Value(id),
      workoutId: Value(workoutId),
      completedAt: Value(completedAt),
      distance: distance == null && nullToAbsent
          ? const Value.absent()
          : Value(distance),
      duration: duration == null && nullToAbsent
          ? const Value.absent()
          : Value(duration),
    );
  }

  factory WorkoutHistoryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutHistoryData(
      id: serializer.fromJson<int>(json['id']),
      workoutId: serializer.fromJson<int>(json['workoutId']),
      completedAt: serializer.fromJson<DateTime>(json['completedAt']),
      distance: serializer.fromJson<double?>(json['distance']),
      duration: serializer.fromJson<int?>(json['duration']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'workoutId': serializer.toJson<int>(workoutId),
      'completedAt': serializer.toJson<DateTime>(completedAt),
      'distance': serializer.toJson<double?>(distance),
      'duration': serializer.toJson<int?>(duration),
    };
  }

  WorkoutHistoryData copyWith(
          {int? id,
          int? workoutId,
          DateTime? completedAt,
          Value<double?> distance = const Value.absent(),
          Value<int?> duration = const Value.absent()}) =>
      WorkoutHistoryData(
        id: id ?? this.id,
        workoutId: workoutId ?? this.workoutId,
        completedAt: completedAt ?? this.completedAt,
        distance: distance.present ? distance.value : this.distance,
        duration: duration.present ? duration.value : this.duration,
      );
  WorkoutHistoryData copyWithCompanion(WorkoutHistoryCompanion data) {
    return WorkoutHistoryData(
      id: data.id.present ? data.id.value : this.id,
      workoutId: data.workoutId.present ? data.workoutId.value : this.workoutId,
      completedAt:
          data.completedAt.present ? data.completedAt.value : this.completedAt,
      distance: data.distance.present ? data.distance.value : this.distance,
      duration: data.duration.present ? data.duration.value : this.duration,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutHistoryData(')
          ..write('id: $id, ')
          ..write('workoutId: $workoutId, ')
          ..write('completedAt: $completedAt, ')
          ..write('distance: $distance, ')
          ..write('duration: $duration')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, workoutId, completedAt, distance, duration);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutHistoryData &&
          other.id == this.id &&
          other.workoutId == this.workoutId &&
          other.completedAt == this.completedAt &&
          other.distance == this.distance &&
          other.duration == this.duration);
}

class WorkoutHistoryCompanion extends UpdateCompanion<WorkoutHistoryData> {
  final Value<int> id;
  final Value<int> workoutId;
  final Value<DateTime> completedAt;
  final Value<double?> distance;
  final Value<int?> duration;
  const WorkoutHistoryCompanion({
    this.id = const Value.absent(),
    this.workoutId = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.distance = const Value.absent(),
    this.duration = const Value.absent(),
  });
  WorkoutHistoryCompanion.insert({
    this.id = const Value.absent(),
    required int workoutId,
    this.completedAt = const Value.absent(),
    this.distance = const Value.absent(),
    this.duration = const Value.absent(),
  }) : workoutId = Value(workoutId);
  static Insertable<WorkoutHistoryData> custom({
    Expression<int>? id,
    Expression<int>? workoutId,
    Expression<DateTime>? completedAt,
    Expression<double>? distance,
    Expression<int>? duration,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workoutId != null) 'workout_id': workoutId,
      if (completedAt != null) 'completed_at': completedAt,
      if (distance != null) 'distance': distance,
      if (duration != null) 'duration': duration,
    });
  }

  WorkoutHistoryCompanion copyWith(
      {Value<int>? id,
      Value<int>? workoutId,
      Value<DateTime>? completedAt,
      Value<double?>? distance,
      Value<int?>? duration}) {
    return WorkoutHistoryCompanion(
      id: id ?? this.id,
      workoutId: workoutId ?? this.workoutId,
      completedAt: completedAt ?? this.completedAt,
      distance: distance ?? this.distance,
      duration: duration ?? this.duration,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (workoutId.present) {
      map['workout_id'] = Variable<int>(workoutId.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (distance.present) {
      map['distance'] = Variable<double>(distance.value);
    }
    if (duration.present) {
      map['duration'] = Variable<int>(duration.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutHistoryCompanion(')
          ..write('id: $id, ')
          ..write('workoutId: $workoutId, ')
          ..write('completedAt: $completedAt, ')
          ..write('distance: $distance, ')
          ..write('duration: $duration')
          ..write(')'))
        .toString();
  }
}

class $IntervalHistoryTable extends IntervalHistory
    with TableInfo<$IntervalHistoryTable, IntervalHistoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IntervalHistoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _workoutHistoryIdMeta =
      const VerificationMeta('workoutHistoryId');
  @override
  late final GeneratedColumn<int> workoutHistoryId = GeneratedColumn<int>(
      'workout_history_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES workout_history (id)'));
  static const VerificationMeta _stepIdMeta = const VerificationMeta('stepId');
  @override
  late final GeneratedColumn<int> stepId = GeneratedColumn<int>(
      'step_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES step (id)'));
  static const VerificationMeta _stepNameMeta =
      const VerificationMeta('stepName');
  @override
  late final GeneratedColumn<String> stepName = GeneratedColumn<String>(
      'step_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _targetDurationMeta =
      const VerificationMeta('targetDuration');
  @override
  late final GeneratedColumn<int> targetDuration = GeneratedColumn<int>(
      'target_duration', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _actualDurationMeta =
      const VerificationMeta('actualDuration');
  @override
  late final GeneratedColumn<int> actualDuration = GeneratedColumn<int>(
      'actual_duration', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _targetDistanceMeta =
      const VerificationMeta('targetDistance');
  @override
  late final GeneratedColumn<int> targetDistance = GeneratedColumn<int>(
      'target_distance', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _actualDistanceMeta =
      const VerificationMeta('actualDistance');
  @override
  late final GeneratedColumn<int> actualDistance = GeneratedColumn<int>(
      'actual_distance', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _targetPaceMeta =
      const VerificationMeta('targetPace');
  @override
  late final GeneratedColumn<int> targetPace = GeneratedColumn<int>(
      'target_pace', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _actualPaceMeta =
      const VerificationMeta('actualPace');
  @override
  late final GeneratedColumn<int> actualPace = GeneratedColumn<int>(
      'actual_pace', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _orderIndexMeta =
      const VerificationMeta('orderIndex');
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
      'order_index', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        workoutHistoryId,
        stepId,
        stepName,
        targetDuration,
        actualDuration,
        targetDistance,
        actualDistance,
        targetPace,
        actualPace,
        orderIndex
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'interval_history';
  @override
  VerificationContext validateIntegrity(
      Insertable<IntervalHistoryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('workout_history_id')) {
      context.handle(
          _workoutHistoryIdMeta,
          workoutHistoryId.isAcceptableOrUnknown(
              data['workout_history_id']!, _workoutHistoryIdMeta));
    } else if (isInserting) {
      context.missing(_workoutHistoryIdMeta);
    }
    if (data.containsKey('step_id')) {
      context.handle(_stepIdMeta,
          stepId.isAcceptableOrUnknown(data['step_id']!, _stepIdMeta));
    }
    if (data.containsKey('step_name')) {
      context.handle(_stepNameMeta,
          stepName.isAcceptableOrUnknown(data['step_name']!, _stepNameMeta));
    } else if (isInserting) {
      context.missing(_stepNameMeta);
    }
    if (data.containsKey('target_duration')) {
      context.handle(
          _targetDurationMeta,
          targetDuration.isAcceptableOrUnknown(
              data['target_duration']!, _targetDurationMeta));
    }
    if (data.containsKey('actual_duration')) {
      context.handle(
          _actualDurationMeta,
          actualDuration.isAcceptableOrUnknown(
              data['actual_duration']!, _actualDurationMeta));
    }
    if (data.containsKey('target_distance')) {
      context.handle(
          _targetDistanceMeta,
          targetDistance.isAcceptableOrUnknown(
              data['target_distance']!, _targetDistanceMeta));
    }
    if (data.containsKey('actual_distance')) {
      context.handle(
          _actualDistanceMeta,
          actualDistance.isAcceptableOrUnknown(
              data['actual_distance']!, _actualDistanceMeta));
    }
    if (data.containsKey('target_pace')) {
      context.handle(
          _targetPaceMeta,
          targetPace.isAcceptableOrUnknown(
              data['target_pace']!, _targetPaceMeta));
    }
    if (data.containsKey('actual_pace')) {
      context.handle(
          _actualPaceMeta,
          actualPace.isAcceptableOrUnknown(
              data['actual_pace']!, _actualPaceMeta));
    }
    if (data.containsKey('order_index')) {
      context.handle(
          _orderIndexMeta,
          orderIndex.isAcceptableOrUnknown(
              data['order_index']!, _orderIndexMeta));
    } else if (isInserting) {
      context.missing(_orderIndexMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  IntervalHistoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IntervalHistoryData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      workoutHistoryId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}workout_history_id'])!,
      stepId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}step_id']),
      stepName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}step_name'])!,
      targetDuration: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}target_duration']),
      actualDuration: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}actual_duration']),
      targetDistance: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}target_distance']),
      actualDistance: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}actual_distance']),
      targetPace: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}target_pace']),
      actualPace: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}actual_pace']),
      orderIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order_index'])!,
    );
  }

  @override
  $IntervalHistoryTable createAlias(String alias) {
    return $IntervalHistoryTable(attachedDatabase, alias);
  }
}

class IntervalHistoryData extends DataClass
    implements Insertable<IntervalHistoryData> {
  final int id;
  final int workoutHistoryId;
  final int? stepId;
  final String stepName;
  final int? targetDuration;
  final int? actualDuration;
  final int? targetDistance;
  final int? actualDistance;
  final int? targetPace;
  final int? actualPace;
  final int orderIndex;
  const IntervalHistoryData(
      {required this.id,
      required this.workoutHistoryId,
      this.stepId,
      required this.stepName,
      this.targetDuration,
      this.actualDuration,
      this.targetDistance,
      this.actualDistance,
      this.targetPace,
      this.actualPace,
      required this.orderIndex});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['workout_history_id'] = Variable<int>(workoutHistoryId);
    if (!nullToAbsent || stepId != null) {
      map['step_id'] = Variable<int>(stepId);
    }
    map['step_name'] = Variable<String>(stepName);
    if (!nullToAbsent || targetDuration != null) {
      map['target_duration'] = Variable<int>(targetDuration);
    }
    if (!nullToAbsent || actualDuration != null) {
      map['actual_duration'] = Variable<int>(actualDuration);
    }
    if (!nullToAbsent || targetDistance != null) {
      map['target_distance'] = Variable<int>(targetDistance);
    }
    if (!nullToAbsent || actualDistance != null) {
      map['actual_distance'] = Variable<int>(actualDistance);
    }
    if (!nullToAbsent || targetPace != null) {
      map['target_pace'] = Variable<int>(targetPace);
    }
    if (!nullToAbsent || actualPace != null) {
      map['actual_pace'] = Variable<int>(actualPace);
    }
    map['order_index'] = Variable<int>(orderIndex);
    return map;
  }

  IntervalHistoryCompanion toCompanion(bool nullToAbsent) {
    return IntervalHistoryCompanion(
      id: Value(id),
      workoutHistoryId: Value(workoutHistoryId),
      stepId:
          stepId == null && nullToAbsent ? const Value.absent() : Value(stepId),
      stepName: Value(stepName),
      targetDuration: targetDuration == null && nullToAbsent
          ? const Value.absent()
          : Value(targetDuration),
      actualDuration: actualDuration == null && nullToAbsent
          ? const Value.absent()
          : Value(actualDuration),
      targetDistance: targetDistance == null && nullToAbsent
          ? const Value.absent()
          : Value(targetDistance),
      actualDistance: actualDistance == null && nullToAbsent
          ? const Value.absent()
          : Value(actualDistance),
      targetPace: targetPace == null && nullToAbsent
          ? const Value.absent()
          : Value(targetPace),
      actualPace: actualPace == null && nullToAbsent
          ? const Value.absent()
          : Value(actualPace),
      orderIndex: Value(orderIndex),
    );
  }

  factory IntervalHistoryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IntervalHistoryData(
      id: serializer.fromJson<int>(json['id']),
      workoutHistoryId: serializer.fromJson<int>(json['workoutHistoryId']),
      stepId: serializer.fromJson<int?>(json['stepId']),
      stepName: serializer.fromJson<String>(json['stepName']),
      targetDuration: serializer.fromJson<int?>(json['targetDuration']),
      actualDuration: serializer.fromJson<int?>(json['actualDuration']),
      targetDistance: serializer.fromJson<int?>(json['targetDistance']),
      actualDistance: serializer.fromJson<int?>(json['actualDistance']),
      targetPace: serializer.fromJson<int?>(json['targetPace']),
      actualPace: serializer.fromJson<int?>(json['actualPace']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'workoutHistoryId': serializer.toJson<int>(workoutHistoryId),
      'stepId': serializer.toJson<int?>(stepId),
      'stepName': serializer.toJson<String>(stepName),
      'targetDuration': serializer.toJson<int?>(targetDuration),
      'actualDuration': serializer.toJson<int?>(actualDuration),
      'targetDistance': serializer.toJson<int?>(targetDistance),
      'actualDistance': serializer.toJson<int?>(actualDistance),
      'targetPace': serializer.toJson<int?>(targetPace),
      'actualPace': serializer.toJson<int?>(actualPace),
      'orderIndex': serializer.toJson<int>(orderIndex),
    };
  }

  IntervalHistoryData copyWith(
          {int? id,
          int? workoutHistoryId,
          Value<int?> stepId = const Value.absent(),
          String? stepName,
          Value<int?> targetDuration = const Value.absent(),
          Value<int?> actualDuration = const Value.absent(),
          Value<int?> targetDistance = const Value.absent(),
          Value<int?> actualDistance = const Value.absent(),
          Value<int?> targetPace = const Value.absent(),
          Value<int?> actualPace = const Value.absent(),
          int? orderIndex}) =>
      IntervalHistoryData(
        id: id ?? this.id,
        workoutHistoryId: workoutHistoryId ?? this.workoutHistoryId,
        stepId: stepId.present ? stepId.value : this.stepId,
        stepName: stepName ?? this.stepName,
        targetDuration:
            targetDuration.present ? targetDuration.value : this.targetDuration,
        actualDuration:
            actualDuration.present ? actualDuration.value : this.actualDuration,
        targetDistance:
            targetDistance.present ? targetDistance.value : this.targetDistance,
        actualDistance:
            actualDistance.present ? actualDistance.value : this.actualDistance,
        targetPace: targetPace.present ? targetPace.value : this.targetPace,
        actualPace: actualPace.present ? actualPace.value : this.actualPace,
        orderIndex: orderIndex ?? this.orderIndex,
      );
  IntervalHistoryData copyWithCompanion(IntervalHistoryCompanion data) {
    return IntervalHistoryData(
      id: data.id.present ? data.id.value : this.id,
      workoutHistoryId: data.workoutHistoryId.present
          ? data.workoutHistoryId.value
          : this.workoutHistoryId,
      stepId: data.stepId.present ? data.stepId.value : this.stepId,
      stepName: data.stepName.present ? data.stepName.value : this.stepName,
      targetDuration: data.targetDuration.present
          ? data.targetDuration.value
          : this.targetDuration,
      actualDuration: data.actualDuration.present
          ? data.actualDuration.value
          : this.actualDuration,
      targetDistance: data.targetDistance.present
          ? data.targetDistance.value
          : this.targetDistance,
      actualDistance: data.actualDistance.present
          ? data.actualDistance.value
          : this.actualDistance,
      targetPace:
          data.targetPace.present ? data.targetPace.value : this.targetPace,
      actualPace:
          data.actualPace.present ? data.actualPace.value : this.actualPace,
      orderIndex:
          data.orderIndex.present ? data.orderIndex.value : this.orderIndex,
    );
  }

  @override
  String toString() {
    return (StringBuffer('IntervalHistoryData(')
          ..write('id: $id, ')
          ..write('workoutHistoryId: $workoutHistoryId, ')
          ..write('stepId: $stepId, ')
          ..write('stepName: $stepName, ')
          ..write('targetDuration: $targetDuration, ')
          ..write('actualDuration: $actualDuration, ')
          ..write('targetDistance: $targetDistance, ')
          ..write('actualDistance: $actualDistance, ')
          ..write('targetPace: $targetPace, ')
          ..write('actualPace: $actualPace, ')
          ..write('orderIndex: $orderIndex')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      workoutHistoryId,
      stepId,
      stepName,
      targetDuration,
      actualDuration,
      targetDistance,
      actualDistance,
      targetPace,
      actualPace,
      orderIndex);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IntervalHistoryData &&
          other.id == this.id &&
          other.workoutHistoryId == this.workoutHistoryId &&
          other.stepId == this.stepId &&
          other.stepName == this.stepName &&
          other.targetDuration == this.targetDuration &&
          other.actualDuration == this.actualDuration &&
          other.targetDistance == this.targetDistance &&
          other.actualDistance == this.actualDistance &&
          other.targetPace == this.targetPace &&
          other.actualPace == this.actualPace &&
          other.orderIndex == this.orderIndex);
}

class IntervalHistoryCompanion extends UpdateCompanion<IntervalHistoryData> {
  final Value<int> id;
  final Value<int> workoutHistoryId;
  final Value<int?> stepId;
  final Value<String> stepName;
  final Value<int?> targetDuration;
  final Value<int?> actualDuration;
  final Value<int?> targetDistance;
  final Value<int?> actualDistance;
  final Value<int?> targetPace;
  final Value<int?> actualPace;
  final Value<int> orderIndex;
  const IntervalHistoryCompanion({
    this.id = const Value.absent(),
    this.workoutHistoryId = const Value.absent(),
    this.stepId = const Value.absent(),
    this.stepName = const Value.absent(),
    this.targetDuration = const Value.absent(),
    this.actualDuration = const Value.absent(),
    this.targetDistance = const Value.absent(),
    this.actualDistance = const Value.absent(),
    this.targetPace = const Value.absent(),
    this.actualPace = const Value.absent(),
    this.orderIndex = const Value.absent(),
  });
  IntervalHistoryCompanion.insert({
    this.id = const Value.absent(),
    required int workoutHistoryId,
    this.stepId = const Value.absent(),
    required String stepName,
    this.targetDuration = const Value.absent(),
    this.actualDuration = const Value.absent(),
    this.targetDistance = const Value.absent(),
    this.actualDistance = const Value.absent(),
    this.targetPace = const Value.absent(),
    this.actualPace = const Value.absent(),
    required int orderIndex,
  })  : workoutHistoryId = Value(workoutHistoryId),
        stepName = Value(stepName),
        orderIndex = Value(orderIndex);
  static Insertable<IntervalHistoryData> custom({
    Expression<int>? id,
    Expression<int>? workoutHistoryId,
    Expression<int>? stepId,
    Expression<String>? stepName,
    Expression<int>? targetDuration,
    Expression<int>? actualDuration,
    Expression<int>? targetDistance,
    Expression<int>? actualDistance,
    Expression<int>? targetPace,
    Expression<int>? actualPace,
    Expression<int>? orderIndex,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workoutHistoryId != null) 'workout_history_id': workoutHistoryId,
      if (stepId != null) 'step_id': stepId,
      if (stepName != null) 'step_name': stepName,
      if (targetDuration != null) 'target_duration': targetDuration,
      if (actualDuration != null) 'actual_duration': actualDuration,
      if (targetDistance != null) 'target_distance': targetDistance,
      if (actualDistance != null) 'actual_distance': actualDistance,
      if (targetPace != null) 'target_pace': targetPace,
      if (actualPace != null) 'actual_pace': actualPace,
      if (orderIndex != null) 'order_index': orderIndex,
    });
  }

  IntervalHistoryCompanion copyWith(
      {Value<int>? id,
      Value<int>? workoutHistoryId,
      Value<int?>? stepId,
      Value<String>? stepName,
      Value<int?>? targetDuration,
      Value<int?>? actualDuration,
      Value<int?>? targetDistance,
      Value<int?>? actualDistance,
      Value<int?>? targetPace,
      Value<int?>? actualPace,
      Value<int>? orderIndex}) {
    return IntervalHistoryCompanion(
      id: id ?? this.id,
      workoutHistoryId: workoutHistoryId ?? this.workoutHistoryId,
      stepId: stepId ?? this.stepId,
      stepName: stepName ?? this.stepName,
      targetDuration: targetDuration ?? this.targetDuration,
      actualDuration: actualDuration ?? this.actualDuration,
      targetDistance: targetDistance ?? this.targetDistance,
      actualDistance: actualDistance ?? this.actualDistance,
      targetPace: targetPace ?? this.targetPace,
      actualPace: actualPace ?? this.actualPace,
      orderIndex: orderIndex ?? this.orderIndex,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (workoutHistoryId.present) {
      map['workout_history_id'] = Variable<int>(workoutHistoryId.value);
    }
    if (stepId.present) {
      map['step_id'] = Variable<int>(stepId.value);
    }
    if (stepName.present) {
      map['step_name'] = Variable<String>(stepName.value);
    }
    if (targetDuration.present) {
      map['target_duration'] = Variable<int>(targetDuration.value);
    }
    if (actualDuration.present) {
      map['actual_duration'] = Variable<int>(actualDuration.value);
    }
    if (targetDistance.present) {
      map['target_distance'] = Variable<int>(targetDistance.value);
    }
    if (actualDistance.present) {
      map['actual_distance'] = Variable<int>(actualDistance.value);
    }
    if (targetPace.present) {
      map['target_pace'] = Variable<int>(targetPace.value);
    }
    if (actualPace.present) {
      map['actual_pace'] = Variable<int>(actualPace.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IntervalHistoryCompanion(')
          ..write('id: $id, ')
          ..write('workoutHistoryId: $workoutHistoryId, ')
          ..write('stepId: $stepId, ')
          ..write('stepName: $stepName, ')
          ..write('targetDuration: $targetDuration, ')
          ..write('actualDuration: $actualDuration, ')
          ..write('targetDistance: $targetDistance, ')
          ..write('actualDistance: $actualDistance, ')
          ..write('targetPace: $targetPace, ')
          ..write('actualPace: $actualPace, ')
          ..write('orderIndex: $orderIndex')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $WorkoutTable workout = $WorkoutTable(this);
  late final $BlockTable block = $BlockTable(this);
  late final $StepTable step = $StepTable(this);
  late final $WorkoutHistoryTable workoutHistory = $WorkoutHistoryTable(this);
  late final $IntervalHistoryTable intervalHistory =
      $IntervalHistoryTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [workout, block, step, workoutHistory, intervalHistory];
}

typedef $$WorkoutTableCreateCompanionBuilder = WorkoutCompanion Function({
  Value<int> id,
  required String name,
  Value<String?> description,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
});
typedef $$WorkoutTableUpdateCompanionBuilder = WorkoutCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> description,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
});

final class $$WorkoutTableReferences
    extends BaseReferences<_$AppDatabase, $WorkoutTable, WorkoutData> {
  $$WorkoutTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BlockTable, List<BlockData>> _blockRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.block,
          aliasName: $_aliasNameGenerator(db.workout.id, db.block.workoutId));

  $$BlockTableProcessedTableManager get blockRefs {
    final manager = $$BlockTableTableManager($_db, $_db.block)
        .filter((f) => f.workoutId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_blockRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$WorkoutHistoryTable, List<WorkoutHistoryData>>
      _workoutHistoryRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.workoutHistory,
              aliasName: $_aliasNameGenerator(
                  db.workout.id, db.workoutHistory.workoutId));

  $$WorkoutHistoryTableProcessedTableManager get workoutHistoryRefs {
    final manager = $$WorkoutHistoryTableTableManager($_db, $_db.workoutHistory)
        .filter((f) => f.workoutId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_workoutHistoryRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$WorkoutTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutTable> {
  $$WorkoutTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> blockRefs(
      Expression<bool> Function($$BlockTableFilterComposer f) f) {
    final $$BlockTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.block,
        getReferencedColumn: (t) => t.workoutId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BlockTableFilterComposer(
              $db: $db,
              $table: $db.block,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> workoutHistoryRefs(
      Expression<bool> Function($$WorkoutHistoryTableFilterComposer f) f) {
    final $$WorkoutHistoryTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.workoutHistory,
        getReferencedColumn: (t) => t.workoutId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutHistoryTableFilterComposer(
              $db: $db,
              $table: $db.workoutHistory,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$WorkoutTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutTable> {
  $$WorkoutTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$WorkoutTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutTable> {
  $$WorkoutTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> blockRefs<T extends Object>(
      Expression<T> Function($$BlockTableAnnotationComposer a) f) {
    final $$BlockTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.block,
        getReferencedColumn: (t) => t.workoutId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BlockTableAnnotationComposer(
              $db: $db,
              $table: $db.block,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> workoutHistoryRefs<T extends Object>(
      Expression<T> Function($$WorkoutHistoryTableAnnotationComposer a) f) {
    final $$WorkoutHistoryTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.workoutHistory,
        getReferencedColumn: (t) => t.workoutId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutHistoryTableAnnotationComposer(
              $db: $db,
              $table: $db.workoutHistory,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$WorkoutTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WorkoutTable,
    WorkoutData,
    $$WorkoutTableFilterComposer,
    $$WorkoutTableOrderingComposer,
    $$WorkoutTableAnnotationComposer,
    $$WorkoutTableCreateCompanionBuilder,
    $$WorkoutTableUpdateCompanionBuilder,
    (WorkoutData, $$WorkoutTableReferences),
    WorkoutData,
    PrefetchHooks Function({bool blockRefs, bool workoutHistoryRefs})> {
  $$WorkoutTableTableManager(_$AppDatabase db, $WorkoutTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              WorkoutCompanion(
            id: id,
            name: name,
            description: description,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String?> description = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              WorkoutCompanion.insert(
            id: id,
            name: name,
            description: description,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$WorkoutTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {blockRefs = false, workoutHistoryRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (blockRefs) db.block,
                if (workoutHistoryRefs) db.workoutHistory
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (blockRefs)
                    await $_getPrefetchedData<WorkoutData, $WorkoutTable,
                            BlockData>(
                        currentTable: table,
                        referencedTable:
                            $$WorkoutTableReferences._blockRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$WorkoutTableReferences(db, table, p0).blockRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.workoutId == item.id),
                        typedResults: items),
                  if (workoutHistoryRefs)
                    await $_getPrefetchedData<WorkoutData, $WorkoutTable,
                            WorkoutHistoryData>(
                        currentTable: table,
                        referencedTable: $$WorkoutTableReferences
                            ._workoutHistoryRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$WorkoutTableReferences(db, table, p0)
                                .workoutHistoryRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.workoutId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$WorkoutTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WorkoutTable,
    WorkoutData,
    $$WorkoutTableFilterComposer,
    $$WorkoutTableOrderingComposer,
    $$WorkoutTableAnnotationComposer,
    $$WorkoutTableCreateCompanionBuilder,
    $$WorkoutTableUpdateCompanionBuilder,
    (WorkoutData, $$WorkoutTableReferences),
    WorkoutData,
    PrefetchHooks Function({bool blockRefs, bool workoutHistoryRefs})>;
typedef $$BlockTableCreateCompanionBuilder = BlockCompanion Function({
  Value<int> id,
  required String name,
  required int workoutId,
  required int order,
  Value<int> repeatCount,
});
typedef $$BlockTableUpdateCompanionBuilder = BlockCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<int> workoutId,
  Value<int> order,
  Value<int> repeatCount,
});

final class $$BlockTableReferences
    extends BaseReferences<_$AppDatabase, $BlockTable, BlockData> {
  $$BlockTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WorkoutTable _workoutIdTable(_$AppDatabase db) => db.workout
      .createAlias($_aliasNameGenerator(db.block.workoutId, db.workout.id));

  $$WorkoutTableProcessedTableManager get workoutId {
    final $_column = $_itemColumn<int>('workout_id')!;

    final manager = $$WorkoutTableTableManager($_db, $_db.workout)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_workoutIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$StepTable, List<StepData>> _stepRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.step,
          aliasName: $_aliasNameGenerator(db.block.id, db.step.blockId));

  $$StepTableProcessedTableManager get stepRefs {
    final manager = $$StepTableTableManager($_db, $_db.step)
        .filter((f) => f.blockId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_stepRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$BlockTableFilterComposer extends Composer<_$AppDatabase, $BlockTable> {
  $$BlockTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get order => $composableBuilder(
      column: $table.order, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get repeatCount => $composableBuilder(
      column: $table.repeatCount, builder: (column) => ColumnFilters(column));

  $$WorkoutTableFilterComposer get workoutId {
    final $$WorkoutTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workoutId,
        referencedTable: $db.workout,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutTableFilterComposer(
              $db: $db,
              $table: $db.workout,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> stepRefs(
      Expression<bool> Function($$StepTableFilterComposer f) f) {
    final $$StepTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.step,
        getReferencedColumn: (t) => t.blockId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StepTableFilterComposer(
              $db: $db,
              $table: $db.step,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$BlockTableOrderingComposer
    extends Composer<_$AppDatabase, $BlockTable> {
  $$BlockTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get order => $composableBuilder(
      column: $table.order, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get repeatCount => $composableBuilder(
      column: $table.repeatCount, builder: (column) => ColumnOrderings(column));

  $$WorkoutTableOrderingComposer get workoutId {
    final $$WorkoutTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workoutId,
        referencedTable: $db.workout,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutTableOrderingComposer(
              $db: $db,
              $table: $db.workout,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BlockTableAnnotationComposer
    extends Composer<_$AppDatabase, $BlockTable> {
  $$BlockTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  GeneratedColumn<int> get repeatCount => $composableBuilder(
      column: $table.repeatCount, builder: (column) => column);

  $$WorkoutTableAnnotationComposer get workoutId {
    final $$WorkoutTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workoutId,
        referencedTable: $db.workout,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutTableAnnotationComposer(
              $db: $db,
              $table: $db.workout,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> stepRefs<T extends Object>(
      Expression<T> Function($$StepTableAnnotationComposer a) f) {
    final $$StepTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.step,
        getReferencedColumn: (t) => t.blockId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StepTableAnnotationComposer(
              $db: $db,
              $table: $db.step,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$BlockTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BlockTable,
    BlockData,
    $$BlockTableFilterComposer,
    $$BlockTableOrderingComposer,
    $$BlockTableAnnotationComposer,
    $$BlockTableCreateCompanionBuilder,
    $$BlockTableUpdateCompanionBuilder,
    (BlockData, $$BlockTableReferences),
    BlockData,
    PrefetchHooks Function({bool workoutId, bool stepRefs})> {
  $$BlockTableTableManager(_$AppDatabase db, $BlockTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BlockTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BlockTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BlockTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> workoutId = const Value.absent(),
            Value<int> order = const Value.absent(),
            Value<int> repeatCount = const Value.absent(),
          }) =>
              BlockCompanion(
            id: id,
            name: name,
            workoutId: workoutId,
            order: order,
            repeatCount: repeatCount,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required int workoutId,
            required int order,
            Value<int> repeatCount = const Value.absent(),
          }) =>
              BlockCompanion.insert(
            id: id,
            name: name,
            workoutId: workoutId,
            order: order,
            repeatCount: repeatCount,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$BlockTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({workoutId = false, stepRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (stepRefs) db.step],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (workoutId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.workoutId,
                    referencedTable: $$BlockTableReferences._workoutIdTable(db),
                    referencedColumn:
                        $$BlockTableReferences._workoutIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (stepRefs)
                    await $_getPrefetchedData<BlockData, $BlockTable, StepData>(
                        currentTable: table,
                        referencedTable:
                            $$BlockTableReferences._stepRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$BlockTableReferences(db, table, p0).stepRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.blockId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$BlockTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BlockTable,
    BlockData,
    $$BlockTableFilterComposer,
    $$BlockTableOrderingComposer,
    $$BlockTableAnnotationComposer,
    $$BlockTableCreateCompanionBuilder,
    $$BlockTableUpdateCompanionBuilder,
    (BlockData, $$BlockTableReferences),
    BlockData,
    PrefetchHooks Function({bool workoutId, bool stepRefs})>;
typedef $$StepTableCreateCompanionBuilder = StepCompanion Function({
  Value<int> id,
  required String name,
  required String stepType,
  required int blockId,
  required int order,
  required int durationSeconds,
  Value<double?> targetSpeed,
  Value<double?> targetDistance,
  required int orderIndex,
});
typedef $$StepTableUpdateCompanionBuilder = StepCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> stepType,
  Value<int> blockId,
  Value<int> order,
  Value<int> durationSeconds,
  Value<double?> targetSpeed,
  Value<double?> targetDistance,
  Value<int> orderIndex,
});

final class $$StepTableReferences
    extends BaseReferences<_$AppDatabase, $StepTable, StepData> {
  $$StepTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BlockTable _blockIdTable(_$AppDatabase db) =>
      db.block.createAlias($_aliasNameGenerator(db.step.blockId, db.block.id));

  $$BlockTableProcessedTableManager get blockId {
    final $_column = $_itemColumn<int>('block_id')!;

    final manager = $$BlockTableTableManager($_db, $_db.block)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_blockIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$IntervalHistoryTable, List<IntervalHistoryData>>
      _intervalHistoryRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.intervalHistory,
              aliasName:
                  $_aliasNameGenerator(db.step.id, db.intervalHistory.stepId));

  $$IntervalHistoryTableProcessedTableManager get intervalHistoryRefs {
    final manager =
        $$IntervalHistoryTableTableManager($_db, $_db.intervalHistory)
            .filter((f) => f.stepId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_intervalHistoryRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$StepTableFilterComposer extends Composer<_$AppDatabase, $StepTable> {
  $$StepTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get stepType => $composableBuilder(
      column: $table.stepType, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get order => $composableBuilder(
      column: $table.order, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationSeconds => $composableBuilder(
      column: $table.durationSeconds,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get targetSpeed => $composableBuilder(
      column: $table.targetSpeed, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get targetDistance => $composableBuilder(
      column: $table.targetDistance,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get orderIndex => $composableBuilder(
      column: $table.orderIndex, builder: (column) => ColumnFilters(column));

  $$BlockTableFilterComposer get blockId {
    final $$BlockTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.blockId,
        referencedTable: $db.block,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BlockTableFilterComposer(
              $db: $db,
              $table: $db.block,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> intervalHistoryRefs(
      Expression<bool> Function($$IntervalHistoryTableFilterComposer f) f) {
    final $$IntervalHistoryTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.intervalHistory,
        getReferencedColumn: (t) => t.stepId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$IntervalHistoryTableFilterComposer(
              $db: $db,
              $table: $db.intervalHistory,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$StepTableOrderingComposer extends Composer<_$AppDatabase, $StepTable> {
  $$StepTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get stepType => $composableBuilder(
      column: $table.stepType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get order => $composableBuilder(
      column: $table.order, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
      column: $table.durationSeconds,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get targetSpeed => $composableBuilder(
      column: $table.targetSpeed, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get targetDistance => $composableBuilder(
      column: $table.targetDistance,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get orderIndex => $composableBuilder(
      column: $table.orderIndex, builder: (column) => ColumnOrderings(column));

  $$BlockTableOrderingComposer get blockId {
    final $$BlockTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.blockId,
        referencedTable: $db.block,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BlockTableOrderingComposer(
              $db: $db,
              $table: $db.block,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$StepTableAnnotationComposer
    extends Composer<_$AppDatabase, $StepTable> {
  $$StepTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get stepType =>
      $composableBuilder(column: $table.stepType, builder: (column) => column);

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
      column: $table.durationSeconds, builder: (column) => column);

  GeneratedColumn<double> get targetSpeed => $composableBuilder(
      column: $table.targetSpeed, builder: (column) => column);

  GeneratedColumn<double> get targetDistance => $composableBuilder(
      column: $table.targetDistance, builder: (column) => column);

  GeneratedColumn<int> get orderIndex => $composableBuilder(
      column: $table.orderIndex, builder: (column) => column);

  $$BlockTableAnnotationComposer get blockId {
    final $$BlockTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.blockId,
        referencedTable: $db.block,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BlockTableAnnotationComposer(
              $db: $db,
              $table: $db.block,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> intervalHistoryRefs<T extends Object>(
      Expression<T> Function($$IntervalHistoryTableAnnotationComposer a) f) {
    final $$IntervalHistoryTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.intervalHistory,
        getReferencedColumn: (t) => t.stepId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$IntervalHistoryTableAnnotationComposer(
              $db: $db,
              $table: $db.intervalHistory,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$StepTableTableManager extends RootTableManager<
    _$AppDatabase,
    $StepTable,
    StepData,
    $$StepTableFilterComposer,
    $$StepTableOrderingComposer,
    $$StepTableAnnotationComposer,
    $$StepTableCreateCompanionBuilder,
    $$StepTableUpdateCompanionBuilder,
    (StepData, $$StepTableReferences),
    StepData,
    PrefetchHooks Function({bool blockId, bool intervalHistoryRefs})> {
  $$StepTableTableManager(_$AppDatabase db, $StepTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StepTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StepTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StepTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> stepType = const Value.absent(),
            Value<int> blockId = const Value.absent(),
            Value<int> order = const Value.absent(),
            Value<int> durationSeconds = const Value.absent(),
            Value<double?> targetSpeed = const Value.absent(),
            Value<double?> targetDistance = const Value.absent(),
            Value<int> orderIndex = const Value.absent(),
          }) =>
              StepCompanion(
            id: id,
            name: name,
            stepType: stepType,
            blockId: blockId,
            order: order,
            durationSeconds: durationSeconds,
            targetSpeed: targetSpeed,
            targetDistance: targetDistance,
            orderIndex: orderIndex,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String stepType,
            required int blockId,
            required int order,
            required int durationSeconds,
            Value<double?> targetSpeed = const Value.absent(),
            Value<double?> targetDistance = const Value.absent(),
            required int orderIndex,
          }) =>
              StepCompanion.insert(
            id: id,
            name: name,
            stepType: stepType,
            blockId: blockId,
            order: order,
            durationSeconds: durationSeconds,
            targetSpeed: targetSpeed,
            targetDistance: targetDistance,
            orderIndex: orderIndex,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$StepTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {blockId = false, intervalHistoryRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (intervalHistoryRefs) db.intervalHistory
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (blockId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.blockId,
                    referencedTable: $$StepTableReferences._blockIdTable(db),
                    referencedColumn:
                        $$StepTableReferences._blockIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (intervalHistoryRefs)
                    await $_getPrefetchedData<StepData, $StepTable,
                            IntervalHistoryData>(
                        currentTable: table,
                        referencedTable:
                            $$StepTableReferences._intervalHistoryRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$StepTableReferences(db, table, p0)
                                .intervalHistoryRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.stepId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$StepTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $StepTable,
    StepData,
    $$StepTableFilterComposer,
    $$StepTableOrderingComposer,
    $$StepTableAnnotationComposer,
    $$StepTableCreateCompanionBuilder,
    $$StepTableUpdateCompanionBuilder,
    (StepData, $$StepTableReferences),
    StepData,
    PrefetchHooks Function({bool blockId, bool intervalHistoryRefs})>;
typedef $$WorkoutHistoryTableCreateCompanionBuilder = WorkoutHistoryCompanion
    Function({
  Value<int> id,
  required int workoutId,
  Value<DateTime> completedAt,
  Value<double?> distance,
  Value<int?> duration,
});
typedef $$WorkoutHistoryTableUpdateCompanionBuilder = WorkoutHistoryCompanion
    Function({
  Value<int> id,
  Value<int> workoutId,
  Value<DateTime> completedAt,
  Value<double?> distance,
  Value<int?> duration,
});

final class $$WorkoutHistoryTableReferences extends BaseReferences<
    _$AppDatabase, $WorkoutHistoryTable, WorkoutHistoryData> {
  $$WorkoutHistoryTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $WorkoutTable _workoutIdTable(_$AppDatabase db) =>
      db.workout.createAlias(
          $_aliasNameGenerator(db.workoutHistory.workoutId, db.workout.id));

  $$WorkoutTableProcessedTableManager get workoutId {
    final $_column = $_itemColumn<int>('workout_id')!;

    final manager = $$WorkoutTableTableManager($_db, $_db.workout)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_workoutIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$IntervalHistoryTable, List<IntervalHistoryData>>
      _intervalHistoryRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.intervalHistory,
              aliasName: $_aliasNameGenerator(
                  db.workoutHistory.id, db.intervalHistory.workoutHistoryId));

  $$IntervalHistoryTableProcessedTableManager get intervalHistoryRefs {
    final manager =
        $$IntervalHistoryTableTableManager($_db, $_db.intervalHistory).filter(
            (f) => f.workoutHistoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_intervalHistoryRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$WorkoutHistoryTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutHistoryTable> {
  $$WorkoutHistoryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get distance => $composableBuilder(
      column: $table.distance, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get duration => $composableBuilder(
      column: $table.duration, builder: (column) => ColumnFilters(column));

  $$WorkoutTableFilterComposer get workoutId {
    final $$WorkoutTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workoutId,
        referencedTable: $db.workout,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutTableFilterComposer(
              $db: $db,
              $table: $db.workout,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> intervalHistoryRefs(
      Expression<bool> Function($$IntervalHistoryTableFilterComposer f) f) {
    final $$IntervalHistoryTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.intervalHistory,
        getReferencedColumn: (t) => t.workoutHistoryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$IntervalHistoryTableFilterComposer(
              $db: $db,
              $table: $db.intervalHistory,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$WorkoutHistoryTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutHistoryTable> {
  $$WorkoutHistoryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get distance => $composableBuilder(
      column: $table.distance, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get duration => $composableBuilder(
      column: $table.duration, builder: (column) => ColumnOrderings(column));

  $$WorkoutTableOrderingComposer get workoutId {
    final $$WorkoutTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workoutId,
        referencedTable: $db.workout,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutTableOrderingComposer(
              $db: $db,
              $table: $db.workout,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WorkoutHistoryTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutHistoryTable> {
  $$WorkoutHistoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => column);

  GeneratedColumn<double> get distance =>
      $composableBuilder(column: $table.distance, builder: (column) => column);

  GeneratedColumn<int> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  $$WorkoutTableAnnotationComposer get workoutId {
    final $$WorkoutTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workoutId,
        referencedTable: $db.workout,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutTableAnnotationComposer(
              $db: $db,
              $table: $db.workout,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> intervalHistoryRefs<T extends Object>(
      Expression<T> Function($$IntervalHistoryTableAnnotationComposer a) f) {
    final $$IntervalHistoryTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.intervalHistory,
        getReferencedColumn: (t) => t.workoutHistoryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$IntervalHistoryTableAnnotationComposer(
              $db: $db,
              $table: $db.intervalHistory,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$WorkoutHistoryTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WorkoutHistoryTable,
    WorkoutHistoryData,
    $$WorkoutHistoryTableFilterComposer,
    $$WorkoutHistoryTableOrderingComposer,
    $$WorkoutHistoryTableAnnotationComposer,
    $$WorkoutHistoryTableCreateCompanionBuilder,
    $$WorkoutHistoryTableUpdateCompanionBuilder,
    (WorkoutHistoryData, $$WorkoutHistoryTableReferences),
    WorkoutHistoryData,
    PrefetchHooks Function({bool workoutId, bool intervalHistoryRefs})> {
  $$WorkoutHistoryTableTableManager(
      _$AppDatabase db, $WorkoutHistoryTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutHistoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutHistoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutHistoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> workoutId = const Value.absent(),
            Value<DateTime> completedAt = const Value.absent(),
            Value<double?> distance = const Value.absent(),
            Value<int?> duration = const Value.absent(),
          }) =>
              WorkoutHistoryCompanion(
            id: id,
            workoutId: workoutId,
            completedAt: completedAt,
            distance: distance,
            duration: duration,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int workoutId,
            Value<DateTime> completedAt = const Value.absent(),
            Value<double?> distance = const Value.absent(),
            Value<int?> duration = const Value.absent(),
          }) =>
              WorkoutHistoryCompanion.insert(
            id: id,
            workoutId: workoutId,
            completedAt: completedAt,
            distance: distance,
            duration: duration,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$WorkoutHistoryTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {workoutId = false, intervalHistoryRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (intervalHistoryRefs) db.intervalHistory
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (workoutId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.workoutId,
                    referencedTable:
                        $$WorkoutHistoryTableReferences._workoutIdTable(db),
                    referencedColumn:
                        $$WorkoutHistoryTableReferences._workoutIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (intervalHistoryRefs)
                    await $_getPrefetchedData<WorkoutHistoryData,
                            $WorkoutHistoryTable, IntervalHistoryData>(
                        currentTable: table,
                        referencedTable: $$WorkoutHistoryTableReferences
                            ._intervalHistoryRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$WorkoutHistoryTableReferences(db, table, p0)
                                .intervalHistoryRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.workoutHistoryId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$WorkoutHistoryTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WorkoutHistoryTable,
    WorkoutHistoryData,
    $$WorkoutHistoryTableFilterComposer,
    $$WorkoutHistoryTableOrderingComposer,
    $$WorkoutHistoryTableAnnotationComposer,
    $$WorkoutHistoryTableCreateCompanionBuilder,
    $$WorkoutHistoryTableUpdateCompanionBuilder,
    (WorkoutHistoryData, $$WorkoutHistoryTableReferences),
    WorkoutHistoryData,
    PrefetchHooks Function({bool workoutId, bool intervalHistoryRefs})>;
typedef $$IntervalHistoryTableCreateCompanionBuilder = IntervalHistoryCompanion
    Function({
  Value<int> id,
  required int workoutHistoryId,
  Value<int?> stepId,
  required String stepName,
  Value<int?> targetDuration,
  Value<int?> actualDuration,
  Value<int?> targetDistance,
  Value<int?> actualDistance,
  Value<int?> targetPace,
  Value<int?> actualPace,
  required int orderIndex,
});
typedef $$IntervalHistoryTableUpdateCompanionBuilder = IntervalHistoryCompanion
    Function({
  Value<int> id,
  Value<int> workoutHistoryId,
  Value<int?> stepId,
  Value<String> stepName,
  Value<int?> targetDuration,
  Value<int?> actualDuration,
  Value<int?> targetDistance,
  Value<int?> actualDistance,
  Value<int?> targetPace,
  Value<int?> actualPace,
  Value<int> orderIndex,
});

final class $$IntervalHistoryTableReferences extends BaseReferences<
    _$AppDatabase, $IntervalHistoryTable, IntervalHistoryData> {
  $$IntervalHistoryTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $WorkoutHistoryTable _workoutHistoryIdTable(_$AppDatabase db) =>
      db.workoutHistory.createAlias($_aliasNameGenerator(
          db.intervalHistory.workoutHistoryId, db.workoutHistory.id));

  $$WorkoutHistoryTableProcessedTableManager get workoutHistoryId {
    final $_column = $_itemColumn<int>('workout_history_id')!;

    final manager = $$WorkoutHistoryTableTableManager($_db, $_db.workoutHistory)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_workoutHistoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $StepTable _stepIdTable(_$AppDatabase db) => db.step
      .createAlias($_aliasNameGenerator(db.intervalHistory.stepId, db.step.id));

  $$StepTableProcessedTableManager? get stepId {
    final $_column = $_itemColumn<int>('step_id');
    if ($_column == null) return null;
    final manager = $$StepTableTableManager($_db, $_db.step)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_stepIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$IntervalHistoryTableFilterComposer
    extends Composer<_$AppDatabase, $IntervalHistoryTable> {
  $$IntervalHistoryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get stepName => $composableBuilder(
      column: $table.stepName, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get targetDuration => $composableBuilder(
      column: $table.targetDuration,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get actualDuration => $composableBuilder(
      column: $table.actualDuration,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get targetDistance => $composableBuilder(
      column: $table.targetDistance,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get actualDistance => $composableBuilder(
      column: $table.actualDistance,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get targetPace => $composableBuilder(
      column: $table.targetPace, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get actualPace => $composableBuilder(
      column: $table.actualPace, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get orderIndex => $composableBuilder(
      column: $table.orderIndex, builder: (column) => ColumnFilters(column));

  $$WorkoutHistoryTableFilterComposer get workoutHistoryId {
    final $$WorkoutHistoryTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workoutHistoryId,
        referencedTable: $db.workoutHistory,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutHistoryTableFilterComposer(
              $db: $db,
              $table: $db.workoutHistory,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$StepTableFilterComposer get stepId {
    final $$StepTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.stepId,
        referencedTable: $db.step,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StepTableFilterComposer(
              $db: $db,
              $table: $db.step,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$IntervalHistoryTableOrderingComposer
    extends Composer<_$AppDatabase, $IntervalHistoryTable> {
  $$IntervalHistoryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get stepName => $composableBuilder(
      column: $table.stepName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get targetDuration => $composableBuilder(
      column: $table.targetDuration,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get actualDuration => $composableBuilder(
      column: $table.actualDuration,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get targetDistance => $composableBuilder(
      column: $table.targetDistance,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get actualDistance => $composableBuilder(
      column: $table.actualDistance,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get targetPace => $composableBuilder(
      column: $table.targetPace, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get actualPace => $composableBuilder(
      column: $table.actualPace, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get orderIndex => $composableBuilder(
      column: $table.orderIndex, builder: (column) => ColumnOrderings(column));

  $$WorkoutHistoryTableOrderingComposer get workoutHistoryId {
    final $$WorkoutHistoryTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workoutHistoryId,
        referencedTable: $db.workoutHistory,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutHistoryTableOrderingComposer(
              $db: $db,
              $table: $db.workoutHistory,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$StepTableOrderingComposer get stepId {
    final $$StepTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.stepId,
        referencedTable: $db.step,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StepTableOrderingComposer(
              $db: $db,
              $table: $db.step,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$IntervalHistoryTableAnnotationComposer
    extends Composer<_$AppDatabase, $IntervalHistoryTable> {
  $$IntervalHistoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get stepName =>
      $composableBuilder(column: $table.stepName, builder: (column) => column);

  GeneratedColumn<int> get targetDuration => $composableBuilder(
      column: $table.targetDuration, builder: (column) => column);

  GeneratedColumn<int> get actualDuration => $composableBuilder(
      column: $table.actualDuration, builder: (column) => column);

  GeneratedColumn<int> get targetDistance => $composableBuilder(
      column: $table.targetDistance, builder: (column) => column);

  GeneratedColumn<int> get actualDistance => $composableBuilder(
      column: $table.actualDistance, builder: (column) => column);

  GeneratedColumn<int> get targetPace => $composableBuilder(
      column: $table.targetPace, builder: (column) => column);

  GeneratedColumn<int> get actualPace => $composableBuilder(
      column: $table.actualPace, builder: (column) => column);

  GeneratedColumn<int> get orderIndex => $composableBuilder(
      column: $table.orderIndex, builder: (column) => column);

  $$WorkoutHistoryTableAnnotationComposer get workoutHistoryId {
    final $$WorkoutHistoryTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.workoutHistoryId,
        referencedTable: $db.workoutHistory,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WorkoutHistoryTableAnnotationComposer(
              $db: $db,
              $table: $db.workoutHistory,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$StepTableAnnotationComposer get stepId {
    final $$StepTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.stepId,
        referencedTable: $db.step,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StepTableAnnotationComposer(
              $db: $db,
              $table: $db.step,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$IntervalHistoryTableTableManager extends RootTableManager<
    _$AppDatabase,
    $IntervalHistoryTable,
    IntervalHistoryData,
    $$IntervalHistoryTableFilterComposer,
    $$IntervalHistoryTableOrderingComposer,
    $$IntervalHistoryTableAnnotationComposer,
    $$IntervalHistoryTableCreateCompanionBuilder,
    $$IntervalHistoryTableUpdateCompanionBuilder,
    (IntervalHistoryData, $$IntervalHistoryTableReferences),
    IntervalHistoryData,
    PrefetchHooks Function({bool workoutHistoryId, bool stepId})> {
  $$IntervalHistoryTableTableManager(
      _$AppDatabase db, $IntervalHistoryTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IntervalHistoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IntervalHistoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IntervalHistoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> workoutHistoryId = const Value.absent(),
            Value<int?> stepId = const Value.absent(),
            Value<String> stepName = const Value.absent(),
            Value<int?> targetDuration = const Value.absent(),
            Value<int?> actualDuration = const Value.absent(),
            Value<int?> targetDistance = const Value.absent(),
            Value<int?> actualDistance = const Value.absent(),
            Value<int?> targetPace = const Value.absent(),
            Value<int?> actualPace = const Value.absent(),
            Value<int> orderIndex = const Value.absent(),
          }) =>
              IntervalHistoryCompanion(
            id: id,
            workoutHistoryId: workoutHistoryId,
            stepId: stepId,
            stepName: stepName,
            targetDuration: targetDuration,
            actualDuration: actualDuration,
            targetDistance: targetDistance,
            actualDistance: actualDistance,
            targetPace: targetPace,
            actualPace: actualPace,
            orderIndex: orderIndex,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int workoutHistoryId,
            Value<int?> stepId = const Value.absent(),
            required String stepName,
            Value<int?> targetDuration = const Value.absent(),
            Value<int?> actualDuration = const Value.absent(),
            Value<int?> targetDistance = const Value.absent(),
            Value<int?> actualDistance = const Value.absent(),
            Value<int?> targetPace = const Value.absent(),
            Value<int?> actualPace = const Value.absent(),
            required int orderIndex,
          }) =>
              IntervalHistoryCompanion.insert(
            id: id,
            workoutHistoryId: workoutHistoryId,
            stepId: stepId,
            stepName: stepName,
            targetDuration: targetDuration,
            actualDuration: actualDuration,
            targetDistance: targetDistance,
            actualDistance: actualDistance,
            targetPace: targetPace,
            actualPace: actualPace,
            orderIndex: orderIndex,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$IntervalHistoryTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({workoutHistoryId = false, stepId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (workoutHistoryId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.workoutHistoryId,
                    referencedTable: $$IntervalHistoryTableReferences
                        ._workoutHistoryIdTable(db),
                    referencedColumn: $$IntervalHistoryTableReferences
                        ._workoutHistoryIdTable(db)
                        .id,
                  ) as T;
                }
                if (stepId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.stepId,
                    referencedTable:
                        $$IntervalHistoryTableReferences._stepIdTable(db),
                    referencedColumn:
                        $$IntervalHistoryTableReferences._stepIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$IntervalHistoryTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $IntervalHistoryTable,
    IntervalHistoryData,
    $$IntervalHistoryTableFilterComposer,
    $$IntervalHistoryTableOrderingComposer,
    $$IntervalHistoryTableAnnotationComposer,
    $$IntervalHistoryTableCreateCompanionBuilder,
    $$IntervalHistoryTableUpdateCompanionBuilder,
    (IntervalHistoryData, $$IntervalHistoryTableReferences),
    IntervalHistoryData,
    PrefetchHooks Function({bool workoutHistoryId, bool stepId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$WorkoutTableTableManager get workout =>
      $$WorkoutTableTableManager(_db, _db.workout);
  $$BlockTableTableManager get block =>
      $$BlockTableTableManager(_db, _db.block);
  $$StepTableTableManager get step => $$StepTableTableManager(_db, _db.step);
  $$WorkoutHistoryTableTableManager get workoutHistory =>
      $$WorkoutHistoryTableTableManager(_db, _db.workoutHistory);
  $$IntervalHistoryTableTableManager get intervalHistory =>
      $$IntervalHistoryTableTableManager(_db, _db.intervalHistory);
}
