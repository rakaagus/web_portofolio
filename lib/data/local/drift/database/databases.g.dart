// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'databases.dart';

// ignore_for_file: type=lint
class $PortoEntityTable extends PortoEntity
    with TableInfo<$PortoEntityTable, portos> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PortoEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _platformMeta = const VerificationMeta(
    'platform',
  );
  @override
  late final GeneratedColumn<String> platform = GeneratedColumn<String>(
    'platform',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stackMeta = const VerificationMeta('stack');
  @override
  late final GeneratedColumn<String> stack = GeneratedColumn<String>(
    'stack',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createDateMeta = const VerificationMeta(
    'createDate',
  );
  @override
  late final GeneratedColumn<DateTime> createDate = GeneratedColumn<DateTime>(
    'create_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _linkMeta = const VerificationMeta('link');
  @override
  late final GeneratedColumn<String> link = GeneratedColumn<String>(
    'link',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    platform,
    stack,
    createDate,
    link,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'porto_entity';
  @override
  VerificationContext validateIntegrity(
    Insertable<portos> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('platform')) {
      context.handle(
        _platformMeta,
        platform.isAcceptableOrUnknown(data['platform']!, _platformMeta),
      );
    } else if (isInserting) {
      context.missing(_platformMeta);
    }
    if (data.containsKey('stack')) {
      context.handle(
        _stackMeta,
        stack.isAcceptableOrUnknown(data['stack']!, _stackMeta),
      );
    } else if (isInserting) {
      context.missing(_stackMeta);
    }
    if (data.containsKey('create_date')) {
      context.handle(
        _createDateMeta,
        createDate.isAcceptableOrUnknown(data['create_date']!, _createDateMeta),
      );
    } else if (isInserting) {
      context.missing(_createDateMeta);
    }
    if (data.containsKey('link')) {
      context.handle(
        _linkMeta,
        link.isAcceptableOrUnknown(data['link']!, _linkMeta),
      );
    } else if (isInserting) {
      context.missing(_linkMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  portos map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return portos(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      title:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}title'],
          )!,
      description:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}description'],
          )!,
      platform:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}platform'],
          )!,
      stack:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}stack'],
          )!,
      createDate:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}create_date'],
          )!,
      link:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}link'],
          )!,
    );
  }

  @override
  $PortoEntityTable createAlias(String alias) {
    return $PortoEntityTable(attachedDatabase, alias);
  }
}

class portos extends DataClass implements Insertable<portos> {
  final int id;
  final String title;
  final String description;
  final String platform;
  final String stack;
  final DateTime createDate;
  final String link;
  const portos({
    required this.id,
    required this.title,
    required this.description,
    required this.platform,
    required this.stack,
    required this.createDate,
    required this.link,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['platform'] = Variable<String>(platform);
    map['stack'] = Variable<String>(stack);
    map['create_date'] = Variable<DateTime>(createDate);
    map['link'] = Variable<String>(link);
    return map;
  }

  PortoEntityCompanion toCompanion(bool nullToAbsent) {
    return PortoEntityCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
      platform: Value(platform),
      stack: Value(stack),
      createDate: Value(createDate),
      link: Value(link),
    );
  }

  factory portos.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return portos(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      platform: serializer.fromJson<String>(json['platform']),
      stack: serializer.fromJson<String>(json['stack']),
      createDate: serializer.fromJson<DateTime>(json['createDate']),
      link: serializer.fromJson<String>(json['link']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'platform': serializer.toJson<String>(platform),
      'stack': serializer.toJson<String>(stack),
      'createDate': serializer.toJson<DateTime>(createDate),
      'link': serializer.toJson<String>(link),
    };
  }

  portos copyWith({
    int? id,
    String? title,
    String? description,
    String? platform,
    String? stack,
    DateTime? createDate,
    String? link,
  }) => portos(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    platform: platform ?? this.platform,
    stack: stack ?? this.stack,
    createDate: createDate ?? this.createDate,
    link: link ?? this.link,
  );
  portos copyWithCompanion(PortoEntityCompanion data) {
    return portos(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      platform: data.platform.present ? data.platform.value : this.platform,
      stack: data.stack.present ? data.stack.value : this.stack,
      createDate:
          data.createDate.present ? data.createDate.value : this.createDate,
      link: data.link.present ? data.link.value : this.link,
    );
  }

  @override
  String toString() {
    return (StringBuffer('portos(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('platform: $platform, ')
          ..write('stack: $stack, ')
          ..write('createDate: $createDate, ')
          ..write('link: $link')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, description, platform, stack, createDate, link);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is portos &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.platform == this.platform &&
          other.stack == this.stack &&
          other.createDate == this.createDate &&
          other.link == this.link);
}

class PortoEntityCompanion extends UpdateCompanion<portos> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> description;
  final Value<String> platform;
  final Value<String> stack;
  final Value<DateTime> createDate;
  final Value<String> link;
  const PortoEntityCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.platform = const Value.absent(),
    this.stack = const Value.absent(),
    this.createDate = const Value.absent(),
    this.link = const Value.absent(),
  });
  PortoEntityCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String description,
    required String platform,
    required String stack,
    required DateTime createDate,
    required String link,
  }) : title = Value(title),
       description = Value(description),
       platform = Value(platform),
       stack = Value(stack),
       createDate = Value(createDate),
       link = Value(link);
  static Insertable<portos> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? platform,
    Expression<String>? stack,
    Expression<DateTime>? createDate,
    Expression<String>? link,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (platform != null) 'platform': platform,
      if (stack != null) 'stack': stack,
      if (createDate != null) 'create_date': createDate,
      if (link != null) 'link': link,
    });
  }

  PortoEntityCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? description,
    Value<String>? platform,
    Value<String>? stack,
    Value<DateTime>? createDate,
    Value<String>? link,
  }) {
    return PortoEntityCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      platform: platform ?? this.platform,
      stack: stack ?? this.stack,
      createDate: createDate ?? this.createDate,
      link: link ?? this.link,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (platform.present) {
      map['platform'] = Variable<String>(platform.value);
    }
    if (stack.present) {
      map['stack'] = Variable<String>(stack.value);
    }
    if (createDate.present) {
      map['create_date'] = Variable<DateTime>(createDate.value);
    }
    if (link.present) {
      map['link'] = Variable<String>(link.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PortoEntityCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('platform: $platform, ')
          ..write('stack: $stack, ')
          ..write('createDate: $createDate, ')
          ..write('link: $link')
          ..write(')'))
        .toString();
  }
}

class $EducationEntityTable extends EducationEntity
    with TableInfo<$EducationEntityTable, educations> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EducationEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _eduNameMeta = const VerificationMeta(
    'eduName',
  );
  @override
  late final GeneratedColumn<String> eduName = GeneratedColumn<String>(
    'edu_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
    'end_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hasFinishedMeta = const VerificationMeta(
    'hasFinished',
  );
  @override
  late final GeneratedColumn<bool> hasFinished = GeneratedColumn<bool>(
    'has_finished',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has_finished" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    eduName,
    description,
    startDate,
    endDate,
    hasFinished,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'education_entity';
  @override
  VerificationContext validateIntegrity(
    Insertable<educations> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('edu_name')) {
      context.handle(
        _eduNameMeta,
        eduName.isAcceptableOrUnknown(data['edu_name']!, _eduNameMeta),
      );
    } else if (isInserting) {
      context.missing(_eduNameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    } else if (isInserting) {
      context.missing(_endDateMeta);
    }
    if (data.containsKey('has_finished')) {
      context.handle(
        _hasFinishedMeta,
        hasFinished.isAcceptableOrUnknown(
          data['has_finished']!,
          _hasFinishedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  educations map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return educations(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      eduName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}edu_name'],
          )!,
      description:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}description'],
          )!,
      startDate:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}start_date'],
          )!,
      endDate:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}end_date'],
          )!,
      hasFinished:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}has_finished'],
          )!,
    );
  }

  @override
  $EducationEntityTable createAlias(String alias) {
    return $EducationEntityTable(attachedDatabase, alias);
  }
}

class educations extends DataClass implements Insertable<educations> {
  final int id;
  final String eduName;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final bool hasFinished;
  const educations({
    required this.id,
    required this.eduName,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.hasFinished,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['edu_name'] = Variable<String>(eduName);
    map['description'] = Variable<String>(description);
    map['start_date'] = Variable<DateTime>(startDate);
    map['end_date'] = Variable<DateTime>(endDate);
    map['has_finished'] = Variable<bool>(hasFinished);
    return map;
  }

  EducationEntityCompanion toCompanion(bool nullToAbsent) {
    return EducationEntityCompanion(
      id: Value(id),
      eduName: Value(eduName),
      description: Value(description),
      startDate: Value(startDate),
      endDate: Value(endDate),
      hasFinished: Value(hasFinished),
    );
  }

  factory educations.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return educations(
      id: serializer.fromJson<int>(json['id']),
      eduName: serializer.fromJson<String>(json['eduName']),
      description: serializer.fromJson<String>(json['description']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime>(json['endDate']),
      hasFinished: serializer.fromJson<bool>(json['hasFinished']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'eduName': serializer.toJson<String>(eduName),
      'description': serializer.toJson<String>(description),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime>(endDate),
      'hasFinished': serializer.toJson<bool>(hasFinished),
    };
  }

  educations copyWith({
    int? id,
    String? eduName,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    bool? hasFinished,
  }) => educations(
    id: id ?? this.id,
    eduName: eduName ?? this.eduName,
    description: description ?? this.description,
    startDate: startDate ?? this.startDate,
    endDate: endDate ?? this.endDate,
    hasFinished: hasFinished ?? this.hasFinished,
  );
  educations copyWithCompanion(EducationEntityCompanion data) {
    return educations(
      id: data.id.present ? data.id.value : this.id,
      eduName: data.eduName.present ? data.eduName.value : this.eduName,
      description:
          data.description.present ? data.description.value : this.description,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      hasFinished:
          data.hasFinished.present ? data.hasFinished.value : this.hasFinished,
    );
  }

  @override
  String toString() {
    return (StringBuffer('educations(')
          ..write('id: $id, ')
          ..write('eduName: $eduName, ')
          ..write('description: $description, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('hasFinished: $hasFinished')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, eduName, description, startDate, endDate, hasFinished);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is educations &&
          other.id == this.id &&
          other.eduName == this.eduName &&
          other.description == this.description &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.hasFinished == this.hasFinished);
}

class EducationEntityCompanion extends UpdateCompanion<educations> {
  final Value<int> id;
  final Value<String> eduName;
  final Value<String> description;
  final Value<DateTime> startDate;
  final Value<DateTime> endDate;
  final Value<bool> hasFinished;
  const EducationEntityCompanion({
    this.id = const Value.absent(),
    this.eduName = const Value.absent(),
    this.description = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.hasFinished = const Value.absent(),
  });
  EducationEntityCompanion.insert({
    this.id = const Value.absent(),
    required String eduName,
    required String description,
    required DateTime startDate,
    required DateTime endDate,
    this.hasFinished = const Value.absent(),
  }) : eduName = Value(eduName),
       description = Value(description),
       startDate = Value(startDate),
       endDate = Value(endDate);
  static Insertable<educations> custom({
    Expression<int>? id,
    Expression<String>? eduName,
    Expression<String>? description,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<bool>? hasFinished,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eduName != null) 'edu_name': eduName,
      if (description != null) 'description': description,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (hasFinished != null) 'has_finished': hasFinished,
    });
  }

  EducationEntityCompanion copyWith({
    Value<int>? id,
    Value<String>? eduName,
    Value<String>? description,
    Value<DateTime>? startDate,
    Value<DateTime>? endDate,
    Value<bool>? hasFinished,
  }) {
    return EducationEntityCompanion(
      id: id ?? this.id,
      eduName: eduName ?? this.eduName,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      hasFinished: hasFinished ?? this.hasFinished,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (eduName.present) {
      map['edu_name'] = Variable<String>(eduName.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (hasFinished.present) {
      map['has_finished'] = Variable<bool>(hasFinished.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EducationEntityCompanion(')
          ..write('id: $id, ')
          ..write('eduName: $eduName, ')
          ..write('description: $description, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('hasFinished: $hasFinished')
          ..write(')'))
        .toString();
  }
}

class $ExperienceEntityTable extends ExperienceEntity
    with TableInfo<$ExperienceEntityTable, experiences> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExperienceEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _companyNameMeta = const VerificationMeta(
    'companyName',
  );
  @override
  late final GeneratedColumn<String> companyName = GeneratedColumn<String>(
    'company_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
    'end_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hasFinishedMeta = const VerificationMeta(
    'hasFinished',
  );
  @override
  late final GeneratedColumn<bool> hasFinished = GeneratedColumn<bool>(
    'has_finished',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has_finished" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    companyName,
    description,
    role,
    startDate,
    endDate,
    hasFinished,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'experience_entity';
  @override
  VerificationContext validateIntegrity(
    Insertable<experiences> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('company_name')) {
      context.handle(
        _companyNameMeta,
        companyName.isAcceptableOrUnknown(
          data['company_name']!,
          _companyNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_companyNameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    } else if (isInserting) {
      context.missing(_endDateMeta);
    }
    if (data.containsKey('has_finished')) {
      context.handle(
        _hasFinishedMeta,
        hasFinished.isAcceptableOrUnknown(
          data['has_finished']!,
          _hasFinishedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  experiences map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return experiences(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      companyName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}company_name'],
          )!,
      description:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}description'],
          )!,
      role:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}role'],
          )!,
      startDate:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}start_date'],
          )!,
      endDate:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}end_date'],
          )!,
      hasFinished:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}has_finished'],
          )!,
    );
  }

  @override
  $ExperienceEntityTable createAlias(String alias) {
    return $ExperienceEntityTable(attachedDatabase, alias);
  }
}

class experiences extends DataClass implements Insertable<experiences> {
  final int id;
  final String companyName;
  final String description;
  final String role;
  final DateTime startDate;
  final DateTime endDate;
  final bool hasFinished;
  const experiences({
    required this.id,
    required this.companyName,
    required this.description,
    required this.role,
    required this.startDate,
    required this.endDate,
    required this.hasFinished,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['company_name'] = Variable<String>(companyName);
    map['description'] = Variable<String>(description);
    map['role'] = Variable<String>(role);
    map['start_date'] = Variable<DateTime>(startDate);
    map['end_date'] = Variable<DateTime>(endDate);
    map['has_finished'] = Variable<bool>(hasFinished);
    return map;
  }

  ExperienceEntityCompanion toCompanion(bool nullToAbsent) {
    return ExperienceEntityCompanion(
      id: Value(id),
      companyName: Value(companyName),
      description: Value(description),
      role: Value(role),
      startDate: Value(startDate),
      endDate: Value(endDate),
      hasFinished: Value(hasFinished),
    );
  }

  factory experiences.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return experiences(
      id: serializer.fromJson<int>(json['id']),
      companyName: serializer.fromJson<String>(json['companyName']),
      description: serializer.fromJson<String>(json['description']),
      role: serializer.fromJson<String>(json['role']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime>(json['endDate']),
      hasFinished: serializer.fromJson<bool>(json['hasFinished']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'companyName': serializer.toJson<String>(companyName),
      'description': serializer.toJson<String>(description),
      'role': serializer.toJson<String>(role),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime>(endDate),
      'hasFinished': serializer.toJson<bool>(hasFinished),
    };
  }

  experiences copyWith({
    int? id,
    String? companyName,
    String? description,
    String? role,
    DateTime? startDate,
    DateTime? endDate,
    bool? hasFinished,
  }) => experiences(
    id: id ?? this.id,
    companyName: companyName ?? this.companyName,
    description: description ?? this.description,
    role: role ?? this.role,
    startDate: startDate ?? this.startDate,
    endDate: endDate ?? this.endDate,
    hasFinished: hasFinished ?? this.hasFinished,
  );
  experiences copyWithCompanion(ExperienceEntityCompanion data) {
    return experiences(
      id: data.id.present ? data.id.value : this.id,
      companyName:
          data.companyName.present ? data.companyName.value : this.companyName,
      description:
          data.description.present ? data.description.value : this.description,
      role: data.role.present ? data.role.value : this.role,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      hasFinished:
          data.hasFinished.present ? data.hasFinished.value : this.hasFinished,
    );
  }

  @override
  String toString() {
    return (StringBuffer('experiences(')
          ..write('id: $id, ')
          ..write('companyName: $companyName, ')
          ..write('description: $description, ')
          ..write('role: $role, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('hasFinished: $hasFinished')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    companyName,
    description,
    role,
    startDate,
    endDate,
    hasFinished,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is experiences &&
          other.id == this.id &&
          other.companyName == this.companyName &&
          other.description == this.description &&
          other.role == this.role &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.hasFinished == this.hasFinished);
}

class ExperienceEntityCompanion extends UpdateCompanion<experiences> {
  final Value<int> id;
  final Value<String> companyName;
  final Value<String> description;
  final Value<String> role;
  final Value<DateTime> startDate;
  final Value<DateTime> endDate;
  final Value<bool> hasFinished;
  const ExperienceEntityCompanion({
    this.id = const Value.absent(),
    this.companyName = const Value.absent(),
    this.description = const Value.absent(),
    this.role = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.hasFinished = const Value.absent(),
  });
  ExperienceEntityCompanion.insert({
    this.id = const Value.absent(),
    required String companyName,
    required String description,
    required String role,
    required DateTime startDate,
    required DateTime endDate,
    this.hasFinished = const Value.absent(),
  }) : companyName = Value(companyName),
       description = Value(description),
       role = Value(role),
       startDate = Value(startDate),
       endDate = Value(endDate);
  static Insertable<experiences> custom({
    Expression<int>? id,
    Expression<String>? companyName,
    Expression<String>? description,
    Expression<String>? role,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<bool>? hasFinished,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (companyName != null) 'company_name': companyName,
      if (description != null) 'description': description,
      if (role != null) 'role': role,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (hasFinished != null) 'has_finished': hasFinished,
    });
  }

  ExperienceEntityCompanion copyWith({
    Value<int>? id,
    Value<String>? companyName,
    Value<String>? description,
    Value<String>? role,
    Value<DateTime>? startDate,
    Value<DateTime>? endDate,
    Value<bool>? hasFinished,
  }) {
    return ExperienceEntityCompanion(
      id: id ?? this.id,
      companyName: companyName ?? this.companyName,
      description: description ?? this.description,
      role: role ?? this.role,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      hasFinished: hasFinished ?? this.hasFinished,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (companyName.present) {
      map['company_name'] = Variable<String>(companyName.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (hasFinished.present) {
      map['has_finished'] = Variable<bool>(hasFinished.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExperienceEntityCompanion(')
          ..write('id: $id, ')
          ..write('companyName: $companyName, ')
          ..write('description: $description, ')
          ..write('role: $role, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('hasFinished: $hasFinished')
          ..write(')'))
        .toString();
  }
}

class $ImageEntityTable extends ImageEntity
    with TableInfo<$ImageEntityTable, images> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ImageEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _srcMeta = const VerificationMeta('src');
  @override
  late final GeneratedColumn<String> src = GeneratedColumn<String>(
    'src',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, src];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'image_entity';
  @override
  VerificationContext validateIntegrity(
    Insertable<images> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('src')) {
      context.handle(
        _srcMeta,
        src.isAcceptableOrUnknown(data['src']!, _srcMeta),
      );
    } else if (isInserting) {
      context.missing(_srcMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  images map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return images(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      src:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}src'],
          )!,
    );
  }

  @override
  $ImageEntityTable createAlias(String alias) {
    return $ImageEntityTable(attachedDatabase, alias);
  }
}

class images extends DataClass implements Insertable<images> {
  final int id;
  final String src;
  const images({required this.id, required this.src});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['src'] = Variable<String>(src);
    return map;
  }

  ImageEntityCompanion toCompanion(bool nullToAbsent) {
    return ImageEntityCompanion(id: Value(id), src: Value(src));
  }

  factory images.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return images(
      id: serializer.fromJson<int>(json['id']),
      src: serializer.fromJson<String>(json['src']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'src': serializer.toJson<String>(src),
    };
  }

  images copyWith({int? id, String? src}) =>
      images(id: id ?? this.id, src: src ?? this.src);
  images copyWithCompanion(ImageEntityCompanion data) {
    return images(
      id: data.id.present ? data.id.value : this.id,
      src: data.src.present ? data.src.value : this.src,
    );
  }

  @override
  String toString() {
    return (StringBuffer('images(')
          ..write('id: $id, ')
          ..write('src: $src')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, src);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is images && other.id == this.id && other.src == this.src);
}

class ImageEntityCompanion extends UpdateCompanion<images> {
  final Value<int> id;
  final Value<String> src;
  const ImageEntityCompanion({
    this.id = const Value.absent(),
    this.src = const Value.absent(),
  });
  ImageEntityCompanion.insert({
    this.id = const Value.absent(),
    required String src,
  }) : src = Value(src);
  static Insertable<images> custom({
    Expression<int>? id,
    Expression<String>? src,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (src != null) 'src': src,
    });
  }

  ImageEntityCompanion copyWith({Value<int>? id, Value<String>? src}) {
    return ImageEntityCompanion(id: id ?? this.id, src: src ?? this.src);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (src.present) {
      map['src'] = Variable<String>(src.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ImageEntityCompanion(')
          ..write('id: $id, ')
          ..write('src: $src')
          ..write(')'))
        .toString();
  }
}

class $OrganizationEntityTable extends OrganizationEntity
    with TableInfo<$OrganizationEntityTable, organizations> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrganizationEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _orgNameMeta = const VerificationMeta(
    'orgName',
  );
  @override
  late final GeneratedColumn<String> orgName = GeneratedColumn<String>(
    'org_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
    'end_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hasFinishedMeta = const VerificationMeta(
    'hasFinished',
  );
  @override
  late final GeneratedColumn<bool> hasFinished = GeneratedColumn<bool>(
    'has_finished',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has_finished" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    orgName,
    description,
    startDate,
    endDate,
    hasFinished,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'organization_entity';
  @override
  VerificationContext validateIntegrity(
    Insertable<organizations> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('org_name')) {
      context.handle(
        _orgNameMeta,
        orgName.isAcceptableOrUnknown(data['org_name']!, _orgNameMeta),
      );
    } else if (isInserting) {
      context.missing(_orgNameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    } else if (isInserting) {
      context.missing(_endDateMeta);
    }
    if (data.containsKey('has_finished')) {
      context.handle(
        _hasFinishedMeta,
        hasFinished.isAcceptableOrUnknown(
          data['has_finished']!,
          _hasFinishedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  organizations map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return organizations(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      orgName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}org_name'],
          )!,
      description:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}description'],
          )!,
      startDate:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}start_date'],
          )!,
      endDate:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}end_date'],
          )!,
      hasFinished:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}has_finished'],
          )!,
    );
  }

  @override
  $OrganizationEntityTable createAlias(String alias) {
    return $OrganizationEntityTable(attachedDatabase, alias);
  }
}

class organizations extends DataClass implements Insertable<organizations> {
  final int id;
  final String orgName;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final bool hasFinished;
  const organizations({
    required this.id,
    required this.orgName,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.hasFinished,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['org_name'] = Variable<String>(orgName);
    map['description'] = Variable<String>(description);
    map['start_date'] = Variable<DateTime>(startDate);
    map['end_date'] = Variable<DateTime>(endDate);
    map['has_finished'] = Variable<bool>(hasFinished);
    return map;
  }

  OrganizationEntityCompanion toCompanion(bool nullToAbsent) {
    return OrganizationEntityCompanion(
      id: Value(id),
      orgName: Value(orgName),
      description: Value(description),
      startDate: Value(startDate),
      endDate: Value(endDate),
      hasFinished: Value(hasFinished),
    );
  }

  factory organizations.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return organizations(
      id: serializer.fromJson<int>(json['id']),
      orgName: serializer.fromJson<String>(json['orgName']),
      description: serializer.fromJson<String>(json['description']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime>(json['endDate']),
      hasFinished: serializer.fromJson<bool>(json['hasFinished']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'orgName': serializer.toJson<String>(orgName),
      'description': serializer.toJson<String>(description),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime>(endDate),
      'hasFinished': serializer.toJson<bool>(hasFinished),
    };
  }

  organizations copyWith({
    int? id,
    String? orgName,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    bool? hasFinished,
  }) => organizations(
    id: id ?? this.id,
    orgName: orgName ?? this.orgName,
    description: description ?? this.description,
    startDate: startDate ?? this.startDate,
    endDate: endDate ?? this.endDate,
    hasFinished: hasFinished ?? this.hasFinished,
  );
  organizations copyWithCompanion(OrganizationEntityCompanion data) {
    return organizations(
      id: data.id.present ? data.id.value : this.id,
      orgName: data.orgName.present ? data.orgName.value : this.orgName,
      description:
          data.description.present ? data.description.value : this.description,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      hasFinished:
          data.hasFinished.present ? data.hasFinished.value : this.hasFinished,
    );
  }

  @override
  String toString() {
    return (StringBuffer('organizations(')
          ..write('id: $id, ')
          ..write('orgName: $orgName, ')
          ..write('description: $description, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('hasFinished: $hasFinished')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, orgName, description, startDate, endDate, hasFinished);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is organizations &&
          other.id == this.id &&
          other.orgName == this.orgName &&
          other.description == this.description &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.hasFinished == this.hasFinished);
}

class OrganizationEntityCompanion extends UpdateCompanion<organizations> {
  final Value<int> id;
  final Value<String> orgName;
  final Value<String> description;
  final Value<DateTime> startDate;
  final Value<DateTime> endDate;
  final Value<bool> hasFinished;
  const OrganizationEntityCompanion({
    this.id = const Value.absent(),
    this.orgName = const Value.absent(),
    this.description = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.hasFinished = const Value.absent(),
  });
  OrganizationEntityCompanion.insert({
    this.id = const Value.absent(),
    required String orgName,
    required String description,
    required DateTime startDate,
    required DateTime endDate,
    this.hasFinished = const Value.absent(),
  }) : orgName = Value(orgName),
       description = Value(description),
       startDate = Value(startDate),
       endDate = Value(endDate);
  static Insertable<organizations> custom({
    Expression<int>? id,
    Expression<String>? orgName,
    Expression<String>? description,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<bool>? hasFinished,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (orgName != null) 'org_name': orgName,
      if (description != null) 'description': description,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (hasFinished != null) 'has_finished': hasFinished,
    });
  }

  OrganizationEntityCompanion copyWith({
    Value<int>? id,
    Value<String>? orgName,
    Value<String>? description,
    Value<DateTime>? startDate,
    Value<DateTime>? endDate,
    Value<bool>? hasFinished,
  }) {
    return OrganizationEntityCompanion(
      id: id ?? this.id,
      orgName: orgName ?? this.orgName,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      hasFinished: hasFinished ?? this.hasFinished,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (orgName.present) {
      map['org_name'] = Variable<String>(orgName.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (hasFinished.present) {
      map['has_finished'] = Variable<bool>(hasFinished.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrganizationEntityCompanion(')
          ..write('id: $id, ')
          ..write('orgName: $orgName, ')
          ..write('description: $description, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('hasFinished: $hasFinished')
          ..write(')'))
        .toString();
  }
}

class $SkillEntityTable extends SkillEntity
    with TableInfo<$SkillEntityTable, skills> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SkillEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _skillNameMeta = const VerificationMeta(
    'skillName',
  );
  @override
  late final GeneratedColumn<String> skillName = GeneratedColumn<String>(
    'skill_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _skillSetMeta = const VerificationMeta(
    'skillSet',
  );
  @override
  late final GeneratedColumn<String> skillSet = GeneratedColumn<String>(
    'skill_set',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _proficiencyMeta = const VerificationMeta(
    'proficiency',
  );
  @override
  late final GeneratedColumn<int> proficiency = GeneratedColumn<int>(
    'proficiency',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    skillName,
    description,
    skillSet,
    proficiency,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'skill_entity';
  @override
  VerificationContext validateIntegrity(
    Insertable<skills> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('skill_name')) {
      context.handle(
        _skillNameMeta,
        skillName.isAcceptableOrUnknown(data['skill_name']!, _skillNameMeta),
      );
    } else if (isInserting) {
      context.missing(_skillNameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('skill_set')) {
      context.handle(
        _skillSetMeta,
        skillSet.isAcceptableOrUnknown(data['skill_set']!, _skillSetMeta),
      );
    } else if (isInserting) {
      context.missing(_skillSetMeta);
    }
    if (data.containsKey('proficiency')) {
      context.handle(
        _proficiencyMeta,
        proficiency.isAcceptableOrUnknown(
          data['proficiency']!,
          _proficiencyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_proficiencyMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  skills map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return skills(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      skillName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}skill_name'],
          )!,
      description:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}description'],
          )!,
      skillSet:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}skill_set'],
          )!,
      proficiency:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}proficiency'],
          )!,
    );
  }

  @override
  $SkillEntityTable createAlias(String alias) {
    return $SkillEntityTable(attachedDatabase, alias);
  }
}

class skills extends DataClass implements Insertable<skills> {
  final int id;
  final String skillName;
  final String description;
  final String skillSet;
  final int proficiency;
  const skills({
    required this.id,
    required this.skillName,
    required this.description,
    required this.skillSet,
    required this.proficiency,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['skill_name'] = Variable<String>(skillName);
    map['description'] = Variable<String>(description);
    map['skill_set'] = Variable<String>(skillSet);
    map['proficiency'] = Variable<int>(proficiency);
    return map;
  }

  SkillEntityCompanion toCompanion(bool nullToAbsent) {
    return SkillEntityCompanion(
      id: Value(id),
      skillName: Value(skillName),
      description: Value(description),
      skillSet: Value(skillSet),
      proficiency: Value(proficiency),
    );
  }

  factory skills.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return skills(
      id: serializer.fromJson<int>(json['id']),
      skillName: serializer.fromJson<String>(json['skillName']),
      description: serializer.fromJson<String>(json['description']),
      skillSet: serializer.fromJson<String>(json['skillSet']),
      proficiency: serializer.fromJson<int>(json['proficiency']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'skillName': serializer.toJson<String>(skillName),
      'description': serializer.toJson<String>(description),
      'skillSet': serializer.toJson<String>(skillSet),
      'proficiency': serializer.toJson<int>(proficiency),
    };
  }

  skills copyWith({
    int? id,
    String? skillName,
    String? description,
    String? skillSet,
    int? proficiency,
  }) => skills(
    id: id ?? this.id,
    skillName: skillName ?? this.skillName,
    description: description ?? this.description,
    skillSet: skillSet ?? this.skillSet,
    proficiency: proficiency ?? this.proficiency,
  );
  skills copyWithCompanion(SkillEntityCompanion data) {
    return skills(
      id: data.id.present ? data.id.value : this.id,
      skillName: data.skillName.present ? data.skillName.value : this.skillName,
      description:
          data.description.present ? data.description.value : this.description,
      skillSet: data.skillSet.present ? data.skillSet.value : this.skillSet,
      proficiency:
          data.proficiency.present ? data.proficiency.value : this.proficiency,
    );
  }

  @override
  String toString() {
    return (StringBuffer('skills(')
          ..write('id: $id, ')
          ..write('skillName: $skillName, ')
          ..write('description: $description, ')
          ..write('skillSet: $skillSet, ')
          ..write('proficiency: $proficiency')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, skillName, description, skillSet, proficiency);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is skills &&
          other.id == this.id &&
          other.skillName == this.skillName &&
          other.description == this.description &&
          other.skillSet == this.skillSet &&
          other.proficiency == this.proficiency);
}

class SkillEntityCompanion extends UpdateCompanion<skills> {
  final Value<int> id;
  final Value<String> skillName;
  final Value<String> description;
  final Value<String> skillSet;
  final Value<int> proficiency;
  const SkillEntityCompanion({
    this.id = const Value.absent(),
    this.skillName = const Value.absent(),
    this.description = const Value.absent(),
    this.skillSet = const Value.absent(),
    this.proficiency = const Value.absent(),
  });
  SkillEntityCompanion.insert({
    this.id = const Value.absent(),
    required String skillName,
    required String description,
    required String skillSet,
    required int proficiency,
  }) : skillName = Value(skillName),
       description = Value(description),
       skillSet = Value(skillSet),
       proficiency = Value(proficiency);
  static Insertable<skills> custom({
    Expression<int>? id,
    Expression<String>? skillName,
    Expression<String>? description,
    Expression<String>? skillSet,
    Expression<int>? proficiency,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (skillName != null) 'skill_name': skillName,
      if (description != null) 'description': description,
      if (skillSet != null) 'skill_set': skillSet,
      if (proficiency != null) 'proficiency': proficiency,
    });
  }

  SkillEntityCompanion copyWith({
    Value<int>? id,
    Value<String>? skillName,
    Value<String>? description,
    Value<String>? skillSet,
    Value<int>? proficiency,
  }) {
    return SkillEntityCompanion(
      id: id ?? this.id,
      skillName: skillName ?? this.skillName,
      description: description ?? this.description,
      skillSet: skillSet ?? this.skillSet,
      proficiency: proficiency ?? this.proficiency,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (skillName.present) {
      map['skill_name'] = Variable<String>(skillName.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (skillSet.present) {
      map['skill_set'] = Variable<String>(skillSet.value);
    }
    if (proficiency.present) {
      map['proficiency'] = Variable<int>(proficiency.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SkillEntityCompanion(')
          ..write('id: $id, ')
          ..write('skillName: $skillName, ')
          ..write('description: $description, ')
          ..write('skillSet: $skillSet, ')
          ..write('proficiency: $proficiency')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PortoEntityTable portoEntity = $PortoEntityTable(this);
  late final $EducationEntityTable educationEntity = $EducationEntityTable(
    this,
  );
  late final $ExperienceEntityTable experienceEntity = $ExperienceEntityTable(
    this,
  );
  late final $ImageEntityTable imageEntity = $ImageEntityTable(this);
  late final $OrganizationEntityTable organizationEntity =
      $OrganizationEntityTable(this);
  late final $SkillEntityTable skillEntity = $SkillEntityTable(this);
  late final PortoDao portoDao = PortoDao(this as AppDatabase);
  late final EducationDao educationDao = EducationDao(this as AppDatabase);
  late final ExperienceDao experienceDao = ExperienceDao(this as AppDatabase);
  late final OrganizationDao organizationDao = OrganizationDao(
    this as AppDatabase,
  );
  late final SkillDao skillDao = SkillDao(this as AppDatabase);
  late final ImageDao imageDao = ImageDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    portoEntity,
    educationEntity,
    experienceEntity,
    imageEntity,
    organizationEntity,
    skillEntity,
  ];
}

typedef $$PortoEntityTableCreateCompanionBuilder =
    PortoEntityCompanion Function({
      Value<int> id,
      required String title,
      required String description,
      required String platform,
      required String stack,
      required DateTime createDate,
      required String link,
    });
typedef $$PortoEntityTableUpdateCompanionBuilder =
    PortoEntityCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> description,
      Value<String> platform,
      Value<String> stack,
      Value<DateTime> createDate,
      Value<String> link,
    });

class $$PortoEntityTableFilterComposer
    extends Composer<_$AppDatabase, $PortoEntityTable> {
  $$PortoEntityTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get platform => $composableBuilder(
    column: $table.platform,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stack => $composableBuilder(
    column: $table.stack,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createDate => $composableBuilder(
    column: $table.createDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get link => $composableBuilder(
    column: $table.link,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PortoEntityTableOrderingComposer
    extends Composer<_$AppDatabase, $PortoEntityTable> {
  $$PortoEntityTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get platform => $composableBuilder(
    column: $table.platform,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stack => $composableBuilder(
    column: $table.stack,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createDate => $composableBuilder(
    column: $table.createDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get link => $composableBuilder(
    column: $table.link,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PortoEntityTableAnnotationComposer
    extends Composer<_$AppDatabase, $PortoEntityTable> {
  $$PortoEntityTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get platform =>
      $composableBuilder(column: $table.platform, builder: (column) => column);

  GeneratedColumn<String> get stack =>
      $composableBuilder(column: $table.stack, builder: (column) => column);

  GeneratedColumn<DateTime> get createDate => $composableBuilder(
    column: $table.createDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get link =>
      $composableBuilder(column: $table.link, builder: (column) => column);
}

class $$PortoEntityTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PortoEntityTable,
          portos,
          $$PortoEntityTableFilterComposer,
          $$PortoEntityTableOrderingComposer,
          $$PortoEntityTableAnnotationComposer,
          $$PortoEntityTableCreateCompanionBuilder,
          $$PortoEntityTableUpdateCompanionBuilder,
          (portos, BaseReferences<_$AppDatabase, $PortoEntityTable, portos>),
          portos,
          PrefetchHooks Function()
        > {
  $$PortoEntityTableTableManager(_$AppDatabase db, $PortoEntityTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$PortoEntityTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$PortoEntityTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$PortoEntityTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> platform = const Value.absent(),
                Value<String> stack = const Value.absent(),
                Value<DateTime> createDate = const Value.absent(),
                Value<String> link = const Value.absent(),
              }) => PortoEntityCompanion(
                id: id,
                title: title,
                description: description,
                platform: platform,
                stack: stack,
                createDate: createDate,
                link: link,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required String description,
                required String platform,
                required String stack,
                required DateTime createDate,
                required String link,
              }) => PortoEntityCompanion.insert(
                id: id,
                title: title,
                description: description,
                platform: platform,
                stack: stack,
                createDate: createDate,
                link: link,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PortoEntityTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PortoEntityTable,
      portos,
      $$PortoEntityTableFilterComposer,
      $$PortoEntityTableOrderingComposer,
      $$PortoEntityTableAnnotationComposer,
      $$PortoEntityTableCreateCompanionBuilder,
      $$PortoEntityTableUpdateCompanionBuilder,
      (portos, BaseReferences<_$AppDatabase, $PortoEntityTable, portos>),
      portos,
      PrefetchHooks Function()
    >;
typedef $$EducationEntityTableCreateCompanionBuilder =
    EducationEntityCompanion Function({
      Value<int> id,
      required String eduName,
      required String description,
      required DateTime startDate,
      required DateTime endDate,
      Value<bool> hasFinished,
    });
typedef $$EducationEntityTableUpdateCompanionBuilder =
    EducationEntityCompanion Function({
      Value<int> id,
      Value<String> eduName,
      Value<String> description,
      Value<DateTime> startDate,
      Value<DateTime> endDate,
      Value<bool> hasFinished,
    });

class $$EducationEntityTableFilterComposer
    extends Composer<_$AppDatabase, $EducationEntityTable> {
  $$EducationEntityTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eduName => $composableBuilder(
    column: $table.eduName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasFinished => $composableBuilder(
    column: $table.hasFinished,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EducationEntityTableOrderingComposer
    extends Composer<_$AppDatabase, $EducationEntityTable> {
  $$EducationEntityTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eduName => $composableBuilder(
    column: $table.eduName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasFinished => $composableBuilder(
    column: $table.hasFinished,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EducationEntityTableAnnotationComposer
    extends Composer<_$AppDatabase, $EducationEntityTable> {
  $$EducationEntityTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get eduName =>
      $composableBuilder(column: $table.eduName, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<bool> get hasFinished => $composableBuilder(
    column: $table.hasFinished,
    builder: (column) => column,
  );
}

class $$EducationEntityTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EducationEntityTable,
          educations,
          $$EducationEntityTableFilterComposer,
          $$EducationEntityTableOrderingComposer,
          $$EducationEntityTableAnnotationComposer,
          $$EducationEntityTableCreateCompanionBuilder,
          $$EducationEntityTableUpdateCompanionBuilder,
          (
            educations,
            BaseReferences<_$AppDatabase, $EducationEntityTable, educations>,
          ),
          educations,
          PrefetchHooks Function()
        > {
  $$EducationEntityTableTableManager(
    _$AppDatabase db,
    $EducationEntityTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$EducationEntityTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$EducationEntityTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$EducationEntityTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> eduName = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<DateTime> endDate = const Value.absent(),
                Value<bool> hasFinished = const Value.absent(),
              }) => EducationEntityCompanion(
                id: id,
                eduName: eduName,
                description: description,
                startDate: startDate,
                endDate: endDate,
                hasFinished: hasFinished,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String eduName,
                required String description,
                required DateTime startDate,
                required DateTime endDate,
                Value<bool> hasFinished = const Value.absent(),
              }) => EducationEntityCompanion.insert(
                id: id,
                eduName: eduName,
                description: description,
                startDate: startDate,
                endDate: endDate,
                hasFinished: hasFinished,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EducationEntityTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EducationEntityTable,
      educations,
      $$EducationEntityTableFilterComposer,
      $$EducationEntityTableOrderingComposer,
      $$EducationEntityTableAnnotationComposer,
      $$EducationEntityTableCreateCompanionBuilder,
      $$EducationEntityTableUpdateCompanionBuilder,
      (
        educations,
        BaseReferences<_$AppDatabase, $EducationEntityTable, educations>,
      ),
      educations,
      PrefetchHooks Function()
    >;
typedef $$ExperienceEntityTableCreateCompanionBuilder =
    ExperienceEntityCompanion Function({
      Value<int> id,
      required String companyName,
      required String description,
      required String role,
      required DateTime startDate,
      required DateTime endDate,
      Value<bool> hasFinished,
    });
typedef $$ExperienceEntityTableUpdateCompanionBuilder =
    ExperienceEntityCompanion Function({
      Value<int> id,
      Value<String> companyName,
      Value<String> description,
      Value<String> role,
      Value<DateTime> startDate,
      Value<DateTime> endDate,
      Value<bool> hasFinished,
    });

class $$ExperienceEntityTableFilterComposer
    extends Composer<_$AppDatabase, $ExperienceEntityTable> {
  $$ExperienceEntityTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get companyName => $composableBuilder(
    column: $table.companyName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasFinished => $composableBuilder(
    column: $table.hasFinished,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExperienceEntityTableOrderingComposer
    extends Composer<_$AppDatabase, $ExperienceEntityTable> {
  $$ExperienceEntityTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get companyName => $composableBuilder(
    column: $table.companyName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasFinished => $composableBuilder(
    column: $table.hasFinished,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExperienceEntityTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExperienceEntityTable> {
  $$ExperienceEntityTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get companyName => $composableBuilder(
    column: $table.companyName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<bool> get hasFinished => $composableBuilder(
    column: $table.hasFinished,
    builder: (column) => column,
  );
}

class $$ExperienceEntityTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExperienceEntityTable,
          experiences,
          $$ExperienceEntityTableFilterComposer,
          $$ExperienceEntityTableOrderingComposer,
          $$ExperienceEntityTableAnnotationComposer,
          $$ExperienceEntityTableCreateCompanionBuilder,
          $$ExperienceEntityTableUpdateCompanionBuilder,
          (
            experiences,
            BaseReferences<_$AppDatabase, $ExperienceEntityTable, experiences>,
          ),
          experiences,
          PrefetchHooks Function()
        > {
  $$ExperienceEntityTableTableManager(
    _$AppDatabase db,
    $ExperienceEntityTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$ExperienceEntityTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$ExperienceEntityTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$ExperienceEntityTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> companyName = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<DateTime> endDate = const Value.absent(),
                Value<bool> hasFinished = const Value.absent(),
              }) => ExperienceEntityCompanion(
                id: id,
                companyName: companyName,
                description: description,
                role: role,
                startDate: startDate,
                endDate: endDate,
                hasFinished: hasFinished,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String companyName,
                required String description,
                required String role,
                required DateTime startDate,
                required DateTime endDate,
                Value<bool> hasFinished = const Value.absent(),
              }) => ExperienceEntityCompanion.insert(
                id: id,
                companyName: companyName,
                description: description,
                role: role,
                startDate: startDate,
                endDate: endDate,
                hasFinished: hasFinished,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExperienceEntityTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExperienceEntityTable,
      experiences,
      $$ExperienceEntityTableFilterComposer,
      $$ExperienceEntityTableOrderingComposer,
      $$ExperienceEntityTableAnnotationComposer,
      $$ExperienceEntityTableCreateCompanionBuilder,
      $$ExperienceEntityTableUpdateCompanionBuilder,
      (
        experiences,
        BaseReferences<_$AppDatabase, $ExperienceEntityTable, experiences>,
      ),
      experiences,
      PrefetchHooks Function()
    >;
typedef $$ImageEntityTableCreateCompanionBuilder =
    ImageEntityCompanion Function({Value<int> id, required String src});
typedef $$ImageEntityTableUpdateCompanionBuilder =
    ImageEntityCompanion Function({Value<int> id, Value<String> src});

class $$ImageEntityTableFilterComposer
    extends Composer<_$AppDatabase, $ImageEntityTable> {
  $$ImageEntityTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get src => $composableBuilder(
    column: $table.src,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ImageEntityTableOrderingComposer
    extends Composer<_$AppDatabase, $ImageEntityTable> {
  $$ImageEntityTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get src => $composableBuilder(
    column: $table.src,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ImageEntityTableAnnotationComposer
    extends Composer<_$AppDatabase, $ImageEntityTable> {
  $$ImageEntityTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get src =>
      $composableBuilder(column: $table.src, builder: (column) => column);
}

class $$ImageEntityTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ImageEntityTable,
          images,
          $$ImageEntityTableFilterComposer,
          $$ImageEntityTableOrderingComposer,
          $$ImageEntityTableAnnotationComposer,
          $$ImageEntityTableCreateCompanionBuilder,
          $$ImageEntityTableUpdateCompanionBuilder,
          (images, BaseReferences<_$AppDatabase, $ImageEntityTable, images>),
          images,
          PrefetchHooks Function()
        > {
  $$ImageEntityTableTableManager(_$AppDatabase db, $ImageEntityTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$ImageEntityTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$ImageEntityTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$ImageEntityTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> src = const Value.absent(),
              }) => ImageEntityCompanion(id: id, src: src),
          createCompanionCallback:
              ({Value<int> id = const Value.absent(), required String src}) =>
                  ImageEntityCompanion.insert(id: id, src: src),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ImageEntityTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ImageEntityTable,
      images,
      $$ImageEntityTableFilterComposer,
      $$ImageEntityTableOrderingComposer,
      $$ImageEntityTableAnnotationComposer,
      $$ImageEntityTableCreateCompanionBuilder,
      $$ImageEntityTableUpdateCompanionBuilder,
      (images, BaseReferences<_$AppDatabase, $ImageEntityTable, images>),
      images,
      PrefetchHooks Function()
    >;
typedef $$OrganizationEntityTableCreateCompanionBuilder =
    OrganizationEntityCompanion Function({
      Value<int> id,
      required String orgName,
      required String description,
      required DateTime startDate,
      required DateTime endDate,
      Value<bool> hasFinished,
    });
typedef $$OrganizationEntityTableUpdateCompanionBuilder =
    OrganizationEntityCompanion Function({
      Value<int> id,
      Value<String> orgName,
      Value<String> description,
      Value<DateTime> startDate,
      Value<DateTime> endDate,
      Value<bool> hasFinished,
    });

class $$OrganizationEntityTableFilterComposer
    extends Composer<_$AppDatabase, $OrganizationEntityTable> {
  $$OrganizationEntityTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get orgName => $composableBuilder(
    column: $table.orgName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasFinished => $composableBuilder(
    column: $table.hasFinished,
    builder: (column) => ColumnFilters(column),
  );
}

class $$OrganizationEntityTableOrderingComposer
    extends Composer<_$AppDatabase, $OrganizationEntityTable> {
  $$OrganizationEntityTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get orgName => $composableBuilder(
    column: $table.orgName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasFinished => $composableBuilder(
    column: $table.hasFinished,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OrganizationEntityTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrganizationEntityTable> {
  $$OrganizationEntityTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get orgName =>
      $composableBuilder(column: $table.orgName, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<bool> get hasFinished => $composableBuilder(
    column: $table.hasFinished,
    builder: (column) => column,
  );
}

class $$OrganizationEntityTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OrganizationEntityTable,
          organizations,
          $$OrganizationEntityTableFilterComposer,
          $$OrganizationEntityTableOrderingComposer,
          $$OrganizationEntityTableAnnotationComposer,
          $$OrganizationEntityTableCreateCompanionBuilder,
          $$OrganizationEntityTableUpdateCompanionBuilder,
          (
            organizations,
            BaseReferences<
              _$AppDatabase,
              $OrganizationEntityTable,
              organizations
            >,
          ),
          organizations,
          PrefetchHooks Function()
        > {
  $$OrganizationEntityTableTableManager(
    _$AppDatabase db,
    $OrganizationEntityTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$OrganizationEntityTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$OrganizationEntityTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$OrganizationEntityTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> orgName = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<DateTime> endDate = const Value.absent(),
                Value<bool> hasFinished = const Value.absent(),
              }) => OrganizationEntityCompanion(
                id: id,
                orgName: orgName,
                description: description,
                startDate: startDate,
                endDate: endDate,
                hasFinished: hasFinished,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String orgName,
                required String description,
                required DateTime startDate,
                required DateTime endDate,
                Value<bool> hasFinished = const Value.absent(),
              }) => OrganizationEntityCompanion.insert(
                id: id,
                orgName: orgName,
                description: description,
                startDate: startDate,
                endDate: endDate,
                hasFinished: hasFinished,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$OrganizationEntityTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OrganizationEntityTable,
      organizations,
      $$OrganizationEntityTableFilterComposer,
      $$OrganizationEntityTableOrderingComposer,
      $$OrganizationEntityTableAnnotationComposer,
      $$OrganizationEntityTableCreateCompanionBuilder,
      $$OrganizationEntityTableUpdateCompanionBuilder,
      (
        organizations,
        BaseReferences<_$AppDatabase, $OrganizationEntityTable, organizations>,
      ),
      organizations,
      PrefetchHooks Function()
    >;
typedef $$SkillEntityTableCreateCompanionBuilder =
    SkillEntityCompanion Function({
      Value<int> id,
      required String skillName,
      required String description,
      required String skillSet,
      required int proficiency,
    });
typedef $$SkillEntityTableUpdateCompanionBuilder =
    SkillEntityCompanion Function({
      Value<int> id,
      Value<String> skillName,
      Value<String> description,
      Value<String> skillSet,
      Value<int> proficiency,
    });

class $$SkillEntityTableFilterComposer
    extends Composer<_$AppDatabase, $SkillEntityTable> {
  $$SkillEntityTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get skillName => $composableBuilder(
    column: $table.skillName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get skillSet => $composableBuilder(
    column: $table.skillSet,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get proficiency => $composableBuilder(
    column: $table.proficiency,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SkillEntityTableOrderingComposer
    extends Composer<_$AppDatabase, $SkillEntityTable> {
  $$SkillEntityTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get skillName => $composableBuilder(
    column: $table.skillName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get skillSet => $composableBuilder(
    column: $table.skillSet,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get proficiency => $composableBuilder(
    column: $table.proficiency,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SkillEntityTableAnnotationComposer
    extends Composer<_$AppDatabase, $SkillEntityTable> {
  $$SkillEntityTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get skillName =>
      $composableBuilder(column: $table.skillName, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get skillSet =>
      $composableBuilder(column: $table.skillSet, builder: (column) => column);

  GeneratedColumn<int> get proficiency => $composableBuilder(
    column: $table.proficiency,
    builder: (column) => column,
  );
}

class $$SkillEntityTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SkillEntityTable,
          skills,
          $$SkillEntityTableFilterComposer,
          $$SkillEntityTableOrderingComposer,
          $$SkillEntityTableAnnotationComposer,
          $$SkillEntityTableCreateCompanionBuilder,
          $$SkillEntityTableUpdateCompanionBuilder,
          (skills, BaseReferences<_$AppDatabase, $SkillEntityTable, skills>),
          skills,
          PrefetchHooks Function()
        > {
  $$SkillEntityTableTableManager(_$AppDatabase db, $SkillEntityTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$SkillEntityTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$SkillEntityTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$SkillEntityTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> skillName = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> skillSet = const Value.absent(),
                Value<int> proficiency = const Value.absent(),
              }) => SkillEntityCompanion(
                id: id,
                skillName: skillName,
                description: description,
                skillSet: skillSet,
                proficiency: proficiency,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String skillName,
                required String description,
                required String skillSet,
                required int proficiency,
              }) => SkillEntityCompanion.insert(
                id: id,
                skillName: skillName,
                description: description,
                skillSet: skillSet,
                proficiency: proficiency,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SkillEntityTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SkillEntityTable,
      skills,
      $$SkillEntityTableFilterComposer,
      $$SkillEntityTableOrderingComposer,
      $$SkillEntityTableAnnotationComposer,
      $$SkillEntityTableCreateCompanionBuilder,
      $$SkillEntityTableUpdateCompanionBuilder,
      (skills, BaseReferences<_$AppDatabase, $SkillEntityTable, skills>),
      skills,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PortoEntityTableTableManager get portoEntity =>
      $$PortoEntityTableTableManager(_db, _db.portoEntity);
  $$EducationEntityTableTableManager get educationEntity =>
      $$EducationEntityTableTableManager(_db, _db.educationEntity);
  $$ExperienceEntityTableTableManager get experienceEntity =>
      $$ExperienceEntityTableTableManager(_db, _db.experienceEntity);
  $$ImageEntityTableTableManager get imageEntity =>
      $$ImageEntityTableTableManager(_db, _db.imageEntity);
  $$OrganizationEntityTableTableManager get organizationEntity =>
      $$OrganizationEntityTableTableManager(_db, _db.organizationEntity);
  $$SkillEntityTableTableManager get skillEntity =>
      $$SkillEntityTableTableManager(_db, _db.skillEntity);
}
