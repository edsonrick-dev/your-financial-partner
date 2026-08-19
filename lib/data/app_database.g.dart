// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CashflowCategoriesTableTable extends CashflowCategoriesTable
    with TableInfo<$CashflowCategoriesTableTable, CashflowCategoriesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CashflowCategoriesTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDefaultMeta = const VerificationMeta(
    'isDefault',
  );
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
    'is_default',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_default" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, icon, type, isDefault];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cashflow_categories_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<CashflowCategoriesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
    } else if (isInserting) {
      context.missing(_iconMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('is_default')) {
      context.handle(
        _isDefaultMeta,
        isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CashflowCategoriesTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CashflowCategoriesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      isDefault: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_default'],
      )!,
    );
  }

  @override
  $CashflowCategoriesTableTable createAlias(String alias) {
    return $CashflowCategoriesTableTable(attachedDatabase, alias);
  }
}

class CashflowCategoriesTableData extends DataClass
    implements Insertable<CashflowCategoriesTableData> {
  final int id;
  final String name;
  final String icon;
  final String type;
  final bool isDefault;
  const CashflowCategoriesTableData({
    required this.id,
    required this.name,
    required this.icon,
    required this.type,
    required this.isDefault,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['icon'] = Variable<String>(icon);
    map['type'] = Variable<String>(type);
    map['is_default'] = Variable<bool>(isDefault);
    return map;
  }

  CashflowCategoriesTableCompanion toCompanion(bool nullToAbsent) {
    return CashflowCategoriesTableCompanion(
      id: Value(id),
      name: Value(name),
      icon: Value(icon),
      type: Value(type),
      isDefault: Value(isDefault),
    );
  }

  factory CashflowCategoriesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CashflowCategoriesTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      icon: serializer.fromJson<String>(json['icon']),
      type: serializer.fromJson<String>(json['type']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'icon': serializer.toJson<String>(icon),
      'type': serializer.toJson<String>(type),
      'isDefault': serializer.toJson<bool>(isDefault),
    };
  }

  CashflowCategoriesTableData copyWith({
    int? id,
    String? name,
    String? icon,
    String? type,
    bool? isDefault,
  }) => CashflowCategoriesTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    icon: icon ?? this.icon,
    type: type ?? this.type,
    isDefault: isDefault ?? this.isDefault,
  );
  CashflowCategoriesTableData copyWithCompanion(
    CashflowCategoriesTableCompanion data,
  ) {
    return CashflowCategoriesTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      icon: data.icon.present ? data.icon.value : this.icon,
      type: data.type.present ? data.type.value : this.type,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CashflowCategoriesTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('type: $type, ')
          ..write('isDefault: $isDefault')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, icon, type, isDefault);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CashflowCategoriesTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.icon == this.icon &&
          other.type == this.type &&
          other.isDefault == this.isDefault);
}

class CashflowCategoriesTableCompanion
    extends UpdateCompanion<CashflowCategoriesTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> icon;
  final Value<String> type;
  final Value<bool> isDefault;
  const CashflowCategoriesTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.icon = const Value.absent(),
    this.type = const Value.absent(),
    this.isDefault = const Value.absent(),
  });
  CashflowCategoriesTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String icon,
    required String type,
    this.isDefault = const Value.absent(),
  }) : name = Value(name),
       icon = Value(icon),
       type = Value(type);
  static Insertable<CashflowCategoriesTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? icon,
    Expression<String>? type,
    Expression<bool>? isDefault,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (icon != null) 'icon': icon,
      if (type != null) 'type': type,
      if (isDefault != null) 'is_default': isDefault,
    });
  }

  CashflowCategoriesTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? icon,
    Value<String>? type,
    Value<bool>? isDefault,
  }) {
    return CashflowCategoriesTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      type: type ?? this.type,
      isDefault: isDefault ?? this.isDefault,
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
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CashflowCategoriesTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('type: $type, ')
          ..write('isDefault: $isDefault')
          ..write(')'))
        .toString();
  }
}

class $AccountsTableTable extends AccountsTable
    with TableInfo<$AccountsTableTable, AccountsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccountsTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountTypeMeta = const VerificationMeta(
    'accountType',
  );
  @override
  late final GeneratedColumn<String> accountType = GeneratedColumn<String>(
    'account_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentValueMeta = const VerificationMeta(
    'currentValue',
  );
  @override
  late final GeneratedColumn<double> currentValue = GeneratedColumn<double>(
    'current_value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isSystemMeta = const VerificationMeta(
    'isSystem',
  );
  @override
  late final GeneratedColumn<bool> isSystem = GeneratedColumn<bool>(
    'is_system',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_system" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _creditLimitMeta = const VerificationMeta(
    'creditLimit',
  );
  @override
  late final GeneratedColumn<double> creditLimit = GeneratedColumn<double>(
    'credit_limit',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    icon,
    accountType,
    currentValue,
    isSystem,
    creditLimit,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'accounts_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<AccountsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
    } else if (isInserting) {
      context.missing(_iconMeta);
    }
    if (data.containsKey('account_type')) {
      context.handle(
        _accountTypeMeta,
        accountType.isAcceptableOrUnknown(
          data['account_type']!,
          _accountTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_accountTypeMeta);
    }
    if (data.containsKey('current_value')) {
      context.handle(
        _currentValueMeta,
        currentValue.isAcceptableOrUnknown(
          data['current_value']!,
          _currentValueMeta,
        ),
      );
    }
    if (data.containsKey('is_system')) {
      context.handle(
        _isSystemMeta,
        isSystem.isAcceptableOrUnknown(data['is_system']!, _isSystemMeta),
      );
    }
    if (data.containsKey('credit_limit')) {
      context.handle(
        _creditLimitMeta,
        creditLimit.isAcceptableOrUnknown(
          data['credit_limit']!,
          _creditLimitMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AccountsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AccountsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      )!,
      accountType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_type'],
      )!,
      currentValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}current_value'],
      )!,
      isSystem: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_system'],
      )!,
      creditLimit: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}credit_limit'],
      ),
    );
  }

  @override
  $AccountsTableTable createAlias(String alias) {
    return $AccountsTableTable(attachedDatabase, alias);
  }
}

class AccountsTableData extends DataClass
    implements Insertable<AccountsTableData> {
  final int id;
  final String name;
  final String icon;
  final String accountType;
  final double currentValue;
  final bool isSystem;
  final double? creditLimit;
  const AccountsTableData({
    required this.id,
    required this.name,
    required this.icon,
    required this.accountType,
    required this.currentValue,
    required this.isSystem,
    this.creditLimit,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['icon'] = Variable<String>(icon);
    map['account_type'] = Variable<String>(accountType);
    map['current_value'] = Variable<double>(currentValue);
    map['is_system'] = Variable<bool>(isSystem);
    if (!nullToAbsent || creditLimit != null) {
      map['credit_limit'] = Variable<double>(creditLimit);
    }
    return map;
  }

  AccountsTableCompanion toCompanion(bool nullToAbsent) {
    return AccountsTableCompanion(
      id: Value(id),
      name: Value(name),
      icon: Value(icon),
      accountType: Value(accountType),
      currentValue: Value(currentValue),
      isSystem: Value(isSystem),
      creditLimit: creditLimit == null && nullToAbsent
          ? const Value.absent()
          : Value(creditLimit),
    );
  }

  factory AccountsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccountsTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      icon: serializer.fromJson<String>(json['icon']),
      accountType: serializer.fromJson<String>(json['accountType']),
      currentValue: serializer.fromJson<double>(json['currentValue']),
      isSystem: serializer.fromJson<bool>(json['isSystem']),
      creditLimit: serializer.fromJson<double?>(json['creditLimit']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'icon': serializer.toJson<String>(icon),
      'accountType': serializer.toJson<String>(accountType),
      'currentValue': serializer.toJson<double>(currentValue),
      'isSystem': serializer.toJson<bool>(isSystem),
      'creditLimit': serializer.toJson<double?>(creditLimit),
    };
  }

  AccountsTableData copyWith({
    int? id,
    String? name,
    String? icon,
    String? accountType,
    double? currentValue,
    bool? isSystem,
    Value<double?> creditLimit = const Value.absent(),
  }) => AccountsTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    icon: icon ?? this.icon,
    accountType: accountType ?? this.accountType,
    currentValue: currentValue ?? this.currentValue,
    isSystem: isSystem ?? this.isSystem,
    creditLimit: creditLimit.present ? creditLimit.value : this.creditLimit,
  );
  AccountsTableData copyWithCompanion(AccountsTableCompanion data) {
    return AccountsTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      icon: data.icon.present ? data.icon.value : this.icon,
      accountType: data.accountType.present
          ? data.accountType.value
          : this.accountType,
      currentValue: data.currentValue.present
          ? data.currentValue.value
          : this.currentValue,
      isSystem: data.isSystem.present ? data.isSystem.value : this.isSystem,
      creditLimit: data.creditLimit.present
          ? data.creditLimit.value
          : this.creditLimit,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AccountsTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('accountType: $accountType, ')
          ..write('currentValue: $currentValue, ')
          ..write('isSystem: $isSystem, ')
          ..write('creditLimit: $creditLimit')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    icon,
    accountType,
    currentValue,
    isSystem,
    creditLimit,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AccountsTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.icon == this.icon &&
          other.accountType == this.accountType &&
          other.currentValue == this.currentValue &&
          other.isSystem == this.isSystem &&
          other.creditLimit == this.creditLimit);
}

class AccountsTableCompanion extends UpdateCompanion<AccountsTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> icon;
  final Value<String> accountType;
  final Value<double> currentValue;
  final Value<bool> isSystem;
  final Value<double?> creditLimit;
  const AccountsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.icon = const Value.absent(),
    this.accountType = const Value.absent(),
    this.currentValue = const Value.absent(),
    this.isSystem = const Value.absent(),
    this.creditLimit = const Value.absent(),
  });
  AccountsTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String icon,
    required String accountType,
    this.currentValue = const Value.absent(),
    this.isSystem = const Value.absent(),
    this.creditLimit = const Value.absent(),
  }) : name = Value(name),
       icon = Value(icon),
       accountType = Value(accountType);
  static Insertable<AccountsTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? icon,
    Expression<String>? accountType,
    Expression<double>? currentValue,
    Expression<bool>? isSystem,
    Expression<double>? creditLimit,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (icon != null) 'icon': icon,
      if (accountType != null) 'account_type': accountType,
      if (currentValue != null) 'current_value': currentValue,
      if (isSystem != null) 'is_system': isSystem,
      if (creditLimit != null) 'credit_limit': creditLimit,
    });
  }

  AccountsTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? icon,
    Value<String>? accountType,
    Value<double>? currentValue,
    Value<bool>? isSystem,
    Value<double?>? creditLimit,
  }) {
    return AccountsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      accountType: accountType ?? this.accountType,
      currentValue: currentValue ?? this.currentValue,
      isSystem: isSystem ?? this.isSystem,
      creditLimit: creditLimit ?? this.creditLimit,
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
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (accountType.present) {
      map['account_type'] = Variable<String>(accountType.value);
    }
    if (currentValue.present) {
      map['current_value'] = Variable<double>(currentValue.value);
    }
    if (isSystem.present) {
      map['is_system'] = Variable<bool>(isSystem.value);
    }
    if (creditLimit.present) {
      map['credit_limit'] = Variable<double>(creditLimit.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('accountType: $accountType, ')
          ..write('currentValue: $currentValue, ')
          ..write('isSystem: $isSystem, ')
          ..write('creditLimit: $creditLimit')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTableTable extends TransactionsTable
    with TableInfo<$TransactionsTableTable, TransactionsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _transactionTypeMeta = const VerificationMeta(
    'transactionType',
  );
  @override
  late final GeneratedColumn<String> transactionType = GeneratedColumn<String>(
    'transaction_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES cashflow_categories_table (id)',
    ),
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<int> accountId = GeneratedColumn<int>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES accounts_table (id)',
    ),
  );
  static const VerificationMeta _linkedAccountIdMeta = const VerificationMeta(
    'linkedAccountId',
  );
  @override
  late final GeneratedColumn<int> linkedAccountId = GeneratedColumn<int>(
    'linked_account_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES accounts_table (id)',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    amount,
    date,
    note,
    transactionType,
    categoryId,
    accountId,
    linkedAccountId,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<TransactionsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('transaction_type')) {
      context.handle(
        _transactionTypeMeta,
        transactionType.isAcceptableOrUnknown(
          data['transaction_type']!,
          _transactionTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transactionTypeMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('linked_account_id')) {
      context.handle(
        _linkedAccountIdMeta,
        linkedAccountId.isAcceptableOrUnknown(
          data['linked_account_id']!,
          _linkedAccountIdMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      transactionType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transaction_type'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category_id'],
      ),
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}account_id'],
      )!,
      linkedAccountId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}linked_account_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $TransactionsTableTable createAlias(String alias) {
    return $TransactionsTableTable(attachedDatabase, alias);
  }
}

class TransactionsTableData extends DataClass
    implements Insertable<TransactionsTableData> {
  final int id;
  final double amount;
  final DateTime date;
  final String? note;
  final String transactionType;
  final int? categoryId;
  final int accountId;
  final int? linkedAccountId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const TransactionsTableData({
    required this.id,
    required this.amount,
    required this.date,
    this.note,
    required this.transactionType,
    this.categoryId,
    required this.accountId,
    this.linkedAccountId,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['amount'] = Variable<double>(amount);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['transaction_type'] = Variable<String>(transactionType);
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<int>(categoryId);
    }
    map['account_id'] = Variable<int>(accountId);
    if (!nullToAbsent || linkedAccountId != null) {
      map['linked_account_id'] = Variable<int>(linkedAccountId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TransactionsTableCompanion toCompanion(bool nullToAbsent) {
    return TransactionsTableCompanion(
      id: Value(id),
      amount: Value(amount),
      date: Value(date),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      transactionType: Value(transactionType),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      accountId: Value(accountId),
      linkedAccountId: linkedAccountId == null && nullToAbsent
          ? const Value.absent()
          : Value(linkedAccountId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory TransactionsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionsTableData(
      id: serializer.fromJson<int>(json['id']),
      amount: serializer.fromJson<double>(json['amount']),
      date: serializer.fromJson<DateTime>(json['date']),
      note: serializer.fromJson<String?>(json['note']),
      transactionType: serializer.fromJson<String>(json['transactionType']),
      categoryId: serializer.fromJson<int?>(json['categoryId']),
      accountId: serializer.fromJson<int>(json['accountId']),
      linkedAccountId: serializer.fromJson<int?>(json['linkedAccountId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'amount': serializer.toJson<double>(amount),
      'date': serializer.toJson<DateTime>(date),
      'note': serializer.toJson<String?>(note),
      'transactionType': serializer.toJson<String>(transactionType),
      'categoryId': serializer.toJson<int?>(categoryId),
      'accountId': serializer.toJson<int>(accountId),
      'linkedAccountId': serializer.toJson<int?>(linkedAccountId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  TransactionsTableData copyWith({
    int? id,
    double? amount,
    DateTime? date,
    Value<String?> note = const Value.absent(),
    String? transactionType,
    Value<int?> categoryId = const Value.absent(),
    int? accountId,
    Value<int?> linkedAccountId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => TransactionsTableData(
    id: id ?? this.id,
    amount: amount ?? this.amount,
    date: date ?? this.date,
    note: note.present ? note.value : this.note,
    transactionType: transactionType ?? this.transactionType,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    accountId: accountId ?? this.accountId,
    linkedAccountId: linkedAccountId.present
        ? linkedAccountId.value
        : this.linkedAccountId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  TransactionsTableData copyWithCompanion(TransactionsTableCompanion data) {
    return TransactionsTableData(
      id: data.id.present ? data.id.value : this.id,
      amount: data.amount.present ? data.amount.value : this.amount,
      date: data.date.present ? data.date.value : this.date,
      note: data.note.present ? data.note.value : this.note,
      transactionType: data.transactionType.present
          ? data.transactionType.value
          : this.transactionType,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      linkedAccountId: data.linkedAccountId.present
          ? data.linkedAccountId.value
          : this.linkedAccountId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsTableData(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('note: $note, ')
          ..write('transactionType: $transactionType, ')
          ..write('categoryId: $categoryId, ')
          ..write('accountId: $accountId, ')
          ..write('linkedAccountId: $linkedAccountId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    amount,
    date,
    note,
    transactionType,
    categoryId,
    accountId,
    linkedAccountId,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionsTableData &&
          other.id == this.id &&
          other.amount == this.amount &&
          other.date == this.date &&
          other.note == this.note &&
          other.transactionType == this.transactionType &&
          other.categoryId == this.categoryId &&
          other.accountId == this.accountId &&
          other.linkedAccountId == this.linkedAccountId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TransactionsTableCompanion
    extends UpdateCompanion<TransactionsTableData> {
  final Value<int> id;
  final Value<double> amount;
  final Value<DateTime> date;
  final Value<String?> note;
  final Value<String> transactionType;
  final Value<int?> categoryId;
  final Value<int> accountId;
  final Value<int?> linkedAccountId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const TransactionsTableCompanion({
    this.id = const Value.absent(),
    this.amount = const Value.absent(),
    this.date = const Value.absent(),
    this.note = const Value.absent(),
    this.transactionType = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.accountId = const Value.absent(),
    this.linkedAccountId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  TransactionsTableCompanion.insert({
    this.id = const Value.absent(),
    required double amount,
    required DateTime date,
    this.note = const Value.absent(),
    required String transactionType,
    this.categoryId = const Value.absent(),
    required int accountId,
    this.linkedAccountId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : amount = Value(amount),
       date = Value(date),
       transactionType = Value(transactionType),
       accountId = Value(accountId);
  static Insertable<TransactionsTableData> custom({
    Expression<int>? id,
    Expression<double>? amount,
    Expression<DateTime>? date,
    Expression<String>? note,
    Expression<String>? transactionType,
    Expression<int>? categoryId,
    Expression<int>? accountId,
    Expression<int>? linkedAccountId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (amount != null) 'amount': amount,
      if (date != null) 'date': date,
      if (note != null) 'note': note,
      if (transactionType != null) 'transaction_type': transactionType,
      if (categoryId != null) 'category_id': categoryId,
      if (accountId != null) 'account_id': accountId,
      if (linkedAccountId != null) 'linked_account_id': linkedAccountId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  TransactionsTableCompanion copyWith({
    Value<int>? id,
    Value<double>? amount,
    Value<DateTime>? date,
    Value<String?>? note,
    Value<String>? transactionType,
    Value<int?>? categoryId,
    Value<int>? accountId,
    Value<int?>? linkedAccountId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return TransactionsTableCompanion(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      note: note ?? this.note,
      transactionType: transactionType ?? this.transactionType,
      categoryId: categoryId ?? this.categoryId,
      accountId: accountId ?? this.accountId,
      linkedAccountId: linkedAccountId ?? this.linkedAccountId,
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
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (transactionType.present) {
      map['transaction_type'] = Variable<String>(transactionType.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<int>(accountId.value);
    }
    if (linkedAccountId.present) {
      map['linked_account_id'] = Variable<int>(linkedAccountId.value);
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
    return (StringBuffer('TransactionsTableCompanion(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('note: $note, ')
          ..write('transactionType: $transactionType, ')
          ..write('categoryId: $categoryId, ')
          ..write('accountId: $accountId, ')
          ..write('linkedAccountId: $linkedAccountId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $EntitiesTableTable extends EntitiesTable
    with TableInfo<$EntitiesTableTable, EntitiesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EntitiesTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _shortCodeMeta = const VerificationMeta(
    'shortCode',
  );
  @override
  late final GeneratedColumn<String> shortCode = GeneratedColumn<String>(
    'short_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _organizationTypeMeta = const VerificationMeta(
    'organizationType',
  );
  @override
  late final GeneratedColumn<String> organizationType = GeneratedColumn<String>(
    'organization_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isSystemMeta = const VerificationMeta(
    'isSystem',
  );
  @override
  late final GeneratedColumn<bool> isSystem = GeneratedColumn<bool>(
    'is_system',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_system" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _iconKeyMeta = const VerificationMeta(
    'iconKey',
  );
  @override
  late final GeneratedColumn<String> iconKey = GeneratedColumn<String>(
    'icon_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contactNumberMeta = const VerificationMeta(
    'contactNumber',
  );
  @override
  late final GeneratedColumn<String> contactNumber = GeneratedColumn<String>(
    'contact_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailAddressMeta = const VerificationMeta(
    'emailAddress',
  );
  @override
  late final GeneratedColumn<String> emailAddress = GeneratedColumn<String>(
    'email_address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _metadataMeta = const VerificationMeta(
    'metadata',
  );
  @override
  late final GeneratedColumn<String> metadata = GeneratedColumn<String>(
    'metadata',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    displayName,
    shortCode,
    entityType,
    organizationType,
    isSystem,
    iconKey,
    contactNumber,
    emailAddress,
    metadata,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'entities_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<EntitiesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    }
    if (data.containsKey('short_code')) {
      context.handle(
        _shortCodeMeta,
        shortCode.isAcceptableOrUnknown(data['short_code']!, _shortCodeMeta),
      );
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('organization_type')) {
      context.handle(
        _organizationTypeMeta,
        organizationType.isAcceptableOrUnknown(
          data['organization_type']!,
          _organizationTypeMeta,
        ),
      );
    }
    if (data.containsKey('is_system')) {
      context.handle(
        _isSystemMeta,
        isSystem.isAcceptableOrUnknown(data['is_system']!, _isSystemMeta),
      );
    }
    if (data.containsKey('icon_key')) {
      context.handle(
        _iconKeyMeta,
        iconKey.isAcceptableOrUnknown(data['icon_key']!, _iconKeyMeta),
      );
    }
    if (data.containsKey('contact_number')) {
      context.handle(
        _contactNumberMeta,
        contactNumber.isAcceptableOrUnknown(
          data['contact_number']!,
          _contactNumberMeta,
        ),
      );
    }
    if (data.containsKey('email_address')) {
      context.handle(
        _emailAddressMeta,
        emailAddress.isAcceptableOrUnknown(
          data['email_address']!,
          _emailAddressMeta,
        ),
      );
    }
    if (data.containsKey('metadata')) {
      context.handle(
        _metadataMeta,
        metadata.isAcceptableOrUnknown(data['metadata']!, _metadataMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EntitiesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EntitiesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      ),
      shortCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}short_code'],
      ),
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      )!,
      organizationType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}organization_type'],
      ),
      isSystem: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_system'],
      )!,
      iconKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_key'],
      ),
      contactNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_number'],
      ),
      emailAddress: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email_address'],
      ),
      metadata: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metadata'],
      ),
    );
  }

  @override
  $EntitiesTableTable createAlias(String alias) {
    return $EntitiesTableTable(attachedDatabase, alias);
  }
}

class EntitiesTableData extends DataClass
    implements Insertable<EntitiesTableData> {
  final int id;
  final String name;
  final String? displayName;
  final String? shortCode;
  final String entityType;
  final String? organizationType;
  final bool isSystem;
  final String? iconKey;
  final String? contactNumber;
  final String? emailAddress;
  final String? metadata;
  const EntitiesTableData({
    required this.id,
    required this.name,
    this.displayName,
    this.shortCode,
    required this.entityType,
    this.organizationType,
    required this.isSystem,
    this.iconKey,
    this.contactNumber,
    this.emailAddress,
    this.metadata,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || displayName != null) {
      map['display_name'] = Variable<String>(displayName);
    }
    if (!nullToAbsent || shortCode != null) {
      map['short_code'] = Variable<String>(shortCode);
    }
    map['entity_type'] = Variable<String>(entityType);
    if (!nullToAbsent || organizationType != null) {
      map['organization_type'] = Variable<String>(organizationType);
    }
    map['is_system'] = Variable<bool>(isSystem);
    if (!nullToAbsent || iconKey != null) {
      map['icon_key'] = Variable<String>(iconKey);
    }
    if (!nullToAbsent || contactNumber != null) {
      map['contact_number'] = Variable<String>(contactNumber);
    }
    if (!nullToAbsent || emailAddress != null) {
      map['email_address'] = Variable<String>(emailAddress);
    }
    if (!nullToAbsent || metadata != null) {
      map['metadata'] = Variable<String>(metadata);
    }
    return map;
  }

  EntitiesTableCompanion toCompanion(bool nullToAbsent) {
    return EntitiesTableCompanion(
      id: Value(id),
      name: Value(name),
      displayName: displayName == null && nullToAbsent
          ? const Value.absent()
          : Value(displayName),
      shortCode: shortCode == null && nullToAbsent
          ? const Value.absent()
          : Value(shortCode),
      entityType: Value(entityType),
      organizationType: organizationType == null && nullToAbsent
          ? const Value.absent()
          : Value(organizationType),
      isSystem: Value(isSystem),
      iconKey: iconKey == null && nullToAbsent
          ? const Value.absent()
          : Value(iconKey),
      contactNumber: contactNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(contactNumber),
      emailAddress: emailAddress == null && nullToAbsent
          ? const Value.absent()
          : Value(emailAddress),
      metadata: metadata == null && nullToAbsent
          ? const Value.absent()
          : Value(metadata),
    );
  }

  factory EntitiesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EntitiesTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      displayName: serializer.fromJson<String?>(json['displayName']),
      shortCode: serializer.fromJson<String?>(json['shortCode']),
      entityType: serializer.fromJson<String>(json['entityType']),
      organizationType: serializer.fromJson<String?>(json['organizationType']),
      isSystem: serializer.fromJson<bool>(json['isSystem']),
      iconKey: serializer.fromJson<String?>(json['iconKey']),
      contactNumber: serializer.fromJson<String?>(json['contactNumber']),
      emailAddress: serializer.fromJson<String?>(json['emailAddress']),
      metadata: serializer.fromJson<String?>(json['metadata']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'displayName': serializer.toJson<String?>(displayName),
      'shortCode': serializer.toJson<String?>(shortCode),
      'entityType': serializer.toJson<String>(entityType),
      'organizationType': serializer.toJson<String?>(organizationType),
      'isSystem': serializer.toJson<bool>(isSystem),
      'iconKey': serializer.toJson<String?>(iconKey),
      'contactNumber': serializer.toJson<String?>(contactNumber),
      'emailAddress': serializer.toJson<String?>(emailAddress),
      'metadata': serializer.toJson<String?>(metadata),
    };
  }

  EntitiesTableData copyWith({
    int? id,
    String? name,
    Value<String?> displayName = const Value.absent(),
    Value<String?> shortCode = const Value.absent(),
    String? entityType,
    Value<String?> organizationType = const Value.absent(),
    bool? isSystem,
    Value<String?> iconKey = const Value.absent(),
    Value<String?> contactNumber = const Value.absent(),
    Value<String?> emailAddress = const Value.absent(),
    Value<String?> metadata = const Value.absent(),
  }) => EntitiesTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    displayName: displayName.present ? displayName.value : this.displayName,
    shortCode: shortCode.present ? shortCode.value : this.shortCode,
    entityType: entityType ?? this.entityType,
    organizationType: organizationType.present
        ? organizationType.value
        : this.organizationType,
    isSystem: isSystem ?? this.isSystem,
    iconKey: iconKey.present ? iconKey.value : this.iconKey,
    contactNumber: contactNumber.present
        ? contactNumber.value
        : this.contactNumber,
    emailAddress: emailAddress.present ? emailAddress.value : this.emailAddress,
    metadata: metadata.present ? metadata.value : this.metadata,
  );
  EntitiesTableData copyWithCompanion(EntitiesTableCompanion data) {
    return EntitiesTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      shortCode: data.shortCode.present ? data.shortCode.value : this.shortCode,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      organizationType: data.organizationType.present
          ? data.organizationType.value
          : this.organizationType,
      isSystem: data.isSystem.present ? data.isSystem.value : this.isSystem,
      iconKey: data.iconKey.present ? data.iconKey.value : this.iconKey,
      contactNumber: data.contactNumber.present
          ? data.contactNumber.value
          : this.contactNumber,
      emailAddress: data.emailAddress.present
          ? data.emailAddress.value
          : this.emailAddress,
      metadata: data.metadata.present ? data.metadata.value : this.metadata,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EntitiesTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('displayName: $displayName, ')
          ..write('shortCode: $shortCode, ')
          ..write('entityType: $entityType, ')
          ..write('organizationType: $organizationType, ')
          ..write('isSystem: $isSystem, ')
          ..write('iconKey: $iconKey, ')
          ..write('contactNumber: $contactNumber, ')
          ..write('emailAddress: $emailAddress, ')
          ..write('metadata: $metadata')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    displayName,
    shortCode,
    entityType,
    organizationType,
    isSystem,
    iconKey,
    contactNumber,
    emailAddress,
    metadata,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EntitiesTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.displayName == this.displayName &&
          other.shortCode == this.shortCode &&
          other.entityType == this.entityType &&
          other.organizationType == this.organizationType &&
          other.isSystem == this.isSystem &&
          other.iconKey == this.iconKey &&
          other.contactNumber == this.contactNumber &&
          other.emailAddress == this.emailAddress &&
          other.metadata == this.metadata);
}

class EntitiesTableCompanion extends UpdateCompanion<EntitiesTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> displayName;
  final Value<String?> shortCode;
  final Value<String> entityType;
  final Value<String?> organizationType;
  final Value<bool> isSystem;
  final Value<String?> iconKey;
  final Value<String?> contactNumber;
  final Value<String?> emailAddress;
  final Value<String?> metadata;
  const EntitiesTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.displayName = const Value.absent(),
    this.shortCode = const Value.absent(),
    this.entityType = const Value.absent(),
    this.organizationType = const Value.absent(),
    this.isSystem = const Value.absent(),
    this.iconKey = const Value.absent(),
    this.contactNumber = const Value.absent(),
    this.emailAddress = const Value.absent(),
    this.metadata = const Value.absent(),
  });
  EntitiesTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.displayName = const Value.absent(),
    this.shortCode = const Value.absent(),
    required String entityType,
    this.organizationType = const Value.absent(),
    this.isSystem = const Value.absent(),
    this.iconKey = const Value.absent(),
    this.contactNumber = const Value.absent(),
    this.emailAddress = const Value.absent(),
    this.metadata = const Value.absent(),
  }) : name = Value(name),
       entityType = Value(entityType);
  static Insertable<EntitiesTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? displayName,
    Expression<String>? shortCode,
    Expression<String>? entityType,
    Expression<String>? organizationType,
    Expression<bool>? isSystem,
    Expression<String>? iconKey,
    Expression<String>? contactNumber,
    Expression<String>? emailAddress,
    Expression<String>? metadata,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (displayName != null) 'display_name': displayName,
      if (shortCode != null) 'short_code': shortCode,
      if (entityType != null) 'entity_type': entityType,
      if (organizationType != null) 'organization_type': organizationType,
      if (isSystem != null) 'is_system': isSystem,
      if (iconKey != null) 'icon_key': iconKey,
      if (contactNumber != null) 'contact_number': contactNumber,
      if (emailAddress != null) 'email_address': emailAddress,
      if (metadata != null) 'metadata': metadata,
    });
  }

  EntitiesTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? displayName,
    Value<String?>? shortCode,
    Value<String>? entityType,
    Value<String?>? organizationType,
    Value<bool>? isSystem,
    Value<String?>? iconKey,
    Value<String?>? contactNumber,
    Value<String?>? emailAddress,
    Value<String?>? metadata,
  }) {
    return EntitiesTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      displayName: displayName ?? this.displayName,
      shortCode: shortCode ?? this.shortCode,
      entityType: entityType ?? this.entityType,
      organizationType: organizationType ?? this.organizationType,
      isSystem: isSystem ?? this.isSystem,
      iconKey: iconKey ?? this.iconKey,
      contactNumber: contactNumber ?? this.contactNumber,
      emailAddress: emailAddress ?? this.emailAddress,
      metadata: metadata ?? this.metadata,
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
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (shortCode.present) {
      map['short_code'] = Variable<String>(shortCode.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (organizationType.present) {
      map['organization_type'] = Variable<String>(organizationType.value);
    }
    if (isSystem.present) {
      map['is_system'] = Variable<bool>(isSystem.value);
    }
    if (iconKey.present) {
      map['icon_key'] = Variable<String>(iconKey.value);
    }
    if (contactNumber.present) {
      map['contact_number'] = Variable<String>(contactNumber.value);
    }
    if (emailAddress.present) {
      map['email_address'] = Variable<String>(emailAddress.value);
    }
    if (metadata.present) {
      map['metadata'] = Variable<String>(metadata.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EntitiesTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('displayName: $displayName, ')
          ..write('shortCode: $shortCode, ')
          ..write('entityType: $entityType, ')
          ..write('organizationType: $organizationType, ')
          ..write('isSystem: $isSystem, ')
          ..write('iconKey: $iconKey, ')
          ..write('contactNumber: $contactNumber, ')
          ..write('emailAddress: $emailAddress, ')
          ..write('metadata: $metadata')
          ..write(')'))
        .toString();
  }
}

class $TransactionParticipantsTableTable extends TransactionParticipantsTable
    with
        TableInfo<
          $TransactionParticipantsTableTable,
          TransactionParticipantsTableData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionParticipantsTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _transactionIdMeta = const VerificationMeta(
    'transactionId',
  );
  @override
  late final GeneratedColumn<int> transactionId = GeneratedColumn<int>(
    'transaction_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES transactions_table (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<int> entityId = GeneratedColumn<int>(
    'entity_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES entities_table (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _allocatedAmountMeta = const VerificationMeta(
    'allocatedAmount',
  );
  @override
  late final GeneratedColumn<double> allocatedAmount = GeneratedColumn<double>(
    'allocated_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _allocationPercentageMeta =
      const VerificationMeta('allocationPercentage');
  @override
  late final GeneratedColumn<double> allocationPercentage =
      GeneratedColumn<double>(
        'allocation_percentage',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _isPayerMeta = const VerificationMeta(
    'isPayer',
  );
  @override
  late final GeneratedColumn<bool> isPayer = GeneratedColumn<bool>(
    'is_payer',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_payer" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _displayNameSnapshotMeta =
      const VerificationMeta('displayNameSnapshot');
  @override
  late final GeneratedColumn<String> displayNameSnapshot =
      GeneratedColumn<String>(
        'display_name_snapshot',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    transactionId,
    entityId,
    allocatedAmount,
    allocationPercentage,
    isPayer,
    displayNameSnapshot,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transaction_participants_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<TransactionParticipantsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('transaction_id')) {
      context.handle(
        _transactionIdMeta,
        transactionId.isAcceptableOrUnknown(
          data['transaction_id']!,
          _transactionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transactionIdMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('allocated_amount')) {
      context.handle(
        _allocatedAmountMeta,
        allocatedAmount.isAcceptableOrUnknown(
          data['allocated_amount']!,
          _allocatedAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_allocatedAmountMeta);
    }
    if (data.containsKey('allocation_percentage')) {
      context.handle(
        _allocationPercentageMeta,
        allocationPercentage.isAcceptableOrUnknown(
          data['allocation_percentage']!,
          _allocationPercentageMeta,
        ),
      );
    }
    if (data.containsKey('is_payer')) {
      context.handle(
        _isPayerMeta,
        isPayer.isAcceptableOrUnknown(data['is_payer']!, _isPayerMeta),
      );
    }
    if (data.containsKey('display_name_snapshot')) {
      context.handle(
        _displayNameSnapshotMeta,
        displayNameSnapshot.isAcceptableOrUnknown(
          data['display_name_snapshot']!,
          _displayNameSnapshotMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {transactionId, entityId},
  ];
  @override
  TransactionParticipantsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionParticipantsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      transactionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}transaction_id'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}entity_id'],
      )!,
      allocatedAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}allocated_amount'],
      )!,
      allocationPercentage: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}allocation_percentage'],
      ),
      isPayer: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_payer'],
      )!,
      displayNameSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name_snapshot'],
      ),
    );
  }

  @override
  $TransactionParticipantsTableTable createAlias(String alias) {
    return $TransactionParticipantsTableTable(attachedDatabase, alias);
  }
}

class TransactionParticipantsTableData extends DataClass
    implements Insertable<TransactionParticipantsTableData> {
  final int id;
  final int transactionId;
  final int entityId;
  final double allocatedAmount;
  final double? allocationPercentage;
  final bool isPayer;
  final String? displayNameSnapshot;
  const TransactionParticipantsTableData({
    required this.id,
    required this.transactionId,
    required this.entityId,
    required this.allocatedAmount,
    this.allocationPercentage,
    required this.isPayer,
    this.displayNameSnapshot,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['transaction_id'] = Variable<int>(transactionId);
    map['entity_id'] = Variable<int>(entityId);
    map['allocated_amount'] = Variable<double>(allocatedAmount);
    if (!nullToAbsent || allocationPercentage != null) {
      map['allocation_percentage'] = Variable<double>(allocationPercentage);
    }
    map['is_payer'] = Variable<bool>(isPayer);
    if (!nullToAbsent || displayNameSnapshot != null) {
      map['display_name_snapshot'] = Variable<String>(displayNameSnapshot);
    }
    return map;
  }

  TransactionParticipantsTableCompanion toCompanion(bool nullToAbsent) {
    return TransactionParticipantsTableCompanion(
      id: Value(id),
      transactionId: Value(transactionId),
      entityId: Value(entityId),
      allocatedAmount: Value(allocatedAmount),
      allocationPercentage: allocationPercentage == null && nullToAbsent
          ? const Value.absent()
          : Value(allocationPercentage),
      isPayer: Value(isPayer),
      displayNameSnapshot: displayNameSnapshot == null && nullToAbsent
          ? const Value.absent()
          : Value(displayNameSnapshot),
    );
  }

  factory TransactionParticipantsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionParticipantsTableData(
      id: serializer.fromJson<int>(json['id']),
      transactionId: serializer.fromJson<int>(json['transactionId']),
      entityId: serializer.fromJson<int>(json['entityId']),
      allocatedAmount: serializer.fromJson<double>(json['allocatedAmount']),
      allocationPercentage: serializer.fromJson<double?>(
        json['allocationPercentage'],
      ),
      isPayer: serializer.fromJson<bool>(json['isPayer']),
      displayNameSnapshot: serializer.fromJson<String?>(
        json['displayNameSnapshot'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'transactionId': serializer.toJson<int>(transactionId),
      'entityId': serializer.toJson<int>(entityId),
      'allocatedAmount': serializer.toJson<double>(allocatedAmount),
      'allocationPercentage': serializer.toJson<double?>(allocationPercentage),
      'isPayer': serializer.toJson<bool>(isPayer),
      'displayNameSnapshot': serializer.toJson<String?>(displayNameSnapshot),
    };
  }

  TransactionParticipantsTableData copyWith({
    int? id,
    int? transactionId,
    int? entityId,
    double? allocatedAmount,
    Value<double?> allocationPercentage = const Value.absent(),
    bool? isPayer,
    Value<String?> displayNameSnapshot = const Value.absent(),
  }) => TransactionParticipantsTableData(
    id: id ?? this.id,
    transactionId: transactionId ?? this.transactionId,
    entityId: entityId ?? this.entityId,
    allocatedAmount: allocatedAmount ?? this.allocatedAmount,
    allocationPercentage: allocationPercentage.present
        ? allocationPercentage.value
        : this.allocationPercentage,
    isPayer: isPayer ?? this.isPayer,
    displayNameSnapshot: displayNameSnapshot.present
        ? displayNameSnapshot.value
        : this.displayNameSnapshot,
  );
  TransactionParticipantsTableData copyWithCompanion(
    TransactionParticipantsTableCompanion data,
  ) {
    return TransactionParticipantsTableData(
      id: data.id.present ? data.id.value : this.id,
      transactionId: data.transactionId.present
          ? data.transactionId.value
          : this.transactionId,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      allocatedAmount: data.allocatedAmount.present
          ? data.allocatedAmount.value
          : this.allocatedAmount,
      allocationPercentage: data.allocationPercentage.present
          ? data.allocationPercentage.value
          : this.allocationPercentage,
      isPayer: data.isPayer.present ? data.isPayer.value : this.isPayer,
      displayNameSnapshot: data.displayNameSnapshot.present
          ? data.displayNameSnapshot.value
          : this.displayNameSnapshot,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransactionParticipantsTableData(')
          ..write('id: $id, ')
          ..write('transactionId: $transactionId, ')
          ..write('entityId: $entityId, ')
          ..write('allocatedAmount: $allocatedAmount, ')
          ..write('allocationPercentage: $allocationPercentage, ')
          ..write('isPayer: $isPayer, ')
          ..write('displayNameSnapshot: $displayNameSnapshot')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    transactionId,
    entityId,
    allocatedAmount,
    allocationPercentage,
    isPayer,
    displayNameSnapshot,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionParticipantsTableData &&
          other.id == this.id &&
          other.transactionId == this.transactionId &&
          other.entityId == this.entityId &&
          other.allocatedAmount == this.allocatedAmount &&
          other.allocationPercentage == this.allocationPercentage &&
          other.isPayer == this.isPayer &&
          other.displayNameSnapshot == this.displayNameSnapshot);
}

class TransactionParticipantsTableCompanion
    extends UpdateCompanion<TransactionParticipantsTableData> {
  final Value<int> id;
  final Value<int> transactionId;
  final Value<int> entityId;
  final Value<double> allocatedAmount;
  final Value<double?> allocationPercentage;
  final Value<bool> isPayer;
  final Value<String?> displayNameSnapshot;
  const TransactionParticipantsTableCompanion({
    this.id = const Value.absent(),
    this.transactionId = const Value.absent(),
    this.entityId = const Value.absent(),
    this.allocatedAmount = const Value.absent(),
    this.allocationPercentage = const Value.absent(),
    this.isPayer = const Value.absent(),
    this.displayNameSnapshot = const Value.absent(),
  });
  TransactionParticipantsTableCompanion.insert({
    this.id = const Value.absent(),
    required int transactionId,
    required int entityId,
    required double allocatedAmount,
    this.allocationPercentage = const Value.absent(),
    this.isPayer = const Value.absent(),
    this.displayNameSnapshot = const Value.absent(),
  }) : transactionId = Value(transactionId),
       entityId = Value(entityId),
       allocatedAmount = Value(allocatedAmount);
  static Insertable<TransactionParticipantsTableData> custom({
    Expression<int>? id,
    Expression<int>? transactionId,
    Expression<int>? entityId,
    Expression<double>? allocatedAmount,
    Expression<double>? allocationPercentage,
    Expression<bool>? isPayer,
    Expression<String>? displayNameSnapshot,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (transactionId != null) 'transaction_id': transactionId,
      if (entityId != null) 'entity_id': entityId,
      if (allocatedAmount != null) 'allocated_amount': allocatedAmount,
      if (allocationPercentage != null)
        'allocation_percentage': allocationPercentage,
      if (isPayer != null) 'is_payer': isPayer,
      if (displayNameSnapshot != null)
        'display_name_snapshot': displayNameSnapshot,
    });
  }

  TransactionParticipantsTableCompanion copyWith({
    Value<int>? id,
    Value<int>? transactionId,
    Value<int>? entityId,
    Value<double>? allocatedAmount,
    Value<double?>? allocationPercentage,
    Value<bool>? isPayer,
    Value<String?>? displayNameSnapshot,
  }) {
    return TransactionParticipantsTableCompanion(
      id: id ?? this.id,
      transactionId: transactionId ?? this.transactionId,
      entityId: entityId ?? this.entityId,
      allocatedAmount: allocatedAmount ?? this.allocatedAmount,
      allocationPercentage: allocationPercentage ?? this.allocationPercentage,
      isPayer: isPayer ?? this.isPayer,
      displayNameSnapshot: displayNameSnapshot ?? this.displayNameSnapshot,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (transactionId.present) {
      map['transaction_id'] = Variable<int>(transactionId.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<int>(entityId.value);
    }
    if (allocatedAmount.present) {
      map['allocated_amount'] = Variable<double>(allocatedAmount.value);
    }
    if (allocationPercentage.present) {
      map['allocation_percentage'] = Variable<double>(
        allocationPercentage.value,
      );
    }
    if (isPayer.present) {
      map['is_payer'] = Variable<bool>(isPayer.value);
    }
    if (displayNameSnapshot.present) {
      map['display_name_snapshot'] = Variable<String>(
        displayNameSnapshot.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionParticipantsTableCompanion(')
          ..write('id: $id, ')
          ..write('transactionId: $transactionId, ')
          ..write('entityId: $entityId, ')
          ..write('allocatedAmount: $allocatedAmount, ')
          ..write('allocationPercentage: $allocationPercentage, ')
          ..write('isPayer: $isPayer, ')
          ..write('displayNameSnapshot: $displayNameSnapshot')
          ..write(')'))
        .toString();
  }
}

class $FinancialObligationsTableTable extends FinancialObligationsTable
    with
        TableInfo<
          $FinancialObligationsTableTable,
          FinancialObligationsTableData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FinancialObligationsTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _transactionIdMeta = const VerificationMeta(
    'transactionId',
  );
  @override
  late final GeneratedColumn<int> transactionId = GeneratedColumn<int>(
    'transaction_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES transactions_table (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _debtorEntityIdMeta = const VerificationMeta(
    'debtorEntityId',
  );
  @override
  late final GeneratedColumn<int> debtorEntityId = GeneratedColumn<int>(
    'debtor_entity_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES entities_table (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _creditorEntityIdMeta = const VerificationMeta(
    'creditorEntityId',
  );
  @override
  late final GeneratedColumn<int> creditorEntityId = GeneratedColumn<int>(
    'creditor_entity_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES entities_table (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    transactionId,
    debtorEntityId,
    creditorEntityId,
    amount,
    type,
    note,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'financial_obligations_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<FinancialObligationsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('transaction_id')) {
      context.handle(
        _transactionIdMeta,
        transactionId.isAcceptableOrUnknown(
          data['transaction_id']!,
          _transactionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transactionIdMeta);
    }
    if (data.containsKey('debtor_entity_id')) {
      context.handle(
        _debtorEntityIdMeta,
        debtorEntityId.isAcceptableOrUnknown(
          data['debtor_entity_id']!,
          _debtorEntityIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_debtorEntityIdMeta);
    }
    if (data.containsKey('creditor_entity_id')) {
      context.handle(
        _creditorEntityIdMeta,
        creditorEntityId.isAcceptableOrUnknown(
          data['creditor_entity_id']!,
          _creditorEntityIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_creditorEntityIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FinancialObligationsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FinancialObligationsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      transactionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}transaction_id'],
      )!,
      debtorEntityId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}debtor_entity_id'],
      )!,
      creditorEntityId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}creditor_entity_id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $FinancialObligationsTableTable createAlias(String alias) {
    return $FinancialObligationsTableTable(attachedDatabase, alias);
  }
}

class FinancialObligationsTableData extends DataClass
    implements Insertable<FinancialObligationsTableData> {
  final int id;
  final int transactionId;
  final int debtorEntityId;
  final int creditorEntityId;
  final double amount;
  final String type;
  final String? note;
  final DateTime createdAt;
  const FinancialObligationsTableData({
    required this.id,
    required this.transactionId,
    required this.debtorEntityId,
    required this.creditorEntityId,
    required this.amount,
    required this.type,
    this.note,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['transaction_id'] = Variable<int>(transactionId);
    map['debtor_entity_id'] = Variable<int>(debtorEntityId);
    map['creditor_entity_id'] = Variable<int>(creditorEntityId);
    map['amount'] = Variable<double>(amount);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FinancialObligationsTableCompanion toCompanion(bool nullToAbsent) {
    return FinancialObligationsTableCompanion(
      id: Value(id),
      transactionId: Value(transactionId),
      debtorEntityId: Value(debtorEntityId),
      creditorEntityId: Value(creditorEntityId),
      amount: Value(amount),
      type: Value(type),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
    );
  }

  factory FinancialObligationsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FinancialObligationsTableData(
      id: serializer.fromJson<int>(json['id']),
      transactionId: serializer.fromJson<int>(json['transactionId']),
      debtorEntityId: serializer.fromJson<int>(json['debtorEntityId']),
      creditorEntityId: serializer.fromJson<int>(json['creditorEntityId']),
      amount: serializer.fromJson<double>(json['amount']),
      type: serializer.fromJson<String>(json['type']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'transactionId': serializer.toJson<int>(transactionId),
      'debtorEntityId': serializer.toJson<int>(debtorEntityId),
      'creditorEntityId': serializer.toJson<int>(creditorEntityId),
      'amount': serializer.toJson<double>(amount),
      'type': serializer.toJson<String>(type),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  FinancialObligationsTableData copyWith({
    int? id,
    int? transactionId,
    int? debtorEntityId,
    int? creditorEntityId,
    double? amount,
    String? type,
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
  }) => FinancialObligationsTableData(
    id: id ?? this.id,
    transactionId: transactionId ?? this.transactionId,
    debtorEntityId: debtorEntityId ?? this.debtorEntityId,
    creditorEntityId: creditorEntityId ?? this.creditorEntityId,
    amount: amount ?? this.amount,
    type: type ?? this.type,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
  );
  FinancialObligationsTableData copyWithCompanion(
    FinancialObligationsTableCompanion data,
  ) {
    return FinancialObligationsTableData(
      id: data.id.present ? data.id.value : this.id,
      transactionId: data.transactionId.present
          ? data.transactionId.value
          : this.transactionId,
      debtorEntityId: data.debtorEntityId.present
          ? data.debtorEntityId.value
          : this.debtorEntityId,
      creditorEntityId: data.creditorEntityId.present
          ? data.creditorEntityId.value
          : this.creditorEntityId,
      amount: data.amount.present ? data.amount.value : this.amount,
      type: data.type.present ? data.type.value : this.type,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FinancialObligationsTableData(')
          ..write('id: $id, ')
          ..write('transactionId: $transactionId, ')
          ..write('debtorEntityId: $debtorEntityId, ')
          ..write('creditorEntityId: $creditorEntityId, ')
          ..write('amount: $amount, ')
          ..write('type: $type, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    transactionId,
    debtorEntityId,
    creditorEntityId,
    amount,
    type,
    note,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FinancialObligationsTableData &&
          other.id == this.id &&
          other.transactionId == this.transactionId &&
          other.debtorEntityId == this.debtorEntityId &&
          other.creditorEntityId == this.creditorEntityId &&
          other.amount == this.amount &&
          other.type == this.type &&
          other.note == this.note &&
          other.createdAt == this.createdAt);
}

class FinancialObligationsTableCompanion
    extends UpdateCompanion<FinancialObligationsTableData> {
  final Value<int> id;
  final Value<int> transactionId;
  final Value<int> debtorEntityId;
  final Value<int> creditorEntityId;
  final Value<double> amount;
  final Value<String> type;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  const FinancialObligationsTableCompanion({
    this.id = const Value.absent(),
    this.transactionId = const Value.absent(),
    this.debtorEntityId = const Value.absent(),
    this.creditorEntityId = const Value.absent(),
    this.amount = const Value.absent(),
    this.type = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  FinancialObligationsTableCompanion.insert({
    this.id = const Value.absent(),
    required int transactionId,
    required int debtorEntityId,
    required int creditorEntityId,
    required double amount,
    required String type,
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : transactionId = Value(transactionId),
       debtorEntityId = Value(debtorEntityId),
       creditorEntityId = Value(creditorEntityId),
       amount = Value(amount),
       type = Value(type);
  static Insertable<FinancialObligationsTableData> custom({
    Expression<int>? id,
    Expression<int>? transactionId,
    Expression<int>? debtorEntityId,
    Expression<int>? creditorEntityId,
    Expression<double>? amount,
    Expression<String>? type,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (transactionId != null) 'transaction_id': transactionId,
      if (debtorEntityId != null) 'debtor_entity_id': debtorEntityId,
      if (creditorEntityId != null) 'creditor_entity_id': creditorEntityId,
      if (amount != null) 'amount': amount,
      if (type != null) 'type': type,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  FinancialObligationsTableCompanion copyWith({
    Value<int>? id,
    Value<int>? transactionId,
    Value<int>? debtorEntityId,
    Value<int>? creditorEntityId,
    Value<double>? amount,
    Value<String>? type,
    Value<String?>? note,
    Value<DateTime>? createdAt,
  }) {
    return FinancialObligationsTableCompanion(
      id: id ?? this.id,
      transactionId: transactionId ?? this.transactionId,
      debtorEntityId: debtorEntityId ?? this.debtorEntityId,
      creditorEntityId: creditorEntityId ?? this.creditorEntityId,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (transactionId.present) {
      map['transaction_id'] = Variable<int>(transactionId.value);
    }
    if (debtorEntityId.present) {
      map['debtor_entity_id'] = Variable<int>(debtorEntityId.value);
    }
    if (creditorEntityId.present) {
      map['creditor_entity_id'] = Variable<int>(creditorEntityId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FinancialObligationsTableCompanion(')
          ..write('id: $id, ')
          ..write('transactionId: $transactionId, ')
          ..write('debtorEntityId: $debtorEntityId, ')
          ..write('creditorEntityId: $creditorEntityId, ')
          ..write('amount: $amount, ')
          ..write('type: $type, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CashflowPlansTableTable extends CashflowPlansTable
    with TableInfo<$CashflowPlansTableTable, CashflowPlansTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CashflowPlansTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _planTypeMeta = const VerificationMeta(
    'planType',
  );
  @override
  late final GeneratedColumn<String> planType = GeneratedColumn<String>(
    'plan_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expenseModeMeta = const VerificationMeta(
    'expenseMode',
  );
  @override
  late final GeneratedColumn<String> expenseMode = GeneratedColumn<String>(
    'expense_mode',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES cashflow_categories_table (id)',
    ),
  );
  static const VerificationMeta _debtIdMeta = const VerificationMeta('debtId');
  @override
  late final GeneratedColumn<int> debtId = GeneratedColumn<int>(
    'debt_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _customAmountsJsonMeta = const VerificationMeta(
    'customAmountsJson',
  );
  @override
  late final GeneratedColumn<String> customAmountsJson =
      GeneratedColumn<String>(
        'custom_amounts_json',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _frequencyMeta = const VerificationMeta(
    'frequency',
  );
  @override
  late final GeneratedColumn<String> frequency = GeneratedColumn<String>(
    'frequency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _monthMaskMeta = const VerificationMeta(
    'monthMask',
  );
  @override
  late final GeneratedColumn<int> monthMask = GeneratedColumn<int>(
    'month_mask',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _occurrenceDaysJsonMeta =
      const VerificationMeta('occurrenceDaysJson');
  @override
  late final GeneratedColumn<String> occurrenceDaysJson =
      GeneratedColumn<String>(
        'occurrence_days_json',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _anchorDateMeta = const VerificationMeta(
    'anchorDate',
  );
  @override
  late final GeneratedColumn<DateTime> anchorDate = GeneratedColumn<DateTime>(
    'anchor_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dependentSurvivalFactorMeta =
      const VerificationMeta('dependentSurvivalFactor');
  @override
  late final GeneratedColumn<double> dependentSurvivalFactor =
      GeneratedColumn<double>(
        'dependent_survival_factor',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    planType,
    expenseMode,
    categoryId,
    debtId,
    amount,
    customAmountsJson,
    frequency,
    monthMask,
    occurrenceDaysJson,
    anchorDate,
    dependentSurvivalFactor,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cashflow_plans_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<CashflowPlansTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('plan_type')) {
      context.handle(
        _planTypeMeta,
        planType.isAcceptableOrUnknown(data['plan_type']!, _planTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_planTypeMeta);
    }
    if (data.containsKey('expense_mode')) {
      context.handle(
        _expenseModeMeta,
        expenseMode.isAcceptableOrUnknown(
          data['expense_mode']!,
          _expenseModeMeta,
        ),
      );
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('debt_id')) {
      context.handle(
        _debtIdMeta,
        debtId.isAcceptableOrUnknown(data['debt_id']!, _debtIdMeta),
      );
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    }
    if (data.containsKey('custom_amounts_json')) {
      context.handle(
        _customAmountsJsonMeta,
        customAmountsJson.isAcceptableOrUnknown(
          data['custom_amounts_json']!,
          _customAmountsJsonMeta,
        ),
      );
    }
    if (data.containsKey('frequency')) {
      context.handle(
        _frequencyMeta,
        frequency.isAcceptableOrUnknown(data['frequency']!, _frequencyMeta),
      );
    } else if (isInserting) {
      context.missing(_frequencyMeta);
    }
    if (data.containsKey('month_mask')) {
      context.handle(
        _monthMaskMeta,
        monthMask.isAcceptableOrUnknown(data['month_mask']!, _monthMaskMeta),
      );
    }
    if (data.containsKey('occurrence_days_json')) {
      context.handle(
        _occurrenceDaysJsonMeta,
        occurrenceDaysJson.isAcceptableOrUnknown(
          data['occurrence_days_json']!,
          _occurrenceDaysJsonMeta,
        ),
      );
    }
    if (data.containsKey('anchor_date')) {
      context.handle(
        _anchorDateMeta,
        anchorDate.isAcceptableOrUnknown(data['anchor_date']!, _anchorDateMeta),
      );
    }
    if (data.containsKey('dependent_survival_factor')) {
      context.handle(
        _dependentSurvivalFactorMeta,
        dependentSurvivalFactor.isAcceptableOrUnknown(
          data['dependent_survival_factor']!,
          _dependentSurvivalFactorMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CashflowPlansTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CashflowPlansTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      planType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plan_type'],
      )!,
      expenseMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}expense_mode'],
      ),
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category_id'],
      ),
      debtId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}debt_id'],
      ),
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      ),
      customAmountsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}custom_amounts_json'],
      ),
      frequency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}frequency'],
      )!,
      monthMask: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}month_mask'],
      ),
      occurrenceDaysJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}occurrence_days_json'],
      ),
      anchorDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}anchor_date'],
      ),
      dependentSurvivalFactor: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}dependent_survival_factor'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CashflowPlansTableTable createAlias(String alias) {
    return $CashflowPlansTableTable(attachedDatabase, alias);
  }
}

class CashflowPlansTableData extends DataClass
    implements Insertable<CashflowPlansTableData> {
  final int id;
  final String name;
  final String planType;
  final String? expenseMode;
  final int? categoryId;
  final int? debtId;
  final double? amount;
  final String? customAmountsJson;
  final String frequency;
  final int? monthMask;
  final String? occurrenceDaysJson;
  final DateTime? anchorDate;
  final double dependentSurvivalFactor;
  final DateTime createdAt;
  final DateTime updatedAt;
  const CashflowPlansTableData({
    required this.id,
    required this.name,
    required this.planType,
    this.expenseMode,
    this.categoryId,
    this.debtId,
    this.amount,
    this.customAmountsJson,
    required this.frequency,
    this.monthMask,
    this.occurrenceDaysJson,
    this.anchorDate,
    required this.dependentSurvivalFactor,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['plan_type'] = Variable<String>(planType);
    if (!nullToAbsent || expenseMode != null) {
      map['expense_mode'] = Variable<String>(expenseMode);
    }
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<int>(categoryId);
    }
    if (!nullToAbsent || debtId != null) {
      map['debt_id'] = Variable<int>(debtId);
    }
    if (!nullToAbsent || amount != null) {
      map['amount'] = Variable<double>(amount);
    }
    if (!nullToAbsent || customAmountsJson != null) {
      map['custom_amounts_json'] = Variable<String>(customAmountsJson);
    }
    map['frequency'] = Variable<String>(frequency);
    if (!nullToAbsent || monthMask != null) {
      map['month_mask'] = Variable<int>(monthMask);
    }
    if (!nullToAbsent || occurrenceDaysJson != null) {
      map['occurrence_days_json'] = Variable<String>(occurrenceDaysJson);
    }
    if (!nullToAbsent || anchorDate != null) {
      map['anchor_date'] = Variable<DateTime>(anchorDate);
    }
    map['dependent_survival_factor'] = Variable<double>(
      dependentSurvivalFactor,
    );
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CashflowPlansTableCompanion toCompanion(bool nullToAbsent) {
    return CashflowPlansTableCompanion(
      id: Value(id),
      name: Value(name),
      planType: Value(planType),
      expenseMode: expenseMode == null && nullToAbsent
          ? const Value.absent()
          : Value(expenseMode),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      debtId: debtId == null && nullToAbsent
          ? const Value.absent()
          : Value(debtId),
      amount: amount == null && nullToAbsent
          ? const Value.absent()
          : Value(amount),
      customAmountsJson: customAmountsJson == null && nullToAbsent
          ? const Value.absent()
          : Value(customAmountsJson),
      frequency: Value(frequency),
      monthMask: monthMask == null && nullToAbsent
          ? const Value.absent()
          : Value(monthMask),
      occurrenceDaysJson: occurrenceDaysJson == null && nullToAbsent
          ? const Value.absent()
          : Value(occurrenceDaysJson),
      anchorDate: anchorDate == null && nullToAbsent
          ? const Value.absent()
          : Value(anchorDate),
      dependentSurvivalFactor: Value(dependentSurvivalFactor),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CashflowPlansTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CashflowPlansTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      planType: serializer.fromJson<String>(json['planType']),
      expenseMode: serializer.fromJson<String?>(json['expenseMode']),
      categoryId: serializer.fromJson<int?>(json['categoryId']),
      debtId: serializer.fromJson<int?>(json['debtId']),
      amount: serializer.fromJson<double?>(json['amount']),
      customAmountsJson: serializer.fromJson<String?>(
        json['customAmountsJson'],
      ),
      frequency: serializer.fromJson<String>(json['frequency']),
      monthMask: serializer.fromJson<int?>(json['monthMask']),
      occurrenceDaysJson: serializer.fromJson<String?>(
        json['occurrenceDaysJson'],
      ),
      anchorDate: serializer.fromJson<DateTime?>(json['anchorDate']),
      dependentSurvivalFactor: serializer.fromJson<double>(
        json['dependentSurvivalFactor'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'planType': serializer.toJson<String>(planType),
      'expenseMode': serializer.toJson<String?>(expenseMode),
      'categoryId': serializer.toJson<int?>(categoryId),
      'debtId': serializer.toJson<int?>(debtId),
      'amount': serializer.toJson<double?>(amount),
      'customAmountsJson': serializer.toJson<String?>(customAmountsJson),
      'frequency': serializer.toJson<String>(frequency),
      'monthMask': serializer.toJson<int?>(monthMask),
      'occurrenceDaysJson': serializer.toJson<String?>(occurrenceDaysJson),
      'anchorDate': serializer.toJson<DateTime?>(anchorDate),
      'dependentSurvivalFactor': serializer.toJson<double>(
        dependentSurvivalFactor,
      ),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CashflowPlansTableData copyWith({
    int? id,
    String? name,
    String? planType,
    Value<String?> expenseMode = const Value.absent(),
    Value<int?> categoryId = const Value.absent(),
    Value<int?> debtId = const Value.absent(),
    Value<double?> amount = const Value.absent(),
    Value<String?> customAmountsJson = const Value.absent(),
    String? frequency,
    Value<int?> monthMask = const Value.absent(),
    Value<String?> occurrenceDaysJson = const Value.absent(),
    Value<DateTime?> anchorDate = const Value.absent(),
    double? dependentSurvivalFactor,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => CashflowPlansTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    planType: planType ?? this.planType,
    expenseMode: expenseMode.present ? expenseMode.value : this.expenseMode,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    debtId: debtId.present ? debtId.value : this.debtId,
    amount: amount.present ? amount.value : this.amount,
    customAmountsJson: customAmountsJson.present
        ? customAmountsJson.value
        : this.customAmountsJson,
    frequency: frequency ?? this.frequency,
    monthMask: monthMask.present ? monthMask.value : this.monthMask,
    occurrenceDaysJson: occurrenceDaysJson.present
        ? occurrenceDaysJson.value
        : this.occurrenceDaysJson,
    anchorDate: anchorDate.present ? anchorDate.value : this.anchorDate,
    dependentSurvivalFactor:
        dependentSurvivalFactor ?? this.dependentSurvivalFactor,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CashflowPlansTableData copyWithCompanion(CashflowPlansTableCompanion data) {
    return CashflowPlansTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      planType: data.planType.present ? data.planType.value : this.planType,
      expenseMode: data.expenseMode.present
          ? data.expenseMode.value
          : this.expenseMode,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      debtId: data.debtId.present ? data.debtId.value : this.debtId,
      amount: data.amount.present ? data.amount.value : this.amount,
      customAmountsJson: data.customAmountsJson.present
          ? data.customAmountsJson.value
          : this.customAmountsJson,
      frequency: data.frequency.present ? data.frequency.value : this.frequency,
      monthMask: data.monthMask.present ? data.monthMask.value : this.monthMask,
      occurrenceDaysJson: data.occurrenceDaysJson.present
          ? data.occurrenceDaysJson.value
          : this.occurrenceDaysJson,
      anchorDate: data.anchorDate.present
          ? data.anchorDate.value
          : this.anchorDate,
      dependentSurvivalFactor: data.dependentSurvivalFactor.present
          ? data.dependentSurvivalFactor.value
          : this.dependentSurvivalFactor,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CashflowPlansTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('planType: $planType, ')
          ..write('expenseMode: $expenseMode, ')
          ..write('categoryId: $categoryId, ')
          ..write('debtId: $debtId, ')
          ..write('amount: $amount, ')
          ..write('customAmountsJson: $customAmountsJson, ')
          ..write('frequency: $frequency, ')
          ..write('monthMask: $monthMask, ')
          ..write('occurrenceDaysJson: $occurrenceDaysJson, ')
          ..write('anchorDate: $anchorDate, ')
          ..write('dependentSurvivalFactor: $dependentSurvivalFactor, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    planType,
    expenseMode,
    categoryId,
    debtId,
    amount,
    customAmountsJson,
    frequency,
    monthMask,
    occurrenceDaysJson,
    anchorDate,
    dependentSurvivalFactor,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CashflowPlansTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.planType == this.planType &&
          other.expenseMode == this.expenseMode &&
          other.categoryId == this.categoryId &&
          other.debtId == this.debtId &&
          other.amount == this.amount &&
          other.customAmountsJson == this.customAmountsJson &&
          other.frequency == this.frequency &&
          other.monthMask == this.monthMask &&
          other.occurrenceDaysJson == this.occurrenceDaysJson &&
          other.anchorDate == this.anchorDate &&
          other.dependentSurvivalFactor == this.dependentSurvivalFactor &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CashflowPlansTableCompanion
    extends UpdateCompanion<CashflowPlansTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> planType;
  final Value<String?> expenseMode;
  final Value<int?> categoryId;
  final Value<int?> debtId;
  final Value<double?> amount;
  final Value<String?> customAmountsJson;
  final Value<String> frequency;
  final Value<int?> monthMask;
  final Value<String?> occurrenceDaysJson;
  final Value<DateTime?> anchorDate;
  final Value<double> dependentSurvivalFactor;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const CashflowPlansTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.planType = const Value.absent(),
    this.expenseMode = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.debtId = const Value.absent(),
    this.amount = const Value.absent(),
    this.customAmountsJson = const Value.absent(),
    this.frequency = const Value.absent(),
    this.monthMask = const Value.absent(),
    this.occurrenceDaysJson = const Value.absent(),
    this.anchorDate = const Value.absent(),
    this.dependentSurvivalFactor = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CashflowPlansTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String planType,
    this.expenseMode = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.debtId = const Value.absent(),
    this.amount = const Value.absent(),
    this.customAmountsJson = const Value.absent(),
    required String frequency,
    this.monthMask = const Value.absent(),
    this.occurrenceDaysJson = const Value.absent(),
    this.anchorDate = const Value.absent(),
    this.dependentSurvivalFactor = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name),
       planType = Value(planType),
       frequency = Value(frequency);
  static Insertable<CashflowPlansTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? planType,
    Expression<String>? expenseMode,
    Expression<int>? categoryId,
    Expression<int>? debtId,
    Expression<double>? amount,
    Expression<String>? customAmountsJson,
    Expression<String>? frequency,
    Expression<int>? monthMask,
    Expression<String>? occurrenceDaysJson,
    Expression<DateTime>? anchorDate,
    Expression<double>? dependentSurvivalFactor,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (planType != null) 'plan_type': planType,
      if (expenseMode != null) 'expense_mode': expenseMode,
      if (categoryId != null) 'category_id': categoryId,
      if (debtId != null) 'debt_id': debtId,
      if (amount != null) 'amount': amount,
      if (customAmountsJson != null) 'custom_amounts_json': customAmountsJson,
      if (frequency != null) 'frequency': frequency,
      if (monthMask != null) 'month_mask': monthMask,
      if (occurrenceDaysJson != null)
        'occurrence_days_json': occurrenceDaysJson,
      if (anchorDate != null) 'anchor_date': anchorDate,
      if (dependentSurvivalFactor != null)
        'dependent_survival_factor': dependentSurvivalFactor,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CashflowPlansTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? planType,
    Value<String?>? expenseMode,
    Value<int?>? categoryId,
    Value<int?>? debtId,
    Value<double?>? amount,
    Value<String?>? customAmountsJson,
    Value<String>? frequency,
    Value<int?>? monthMask,
    Value<String?>? occurrenceDaysJson,
    Value<DateTime?>? anchorDate,
    Value<double>? dependentSurvivalFactor,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return CashflowPlansTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      planType: planType ?? this.planType,
      expenseMode: expenseMode ?? this.expenseMode,
      categoryId: categoryId ?? this.categoryId,
      debtId: debtId ?? this.debtId,
      amount: amount ?? this.amount,
      customAmountsJson: customAmountsJson ?? this.customAmountsJson,
      frequency: frequency ?? this.frequency,
      monthMask: monthMask ?? this.monthMask,
      occurrenceDaysJson: occurrenceDaysJson ?? this.occurrenceDaysJson,
      anchorDate: anchorDate ?? this.anchorDate,
      dependentSurvivalFactor:
          dependentSurvivalFactor ?? this.dependentSurvivalFactor,
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
    if (planType.present) {
      map['plan_type'] = Variable<String>(planType.value);
    }
    if (expenseMode.present) {
      map['expense_mode'] = Variable<String>(expenseMode.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (debtId.present) {
      map['debt_id'] = Variable<int>(debtId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (customAmountsJson.present) {
      map['custom_amounts_json'] = Variable<String>(customAmountsJson.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<String>(frequency.value);
    }
    if (monthMask.present) {
      map['month_mask'] = Variable<int>(monthMask.value);
    }
    if (occurrenceDaysJson.present) {
      map['occurrence_days_json'] = Variable<String>(occurrenceDaysJson.value);
    }
    if (anchorDate.present) {
      map['anchor_date'] = Variable<DateTime>(anchorDate.value);
    }
    if (dependentSurvivalFactor.present) {
      map['dependent_survival_factor'] = Variable<double>(
        dependentSurvivalFactor.value,
      );
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
    return (StringBuffer('CashflowPlansTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('planType: $planType, ')
          ..write('expenseMode: $expenseMode, ')
          ..write('categoryId: $categoryId, ')
          ..write('debtId: $debtId, ')
          ..write('amount: $amount, ')
          ..write('customAmountsJson: $customAmountsJson, ')
          ..write('frequency: $frequency, ')
          ..write('monthMask: $monthMask, ')
          ..write('occurrenceDaysJson: $occurrenceDaysJson, ')
          ..write('anchorDate: $anchorDate, ')
          ..write('dependentSurvivalFactor: $dependentSurvivalFactor, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CashflowCategoriesTableTable cashflowCategoriesTable =
      $CashflowCategoriesTableTable(this);
  late final $AccountsTableTable accountsTable = $AccountsTableTable(this);
  late final $TransactionsTableTable transactionsTable =
      $TransactionsTableTable(this);
  late final $EntitiesTableTable entitiesTable = $EntitiesTableTable(this);
  late final $TransactionParticipantsTableTable transactionParticipantsTable =
      $TransactionParticipantsTableTable(this);
  late final $FinancialObligationsTableTable financialObligationsTable =
      $FinancialObligationsTableTable(this);
  late final $CashflowPlansTableTable cashflowPlansTable =
      $CashflowPlansTableTable(this);
  late final TransactionsDao transactionsDao = TransactionsDao(
    this as AppDatabase,
  );
  late final AccountsDao accountsDao = AccountsDao(this as AppDatabase);
  late final PeopleBalanceDao peopleBalanceDao = PeopleBalanceDao(
    this as AppDatabase,
  );
  late final EntitiesDao entitiesDao = EntitiesDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    cashflowCategoriesTable,
    accountsTable,
    transactionsTable,
    entitiesTable,
    transactionParticipantsTable,
    financialObligationsTable,
    cashflowPlansTable,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'transactions_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('transaction_participants_table', kind: UpdateKind.delete),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'entities_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('transaction_participants_table', kind: UpdateKind.delete),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'transactions_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('financial_obligations_table', kind: UpdateKind.delete),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'entities_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('financial_obligations_table', kind: UpdateKind.delete),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'entities_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('financial_obligations_table', kind: UpdateKind.delete),
      ],
    ),
  ]);
}

typedef $$CashflowCategoriesTableTableCreateCompanionBuilder =
    CashflowCategoriesTableCompanion Function({
      Value<int> id,
      required String name,
      required String icon,
      required String type,
      Value<bool> isDefault,
    });
typedef $$CashflowCategoriesTableTableUpdateCompanionBuilder =
    CashflowCategoriesTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> icon,
      Value<String> type,
      Value<bool> isDefault,
    });

final class $$CashflowCategoriesTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CashflowCategoriesTableTable,
          CashflowCategoriesTableData
        > {
  $$CashflowCategoriesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $TransactionsTableTable,
    List<TransactionsTableData>
  >
  _transactionsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.transactionsTable,
        aliasName: $_aliasNameGenerator(
          db.cashflowCategoriesTable.id,
          db.transactionsTable.categoryId,
        ),
      );

  $$TransactionsTableTableProcessedTableManager get transactionsTableRefs {
    final manager = $$TransactionsTableTableTableManager(
      $_db,
      $_db.transactionsTable,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _transactionsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $CashflowPlansTableTable,
    List<CashflowPlansTableData>
  >
  _cashflowPlansTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.cashflowPlansTable,
        aliasName: $_aliasNameGenerator(
          db.cashflowCategoriesTable.id,
          db.cashflowPlansTable.categoryId,
        ),
      );

  $$CashflowPlansTableTableProcessedTableManager get cashflowPlansTableRefs {
    final manager = $$CashflowPlansTableTableTableManager(
      $_db,
      $_db.cashflowPlansTable,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _cashflowPlansTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CashflowCategoriesTableTableFilterComposer
    extends Composer<_$AppDatabase, $CashflowCategoriesTableTable> {
  $$CashflowCategoriesTableTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> transactionsTableRefs(
    Expression<bool> Function($$TransactionsTableTableFilterComposer f) f,
  ) {
    final $$TransactionsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactionsTable,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableTableFilterComposer(
            $db: $db,
            $table: $db.transactionsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> cashflowPlansTableRefs(
    Expression<bool> Function($$CashflowPlansTableTableFilterComposer f) f,
  ) {
    final $$CashflowPlansTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cashflowPlansTable,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CashflowPlansTableTableFilterComposer(
            $db: $db,
            $table: $db.cashflowPlansTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CashflowCategoriesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CashflowCategoriesTableTable> {
  $$CashflowCategoriesTableTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CashflowCategoriesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CashflowCategoriesTableTable> {
  $$CashflowCategoriesTableTableAnnotationComposer({
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

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);

  Expression<T> transactionsTableRefs<T extends Object>(
    Expression<T> Function($$TransactionsTableTableAnnotationComposer a) f,
  ) {
    final $$TransactionsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.transactionsTable,
          getReferencedColumn: (t) => t.categoryId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TransactionsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.transactionsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> cashflowPlansTableRefs<T extends Object>(
    Expression<T> Function($$CashflowPlansTableTableAnnotationComposer a) f,
  ) {
    final $$CashflowPlansTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.cashflowPlansTable,
          getReferencedColumn: (t) => t.categoryId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CashflowPlansTableTableAnnotationComposer(
                $db: $db,
                $table: $db.cashflowPlansTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$CashflowCategoriesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CashflowCategoriesTableTable,
          CashflowCategoriesTableData,
          $$CashflowCategoriesTableTableFilterComposer,
          $$CashflowCategoriesTableTableOrderingComposer,
          $$CashflowCategoriesTableTableAnnotationComposer,
          $$CashflowCategoriesTableTableCreateCompanionBuilder,
          $$CashflowCategoriesTableTableUpdateCompanionBuilder,
          (
            CashflowCategoriesTableData,
            $$CashflowCategoriesTableTableReferences,
          ),
          CashflowCategoriesTableData,
          PrefetchHooks Function({
            bool transactionsTableRefs,
            bool cashflowPlansTableRefs,
          })
        > {
  $$CashflowCategoriesTableTableTableManager(
    _$AppDatabase db,
    $CashflowCategoriesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CashflowCategoriesTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$CashflowCategoriesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CashflowCategoriesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> icon = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
              }) => CashflowCategoriesTableCompanion(
                id: id,
                name: name,
                icon: icon,
                type: type,
                isDefault: isDefault,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String icon,
                required String type,
                Value<bool> isDefault = const Value.absent(),
              }) => CashflowCategoriesTableCompanion.insert(
                id: id,
                name: name,
                icon: icon,
                type: type,
                isDefault: isDefault,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CashflowCategoriesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                transactionsTableRefs = false,
                cashflowPlansTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (transactionsTableRefs) db.transactionsTable,
                    if (cashflowPlansTableRefs) db.cashflowPlansTable,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (transactionsTableRefs)
                        await $_getPrefetchedData<
                          CashflowCategoriesTableData,
                          $CashflowCategoriesTableTable,
                          TransactionsTableData
                        >(
                          currentTable: table,
                          referencedTable:
                              $$CashflowCategoriesTableTableReferences
                                  ._transactionsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CashflowCategoriesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).transactionsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.categoryId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (cashflowPlansTableRefs)
                        await $_getPrefetchedData<
                          CashflowCategoriesTableData,
                          $CashflowCategoriesTableTable,
                          CashflowPlansTableData
                        >(
                          currentTable: table,
                          referencedTable:
                              $$CashflowCategoriesTableTableReferences
                                  ._cashflowPlansTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CashflowCategoriesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).cashflowPlansTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.categoryId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CashflowCategoriesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CashflowCategoriesTableTable,
      CashflowCategoriesTableData,
      $$CashflowCategoriesTableTableFilterComposer,
      $$CashflowCategoriesTableTableOrderingComposer,
      $$CashflowCategoriesTableTableAnnotationComposer,
      $$CashflowCategoriesTableTableCreateCompanionBuilder,
      $$CashflowCategoriesTableTableUpdateCompanionBuilder,
      (CashflowCategoriesTableData, $$CashflowCategoriesTableTableReferences),
      CashflowCategoriesTableData,
      PrefetchHooks Function({
        bool transactionsTableRefs,
        bool cashflowPlansTableRefs,
      })
    >;
typedef $$AccountsTableTableCreateCompanionBuilder =
    AccountsTableCompanion Function({
      Value<int> id,
      required String name,
      required String icon,
      required String accountType,
      Value<double> currentValue,
      Value<bool> isSystem,
      Value<double?> creditLimit,
    });
typedef $$AccountsTableTableUpdateCompanionBuilder =
    AccountsTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> icon,
      Value<String> accountType,
      Value<double> currentValue,
      Value<bool> isSystem,
      Value<double?> creditLimit,
    });

class $$AccountsTableTableFilterComposer
    extends Composer<_$AppDatabase, $AccountsTableTable> {
  $$AccountsTableTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accountType => $composableBuilder(
    column: $table.accountType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get currentValue => $composableBuilder(
    column: $table.currentValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSystem => $composableBuilder(
    column: $table.isSystem,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get creditLimit => $composableBuilder(
    column: $table.creditLimit,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AccountsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AccountsTableTable> {
  $$AccountsTableTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accountType => $composableBuilder(
    column: $table.accountType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get currentValue => $composableBuilder(
    column: $table.currentValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSystem => $composableBuilder(
    column: $table.isSystem,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get creditLimit => $composableBuilder(
    column: $table.creditLimit,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AccountsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AccountsTableTable> {
  $$AccountsTableTableAnnotationComposer({
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

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<String> get accountType => $composableBuilder(
    column: $table.accountType,
    builder: (column) => column,
  );

  GeneratedColumn<double> get currentValue => $composableBuilder(
    column: $table.currentValue,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSystem =>
      $composableBuilder(column: $table.isSystem, builder: (column) => column);

  GeneratedColumn<double> get creditLimit => $composableBuilder(
    column: $table.creditLimit,
    builder: (column) => column,
  );
}

class $$AccountsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AccountsTableTable,
          AccountsTableData,
          $$AccountsTableTableFilterComposer,
          $$AccountsTableTableOrderingComposer,
          $$AccountsTableTableAnnotationComposer,
          $$AccountsTableTableCreateCompanionBuilder,
          $$AccountsTableTableUpdateCompanionBuilder,
          (
            AccountsTableData,
            BaseReferences<
              _$AppDatabase,
              $AccountsTableTable,
              AccountsTableData
            >,
          ),
          AccountsTableData,
          PrefetchHooks Function()
        > {
  $$AccountsTableTableTableManager(_$AppDatabase db, $AccountsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AccountsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AccountsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AccountsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> icon = const Value.absent(),
                Value<String> accountType = const Value.absent(),
                Value<double> currentValue = const Value.absent(),
                Value<bool> isSystem = const Value.absent(),
                Value<double?> creditLimit = const Value.absent(),
              }) => AccountsTableCompanion(
                id: id,
                name: name,
                icon: icon,
                accountType: accountType,
                currentValue: currentValue,
                isSystem: isSystem,
                creditLimit: creditLimit,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String icon,
                required String accountType,
                Value<double> currentValue = const Value.absent(),
                Value<bool> isSystem = const Value.absent(),
                Value<double?> creditLimit = const Value.absent(),
              }) => AccountsTableCompanion.insert(
                id: id,
                name: name,
                icon: icon,
                accountType: accountType,
                currentValue: currentValue,
                isSystem: isSystem,
                creditLimit: creditLimit,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AccountsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AccountsTableTable,
      AccountsTableData,
      $$AccountsTableTableFilterComposer,
      $$AccountsTableTableOrderingComposer,
      $$AccountsTableTableAnnotationComposer,
      $$AccountsTableTableCreateCompanionBuilder,
      $$AccountsTableTableUpdateCompanionBuilder,
      (
        AccountsTableData,
        BaseReferences<_$AppDatabase, $AccountsTableTable, AccountsTableData>,
      ),
      AccountsTableData,
      PrefetchHooks Function()
    >;
typedef $$TransactionsTableTableCreateCompanionBuilder =
    TransactionsTableCompanion Function({
      Value<int> id,
      required double amount,
      required DateTime date,
      Value<String?> note,
      required String transactionType,
      Value<int?> categoryId,
      required int accountId,
      Value<int?> linkedAccountId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$TransactionsTableTableUpdateCompanionBuilder =
    TransactionsTableCompanion Function({
      Value<int> id,
      Value<double> amount,
      Value<DateTime> date,
      Value<String?> note,
      Value<String> transactionType,
      Value<int?> categoryId,
      Value<int> accountId,
      Value<int?> linkedAccountId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$TransactionsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $TransactionsTableTable,
          TransactionsTableData
        > {
  $$TransactionsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CashflowCategoriesTableTable _categoryIdTable(_$AppDatabase db) =>
      db.cashflowCategoriesTable.createAlias(
        $_aliasNameGenerator(
          db.transactionsTable.categoryId,
          db.cashflowCategoriesTable.id,
        ),
      );

  $$CashflowCategoriesTableTableProcessedTableManager? get categoryId {
    final $_column = $_itemColumn<int>('category_id');
    if ($_column == null) return null;
    final manager = $$CashflowCategoriesTableTableTableManager(
      $_db,
      $_db.cashflowCategoriesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AccountsTableTable _accountIdTable(_$AppDatabase db) =>
      db.accountsTable.createAlias(
        $_aliasNameGenerator(
          db.transactionsTable.accountId,
          db.accountsTable.id,
        ),
      );

  $$AccountsTableTableProcessedTableManager get accountId {
    final $_column = $_itemColumn<int>('account_id')!;

    final manager = $$AccountsTableTableTableManager(
      $_db,
      $_db.accountsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AccountsTableTable _linkedAccountIdTable(_$AppDatabase db) =>
      db.accountsTable.createAlias(
        $_aliasNameGenerator(
          db.transactionsTable.linkedAccountId,
          db.accountsTable.id,
        ),
      );

  $$AccountsTableTableProcessedTableManager? get linkedAccountId {
    final $_column = $_itemColumn<int>('linked_account_id');
    if ($_column == null) return null;
    final manager = $$AccountsTableTableTableManager(
      $_db,
      $_db.accountsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_linkedAccountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $TransactionParticipantsTableTable,
    List<TransactionParticipantsTableData>
  >
  _transactionParticipantsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.transactionParticipantsTable,
        aliasName: $_aliasNameGenerator(
          db.transactionsTable.id,
          db.transactionParticipantsTable.transactionId,
        ),
      );

  $$TransactionParticipantsTableTableProcessedTableManager
  get transactionParticipantsTableRefs {
    final manager = $$TransactionParticipantsTableTableTableManager(
      $_db,
      $_db.transactionParticipantsTable,
    ).filter((f) => f.transactionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _transactionParticipantsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $FinancialObligationsTableTable,
    List<FinancialObligationsTableData>
  >
  _financialObligationsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.financialObligationsTable,
        aliasName: $_aliasNameGenerator(
          db.transactionsTable.id,
          db.financialObligationsTable.transactionId,
        ),
      );

  $$FinancialObligationsTableTableProcessedTableManager
  get financialObligationsTableRefs {
    final manager = $$FinancialObligationsTableTableTableManager(
      $_db,
      $_db.financialObligationsTable,
    ).filter((f) => f.transactionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _financialObligationsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TransactionsTableTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionsTableTable> {
  $$TransactionsTableTableFilterComposer({
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

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transactionType => $composableBuilder(
    column: $table.transactionType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CashflowCategoriesTableTableFilterComposer get categoryId {
    final $$CashflowCategoriesTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.categoryId,
          referencedTable: $db.cashflowCategoriesTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CashflowCategoriesTableTableFilterComposer(
                $db: $db,
                $table: $db.cashflowCategoriesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$AccountsTableTableFilterComposer get accountId {
    final $$AccountsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accountsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableTableFilterComposer(
            $db: $db,
            $table: $db.accountsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableTableFilterComposer get linkedAccountId {
    final $$AccountsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.linkedAccountId,
      referencedTable: $db.accountsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableTableFilterComposer(
            $db: $db,
            $table: $db.accountsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> transactionParticipantsTableRefs(
    Expression<bool> Function(
      $$TransactionParticipantsTableTableFilterComposer f,
    )
    f,
  ) {
    final $$TransactionParticipantsTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.transactionParticipantsTable,
          getReferencedColumn: (t) => t.transactionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TransactionParticipantsTableTableFilterComposer(
                $db: $db,
                $table: $db.transactionParticipantsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> financialObligationsTableRefs(
    Expression<bool> Function($$FinancialObligationsTableTableFilterComposer f)
    f,
  ) {
    final $$FinancialObligationsTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.financialObligationsTable,
          getReferencedColumn: (t) => t.transactionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$FinancialObligationsTableTableFilterComposer(
                $db: $db,
                $table: $db.financialObligationsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$TransactionsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionsTableTable> {
  $$TransactionsTableTableOrderingComposer({
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

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transactionType => $composableBuilder(
    column: $table.transactionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CashflowCategoriesTableTableOrderingComposer get categoryId {
    final $$CashflowCategoriesTableTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.categoryId,
          referencedTable: $db.cashflowCategoriesTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CashflowCategoriesTableTableOrderingComposer(
                $db: $db,
                $table: $db.cashflowCategoriesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$AccountsTableTableOrderingComposer get accountId {
    final $$AccountsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accountsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableTableOrderingComposer(
            $db: $db,
            $table: $db.accountsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableTableOrderingComposer get linkedAccountId {
    final $$AccountsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.linkedAccountId,
      referencedTable: $db.accountsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableTableOrderingComposer(
            $db: $db,
            $table: $db.accountsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionsTableTable> {
  $$TransactionsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get transactionType => $composableBuilder(
    column: $table.transactionType,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$CashflowCategoriesTableTableAnnotationComposer get categoryId {
    final $$CashflowCategoriesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.categoryId,
          referencedTable: $db.cashflowCategoriesTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CashflowCategoriesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.cashflowCategoriesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$AccountsTableTableAnnotationComposer get accountId {
    final $$AccountsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.accountsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.accountsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AccountsTableTableAnnotationComposer get linkedAccountId {
    final $$AccountsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.linkedAccountId,
      referencedTable: $db.accountsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccountsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.accountsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> transactionParticipantsTableRefs<T extends Object>(
    Expression<T> Function(
      $$TransactionParticipantsTableTableAnnotationComposer a,
    )
    f,
  ) {
    final $$TransactionParticipantsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.transactionParticipantsTable,
          getReferencedColumn: (t) => t.transactionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TransactionParticipantsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.transactionParticipantsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> financialObligationsTableRefs<T extends Object>(
    Expression<T> Function($$FinancialObligationsTableTableAnnotationComposer a)
    f,
  ) {
    final $$FinancialObligationsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.financialObligationsTable,
          getReferencedColumn: (t) => t.transactionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$FinancialObligationsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.financialObligationsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$TransactionsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TransactionsTableTable,
          TransactionsTableData,
          $$TransactionsTableTableFilterComposer,
          $$TransactionsTableTableOrderingComposer,
          $$TransactionsTableTableAnnotationComposer,
          $$TransactionsTableTableCreateCompanionBuilder,
          $$TransactionsTableTableUpdateCompanionBuilder,
          (TransactionsTableData, $$TransactionsTableTableReferences),
          TransactionsTableData,
          PrefetchHooks Function({
            bool categoryId,
            bool accountId,
            bool linkedAccountId,
            bool transactionParticipantsTableRefs,
            bool financialObligationsTableRefs,
          })
        > {
  $$TransactionsTableTableTableManager(
    _$AppDatabase db,
    $TransactionsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String> transactionType = const Value.absent(),
                Value<int?> categoryId = const Value.absent(),
                Value<int> accountId = const Value.absent(),
                Value<int?> linkedAccountId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => TransactionsTableCompanion(
                id: id,
                amount: amount,
                date: date,
                note: note,
                transactionType: transactionType,
                categoryId: categoryId,
                accountId: accountId,
                linkedAccountId: linkedAccountId,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required double amount,
                required DateTime date,
                Value<String?> note = const Value.absent(),
                required String transactionType,
                Value<int?> categoryId = const Value.absent(),
                required int accountId,
                Value<int?> linkedAccountId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => TransactionsTableCompanion.insert(
                id: id,
                amount: amount,
                date: date,
                note: note,
                transactionType: transactionType,
                categoryId: categoryId,
                accountId: accountId,
                linkedAccountId: linkedAccountId,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TransactionsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                categoryId = false,
                accountId = false,
                linkedAccountId = false,
                transactionParticipantsTableRefs = false,
                financialObligationsTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (transactionParticipantsTableRefs)
                      db.transactionParticipantsTable,
                    if (financialObligationsTableRefs)
                      db.financialObligationsTable,
                  ],
                  addJoins:
                      <
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
                          dynamic
                        >
                      >(state) {
                        if (categoryId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.categoryId,
                                    referencedTable:
                                        $$TransactionsTableTableReferences
                                            ._categoryIdTable(db),
                                    referencedColumn:
                                        $$TransactionsTableTableReferences
                                            ._categoryIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (accountId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.accountId,
                                    referencedTable:
                                        $$TransactionsTableTableReferences
                                            ._accountIdTable(db),
                                    referencedColumn:
                                        $$TransactionsTableTableReferences
                                            ._accountIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (linkedAccountId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.linkedAccountId,
                                    referencedTable:
                                        $$TransactionsTableTableReferences
                                            ._linkedAccountIdTable(db),
                                    referencedColumn:
                                        $$TransactionsTableTableReferences
                                            ._linkedAccountIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (transactionParticipantsTableRefs)
                        await $_getPrefetchedData<
                          TransactionsTableData,
                          $TransactionsTableTable,
                          TransactionParticipantsTableData
                        >(
                          currentTable: table,
                          referencedTable: $$TransactionsTableTableReferences
                              ._transactionParticipantsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TransactionsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).transactionParticipantsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.transactionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (financialObligationsTableRefs)
                        await $_getPrefetchedData<
                          TransactionsTableData,
                          $TransactionsTableTable,
                          FinancialObligationsTableData
                        >(
                          currentTable: table,
                          referencedTable: $$TransactionsTableTableReferences
                              ._financialObligationsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TransactionsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).financialObligationsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.transactionId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TransactionsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TransactionsTableTable,
      TransactionsTableData,
      $$TransactionsTableTableFilterComposer,
      $$TransactionsTableTableOrderingComposer,
      $$TransactionsTableTableAnnotationComposer,
      $$TransactionsTableTableCreateCompanionBuilder,
      $$TransactionsTableTableUpdateCompanionBuilder,
      (TransactionsTableData, $$TransactionsTableTableReferences),
      TransactionsTableData,
      PrefetchHooks Function({
        bool categoryId,
        bool accountId,
        bool linkedAccountId,
        bool transactionParticipantsTableRefs,
        bool financialObligationsTableRefs,
      })
    >;
typedef $$EntitiesTableTableCreateCompanionBuilder =
    EntitiesTableCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> displayName,
      Value<String?> shortCode,
      required String entityType,
      Value<String?> organizationType,
      Value<bool> isSystem,
      Value<String?> iconKey,
      Value<String?> contactNumber,
      Value<String?> emailAddress,
      Value<String?> metadata,
    });
typedef $$EntitiesTableTableUpdateCompanionBuilder =
    EntitiesTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> displayName,
      Value<String?> shortCode,
      Value<String> entityType,
      Value<String?> organizationType,
      Value<bool> isSystem,
      Value<String?> iconKey,
      Value<String?> contactNumber,
      Value<String?> emailAddress,
      Value<String?> metadata,
    });

final class $$EntitiesTableTableReferences
    extends
        BaseReferences<_$AppDatabase, $EntitiesTableTable, EntitiesTableData> {
  $$EntitiesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $TransactionParticipantsTableTable,
    List<TransactionParticipantsTableData>
  >
  _transactionParticipantsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.transactionParticipantsTable,
        aliasName: $_aliasNameGenerator(
          db.entitiesTable.id,
          db.transactionParticipantsTable.entityId,
        ),
      );

  $$TransactionParticipantsTableTableProcessedTableManager
  get transactionParticipantsTableRefs {
    final manager = $$TransactionParticipantsTableTableTableManager(
      $_db,
      $_db.transactionParticipantsTable,
    ).filter((f) => f.entityId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _transactionParticipantsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$EntitiesTableTableFilterComposer
    extends Composer<_$AppDatabase, $EntitiesTableTable> {
  $$EntitiesTableTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shortCode => $composableBuilder(
    column: $table.shortCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get organizationType => $composableBuilder(
    column: $table.organizationType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSystem => $composableBuilder(
    column: $table.isSystem,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconKey => $composableBuilder(
    column: $table.iconKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactNumber => $composableBuilder(
    column: $table.contactNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get emailAddress => $composableBuilder(
    column: $table.emailAddress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metadata => $composableBuilder(
    column: $table.metadata,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> transactionParticipantsTableRefs(
    Expression<bool> Function(
      $$TransactionParticipantsTableTableFilterComposer f,
    )
    f,
  ) {
    final $$TransactionParticipantsTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.transactionParticipantsTable,
          getReferencedColumn: (t) => t.entityId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TransactionParticipantsTableTableFilterComposer(
                $db: $db,
                $table: $db.transactionParticipantsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$EntitiesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $EntitiesTableTable> {
  $$EntitiesTableTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shortCode => $composableBuilder(
    column: $table.shortCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get organizationType => $composableBuilder(
    column: $table.organizationType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSystem => $composableBuilder(
    column: $table.isSystem,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconKey => $composableBuilder(
    column: $table.iconKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactNumber => $composableBuilder(
    column: $table.contactNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get emailAddress => $composableBuilder(
    column: $table.emailAddress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadata => $composableBuilder(
    column: $table.metadata,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EntitiesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $EntitiesTableTable> {
  $$EntitiesTableTableAnnotationComposer({
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

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get shortCode =>
      $composableBuilder(column: $table.shortCode, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get organizationType => $composableBuilder(
    column: $table.organizationType,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSystem =>
      $composableBuilder(column: $table.isSystem, builder: (column) => column);

  GeneratedColumn<String> get iconKey =>
      $composableBuilder(column: $table.iconKey, builder: (column) => column);

  GeneratedColumn<String> get contactNumber => $composableBuilder(
    column: $table.contactNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get emailAddress => $composableBuilder(
    column: $table.emailAddress,
    builder: (column) => column,
  );

  GeneratedColumn<String> get metadata =>
      $composableBuilder(column: $table.metadata, builder: (column) => column);

  Expression<T> transactionParticipantsTableRefs<T extends Object>(
    Expression<T> Function(
      $$TransactionParticipantsTableTableAnnotationComposer a,
    )
    f,
  ) {
    final $$TransactionParticipantsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.transactionParticipantsTable,
          getReferencedColumn: (t) => t.entityId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TransactionParticipantsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.transactionParticipantsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$EntitiesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EntitiesTableTable,
          EntitiesTableData,
          $$EntitiesTableTableFilterComposer,
          $$EntitiesTableTableOrderingComposer,
          $$EntitiesTableTableAnnotationComposer,
          $$EntitiesTableTableCreateCompanionBuilder,
          $$EntitiesTableTableUpdateCompanionBuilder,
          (EntitiesTableData, $$EntitiesTableTableReferences),
          EntitiesTableData,
          PrefetchHooks Function({bool transactionParticipantsTableRefs})
        > {
  $$EntitiesTableTableTableManager(_$AppDatabase db, $EntitiesTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EntitiesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EntitiesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EntitiesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> displayName = const Value.absent(),
                Value<String?> shortCode = const Value.absent(),
                Value<String> entityType = const Value.absent(),
                Value<String?> organizationType = const Value.absent(),
                Value<bool> isSystem = const Value.absent(),
                Value<String?> iconKey = const Value.absent(),
                Value<String?> contactNumber = const Value.absent(),
                Value<String?> emailAddress = const Value.absent(),
                Value<String?> metadata = const Value.absent(),
              }) => EntitiesTableCompanion(
                id: id,
                name: name,
                displayName: displayName,
                shortCode: shortCode,
                entityType: entityType,
                organizationType: organizationType,
                isSystem: isSystem,
                iconKey: iconKey,
                contactNumber: contactNumber,
                emailAddress: emailAddress,
                metadata: metadata,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> displayName = const Value.absent(),
                Value<String?> shortCode = const Value.absent(),
                required String entityType,
                Value<String?> organizationType = const Value.absent(),
                Value<bool> isSystem = const Value.absent(),
                Value<String?> iconKey = const Value.absent(),
                Value<String?> contactNumber = const Value.absent(),
                Value<String?> emailAddress = const Value.absent(),
                Value<String?> metadata = const Value.absent(),
              }) => EntitiesTableCompanion.insert(
                id: id,
                name: name,
                displayName: displayName,
                shortCode: shortCode,
                entityType: entityType,
                organizationType: organizationType,
                isSystem: isSystem,
                iconKey: iconKey,
                contactNumber: contactNumber,
                emailAddress: emailAddress,
                metadata: metadata,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EntitiesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({transactionParticipantsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (transactionParticipantsTableRefs)
                  db.transactionParticipantsTable,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (transactionParticipantsTableRefs)
                    await $_getPrefetchedData<
                      EntitiesTableData,
                      $EntitiesTableTable,
                      TransactionParticipantsTableData
                    >(
                      currentTable: table,
                      referencedTable: $$EntitiesTableTableReferences
                          ._transactionParticipantsTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$EntitiesTableTableReferences(
                            db,
                            table,
                            p0,
                          ).transactionParticipantsTableRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.entityId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$EntitiesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EntitiesTableTable,
      EntitiesTableData,
      $$EntitiesTableTableFilterComposer,
      $$EntitiesTableTableOrderingComposer,
      $$EntitiesTableTableAnnotationComposer,
      $$EntitiesTableTableCreateCompanionBuilder,
      $$EntitiesTableTableUpdateCompanionBuilder,
      (EntitiesTableData, $$EntitiesTableTableReferences),
      EntitiesTableData,
      PrefetchHooks Function({bool transactionParticipantsTableRefs})
    >;
typedef $$TransactionParticipantsTableTableCreateCompanionBuilder =
    TransactionParticipantsTableCompanion Function({
      Value<int> id,
      required int transactionId,
      required int entityId,
      required double allocatedAmount,
      Value<double?> allocationPercentage,
      Value<bool> isPayer,
      Value<String?> displayNameSnapshot,
    });
typedef $$TransactionParticipantsTableTableUpdateCompanionBuilder =
    TransactionParticipantsTableCompanion Function({
      Value<int> id,
      Value<int> transactionId,
      Value<int> entityId,
      Value<double> allocatedAmount,
      Value<double?> allocationPercentage,
      Value<bool> isPayer,
      Value<String?> displayNameSnapshot,
    });

final class $$TransactionParticipantsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $TransactionParticipantsTableTable,
          TransactionParticipantsTableData
        > {
  $$TransactionParticipantsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TransactionsTableTable _transactionIdTable(_$AppDatabase db) =>
      db.transactionsTable.createAlias(
        $_aliasNameGenerator(
          db.transactionParticipantsTable.transactionId,
          db.transactionsTable.id,
        ),
      );

  $$TransactionsTableTableProcessedTableManager get transactionId {
    final $_column = $_itemColumn<int>('transaction_id')!;

    final manager = $$TransactionsTableTableTableManager(
      $_db,
      $_db.transactionsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_transactionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $EntitiesTableTable _entityIdTable(_$AppDatabase db) =>
      db.entitiesTable.createAlias(
        $_aliasNameGenerator(
          db.transactionParticipantsTable.entityId,
          db.entitiesTable.id,
        ),
      );

  $$EntitiesTableTableProcessedTableManager get entityId {
    final $_column = $_itemColumn<int>('entity_id')!;

    final manager = $$EntitiesTableTableTableManager(
      $_db,
      $_db.entitiesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_entityIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TransactionParticipantsTableTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionParticipantsTableTable> {
  $$TransactionParticipantsTableTableFilterComposer({
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

  ColumnFilters<double> get allocatedAmount => $composableBuilder(
    column: $table.allocatedAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get allocationPercentage => $composableBuilder(
    column: $table.allocationPercentage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPayer => $composableBuilder(
    column: $table.isPayer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayNameSnapshot => $composableBuilder(
    column: $table.displayNameSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  $$TransactionsTableTableFilterComposer get transactionId {
    final $$TransactionsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.transactionId,
      referencedTable: $db.transactionsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableTableFilterComposer(
            $db: $db,
            $table: $db.transactionsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EntitiesTableTableFilterComposer get entityId {
    final $$EntitiesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entityId,
      referencedTable: $db.entitiesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntitiesTableTableFilterComposer(
            $db: $db,
            $table: $db.entitiesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionParticipantsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionParticipantsTableTable> {
  $$TransactionParticipantsTableTableOrderingComposer({
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

  ColumnOrderings<double> get allocatedAmount => $composableBuilder(
    column: $table.allocatedAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get allocationPercentage => $composableBuilder(
    column: $table.allocationPercentage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPayer => $composableBuilder(
    column: $table.isPayer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayNameSnapshot => $composableBuilder(
    column: $table.displayNameSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  $$TransactionsTableTableOrderingComposer get transactionId {
    final $$TransactionsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.transactionId,
      referencedTable: $db.transactionsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableTableOrderingComposer(
            $db: $db,
            $table: $db.transactionsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EntitiesTableTableOrderingComposer get entityId {
    final $$EntitiesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entityId,
      referencedTable: $db.entitiesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntitiesTableTableOrderingComposer(
            $db: $db,
            $table: $db.entitiesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionParticipantsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionParticipantsTableTable> {
  $$TransactionParticipantsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get allocatedAmount => $composableBuilder(
    column: $table.allocatedAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get allocationPercentage => $composableBuilder(
    column: $table.allocationPercentage,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isPayer =>
      $composableBuilder(column: $table.isPayer, builder: (column) => column);

  GeneratedColumn<String> get displayNameSnapshot => $composableBuilder(
    column: $table.displayNameSnapshot,
    builder: (column) => column,
  );

  $$TransactionsTableTableAnnotationComposer get transactionId {
    final $$TransactionsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.transactionId,
          referencedTable: $db.transactionsTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TransactionsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.transactionsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$EntitiesTableTableAnnotationComposer get entityId {
    final $$EntitiesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entityId,
      referencedTable: $db.entitiesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntitiesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.entitiesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionParticipantsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TransactionParticipantsTableTable,
          TransactionParticipantsTableData,
          $$TransactionParticipantsTableTableFilterComposer,
          $$TransactionParticipantsTableTableOrderingComposer,
          $$TransactionParticipantsTableTableAnnotationComposer,
          $$TransactionParticipantsTableTableCreateCompanionBuilder,
          $$TransactionParticipantsTableTableUpdateCompanionBuilder,
          (
            TransactionParticipantsTableData,
            $$TransactionParticipantsTableTableReferences,
          ),
          TransactionParticipantsTableData,
          PrefetchHooks Function({bool transactionId, bool entityId})
        > {
  $$TransactionParticipantsTableTableTableManager(
    _$AppDatabase db,
    $TransactionParticipantsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionParticipantsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$TransactionParticipantsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$TransactionParticipantsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> transactionId = const Value.absent(),
                Value<int> entityId = const Value.absent(),
                Value<double> allocatedAmount = const Value.absent(),
                Value<double?> allocationPercentage = const Value.absent(),
                Value<bool> isPayer = const Value.absent(),
                Value<String?> displayNameSnapshot = const Value.absent(),
              }) => TransactionParticipantsTableCompanion(
                id: id,
                transactionId: transactionId,
                entityId: entityId,
                allocatedAmount: allocatedAmount,
                allocationPercentage: allocationPercentage,
                isPayer: isPayer,
                displayNameSnapshot: displayNameSnapshot,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int transactionId,
                required int entityId,
                required double allocatedAmount,
                Value<double?> allocationPercentage = const Value.absent(),
                Value<bool> isPayer = const Value.absent(),
                Value<String?> displayNameSnapshot = const Value.absent(),
              }) => TransactionParticipantsTableCompanion.insert(
                id: id,
                transactionId: transactionId,
                entityId: entityId,
                allocatedAmount: allocatedAmount,
                allocationPercentage: allocationPercentage,
                isPayer: isPayer,
                displayNameSnapshot: displayNameSnapshot,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TransactionParticipantsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({transactionId = false, entityId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (transactionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.transactionId,
                                referencedTable:
                                    $$TransactionParticipantsTableTableReferences
                                        ._transactionIdTable(db),
                                referencedColumn:
                                    $$TransactionParticipantsTableTableReferences
                                        ._transactionIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (entityId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.entityId,
                                referencedTable:
                                    $$TransactionParticipantsTableTableReferences
                                        ._entityIdTable(db),
                                referencedColumn:
                                    $$TransactionParticipantsTableTableReferences
                                        ._entityIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TransactionParticipantsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TransactionParticipantsTableTable,
      TransactionParticipantsTableData,
      $$TransactionParticipantsTableTableFilterComposer,
      $$TransactionParticipantsTableTableOrderingComposer,
      $$TransactionParticipantsTableTableAnnotationComposer,
      $$TransactionParticipantsTableTableCreateCompanionBuilder,
      $$TransactionParticipantsTableTableUpdateCompanionBuilder,
      (
        TransactionParticipantsTableData,
        $$TransactionParticipantsTableTableReferences,
      ),
      TransactionParticipantsTableData,
      PrefetchHooks Function({bool transactionId, bool entityId})
    >;
typedef $$FinancialObligationsTableTableCreateCompanionBuilder =
    FinancialObligationsTableCompanion Function({
      Value<int> id,
      required int transactionId,
      required int debtorEntityId,
      required int creditorEntityId,
      required double amount,
      required String type,
      Value<String?> note,
      Value<DateTime> createdAt,
    });
typedef $$FinancialObligationsTableTableUpdateCompanionBuilder =
    FinancialObligationsTableCompanion Function({
      Value<int> id,
      Value<int> transactionId,
      Value<int> debtorEntityId,
      Value<int> creditorEntityId,
      Value<double> amount,
      Value<String> type,
      Value<String?> note,
      Value<DateTime> createdAt,
    });

final class $$FinancialObligationsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $FinancialObligationsTableTable,
          FinancialObligationsTableData
        > {
  $$FinancialObligationsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TransactionsTableTable _transactionIdTable(_$AppDatabase db) =>
      db.transactionsTable.createAlias(
        $_aliasNameGenerator(
          db.financialObligationsTable.transactionId,
          db.transactionsTable.id,
        ),
      );

  $$TransactionsTableTableProcessedTableManager get transactionId {
    final $_column = $_itemColumn<int>('transaction_id')!;

    final manager = $$TransactionsTableTableTableManager(
      $_db,
      $_db.transactionsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_transactionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $EntitiesTableTable _debtorEntityIdTable(_$AppDatabase db) =>
      db.entitiesTable.createAlias(
        $_aliasNameGenerator(
          db.financialObligationsTable.debtorEntityId,
          db.entitiesTable.id,
        ),
      );

  $$EntitiesTableTableProcessedTableManager get debtorEntityId {
    final $_column = $_itemColumn<int>('debtor_entity_id')!;

    final manager = $$EntitiesTableTableTableManager(
      $_db,
      $_db.entitiesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_debtorEntityIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $EntitiesTableTable _creditorEntityIdTable(_$AppDatabase db) =>
      db.entitiesTable.createAlias(
        $_aliasNameGenerator(
          db.financialObligationsTable.creditorEntityId,
          db.entitiesTable.id,
        ),
      );

  $$EntitiesTableTableProcessedTableManager get creditorEntityId {
    final $_column = $_itemColumn<int>('creditor_entity_id')!;

    final manager = $$EntitiesTableTableTableManager(
      $_db,
      $_db.entitiesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_creditorEntityIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FinancialObligationsTableTableFilterComposer
    extends Composer<_$AppDatabase, $FinancialObligationsTableTable> {
  $$FinancialObligationsTableTableFilterComposer({
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

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$TransactionsTableTableFilterComposer get transactionId {
    final $$TransactionsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.transactionId,
      referencedTable: $db.transactionsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableTableFilterComposer(
            $db: $db,
            $table: $db.transactionsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EntitiesTableTableFilterComposer get debtorEntityId {
    final $$EntitiesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.debtorEntityId,
      referencedTable: $db.entitiesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntitiesTableTableFilterComposer(
            $db: $db,
            $table: $db.entitiesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EntitiesTableTableFilterComposer get creditorEntityId {
    final $$EntitiesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.creditorEntityId,
      referencedTable: $db.entitiesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntitiesTableTableFilterComposer(
            $db: $db,
            $table: $db.entitiesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FinancialObligationsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $FinancialObligationsTableTable> {
  $$FinancialObligationsTableTableOrderingComposer({
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

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$TransactionsTableTableOrderingComposer get transactionId {
    final $$TransactionsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.transactionId,
      referencedTable: $db.transactionsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableTableOrderingComposer(
            $db: $db,
            $table: $db.transactionsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EntitiesTableTableOrderingComposer get debtorEntityId {
    final $$EntitiesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.debtorEntityId,
      referencedTable: $db.entitiesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntitiesTableTableOrderingComposer(
            $db: $db,
            $table: $db.entitiesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EntitiesTableTableOrderingComposer get creditorEntityId {
    final $$EntitiesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.creditorEntityId,
      referencedTable: $db.entitiesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntitiesTableTableOrderingComposer(
            $db: $db,
            $table: $db.entitiesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FinancialObligationsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $FinancialObligationsTableTable> {
  $$FinancialObligationsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$TransactionsTableTableAnnotationComposer get transactionId {
    final $$TransactionsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.transactionId,
          referencedTable: $db.transactionsTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TransactionsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.transactionsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$EntitiesTableTableAnnotationComposer get debtorEntityId {
    final $$EntitiesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.debtorEntityId,
      referencedTable: $db.entitiesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntitiesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.entitiesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EntitiesTableTableAnnotationComposer get creditorEntityId {
    final $$EntitiesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.creditorEntityId,
      referencedTable: $db.entitiesTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntitiesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.entitiesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FinancialObligationsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FinancialObligationsTableTable,
          FinancialObligationsTableData,
          $$FinancialObligationsTableTableFilterComposer,
          $$FinancialObligationsTableTableOrderingComposer,
          $$FinancialObligationsTableTableAnnotationComposer,
          $$FinancialObligationsTableTableCreateCompanionBuilder,
          $$FinancialObligationsTableTableUpdateCompanionBuilder,
          (
            FinancialObligationsTableData,
            $$FinancialObligationsTableTableReferences,
          ),
          FinancialObligationsTableData,
          PrefetchHooks Function({
            bool transactionId,
            bool debtorEntityId,
            bool creditorEntityId,
          })
        > {
  $$FinancialObligationsTableTableTableManager(
    _$AppDatabase db,
    $FinancialObligationsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FinancialObligationsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$FinancialObligationsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$FinancialObligationsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> transactionId = const Value.absent(),
                Value<int> debtorEntityId = const Value.absent(),
                Value<int> creditorEntityId = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => FinancialObligationsTableCompanion(
                id: id,
                transactionId: transactionId,
                debtorEntityId: debtorEntityId,
                creditorEntityId: creditorEntityId,
                amount: amount,
                type: type,
                note: note,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int transactionId,
                required int debtorEntityId,
                required int creditorEntityId,
                required double amount,
                required String type,
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => FinancialObligationsTableCompanion.insert(
                id: id,
                transactionId: transactionId,
                debtorEntityId: debtorEntityId,
                creditorEntityId: creditorEntityId,
                amount: amount,
                type: type,
                note: note,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FinancialObligationsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                transactionId = false,
                debtorEntityId = false,
                creditorEntityId = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
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
                          dynamic
                        >
                      >(state) {
                        if (transactionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.transactionId,
                                    referencedTable:
                                        $$FinancialObligationsTableTableReferences
                                            ._transactionIdTable(db),
                                    referencedColumn:
                                        $$FinancialObligationsTableTableReferences
                                            ._transactionIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (debtorEntityId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.debtorEntityId,
                                    referencedTable:
                                        $$FinancialObligationsTableTableReferences
                                            ._debtorEntityIdTable(db),
                                    referencedColumn:
                                        $$FinancialObligationsTableTableReferences
                                            ._debtorEntityIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (creditorEntityId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.creditorEntityId,
                                    referencedTable:
                                        $$FinancialObligationsTableTableReferences
                                            ._creditorEntityIdTable(db),
                                    referencedColumn:
                                        $$FinancialObligationsTableTableReferences
                                            ._creditorEntityIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$FinancialObligationsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FinancialObligationsTableTable,
      FinancialObligationsTableData,
      $$FinancialObligationsTableTableFilterComposer,
      $$FinancialObligationsTableTableOrderingComposer,
      $$FinancialObligationsTableTableAnnotationComposer,
      $$FinancialObligationsTableTableCreateCompanionBuilder,
      $$FinancialObligationsTableTableUpdateCompanionBuilder,
      (
        FinancialObligationsTableData,
        $$FinancialObligationsTableTableReferences,
      ),
      FinancialObligationsTableData,
      PrefetchHooks Function({
        bool transactionId,
        bool debtorEntityId,
        bool creditorEntityId,
      })
    >;
typedef $$CashflowPlansTableTableCreateCompanionBuilder =
    CashflowPlansTableCompanion Function({
      Value<int> id,
      required String name,
      required String planType,
      Value<String?> expenseMode,
      Value<int?> categoryId,
      Value<int?> debtId,
      Value<double?> amount,
      Value<String?> customAmountsJson,
      required String frequency,
      Value<int?> monthMask,
      Value<String?> occurrenceDaysJson,
      Value<DateTime?> anchorDate,
      Value<double> dependentSurvivalFactor,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$CashflowPlansTableTableUpdateCompanionBuilder =
    CashflowPlansTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> planType,
      Value<String?> expenseMode,
      Value<int?> categoryId,
      Value<int?> debtId,
      Value<double?> amount,
      Value<String?> customAmountsJson,
      Value<String> frequency,
      Value<int?> monthMask,
      Value<String?> occurrenceDaysJson,
      Value<DateTime?> anchorDate,
      Value<double> dependentSurvivalFactor,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$CashflowPlansTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CashflowPlansTableTable,
          CashflowPlansTableData
        > {
  $$CashflowPlansTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CashflowCategoriesTableTable _categoryIdTable(_$AppDatabase db) =>
      db.cashflowCategoriesTable.createAlias(
        $_aliasNameGenerator(
          db.cashflowPlansTable.categoryId,
          db.cashflowCategoriesTable.id,
        ),
      );

  $$CashflowCategoriesTableTableProcessedTableManager? get categoryId {
    final $_column = $_itemColumn<int>('category_id');
    if ($_column == null) return null;
    final manager = $$CashflowCategoriesTableTableTableManager(
      $_db,
      $_db.cashflowCategoriesTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CashflowPlansTableTableFilterComposer
    extends Composer<_$AppDatabase, $CashflowPlansTableTable> {
  $$CashflowPlansTableTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get planType => $composableBuilder(
    column: $table.planType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get expenseMode => $composableBuilder(
    column: $table.expenseMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get debtId => $composableBuilder(
    column: $table.debtId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customAmountsJson => $composableBuilder(
    column: $table.customAmountsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get monthMask => $composableBuilder(
    column: $table.monthMask,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get occurrenceDaysJson => $composableBuilder(
    column: $table.occurrenceDaysJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get anchorDate => $composableBuilder(
    column: $table.anchorDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get dependentSurvivalFactor => $composableBuilder(
    column: $table.dependentSurvivalFactor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CashflowCategoriesTableTableFilterComposer get categoryId {
    final $$CashflowCategoriesTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.categoryId,
          referencedTable: $db.cashflowCategoriesTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CashflowCategoriesTableTableFilterComposer(
                $db: $db,
                $table: $db.cashflowCategoriesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$CashflowPlansTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CashflowPlansTableTable> {
  $$CashflowPlansTableTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get planType => $composableBuilder(
    column: $table.planType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get expenseMode => $composableBuilder(
    column: $table.expenseMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get debtId => $composableBuilder(
    column: $table.debtId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customAmountsJson => $composableBuilder(
    column: $table.customAmountsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get monthMask => $composableBuilder(
    column: $table.monthMask,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get occurrenceDaysJson => $composableBuilder(
    column: $table.occurrenceDaysJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get anchorDate => $composableBuilder(
    column: $table.anchorDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get dependentSurvivalFactor => $composableBuilder(
    column: $table.dependentSurvivalFactor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CashflowCategoriesTableTableOrderingComposer get categoryId {
    final $$CashflowCategoriesTableTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.categoryId,
          referencedTable: $db.cashflowCategoriesTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CashflowCategoriesTableTableOrderingComposer(
                $db: $db,
                $table: $db.cashflowCategoriesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$CashflowPlansTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CashflowPlansTableTable> {
  $$CashflowPlansTableTableAnnotationComposer({
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

  GeneratedColumn<String> get planType =>
      $composableBuilder(column: $table.planType, builder: (column) => column);

  GeneratedColumn<String> get expenseMode => $composableBuilder(
    column: $table.expenseMode,
    builder: (column) => column,
  );

  GeneratedColumn<int> get debtId =>
      $composableBuilder(column: $table.debtId, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get customAmountsJson => $composableBuilder(
    column: $table.customAmountsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get frequency =>
      $composableBuilder(column: $table.frequency, builder: (column) => column);

  GeneratedColumn<int> get monthMask =>
      $composableBuilder(column: $table.monthMask, builder: (column) => column);

  GeneratedColumn<String> get occurrenceDaysJson => $composableBuilder(
    column: $table.occurrenceDaysJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get anchorDate => $composableBuilder(
    column: $table.anchorDate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get dependentSurvivalFactor => $composableBuilder(
    column: $table.dependentSurvivalFactor,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$CashflowCategoriesTableTableAnnotationComposer get categoryId {
    final $$CashflowCategoriesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.categoryId,
          referencedTable: $db.cashflowCategoriesTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CashflowCategoriesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.cashflowCategoriesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$CashflowPlansTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CashflowPlansTableTable,
          CashflowPlansTableData,
          $$CashflowPlansTableTableFilterComposer,
          $$CashflowPlansTableTableOrderingComposer,
          $$CashflowPlansTableTableAnnotationComposer,
          $$CashflowPlansTableTableCreateCompanionBuilder,
          $$CashflowPlansTableTableUpdateCompanionBuilder,
          (CashflowPlansTableData, $$CashflowPlansTableTableReferences),
          CashflowPlansTableData,
          PrefetchHooks Function({bool categoryId})
        > {
  $$CashflowPlansTableTableTableManager(
    _$AppDatabase db,
    $CashflowPlansTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CashflowPlansTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CashflowPlansTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CashflowPlansTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> planType = const Value.absent(),
                Value<String?> expenseMode = const Value.absent(),
                Value<int?> categoryId = const Value.absent(),
                Value<int?> debtId = const Value.absent(),
                Value<double?> amount = const Value.absent(),
                Value<String?> customAmountsJson = const Value.absent(),
                Value<String> frequency = const Value.absent(),
                Value<int?> monthMask = const Value.absent(),
                Value<String?> occurrenceDaysJson = const Value.absent(),
                Value<DateTime?> anchorDate = const Value.absent(),
                Value<double> dependentSurvivalFactor = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CashflowPlansTableCompanion(
                id: id,
                name: name,
                planType: planType,
                expenseMode: expenseMode,
                categoryId: categoryId,
                debtId: debtId,
                amount: amount,
                customAmountsJson: customAmountsJson,
                frequency: frequency,
                monthMask: monthMask,
                occurrenceDaysJson: occurrenceDaysJson,
                anchorDate: anchorDate,
                dependentSurvivalFactor: dependentSurvivalFactor,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String planType,
                Value<String?> expenseMode = const Value.absent(),
                Value<int?> categoryId = const Value.absent(),
                Value<int?> debtId = const Value.absent(),
                Value<double?> amount = const Value.absent(),
                Value<String?> customAmountsJson = const Value.absent(),
                required String frequency,
                Value<int?> monthMask = const Value.absent(),
                Value<String?> occurrenceDaysJson = const Value.absent(),
                Value<DateTime?> anchorDate = const Value.absent(),
                Value<double> dependentSurvivalFactor = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CashflowPlansTableCompanion.insert(
                id: id,
                name: name,
                planType: planType,
                expenseMode: expenseMode,
                categoryId: categoryId,
                debtId: debtId,
                amount: amount,
                customAmountsJson: customAmountsJson,
                frequency: frequency,
                monthMask: monthMask,
                occurrenceDaysJson: occurrenceDaysJson,
                anchorDate: anchorDate,
                dependentSurvivalFactor: dependentSurvivalFactor,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CashflowPlansTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({categoryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (categoryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.categoryId,
                                referencedTable:
                                    $$CashflowPlansTableTableReferences
                                        ._categoryIdTable(db),
                                referencedColumn:
                                    $$CashflowPlansTableTableReferences
                                        ._categoryIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CashflowPlansTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CashflowPlansTableTable,
      CashflowPlansTableData,
      $$CashflowPlansTableTableFilterComposer,
      $$CashflowPlansTableTableOrderingComposer,
      $$CashflowPlansTableTableAnnotationComposer,
      $$CashflowPlansTableTableCreateCompanionBuilder,
      $$CashflowPlansTableTableUpdateCompanionBuilder,
      (CashflowPlansTableData, $$CashflowPlansTableTableReferences),
      CashflowPlansTableData,
      PrefetchHooks Function({bool categoryId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CashflowCategoriesTableTableTableManager get cashflowCategoriesTable =>
      $$CashflowCategoriesTableTableTableManager(
        _db,
        _db.cashflowCategoriesTable,
      );
  $$AccountsTableTableTableManager get accountsTable =>
      $$AccountsTableTableTableManager(_db, _db.accountsTable);
  $$TransactionsTableTableTableManager get transactionsTable =>
      $$TransactionsTableTableTableManager(_db, _db.transactionsTable);
  $$EntitiesTableTableTableManager get entitiesTable =>
      $$EntitiesTableTableTableManager(_db, _db.entitiesTable);
  $$TransactionParticipantsTableTableTableManager
  get transactionParticipantsTable =>
      $$TransactionParticipantsTableTableTableManager(
        _db,
        _db.transactionParticipantsTable,
      );
  $$FinancialObligationsTableTableTableManager get financialObligationsTable =>
      $$FinancialObligationsTableTableTableManager(
        _db,
        _db.financialObligationsTable,
      );
  $$CashflowPlansTableTableTableManager get cashflowPlansTable =>
      $$CashflowPlansTableTableTableManager(_db, _db.cashflowPlansTable);
}
