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
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
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
      ),
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
  final int? accountId;
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
    this.accountId,
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
    if (!nullToAbsent || accountId != null) {
      map['account_id'] = Variable<int>(accountId);
    }
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
      accountId: accountId == null && nullToAbsent
          ? const Value.absent()
          : Value(accountId),
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
      accountId: serializer.fromJson<int?>(json['accountId']),
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
      'accountId': serializer.toJson<int?>(accountId),
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
    Value<int?> accountId = const Value.absent(),
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
    accountId: accountId.present ? accountId.value : this.accountId,
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
  final Value<int?> accountId;
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
    this.accountId = const Value.absent(),
    this.linkedAccountId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : amount = Value(amount),
       date = Value(date),
       transactionType = Value(transactionType);
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
    Value<int?>? accountId,
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

class $LoansTable extends Loans with TableInfo<$LoansTable, Loan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LoansTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _loanTypeMeta = const VerificationMeta(
    'loanType',
  );
  @override
  late final GeneratedColumn<String> loanType = GeneratedColumn<String>(
    'loan_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _originalPrincipalMeta = const VerificationMeta(
    'originalPrincipal',
  );
  @override
  late final GeneratedColumn<double> originalPrincipal =
      GeneratedColumn<double>(
        'original_principal',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _outstandingBalanceMeta =
      const VerificationMeta('outstandingBalance');
  @override
  late final GeneratedColumn<double> outstandingBalance =
      GeneratedColumn<double>(
        'outstanding_balance',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _interestRateMeta = const VerificationMeta(
    'interestRate',
  );
  @override
  late final GeneratedColumn<double> interestRate = GeneratedColumn<double>(
    'interest_rate',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _paymentAmountMeta = const VerificationMeta(
    'paymentAmount',
  );
  @override
  late final GeneratedColumn<double> paymentAmount = GeneratedColumn<double>(
    'payment_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paymentFrequencyMeta = const VerificationMeta(
    'paymentFrequency',
  );
  @override
  late final GeneratedColumn<String> paymentFrequency = GeneratedColumn<String>(
    'payment_frequency',
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
  static const VerificationMeta _maturityDateMeta = const VerificationMeta(
    'maturityDate',
  );
  @override
  late final GeneratedColumn<DateTime> maturityDate = GeneratedColumn<DateTime>(
    'maturity_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _defaultPaymentAccountIdMeta =
      const VerificationMeta('defaultPaymentAccountId');
  @override
  late final GeneratedColumn<int> defaultPaymentAccountId =
      GeneratedColumn<int>(
        'default_payment_account_id',
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
    name,
    loanType,
    originalPrincipal,
    outstandingBalance,
    interestRate,
    paymentAmount,
    paymentFrequency,
    startDate,
    maturityDate,
    defaultPaymentAccountId,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'loans';
  @override
  VerificationContext validateIntegrity(
    Insertable<Loan> instance, {
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
    if (data.containsKey('loan_type')) {
      context.handle(
        _loanTypeMeta,
        loanType.isAcceptableOrUnknown(data['loan_type']!, _loanTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_loanTypeMeta);
    }
    if (data.containsKey('original_principal')) {
      context.handle(
        _originalPrincipalMeta,
        originalPrincipal.isAcceptableOrUnknown(
          data['original_principal']!,
          _originalPrincipalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_originalPrincipalMeta);
    }
    if (data.containsKey('outstanding_balance')) {
      context.handle(
        _outstandingBalanceMeta,
        outstandingBalance.isAcceptableOrUnknown(
          data['outstanding_balance']!,
          _outstandingBalanceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_outstandingBalanceMeta);
    }
    if (data.containsKey('interest_rate')) {
      context.handle(
        _interestRateMeta,
        interestRate.isAcceptableOrUnknown(
          data['interest_rate']!,
          _interestRateMeta,
        ),
      );
    }
    if (data.containsKey('payment_amount')) {
      context.handle(
        _paymentAmountMeta,
        paymentAmount.isAcceptableOrUnknown(
          data['payment_amount']!,
          _paymentAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paymentAmountMeta);
    }
    if (data.containsKey('payment_frequency')) {
      context.handle(
        _paymentFrequencyMeta,
        paymentFrequency.isAcceptableOrUnknown(
          data['payment_frequency']!,
          _paymentFrequencyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paymentFrequencyMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('maturity_date')) {
      context.handle(
        _maturityDateMeta,
        maturityDate.isAcceptableOrUnknown(
          data['maturity_date']!,
          _maturityDateMeta,
        ),
      );
    }
    if (data.containsKey('default_payment_account_id')) {
      context.handle(
        _defaultPaymentAccountIdMeta,
        defaultPaymentAccountId.isAcceptableOrUnknown(
          data['default_payment_account_id']!,
          _defaultPaymentAccountIdMeta,
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
  Loan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Loan(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      loanType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}loan_type'],
      )!,
      originalPrincipal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}original_principal'],
      )!,
      outstandingBalance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}outstanding_balance'],
      )!,
      interestRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}interest_rate'],
      ),
      paymentAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}payment_amount'],
      )!,
      paymentFrequency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_frequency'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      maturityDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}maturity_date'],
      ),
      defaultPaymentAccountId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}default_payment_account_id'],
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
  $LoansTable createAlias(String alias) {
    return $LoansTable(attachedDatabase, alias);
  }
}

class Loan extends DataClass implements Insertable<Loan> {
  final int id;
  final String name;
  final String loanType;
  final double originalPrincipal;
  final double outstandingBalance;
  final double? interestRate;
  final double paymentAmount;
  final String paymentFrequency;
  final DateTime startDate;
  final DateTime? maturityDate;
  final int? defaultPaymentAccountId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Loan({
    required this.id,
    required this.name,
    required this.loanType,
    required this.originalPrincipal,
    required this.outstandingBalance,
    this.interestRate,
    required this.paymentAmount,
    required this.paymentFrequency,
    required this.startDate,
    this.maturityDate,
    this.defaultPaymentAccountId,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['loan_type'] = Variable<String>(loanType);
    map['original_principal'] = Variable<double>(originalPrincipal);
    map['outstanding_balance'] = Variable<double>(outstandingBalance);
    if (!nullToAbsent || interestRate != null) {
      map['interest_rate'] = Variable<double>(interestRate);
    }
    map['payment_amount'] = Variable<double>(paymentAmount);
    map['payment_frequency'] = Variable<String>(paymentFrequency);
    map['start_date'] = Variable<DateTime>(startDate);
    if (!nullToAbsent || maturityDate != null) {
      map['maturity_date'] = Variable<DateTime>(maturityDate);
    }
    if (!nullToAbsent || defaultPaymentAccountId != null) {
      map['default_payment_account_id'] = Variable<int>(
        defaultPaymentAccountId,
      );
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  LoansCompanion toCompanion(bool nullToAbsent) {
    return LoansCompanion(
      id: Value(id),
      name: Value(name),
      loanType: Value(loanType),
      originalPrincipal: Value(originalPrincipal),
      outstandingBalance: Value(outstandingBalance),
      interestRate: interestRate == null && nullToAbsent
          ? const Value.absent()
          : Value(interestRate),
      paymentAmount: Value(paymentAmount),
      paymentFrequency: Value(paymentFrequency),
      startDate: Value(startDate),
      maturityDate: maturityDate == null && nullToAbsent
          ? const Value.absent()
          : Value(maturityDate),
      defaultPaymentAccountId: defaultPaymentAccountId == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultPaymentAccountId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Loan.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Loan(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      loanType: serializer.fromJson<String>(json['loanType']),
      originalPrincipal: serializer.fromJson<double>(json['originalPrincipal']),
      outstandingBalance: serializer.fromJson<double>(
        json['outstandingBalance'],
      ),
      interestRate: serializer.fromJson<double?>(json['interestRate']),
      paymentAmount: serializer.fromJson<double>(json['paymentAmount']),
      paymentFrequency: serializer.fromJson<String>(json['paymentFrequency']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      maturityDate: serializer.fromJson<DateTime?>(json['maturityDate']),
      defaultPaymentAccountId: serializer.fromJson<int?>(
        json['defaultPaymentAccountId'],
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
      'loanType': serializer.toJson<String>(loanType),
      'originalPrincipal': serializer.toJson<double>(originalPrincipal),
      'outstandingBalance': serializer.toJson<double>(outstandingBalance),
      'interestRate': serializer.toJson<double?>(interestRate),
      'paymentAmount': serializer.toJson<double>(paymentAmount),
      'paymentFrequency': serializer.toJson<String>(paymentFrequency),
      'startDate': serializer.toJson<DateTime>(startDate),
      'maturityDate': serializer.toJson<DateTime?>(maturityDate),
      'defaultPaymentAccountId': serializer.toJson<int?>(
        defaultPaymentAccountId,
      ),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Loan copyWith({
    int? id,
    String? name,
    String? loanType,
    double? originalPrincipal,
    double? outstandingBalance,
    Value<double?> interestRate = const Value.absent(),
    double? paymentAmount,
    String? paymentFrequency,
    DateTime? startDate,
    Value<DateTime?> maturityDate = const Value.absent(),
    Value<int?> defaultPaymentAccountId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Loan(
    id: id ?? this.id,
    name: name ?? this.name,
    loanType: loanType ?? this.loanType,
    originalPrincipal: originalPrincipal ?? this.originalPrincipal,
    outstandingBalance: outstandingBalance ?? this.outstandingBalance,
    interestRate: interestRate.present ? interestRate.value : this.interestRate,
    paymentAmount: paymentAmount ?? this.paymentAmount,
    paymentFrequency: paymentFrequency ?? this.paymentFrequency,
    startDate: startDate ?? this.startDate,
    maturityDate: maturityDate.present ? maturityDate.value : this.maturityDate,
    defaultPaymentAccountId: defaultPaymentAccountId.present
        ? defaultPaymentAccountId.value
        : this.defaultPaymentAccountId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Loan copyWithCompanion(LoansCompanion data) {
    return Loan(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      loanType: data.loanType.present ? data.loanType.value : this.loanType,
      originalPrincipal: data.originalPrincipal.present
          ? data.originalPrincipal.value
          : this.originalPrincipal,
      outstandingBalance: data.outstandingBalance.present
          ? data.outstandingBalance.value
          : this.outstandingBalance,
      interestRate: data.interestRate.present
          ? data.interestRate.value
          : this.interestRate,
      paymentAmount: data.paymentAmount.present
          ? data.paymentAmount.value
          : this.paymentAmount,
      paymentFrequency: data.paymentFrequency.present
          ? data.paymentFrequency.value
          : this.paymentFrequency,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      maturityDate: data.maturityDate.present
          ? data.maturityDate.value
          : this.maturityDate,
      defaultPaymentAccountId: data.defaultPaymentAccountId.present
          ? data.defaultPaymentAccountId.value
          : this.defaultPaymentAccountId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Loan(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('loanType: $loanType, ')
          ..write('originalPrincipal: $originalPrincipal, ')
          ..write('outstandingBalance: $outstandingBalance, ')
          ..write('interestRate: $interestRate, ')
          ..write('paymentAmount: $paymentAmount, ')
          ..write('paymentFrequency: $paymentFrequency, ')
          ..write('startDate: $startDate, ')
          ..write('maturityDate: $maturityDate, ')
          ..write('defaultPaymentAccountId: $defaultPaymentAccountId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    loanType,
    originalPrincipal,
    outstandingBalance,
    interestRate,
    paymentAmount,
    paymentFrequency,
    startDate,
    maturityDate,
    defaultPaymentAccountId,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Loan &&
          other.id == this.id &&
          other.name == this.name &&
          other.loanType == this.loanType &&
          other.originalPrincipal == this.originalPrincipal &&
          other.outstandingBalance == this.outstandingBalance &&
          other.interestRate == this.interestRate &&
          other.paymentAmount == this.paymentAmount &&
          other.paymentFrequency == this.paymentFrequency &&
          other.startDate == this.startDate &&
          other.maturityDate == this.maturityDate &&
          other.defaultPaymentAccountId == this.defaultPaymentAccountId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LoansCompanion extends UpdateCompanion<Loan> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> loanType;
  final Value<double> originalPrincipal;
  final Value<double> outstandingBalance;
  final Value<double?> interestRate;
  final Value<double> paymentAmount;
  final Value<String> paymentFrequency;
  final Value<DateTime> startDate;
  final Value<DateTime?> maturityDate;
  final Value<int?> defaultPaymentAccountId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const LoansCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.loanType = const Value.absent(),
    this.originalPrincipal = const Value.absent(),
    this.outstandingBalance = const Value.absent(),
    this.interestRate = const Value.absent(),
    this.paymentAmount = const Value.absent(),
    this.paymentFrequency = const Value.absent(),
    this.startDate = const Value.absent(),
    this.maturityDate = const Value.absent(),
    this.defaultPaymentAccountId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  LoansCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String loanType,
    required double originalPrincipal,
    required double outstandingBalance,
    this.interestRate = const Value.absent(),
    required double paymentAmount,
    required String paymentFrequency,
    required DateTime startDate,
    this.maturityDate = const Value.absent(),
    this.defaultPaymentAccountId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name),
       loanType = Value(loanType),
       originalPrincipal = Value(originalPrincipal),
       outstandingBalance = Value(outstandingBalance),
       paymentAmount = Value(paymentAmount),
       paymentFrequency = Value(paymentFrequency),
       startDate = Value(startDate);
  static Insertable<Loan> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? loanType,
    Expression<double>? originalPrincipal,
    Expression<double>? outstandingBalance,
    Expression<double>? interestRate,
    Expression<double>? paymentAmount,
    Expression<String>? paymentFrequency,
    Expression<DateTime>? startDate,
    Expression<DateTime>? maturityDate,
    Expression<int>? defaultPaymentAccountId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (loanType != null) 'loan_type': loanType,
      if (originalPrincipal != null) 'original_principal': originalPrincipal,
      if (outstandingBalance != null) 'outstanding_balance': outstandingBalance,
      if (interestRate != null) 'interest_rate': interestRate,
      if (paymentAmount != null) 'payment_amount': paymentAmount,
      if (paymentFrequency != null) 'payment_frequency': paymentFrequency,
      if (startDate != null) 'start_date': startDate,
      if (maturityDate != null) 'maturity_date': maturityDate,
      if (defaultPaymentAccountId != null)
        'default_payment_account_id': defaultPaymentAccountId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  LoansCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? loanType,
    Value<double>? originalPrincipal,
    Value<double>? outstandingBalance,
    Value<double?>? interestRate,
    Value<double>? paymentAmount,
    Value<String>? paymentFrequency,
    Value<DateTime>? startDate,
    Value<DateTime?>? maturityDate,
    Value<int?>? defaultPaymentAccountId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return LoansCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      loanType: loanType ?? this.loanType,
      originalPrincipal: originalPrincipal ?? this.originalPrincipal,
      outstandingBalance: outstandingBalance ?? this.outstandingBalance,
      interestRate: interestRate ?? this.interestRate,
      paymentAmount: paymentAmount ?? this.paymentAmount,
      paymentFrequency: paymentFrequency ?? this.paymentFrequency,
      startDate: startDate ?? this.startDate,
      maturityDate: maturityDate ?? this.maturityDate,
      defaultPaymentAccountId:
          defaultPaymentAccountId ?? this.defaultPaymentAccountId,
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
    if (loanType.present) {
      map['loan_type'] = Variable<String>(loanType.value);
    }
    if (originalPrincipal.present) {
      map['original_principal'] = Variable<double>(originalPrincipal.value);
    }
    if (outstandingBalance.present) {
      map['outstanding_balance'] = Variable<double>(outstandingBalance.value);
    }
    if (interestRate.present) {
      map['interest_rate'] = Variable<double>(interestRate.value);
    }
    if (paymentAmount.present) {
      map['payment_amount'] = Variable<double>(paymentAmount.value);
    }
    if (paymentFrequency.present) {
      map['payment_frequency'] = Variable<String>(paymentFrequency.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (maturityDate.present) {
      map['maturity_date'] = Variable<DateTime>(maturityDate.value);
    }
    if (defaultPaymentAccountId.present) {
      map['default_payment_account_id'] = Variable<int>(
        defaultPaymentAccountId.value,
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
    return (StringBuffer('LoansCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('loanType: $loanType, ')
          ..write('originalPrincipal: $originalPrincipal, ')
          ..write('outstandingBalance: $outstandingBalance, ')
          ..write('interestRate: $interestRate, ')
          ..write('paymentAmount: $paymentAmount, ')
          ..write('paymentFrequency: $paymentFrequency, ')
          ..write('startDate: $startDate, ')
          ..write('maturityDate: $maturityDate, ')
          ..write('defaultPaymentAccountId: $defaultPaymentAccountId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $CashFlowPlansTable extends CashFlowPlans
    with TableInfo<$CashFlowPlansTable, CashFlowPlan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CashFlowPlansTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _loanIdMeta = const VerificationMeta('loanId');
  @override
  late final GeneratedColumn<int> loanId = GeneratedColumn<int>(
    'loan_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES loans (id)',
    ),
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
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _periodMeta = const VerificationMeta('period');
  @override
  late final GeneratedColumn<String> period = GeneratedColumn<String>(
    'period',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _distributionTypeMeta = const VerificationMeta(
    'distributionType',
  );
  @override
  late final GeneratedColumn<String> distributionType = GeneratedColumn<String>(
    'distribution_type',
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
    true,
    type: DriftSqlType.dateTime,
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
    requiredDuringInsert: true,
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    categoryId,
    loanId,
    planType,
    amount,
    period,
    distributionType,
    startDate,
    endDate,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cash_flow_plans';
  @override
  VerificationContext validateIntegrity(
    Insertable<CashFlowPlan> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('loan_id')) {
      context.handle(
        _loanIdMeta,
        loanId.isAcceptableOrUnknown(data['loan_id']!, _loanIdMeta),
      );
    }
    if (data.containsKey('plan_type')) {
      context.handle(
        _planTypeMeta,
        planType.isAcceptableOrUnknown(data['plan_type']!, _planTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_planTypeMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('period')) {
      context.handle(
        _periodMeta,
        period.isAcceptableOrUnknown(data['period']!, _periodMeta),
      );
    } else if (isInserting) {
      context.missing(_periodMeta);
    }
    if (data.containsKey('distribution_type')) {
      context.handle(
        _distributionTypeMeta,
        distributionType.isAcceptableOrUnknown(
          data['distribution_type']!,
          _distributionTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_distributionTypeMeta);
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
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CashFlowPlan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CashFlowPlan(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category_id'],
      ),
      loanId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}loan_id'],
      ),
      planType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plan_type'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      period: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}period'],
      )!,
      distributionType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}distribution_type'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_date'],
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
  $CashFlowPlansTable createAlias(String alias) {
    return $CashFlowPlansTable(attachedDatabase, alias);
  }
}

class CashFlowPlan extends DataClass implements Insertable<CashFlowPlan> {
  final int id;
  final int? categoryId;
  final int? loanId;
  final String planType;
  final double amount;
  final String period;
  final String distributionType;
  final DateTime startDate;
  final DateTime? endDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  const CashFlowPlan({
    required this.id,
    this.categoryId,
    this.loanId,
    required this.planType,
    required this.amount,
    required this.period,
    required this.distributionType,
    required this.startDate,
    this.endDate,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<int>(categoryId);
    }
    if (!nullToAbsent || loanId != null) {
      map['loan_id'] = Variable<int>(loanId);
    }
    map['plan_type'] = Variable<String>(planType);
    map['amount'] = Variable<double>(amount);
    map['period'] = Variable<String>(period);
    map['distribution_type'] = Variable<String>(distributionType);
    map['start_date'] = Variable<DateTime>(startDate);
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CashFlowPlansCompanion toCompanion(bool nullToAbsent) {
    return CashFlowPlansCompanion(
      id: Value(id),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      loanId: loanId == null && nullToAbsent
          ? const Value.absent()
          : Value(loanId),
      planType: Value(planType),
      amount: Value(amount),
      period: Value(period),
      distributionType: Value(distributionType),
      startDate: Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CashFlowPlan.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CashFlowPlan(
      id: serializer.fromJson<int>(json['id']),
      categoryId: serializer.fromJson<int?>(json['categoryId']),
      loanId: serializer.fromJson<int?>(json['loanId']),
      planType: serializer.fromJson<String>(json['planType']),
      amount: serializer.fromJson<double>(json['amount']),
      period: serializer.fromJson<String>(json['period']),
      distributionType: serializer.fromJson<String>(json['distributionType']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'categoryId': serializer.toJson<int?>(categoryId),
      'loanId': serializer.toJson<int?>(loanId),
      'planType': serializer.toJson<String>(planType),
      'amount': serializer.toJson<double>(amount),
      'period': serializer.toJson<String>(period),
      'distributionType': serializer.toJson<String>(distributionType),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CashFlowPlan copyWith({
    int? id,
    Value<int?> categoryId = const Value.absent(),
    Value<int?> loanId = const Value.absent(),
    String? planType,
    double? amount,
    String? period,
    String? distributionType,
    DateTime? startDate,
    Value<DateTime?> endDate = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => CashFlowPlan(
    id: id ?? this.id,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    loanId: loanId.present ? loanId.value : this.loanId,
    planType: planType ?? this.planType,
    amount: amount ?? this.amount,
    period: period ?? this.period,
    distributionType: distributionType ?? this.distributionType,
    startDate: startDate ?? this.startDate,
    endDate: endDate.present ? endDate.value : this.endDate,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CashFlowPlan copyWithCompanion(CashFlowPlansCompanion data) {
    return CashFlowPlan(
      id: data.id.present ? data.id.value : this.id,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      loanId: data.loanId.present ? data.loanId.value : this.loanId,
      planType: data.planType.present ? data.planType.value : this.planType,
      amount: data.amount.present ? data.amount.value : this.amount,
      period: data.period.present ? data.period.value : this.period,
      distributionType: data.distributionType.present
          ? data.distributionType.value
          : this.distributionType,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CashFlowPlan(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('loanId: $loanId, ')
          ..write('planType: $planType, ')
          ..write('amount: $amount, ')
          ..write('period: $period, ')
          ..write('distributionType: $distributionType, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    categoryId,
    loanId,
    planType,
    amount,
    period,
    distributionType,
    startDate,
    endDate,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CashFlowPlan &&
          other.id == this.id &&
          other.categoryId == this.categoryId &&
          other.loanId == this.loanId &&
          other.planType == this.planType &&
          other.amount == this.amount &&
          other.period == this.period &&
          other.distributionType == this.distributionType &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CashFlowPlansCompanion extends UpdateCompanion<CashFlowPlan> {
  final Value<int> id;
  final Value<int?> categoryId;
  final Value<int?> loanId;
  final Value<String> planType;
  final Value<double> amount;
  final Value<String> period;
  final Value<String> distributionType;
  final Value<DateTime> startDate;
  final Value<DateTime?> endDate;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const CashFlowPlansCompanion({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.loanId = const Value.absent(),
    this.planType = const Value.absent(),
    this.amount = const Value.absent(),
    this.period = const Value.absent(),
    this.distributionType = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CashFlowPlansCompanion.insert({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.loanId = const Value.absent(),
    required String planType,
    required double amount,
    required String period,
    required String distributionType,
    required DateTime startDate,
    this.endDate = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : planType = Value(planType),
       amount = Value(amount),
       period = Value(period),
       distributionType = Value(distributionType),
       startDate = Value(startDate),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<CashFlowPlan> custom({
    Expression<int>? id,
    Expression<int>? categoryId,
    Expression<int>? loanId,
    Expression<String>? planType,
    Expression<double>? amount,
    Expression<String>? period,
    Expression<String>? distributionType,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryId != null) 'category_id': categoryId,
      if (loanId != null) 'loan_id': loanId,
      if (planType != null) 'plan_type': planType,
      if (amount != null) 'amount': amount,
      if (period != null) 'period': period,
      if (distributionType != null) 'distribution_type': distributionType,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CashFlowPlansCompanion copyWith({
    Value<int>? id,
    Value<int?>? categoryId,
    Value<int?>? loanId,
    Value<String>? planType,
    Value<double>? amount,
    Value<String>? period,
    Value<String>? distributionType,
    Value<DateTime>? startDate,
    Value<DateTime?>? endDate,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return CashFlowPlansCompanion(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      loanId: loanId ?? this.loanId,
      planType: planType ?? this.planType,
      amount: amount ?? this.amount,
      period: period ?? this.period,
      distributionType: distributionType ?? this.distributionType,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
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
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (loanId.present) {
      map['loan_id'] = Variable<int>(loanId.value);
    }
    if (planType.present) {
      map['plan_type'] = Variable<String>(planType.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (period.present) {
      map['period'] = Variable<String>(period.value);
    }
    if (distributionType.present) {
      map['distribution_type'] = Variable<String>(distributionType.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
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
    return (StringBuffer('CashFlowPlansCompanion(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('loanId: $loanId, ')
          ..write('planType: $planType, ')
          ..write('amount: $amount, ')
          ..write('period: $period, ')
          ..write('distributionType: $distributionType, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $CashFlowPlanAllocationsTable extends CashFlowPlanAllocations
    with TableInfo<$CashFlowPlanAllocationsTable, CashFlowPlanAllocation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CashFlowPlanAllocationsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _planIdMeta = const VerificationMeta('planId');
  @override
  late final GeneratedColumn<int> planId = GeneratedColumn<int>(
    'plan_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES cash_flow_plans (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _allocationIndexMeta = const VerificationMeta(
    'allocationIndex',
  );
  @override
  late final GeneratedColumn<int> allocationIndex = GeneratedColumn<int>(
    'allocation_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
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
  @override
  List<GeneratedColumn> get $columns => [id, planId, allocationIndex, amount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cash_flow_plan_allocations';
  @override
  VerificationContext validateIntegrity(
    Insertable<CashFlowPlanAllocation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('plan_id')) {
      context.handle(
        _planIdMeta,
        planId.isAcceptableOrUnknown(data['plan_id']!, _planIdMeta),
      );
    } else if (isInserting) {
      context.missing(_planIdMeta);
    }
    if (data.containsKey('allocation_index')) {
      context.handle(
        _allocationIndexMeta,
        allocationIndex.isAcceptableOrUnknown(
          data['allocation_index']!,
          _allocationIndexMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_allocationIndexMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {planId, allocationIndex},
  ];
  @override
  CashFlowPlanAllocation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CashFlowPlanAllocation(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      planId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}plan_id'],
      )!,
      allocationIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}allocation_index'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
    );
  }

  @override
  $CashFlowPlanAllocationsTable createAlias(String alias) {
    return $CashFlowPlanAllocationsTable(attachedDatabase, alias);
  }
}

class CashFlowPlanAllocation extends DataClass
    implements Insertable<CashFlowPlanAllocation> {
  final int id;
  final int planId;
  final int allocationIndex;
  final double amount;
  const CashFlowPlanAllocation({
    required this.id,
    required this.planId,
    required this.allocationIndex,
    required this.amount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['plan_id'] = Variable<int>(planId);
    map['allocation_index'] = Variable<int>(allocationIndex);
    map['amount'] = Variable<double>(amount);
    return map;
  }

  CashFlowPlanAllocationsCompanion toCompanion(bool nullToAbsent) {
    return CashFlowPlanAllocationsCompanion(
      id: Value(id),
      planId: Value(planId),
      allocationIndex: Value(allocationIndex),
      amount: Value(amount),
    );
  }

  factory CashFlowPlanAllocation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CashFlowPlanAllocation(
      id: serializer.fromJson<int>(json['id']),
      planId: serializer.fromJson<int>(json['planId']),
      allocationIndex: serializer.fromJson<int>(json['allocationIndex']),
      amount: serializer.fromJson<double>(json['amount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'planId': serializer.toJson<int>(planId),
      'allocationIndex': serializer.toJson<int>(allocationIndex),
      'amount': serializer.toJson<double>(amount),
    };
  }

  CashFlowPlanAllocation copyWith({
    int? id,
    int? planId,
    int? allocationIndex,
    double? amount,
  }) => CashFlowPlanAllocation(
    id: id ?? this.id,
    planId: planId ?? this.planId,
    allocationIndex: allocationIndex ?? this.allocationIndex,
    amount: amount ?? this.amount,
  );
  CashFlowPlanAllocation copyWithCompanion(
    CashFlowPlanAllocationsCompanion data,
  ) {
    return CashFlowPlanAllocation(
      id: data.id.present ? data.id.value : this.id,
      planId: data.planId.present ? data.planId.value : this.planId,
      allocationIndex: data.allocationIndex.present
          ? data.allocationIndex.value
          : this.allocationIndex,
      amount: data.amount.present ? data.amount.value : this.amount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CashFlowPlanAllocation(')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('allocationIndex: $allocationIndex, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, planId, allocationIndex, amount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CashFlowPlanAllocation &&
          other.id == this.id &&
          other.planId == this.planId &&
          other.allocationIndex == this.allocationIndex &&
          other.amount == this.amount);
}

class CashFlowPlanAllocationsCompanion
    extends UpdateCompanion<CashFlowPlanAllocation> {
  final Value<int> id;
  final Value<int> planId;
  final Value<int> allocationIndex;
  final Value<double> amount;
  const CashFlowPlanAllocationsCompanion({
    this.id = const Value.absent(),
    this.planId = const Value.absent(),
    this.allocationIndex = const Value.absent(),
    this.amount = const Value.absent(),
  });
  CashFlowPlanAllocationsCompanion.insert({
    this.id = const Value.absent(),
    required int planId,
    required int allocationIndex,
    required double amount,
  }) : planId = Value(planId),
       allocationIndex = Value(allocationIndex),
       amount = Value(amount);
  static Insertable<CashFlowPlanAllocation> custom({
    Expression<int>? id,
    Expression<int>? planId,
    Expression<int>? allocationIndex,
    Expression<double>? amount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (planId != null) 'plan_id': planId,
      if (allocationIndex != null) 'allocation_index': allocationIndex,
      if (amount != null) 'amount': amount,
    });
  }

  CashFlowPlanAllocationsCompanion copyWith({
    Value<int>? id,
    Value<int>? planId,
    Value<int>? allocationIndex,
    Value<double>? amount,
  }) {
    return CashFlowPlanAllocationsCompanion(
      id: id ?? this.id,
      planId: planId ?? this.planId,
      allocationIndex: allocationIndex ?? this.allocationIndex,
      amount: amount ?? this.amount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (planId.present) {
      map['plan_id'] = Variable<int>(planId.value);
    }
    if (allocationIndex.present) {
      map['allocation_index'] = Variable<int>(allocationIndex.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CashFlowPlanAllocationsCompanion(')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('allocationIndex: $allocationIndex, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }
}

class $CreditCardBillingPeriodsTableTable extends CreditCardBillingPeriodsTable
    with
        TableInfo<
          $CreditCardBillingPeriodsTableTable,
          CreditCardBillingPeriodsTableData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CreditCardBillingPeriodsTableTable(this.attachedDatabase, [this._alias]);
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
      'REFERENCES accounts_table (id) ON DELETE CASCADE',
    ),
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
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    accountId,
    startDate,
    endDate,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'credit_card_billing_periods_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<CreditCardBillingPeriodsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
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
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CreditCardBillingPeriodsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CreditCardBillingPeriodsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}account_id'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_date'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $CreditCardBillingPeriodsTableTable createAlias(String alias) {
    return $CreditCardBillingPeriodsTableTable(attachedDatabase, alias);
  }
}

class CreditCardBillingPeriodsTableData extends DataClass
    implements Insertable<CreditCardBillingPeriodsTableData> {
  final int id;
  final int accountId;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  const CreditCardBillingPeriodsTableData({
    required this.id,
    required this.accountId,
    required this.startDate,
    required this.endDate,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['account_id'] = Variable<int>(accountId);
    map['start_date'] = Variable<DateTime>(startDate);
    map['end_date'] = Variable<DateTime>(endDate);
    map['status'] = Variable<String>(status);
    return map;
  }

  CreditCardBillingPeriodsTableCompanion toCompanion(bool nullToAbsent) {
    return CreditCardBillingPeriodsTableCompanion(
      id: Value(id),
      accountId: Value(accountId),
      startDate: Value(startDate),
      endDate: Value(endDate),
      status: Value(status),
    );
  }

  factory CreditCardBillingPeriodsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CreditCardBillingPeriodsTableData(
      id: serializer.fromJson<int>(json['id']),
      accountId: serializer.fromJson<int>(json['accountId']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime>(json['endDate']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'accountId': serializer.toJson<int>(accountId),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime>(endDate),
      'status': serializer.toJson<String>(status),
    };
  }

  CreditCardBillingPeriodsTableData copyWith({
    int? id,
    int? accountId,
    DateTime? startDate,
    DateTime? endDate,
    String? status,
  }) => CreditCardBillingPeriodsTableData(
    id: id ?? this.id,
    accountId: accountId ?? this.accountId,
    startDate: startDate ?? this.startDate,
    endDate: endDate ?? this.endDate,
    status: status ?? this.status,
  );
  CreditCardBillingPeriodsTableData copyWithCompanion(
    CreditCardBillingPeriodsTableCompanion data,
  ) {
    return CreditCardBillingPeriodsTableData(
      id: data.id.present ? data.id.value : this.id,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CreditCardBillingPeriodsTableData(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, accountId, startDate, endDate, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CreditCardBillingPeriodsTableData &&
          other.id == this.id &&
          other.accountId == this.accountId &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.status == this.status);
}

class CreditCardBillingPeriodsTableCompanion
    extends UpdateCompanion<CreditCardBillingPeriodsTableData> {
  final Value<int> id;
  final Value<int> accountId;
  final Value<DateTime> startDate;
  final Value<DateTime> endDate;
  final Value<String> status;
  const CreditCardBillingPeriodsTableCompanion({
    this.id = const Value.absent(),
    this.accountId = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.status = const Value.absent(),
  });
  CreditCardBillingPeriodsTableCompanion.insert({
    this.id = const Value.absent(),
    required int accountId,
    required DateTime startDate,
    required DateTime endDate,
    required String status,
  }) : accountId = Value(accountId),
       startDate = Value(startDate),
       endDate = Value(endDate),
       status = Value(status);
  static Insertable<CreditCardBillingPeriodsTableData> custom({
    Expression<int>? id,
    Expression<int>? accountId,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<String>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accountId != null) 'account_id': accountId,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (status != null) 'status': status,
    });
  }

  CreditCardBillingPeriodsTableCompanion copyWith({
    Value<int>? id,
    Value<int>? accountId,
    Value<DateTime>? startDate,
    Value<DateTime>? endDate,
    Value<String>? status,
  }) {
    return CreditCardBillingPeriodsTableCompanion(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<int>(accountId.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CreditCardBillingPeriodsTableCompanion(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

class $CreditCardStatementsTableTable extends CreditCardStatementsTable
    with
        TableInfo<
          $CreditCardStatementsTableTable,
          CreditCardStatementsTableData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CreditCardStatementsTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _billingPeriodIdMeta = const VerificationMeta(
    'billingPeriodId',
  );
  @override
  late final GeneratedColumn<int> billingPeriodId = GeneratedColumn<int>(
    'billing_period_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES credit_card_billing_periods_table (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _statementBalanceMeta = const VerificationMeta(
    'statementBalance',
  );
  @override
  late final GeneratedColumn<double> statementBalance = GeneratedColumn<double>(
    'statement_balance',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paymentDueDateMeta = const VerificationMeta(
    'paymentDueDate',
  );
  @override
  late final GeneratedColumn<DateTime> paymentDueDate =
      GeneratedColumn<DateTime>(
        'payment_due_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _generatedAtMeta = const VerificationMeta(
    'generatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> generatedAt = GeneratedColumn<DateTime>(
    'generated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    billingPeriodId,
    statementBalance,
    paymentDueDate,
    generatedAt,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'credit_card_statements_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<CreditCardStatementsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('billing_period_id')) {
      context.handle(
        _billingPeriodIdMeta,
        billingPeriodId.isAcceptableOrUnknown(
          data['billing_period_id']!,
          _billingPeriodIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_billingPeriodIdMeta);
    }
    if (data.containsKey('statement_balance')) {
      context.handle(
        _statementBalanceMeta,
        statementBalance.isAcceptableOrUnknown(
          data['statement_balance']!,
          _statementBalanceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_statementBalanceMeta);
    }
    if (data.containsKey('payment_due_date')) {
      context.handle(
        _paymentDueDateMeta,
        paymentDueDate.isAcceptableOrUnknown(
          data['payment_due_date']!,
          _paymentDueDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paymentDueDateMeta);
    }
    if (data.containsKey('generated_at')) {
      context.handle(
        _generatedAtMeta,
        generatedAt.isAcceptableOrUnknown(
          data['generated_at']!,
          _generatedAtMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CreditCardStatementsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CreditCardStatementsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      billingPeriodId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}billing_period_id'],
      )!,
      statementBalance: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}statement_balance'],
      )!,
      paymentDueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}payment_due_date'],
      )!,
      generatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}generated_at'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $CreditCardStatementsTableTable createAlias(String alias) {
    return $CreditCardStatementsTableTable(attachedDatabase, alias);
  }
}

class CreditCardStatementsTableData extends DataClass
    implements Insertable<CreditCardStatementsTableData> {
  final int id;
  final int billingPeriodId;
  final double statementBalance;
  final DateTime paymentDueDate;
  final DateTime generatedAt;
  final String status;
  const CreditCardStatementsTableData({
    required this.id,
    required this.billingPeriodId,
    required this.statementBalance,
    required this.paymentDueDate,
    required this.generatedAt,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['billing_period_id'] = Variable<int>(billingPeriodId);
    map['statement_balance'] = Variable<double>(statementBalance);
    map['payment_due_date'] = Variable<DateTime>(paymentDueDate);
    map['generated_at'] = Variable<DateTime>(generatedAt);
    map['status'] = Variable<String>(status);
    return map;
  }

  CreditCardStatementsTableCompanion toCompanion(bool nullToAbsent) {
    return CreditCardStatementsTableCompanion(
      id: Value(id),
      billingPeriodId: Value(billingPeriodId),
      statementBalance: Value(statementBalance),
      paymentDueDate: Value(paymentDueDate),
      generatedAt: Value(generatedAt),
      status: Value(status),
    );
  }

  factory CreditCardStatementsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CreditCardStatementsTableData(
      id: serializer.fromJson<int>(json['id']),
      billingPeriodId: serializer.fromJson<int>(json['billingPeriodId']),
      statementBalance: serializer.fromJson<double>(json['statementBalance']),
      paymentDueDate: serializer.fromJson<DateTime>(json['paymentDueDate']),
      generatedAt: serializer.fromJson<DateTime>(json['generatedAt']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'billingPeriodId': serializer.toJson<int>(billingPeriodId),
      'statementBalance': serializer.toJson<double>(statementBalance),
      'paymentDueDate': serializer.toJson<DateTime>(paymentDueDate),
      'generatedAt': serializer.toJson<DateTime>(generatedAt),
      'status': serializer.toJson<String>(status),
    };
  }

  CreditCardStatementsTableData copyWith({
    int? id,
    int? billingPeriodId,
    double? statementBalance,
    DateTime? paymentDueDate,
    DateTime? generatedAt,
    String? status,
  }) => CreditCardStatementsTableData(
    id: id ?? this.id,
    billingPeriodId: billingPeriodId ?? this.billingPeriodId,
    statementBalance: statementBalance ?? this.statementBalance,
    paymentDueDate: paymentDueDate ?? this.paymentDueDate,
    generatedAt: generatedAt ?? this.generatedAt,
    status: status ?? this.status,
  );
  CreditCardStatementsTableData copyWithCompanion(
    CreditCardStatementsTableCompanion data,
  ) {
    return CreditCardStatementsTableData(
      id: data.id.present ? data.id.value : this.id,
      billingPeriodId: data.billingPeriodId.present
          ? data.billingPeriodId.value
          : this.billingPeriodId,
      statementBalance: data.statementBalance.present
          ? data.statementBalance.value
          : this.statementBalance,
      paymentDueDate: data.paymentDueDate.present
          ? data.paymentDueDate.value
          : this.paymentDueDate,
      generatedAt: data.generatedAt.present
          ? data.generatedAt.value
          : this.generatedAt,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CreditCardStatementsTableData(')
          ..write('id: $id, ')
          ..write('billingPeriodId: $billingPeriodId, ')
          ..write('statementBalance: $statementBalance, ')
          ..write('paymentDueDate: $paymentDueDate, ')
          ..write('generatedAt: $generatedAt, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    billingPeriodId,
    statementBalance,
    paymentDueDate,
    generatedAt,
    status,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CreditCardStatementsTableData &&
          other.id == this.id &&
          other.billingPeriodId == this.billingPeriodId &&
          other.statementBalance == this.statementBalance &&
          other.paymentDueDate == this.paymentDueDate &&
          other.generatedAt == this.generatedAt &&
          other.status == this.status);
}

class CreditCardStatementsTableCompanion
    extends UpdateCompanion<CreditCardStatementsTableData> {
  final Value<int> id;
  final Value<int> billingPeriodId;
  final Value<double> statementBalance;
  final Value<DateTime> paymentDueDate;
  final Value<DateTime> generatedAt;
  final Value<String> status;
  const CreditCardStatementsTableCompanion({
    this.id = const Value.absent(),
    this.billingPeriodId = const Value.absent(),
    this.statementBalance = const Value.absent(),
    this.paymentDueDate = const Value.absent(),
    this.generatedAt = const Value.absent(),
    this.status = const Value.absent(),
  });
  CreditCardStatementsTableCompanion.insert({
    this.id = const Value.absent(),
    required int billingPeriodId,
    required double statementBalance,
    required DateTime paymentDueDate,
    this.generatedAt = const Value.absent(),
    required String status,
  }) : billingPeriodId = Value(billingPeriodId),
       statementBalance = Value(statementBalance),
       paymentDueDate = Value(paymentDueDate),
       status = Value(status);
  static Insertable<CreditCardStatementsTableData> custom({
    Expression<int>? id,
    Expression<int>? billingPeriodId,
    Expression<double>? statementBalance,
    Expression<DateTime>? paymentDueDate,
    Expression<DateTime>? generatedAt,
    Expression<String>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (billingPeriodId != null) 'billing_period_id': billingPeriodId,
      if (statementBalance != null) 'statement_balance': statementBalance,
      if (paymentDueDate != null) 'payment_due_date': paymentDueDate,
      if (generatedAt != null) 'generated_at': generatedAt,
      if (status != null) 'status': status,
    });
  }

  CreditCardStatementsTableCompanion copyWith({
    Value<int>? id,
    Value<int>? billingPeriodId,
    Value<double>? statementBalance,
    Value<DateTime>? paymentDueDate,
    Value<DateTime>? generatedAt,
    Value<String>? status,
  }) {
    return CreditCardStatementsTableCompanion(
      id: id ?? this.id,
      billingPeriodId: billingPeriodId ?? this.billingPeriodId,
      statementBalance: statementBalance ?? this.statementBalance,
      paymentDueDate: paymentDueDate ?? this.paymentDueDate,
      generatedAt: generatedAt ?? this.generatedAt,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (billingPeriodId.present) {
      map['billing_period_id'] = Variable<int>(billingPeriodId.value);
    }
    if (statementBalance.present) {
      map['statement_balance'] = Variable<double>(statementBalance.value);
    }
    if (paymentDueDate.present) {
      map['payment_due_date'] = Variable<DateTime>(paymentDueDate.value);
    }
    if (generatedAt.present) {
      map['generated_at'] = Variable<DateTime>(generatedAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CreditCardStatementsTableCompanion(')
          ..write('id: $id, ')
          ..write('billingPeriodId: $billingPeriodId, ')
          ..write('statementBalance: $statementBalance, ')
          ..write('paymentDueDate: $paymentDueDate, ')
          ..write('generatedAt: $generatedAt, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

class $BillsTableTable extends BillsTable
    with TableInfo<$BillsTableTable, BillsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BillsTableTable(this.attachedDatabase, [this._alias]);
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
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES accounts_table (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _expectedAmountMeta = const VerificationMeta(
    'expectedAmount',
  );
  @override
  late final GeneratedColumn<double> expectedAmount = GeneratedColumn<double>(
    'expected_amount',
    aliasedName,
    true,
    type: DriftSqlType.double,
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
  static const VerificationMeta _dayOfMonthMeta = const VerificationMeta(
    'dayOfMonth',
  );
  @override
  late final GeneratedColumn<int> dayOfMonth = GeneratedColumn<int>(
    'day_of_month',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reminderEnabledMeta = const VerificationMeta(
    'reminderEnabled',
  );
  @override
  late final GeneratedColumn<bool> reminderEnabled = GeneratedColumn<bool>(
    'reminder_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("reminder_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _reminderDaysBeforeMeta =
      const VerificationMeta('reminderDaysBefore');
  @override
  late final GeneratedColumn<int> reminderDaysBefore = GeneratedColumn<int>(
    'reminder_days_before',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
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
  static const VerificationMeta _statementIdMeta = const VerificationMeta(
    'statementId',
  );
  @override
  late final GeneratedColumn<int> statementId = GeneratedColumn<int>(
    'statement_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES credit_card_statements_table (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    categoryId,
    accountId,
    expectedAmount,
    frequency,
    dayOfMonth,
    reminderEnabled,
    reminderDaysBefore,
    isActive,
    createdAt,
    updatedAt,
    statementId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bills_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<BillsTableData> instance, {
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
    }
    if (data.containsKey('expected_amount')) {
      context.handle(
        _expectedAmountMeta,
        expectedAmount.isAcceptableOrUnknown(
          data['expected_amount']!,
          _expectedAmountMeta,
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
    if (data.containsKey('day_of_month')) {
      context.handle(
        _dayOfMonthMeta,
        dayOfMonth.isAcceptableOrUnknown(
          data['day_of_month']!,
          _dayOfMonthMeta,
        ),
      );
    }
    if (data.containsKey('reminder_enabled')) {
      context.handle(
        _reminderEnabledMeta,
        reminderEnabled.isAcceptableOrUnknown(
          data['reminder_enabled']!,
          _reminderEnabledMeta,
        ),
      );
    }
    if (data.containsKey('reminder_days_before')) {
      context.handle(
        _reminderDaysBeforeMeta,
        reminderDaysBefore.isAcceptableOrUnknown(
          data['reminder_days_before']!,
          _reminderDaysBeforeMeta,
        ),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
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
    if (data.containsKey('statement_id')) {
      context.handle(
        _statementIdMeta,
        statementId.isAcceptableOrUnknown(
          data['statement_id']!,
          _statementIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BillsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BillsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category_id'],
      ),
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}account_id'],
      ),
      expectedAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}expected_amount'],
      ),
      frequency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}frequency'],
      )!,
      dayOfMonth: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}day_of_month'],
      ),
      reminderEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}reminder_enabled'],
      )!,
      reminderDaysBefore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reminder_days_before'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      statementId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}statement_id'],
      ),
    );
  }

  @override
  $BillsTableTable createAlias(String alias) {
    return $BillsTableTable(attachedDatabase, alias);
  }
}

class BillsTableData extends DataClass implements Insertable<BillsTableData> {
  final int id;
  final String name;

  /// Expense category associated with this bill.
  ///
  /// Null when the bill is associated with a financial account
  /// rather than an expense category.
  final int? categoryId;

  /// Financial account associated with this bill.
  ///
  /// Used for account-linked bills such as loan repayments
  /// and credit-card statements.
  ///
  /// Null when this is a normal expense bill.
  final int? accountId;

  /// The amount the user normally expects to pay.
  final double? expectedAmount;

  /// Recurrence frequency.
  final String frequency;

  /// Anchor day used to calculate recurring occurrences.
  ///
  /// For example, a bill created for the 31st remains anchored
  /// to the 31st even when an intermediate month has fewer days.
  final int? dayOfMonth;
  final bool reminderEnabled;
  final int? reminderDaysBefore;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? statementId;
  const BillsTableData({
    required this.id,
    required this.name,
    this.categoryId,
    this.accountId,
    this.expectedAmount,
    required this.frequency,
    this.dayOfMonth,
    required this.reminderEnabled,
    this.reminderDaysBefore,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.statementId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<int>(categoryId);
    }
    if (!nullToAbsent || accountId != null) {
      map['account_id'] = Variable<int>(accountId);
    }
    if (!nullToAbsent || expectedAmount != null) {
      map['expected_amount'] = Variable<double>(expectedAmount);
    }
    map['frequency'] = Variable<String>(frequency);
    if (!nullToAbsent || dayOfMonth != null) {
      map['day_of_month'] = Variable<int>(dayOfMonth);
    }
    map['reminder_enabled'] = Variable<bool>(reminderEnabled);
    if (!nullToAbsent || reminderDaysBefore != null) {
      map['reminder_days_before'] = Variable<int>(reminderDaysBefore);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || statementId != null) {
      map['statement_id'] = Variable<int>(statementId);
    }
    return map;
  }

  BillsTableCompanion toCompanion(bool nullToAbsent) {
    return BillsTableCompanion(
      id: Value(id),
      name: Value(name),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      accountId: accountId == null && nullToAbsent
          ? const Value.absent()
          : Value(accountId),
      expectedAmount: expectedAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(expectedAmount),
      frequency: Value(frequency),
      dayOfMonth: dayOfMonth == null && nullToAbsent
          ? const Value.absent()
          : Value(dayOfMonth),
      reminderEnabled: Value(reminderEnabled),
      reminderDaysBefore: reminderDaysBefore == null && nullToAbsent
          ? const Value.absent()
          : Value(reminderDaysBefore),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      statementId: statementId == null && nullToAbsent
          ? const Value.absent()
          : Value(statementId),
    );
  }

  factory BillsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BillsTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      categoryId: serializer.fromJson<int?>(json['categoryId']),
      accountId: serializer.fromJson<int?>(json['accountId']),
      expectedAmount: serializer.fromJson<double?>(json['expectedAmount']),
      frequency: serializer.fromJson<String>(json['frequency']),
      dayOfMonth: serializer.fromJson<int?>(json['dayOfMonth']),
      reminderEnabled: serializer.fromJson<bool>(json['reminderEnabled']),
      reminderDaysBefore: serializer.fromJson<int?>(json['reminderDaysBefore']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      statementId: serializer.fromJson<int?>(json['statementId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'categoryId': serializer.toJson<int?>(categoryId),
      'accountId': serializer.toJson<int?>(accountId),
      'expectedAmount': serializer.toJson<double?>(expectedAmount),
      'frequency': serializer.toJson<String>(frequency),
      'dayOfMonth': serializer.toJson<int?>(dayOfMonth),
      'reminderEnabled': serializer.toJson<bool>(reminderEnabled),
      'reminderDaysBefore': serializer.toJson<int?>(reminderDaysBefore),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'statementId': serializer.toJson<int?>(statementId),
    };
  }

  BillsTableData copyWith({
    int? id,
    String? name,
    Value<int?> categoryId = const Value.absent(),
    Value<int?> accountId = const Value.absent(),
    Value<double?> expectedAmount = const Value.absent(),
    String? frequency,
    Value<int?> dayOfMonth = const Value.absent(),
    bool? reminderEnabled,
    Value<int?> reminderDaysBefore = const Value.absent(),
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<int?> statementId = const Value.absent(),
  }) => BillsTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    accountId: accountId.present ? accountId.value : this.accountId,
    expectedAmount: expectedAmount.present
        ? expectedAmount.value
        : this.expectedAmount,
    frequency: frequency ?? this.frequency,
    dayOfMonth: dayOfMonth.present ? dayOfMonth.value : this.dayOfMonth,
    reminderEnabled: reminderEnabled ?? this.reminderEnabled,
    reminderDaysBefore: reminderDaysBefore.present
        ? reminderDaysBefore.value
        : this.reminderDaysBefore,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    statementId: statementId.present ? statementId.value : this.statementId,
  );
  BillsTableData copyWithCompanion(BillsTableCompanion data) {
    return BillsTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      expectedAmount: data.expectedAmount.present
          ? data.expectedAmount.value
          : this.expectedAmount,
      frequency: data.frequency.present ? data.frequency.value : this.frequency,
      dayOfMonth: data.dayOfMonth.present
          ? data.dayOfMonth.value
          : this.dayOfMonth,
      reminderEnabled: data.reminderEnabled.present
          ? data.reminderEnabled.value
          : this.reminderEnabled,
      reminderDaysBefore: data.reminderDaysBefore.present
          ? data.reminderDaysBefore.value
          : this.reminderDaysBefore,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      statementId: data.statementId.present
          ? data.statementId.value
          : this.statementId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BillsTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('categoryId: $categoryId, ')
          ..write('accountId: $accountId, ')
          ..write('expectedAmount: $expectedAmount, ')
          ..write('frequency: $frequency, ')
          ..write('dayOfMonth: $dayOfMonth, ')
          ..write('reminderEnabled: $reminderEnabled, ')
          ..write('reminderDaysBefore: $reminderDaysBefore, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('statementId: $statementId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    categoryId,
    accountId,
    expectedAmount,
    frequency,
    dayOfMonth,
    reminderEnabled,
    reminderDaysBefore,
    isActive,
    createdAt,
    updatedAt,
    statementId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BillsTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.categoryId == this.categoryId &&
          other.accountId == this.accountId &&
          other.expectedAmount == this.expectedAmount &&
          other.frequency == this.frequency &&
          other.dayOfMonth == this.dayOfMonth &&
          other.reminderEnabled == this.reminderEnabled &&
          other.reminderDaysBefore == this.reminderDaysBefore &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.statementId == this.statementId);
}

class BillsTableCompanion extends UpdateCompanion<BillsTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<int?> categoryId;
  final Value<int?> accountId;
  final Value<double?> expectedAmount;
  final Value<String> frequency;
  final Value<int?> dayOfMonth;
  final Value<bool> reminderEnabled;
  final Value<int?> reminderDaysBefore;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int?> statementId;
  const BillsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.accountId = const Value.absent(),
    this.expectedAmount = const Value.absent(),
    this.frequency = const Value.absent(),
    this.dayOfMonth = const Value.absent(),
    this.reminderEnabled = const Value.absent(),
    this.reminderDaysBefore = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.statementId = const Value.absent(),
  });
  BillsTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.categoryId = const Value.absent(),
    this.accountId = const Value.absent(),
    this.expectedAmount = const Value.absent(),
    required String frequency,
    this.dayOfMonth = const Value.absent(),
    this.reminderEnabled = const Value.absent(),
    this.reminderDaysBefore = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.statementId = const Value.absent(),
  }) : name = Value(name),
       frequency = Value(frequency);
  static Insertable<BillsTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? categoryId,
    Expression<int>? accountId,
    Expression<double>? expectedAmount,
    Expression<String>? frequency,
    Expression<int>? dayOfMonth,
    Expression<bool>? reminderEnabled,
    Expression<int>? reminderDaysBefore,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? statementId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (categoryId != null) 'category_id': categoryId,
      if (accountId != null) 'account_id': accountId,
      if (expectedAmount != null) 'expected_amount': expectedAmount,
      if (frequency != null) 'frequency': frequency,
      if (dayOfMonth != null) 'day_of_month': dayOfMonth,
      if (reminderEnabled != null) 'reminder_enabled': reminderEnabled,
      if (reminderDaysBefore != null)
        'reminder_days_before': reminderDaysBefore,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (statementId != null) 'statement_id': statementId,
    });
  }

  BillsTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int?>? categoryId,
    Value<int?>? accountId,
    Value<double?>? expectedAmount,
    Value<String>? frequency,
    Value<int?>? dayOfMonth,
    Value<bool>? reminderEnabled,
    Value<int?>? reminderDaysBefore,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int?>? statementId,
  }) {
    return BillsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
      accountId: accountId ?? this.accountId,
      expectedAmount: expectedAmount ?? this.expectedAmount,
      frequency: frequency ?? this.frequency,
      dayOfMonth: dayOfMonth ?? this.dayOfMonth,
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
      reminderDaysBefore: reminderDaysBefore ?? this.reminderDaysBefore,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      statementId: statementId ?? this.statementId,
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
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<int>(accountId.value);
    }
    if (expectedAmount.present) {
      map['expected_amount'] = Variable<double>(expectedAmount.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<String>(frequency.value);
    }
    if (dayOfMonth.present) {
      map['day_of_month'] = Variable<int>(dayOfMonth.value);
    }
    if (reminderEnabled.present) {
      map['reminder_enabled'] = Variable<bool>(reminderEnabled.value);
    }
    if (reminderDaysBefore.present) {
      map['reminder_days_before'] = Variable<int>(reminderDaysBefore.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (statementId.present) {
      map['statement_id'] = Variable<int>(statementId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BillsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('categoryId: $categoryId, ')
          ..write('accountId: $accountId, ')
          ..write('expectedAmount: $expectedAmount, ')
          ..write('frequency: $frequency, ')
          ..write('dayOfMonth: $dayOfMonth, ')
          ..write('reminderEnabled: $reminderEnabled, ')
          ..write('reminderDaysBefore: $reminderDaysBefore, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('statementId: $statementId')
          ..write(')'))
        .toString();
  }
}

class $BillOccurrencesTableTable extends BillOccurrencesTable
    with TableInfo<$BillOccurrencesTableTable, BillOccurrencesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BillOccurrencesTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _billIdMeta = const VerificationMeta('billId');
  @override
  late final GeneratedColumn<int> billId = GeneratedColumn<int>(
    'bill_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES bills_table (id)',
    ),
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
    'due_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expectedAmountMeta = const VerificationMeta(
    'expectedAmount',
  );
  @override
  late final GeneratedColumn<double> expectedAmount = GeneratedColumn<double>(
    'expected_amount',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _actualAmountMeta = const VerificationMeta(
    'actualAmount',
  );
  @override
  late final GeneratedColumn<double> actualAmount = GeneratedColumn<double>(
    'actual_amount',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isPaidMeta = const VerificationMeta('isPaid');
  @override
  late final GeneratedColumn<bool> isPaid = GeneratedColumn<bool>(
    'is_paid',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_paid" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _transactionIdMeta = const VerificationMeta(
    'transactionId',
  );
  @override
  late final GeneratedColumn<int> transactionId = GeneratedColumn<int>(
    'transaction_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES transactions_table (id)',
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    billId,
    dueDate,
    expectedAmount,
    actualAmount,
    isPaid,
    transactionId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bill_occurrences_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<BillOccurrencesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('bill_id')) {
      context.handle(
        _billIdMeta,
        billId.isAcceptableOrUnknown(data['bill_id']!, _billIdMeta),
      );
    } else if (isInserting) {
      context.missing(_billIdMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    } else if (isInserting) {
      context.missing(_dueDateMeta);
    }
    if (data.containsKey('expected_amount')) {
      context.handle(
        _expectedAmountMeta,
        expectedAmount.isAcceptableOrUnknown(
          data['expected_amount']!,
          _expectedAmountMeta,
        ),
      );
    }
    if (data.containsKey('actual_amount')) {
      context.handle(
        _actualAmountMeta,
        actualAmount.isAcceptableOrUnknown(
          data['actual_amount']!,
          _actualAmountMeta,
        ),
      );
    }
    if (data.containsKey('is_paid')) {
      context.handle(
        _isPaidMeta,
        isPaid.isAcceptableOrUnknown(data['is_paid']!, _isPaidMeta),
      );
    }
    if (data.containsKey('transaction_id')) {
      context.handle(
        _transactionIdMeta,
        transactionId.isAcceptableOrUnknown(
          data['transaction_id']!,
          _transactionIdMeta,
        ),
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
  BillOccurrencesTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BillOccurrencesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      billId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bill_id'],
      )!,
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_date'],
      )!,
      expectedAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}expected_amount'],
      ),
      actualAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}actual_amount'],
      ),
      isPaid: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_paid'],
      )!,
      transactionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}transaction_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $BillOccurrencesTableTable createAlias(String alias) {
    return $BillOccurrencesTableTable(attachedDatabase, alias);
  }
}

class BillOccurrencesTableData extends DataClass
    implements Insertable<BillOccurrencesTableData> {
  final int id;
  final int billId;
  final DateTime dueDate;

  /// Snapshot of the amount expected to be paid for this occurrence.
  ///
  /// Null when the amount is not yet known at occurrence creation time,
  /// such as a credit-card statement that has not yet been generated.
  final double? expectedAmount;

  /// Actual amount paid.
  ///
  /// Null until the bill is paid.
  final double? actualAmount;
  final bool isPaid;

  /// Set when the occurrence is converted into a transaction.
  final int? transactionId;
  final DateTime createdAt;
  const BillOccurrencesTableData({
    required this.id,
    required this.billId,
    required this.dueDate,
    this.expectedAmount,
    this.actualAmount,
    required this.isPaid,
    this.transactionId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['bill_id'] = Variable<int>(billId);
    map['due_date'] = Variable<DateTime>(dueDate);
    if (!nullToAbsent || expectedAmount != null) {
      map['expected_amount'] = Variable<double>(expectedAmount);
    }
    if (!nullToAbsent || actualAmount != null) {
      map['actual_amount'] = Variable<double>(actualAmount);
    }
    map['is_paid'] = Variable<bool>(isPaid);
    if (!nullToAbsent || transactionId != null) {
      map['transaction_id'] = Variable<int>(transactionId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  BillOccurrencesTableCompanion toCompanion(bool nullToAbsent) {
    return BillOccurrencesTableCompanion(
      id: Value(id),
      billId: Value(billId),
      dueDate: Value(dueDate),
      expectedAmount: expectedAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(expectedAmount),
      actualAmount: actualAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(actualAmount),
      isPaid: Value(isPaid),
      transactionId: transactionId == null && nullToAbsent
          ? const Value.absent()
          : Value(transactionId),
      createdAt: Value(createdAt),
    );
  }

  factory BillOccurrencesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BillOccurrencesTableData(
      id: serializer.fromJson<int>(json['id']),
      billId: serializer.fromJson<int>(json['billId']),
      dueDate: serializer.fromJson<DateTime>(json['dueDate']),
      expectedAmount: serializer.fromJson<double?>(json['expectedAmount']),
      actualAmount: serializer.fromJson<double?>(json['actualAmount']),
      isPaid: serializer.fromJson<bool>(json['isPaid']),
      transactionId: serializer.fromJson<int?>(json['transactionId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'billId': serializer.toJson<int>(billId),
      'dueDate': serializer.toJson<DateTime>(dueDate),
      'expectedAmount': serializer.toJson<double?>(expectedAmount),
      'actualAmount': serializer.toJson<double?>(actualAmount),
      'isPaid': serializer.toJson<bool>(isPaid),
      'transactionId': serializer.toJson<int?>(transactionId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  BillOccurrencesTableData copyWith({
    int? id,
    int? billId,
    DateTime? dueDate,
    Value<double?> expectedAmount = const Value.absent(),
    Value<double?> actualAmount = const Value.absent(),
    bool? isPaid,
    Value<int?> transactionId = const Value.absent(),
    DateTime? createdAt,
  }) => BillOccurrencesTableData(
    id: id ?? this.id,
    billId: billId ?? this.billId,
    dueDate: dueDate ?? this.dueDate,
    expectedAmount: expectedAmount.present
        ? expectedAmount.value
        : this.expectedAmount,
    actualAmount: actualAmount.present ? actualAmount.value : this.actualAmount,
    isPaid: isPaid ?? this.isPaid,
    transactionId: transactionId.present
        ? transactionId.value
        : this.transactionId,
    createdAt: createdAt ?? this.createdAt,
  );
  BillOccurrencesTableData copyWithCompanion(
    BillOccurrencesTableCompanion data,
  ) {
    return BillOccurrencesTableData(
      id: data.id.present ? data.id.value : this.id,
      billId: data.billId.present ? data.billId.value : this.billId,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      expectedAmount: data.expectedAmount.present
          ? data.expectedAmount.value
          : this.expectedAmount,
      actualAmount: data.actualAmount.present
          ? data.actualAmount.value
          : this.actualAmount,
      isPaid: data.isPaid.present ? data.isPaid.value : this.isPaid,
      transactionId: data.transactionId.present
          ? data.transactionId.value
          : this.transactionId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BillOccurrencesTableData(')
          ..write('id: $id, ')
          ..write('billId: $billId, ')
          ..write('dueDate: $dueDate, ')
          ..write('expectedAmount: $expectedAmount, ')
          ..write('actualAmount: $actualAmount, ')
          ..write('isPaid: $isPaid, ')
          ..write('transactionId: $transactionId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    billId,
    dueDate,
    expectedAmount,
    actualAmount,
    isPaid,
    transactionId,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BillOccurrencesTableData &&
          other.id == this.id &&
          other.billId == this.billId &&
          other.dueDate == this.dueDate &&
          other.expectedAmount == this.expectedAmount &&
          other.actualAmount == this.actualAmount &&
          other.isPaid == this.isPaid &&
          other.transactionId == this.transactionId &&
          other.createdAt == this.createdAt);
}

class BillOccurrencesTableCompanion
    extends UpdateCompanion<BillOccurrencesTableData> {
  final Value<int> id;
  final Value<int> billId;
  final Value<DateTime> dueDate;
  final Value<double?> expectedAmount;
  final Value<double?> actualAmount;
  final Value<bool> isPaid;
  final Value<int?> transactionId;
  final Value<DateTime> createdAt;
  const BillOccurrencesTableCompanion({
    this.id = const Value.absent(),
    this.billId = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.expectedAmount = const Value.absent(),
    this.actualAmount = const Value.absent(),
    this.isPaid = const Value.absent(),
    this.transactionId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  BillOccurrencesTableCompanion.insert({
    this.id = const Value.absent(),
    required int billId,
    required DateTime dueDate,
    this.expectedAmount = const Value.absent(),
    this.actualAmount = const Value.absent(),
    this.isPaid = const Value.absent(),
    this.transactionId = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : billId = Value(billId),
       dueDate = Value(dueDate);
  static Insertable<BillOccurrencesTableData> custom({
    Expression<int>? id,
    Expression<int>? billId,
    Expression<DateTime>? dueDate,
    Expression<double>? expectedAmount,
    Expression<double>? actualAmount,
    Expression<bool>? isPaid,
    Expression<int>? transactionId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (billId != null) 'bill_id': billId,
      if (dueDate != null) 'due_date': dueDate,
      if (expectedAmount != null) 'expected_amount': expectedAmount,
      if (actualAmount != null) 'actual_amount': actualAmount,
      if (isPaid != null) 'is_paid': isPaid,
      if (transactionId != null) 'transaction_id': transactionId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  BillOccurrencesTableCompanion copyWith({
    Value<int>? id,
    Value<int>? billId,
    Value<DateTime>? dueDate,
    Value<double?>? expectedAmount,
    Value<double?>? actualAmount,
    Value<bool>? isPaid,
    Value<int?>? transactionId,
    Value<DateTime>? createdAt,
  }) {
    return BillOccurrencesTableCompanion(
      id: id ?? this.id,
      billId: billId ?? this.billId,
      dueDate: dueDate ?? this.dueDate,
      expectedAmount: expectedAmount ?? this.expectedAmount,
      actualAmount: actualAmount ?? this.actualAmount,
      isPaid: isPaid ?? this.isPaid,
      transactionId: transactionId ?? this.transactionId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (billId.present) {
      map['bill_id'] = Variable<int>(billId.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (expectedAmount.present) {
      map['expected_amount'] = Variable<double>(expectedAmount.value);
    }
    if (actualAmount.present) {
      map['actual_amount'] = Variable<double>(actualAmount.value);
    }
    if (isPaid.present) {
      map['is_paid'] = Variable<bool>(isPaid.value);
    }
    if (transactionId.present) {
      map['transaction_id'] = Variable<int>(transactionId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BillOccurrencesTableCompanion(')
          ..write('id: $id, ')
          ..write('billId: $billId, ')
          ..write('dueDate: $dueDate, ')
          ..write('expectedAmount: $expectedAmount, ')
          ..write('actualAmount: $actualAmount, ')
          ..write('isPaid: $isPaid, ')
          ..write('transactionId: $transactionId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CreditCardDetailsTableTable extends CreditCardDetailsTable
    with TableInfo<$CreditCardDetailsTableTable, CreditCardDetailsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CreditCardDetailsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<int> accountId = GeneratedColumn<int>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES accounts_table (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _statementDayMeta = const VerificationMeta(
    'statementDay',
  );
  @override
  late final GeneratedColumn<int> statementDay = GeneratedColumn<int>(
    'statement_day',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paymentDueDayMeta = const VerificationMeta(
    'paymentDueDay',
  );
  @override
  late final GeneratedColumn<int> paymentDueDay = GeneratedColumn<int>(
    'payment_due_day',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nextStatementDateMeta = const VerificationMeta(
    'nextStatementDate',
  );
  @override
  late final GeneratedColumn<DateTime> nextStatementDate =
      GeneratedColumn<DateTime>(
        'next_statement_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _nextPaymentDueDateMeta =
      const VerificationMeta('nextPaymentDueDate');
  @override
  late final GeneratedColumn<DateTime> nextPaymentDueDate =
      GeneratedColumn<DateTime>(
        'next_payment_due_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    accountId,
    statementDay,
    paymentDueDay,
    nextStatementDate,
    nextPaymentDueDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'credit_card_details_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<CreditCardDetailsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    }
    if (data.containsKey('statement_day')) {
      context.handle(
        _statementDayMeta,
        statementDay.isAcceptableOrUnknown(
          data['statement_day']!,
          _statementDayMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_statementDayMeta);
    }
    if (data.containsKey('payment_due_day')) {
      context.handle(
        _paymentDueDayMeta,
        paymentDueDay.isAcceptableOrUnknown(
          data['payment_due_day']!,
          _paymentDueDayMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paymentDueDayMeta);
    }
    if (data.containsKey('next_statement_date')) {
      context.handle(
        _nextStatementDateMeta,
        nextStatementDate.isAcceptableOrUnknown(
          data['next_statement_date']!,
          _nextStatementDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nextStatementDateMeta);
    }
    if (data.containsKey('next_payment_due_date')) {
      context.handle(
        _nextPaymentDueDateMeta,
        nextPaymentDueDate.isAcceptableOrUnknown(
          data['next_payment_due_date']!,
          _nextPaymentDueDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nextPaymentDueDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {accountId};
  @override
  CreditCardDetailsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CreditCardDetailsTableData(
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}account_id'],
      )!,
      statementDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}statement_day'],
      )!,
      paymentDueDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}payment_due_day'],
      )!,
      nextStatementDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_statement_date'],
      )!,
      nextPaymentDueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_payment_due_date'],
      )!,
    );
  }

  @override
  $CreditCardDetailsTableTable createAlias(String alias) {
    return $CreditCardDetailsTableTable(attachedDatabase, alias);
  }
}

class CreditCardDetailsTableData extends DataClass
    implements Insertable<CreditCardDetailsTableData> {
  final int accountId;

  /// Recurring statement closing day.
  ///
  /// 1–31. If the month does not contain this day,
  /// the last valid day of the month is used.
  final int statementDay;

  /// Recurring payment due day.
  ///
  /// 1–31. If the month does not contain this day,
  /// the last valid day of the month is used.
  final int paymentDueDay;

  /// Next concrete statement closing date.
  final DateTime nextStatementDate;

  /// Next concrete payment due date associated with
  /// the next statement.
  final DateTime nextPaymentDueDate;
  const CreditCardDetailsTableData({
    required this.accountId,
    required this.statementDay,
    required this.paymentDueDay,
    required this.nextStatementDate,
    required this.nextPaymentDueDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['account_id'] = Variable<int>(accountId);
    map['statement_day'] = Variable<int>(statementDay);
    map['payment_due_day'] = Variable<int>(paymentDueDay);
    map['next_statement_date'] = Variable<DateTime>(nextStatementDate);
    map['next_payment_due_date'] = Variable<DateTime>(nextPaymentDueDate);
    return map;
  }

  CreditCardDetailsTableCompanion toCompanion(bool nullToAbsent) {
    return CreditCardDetailsTableCompanion(
      accountId: Value(accountId),
      statementDay: Value(statementDay),
      paymentDueDay: Value(paymentDueDay),
      nextStatementDate: Value(nextStatementDate),
      nextPaymentDueDate: Value(nextPaymentDueDate),
    );
  }

  factory CreditCardDetailsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CreditCardDetailsTableData(
      accountId: serializer.fromJson<int>(json['accountId']),
      statementDay: serializer.fromJson<int>(json['statementDay']),
      paymentDueDay: serializer.fromJson<int>(json['paymentDueDay']),
      nextStatementDate: serializer.fromJson<DateTime>(
        json['nextStatementDate'],
      ),
      nextPaymentDueDate: serializer.fromJson<DateTime>(
        json['nextPaymentDueDate'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'accountId': serializer.toJson<int>(accountId),
      'statementDay': serializer.toJson<int>(statementDay),
      'paymentDueDay': serializer.toJson<int>(paymentDueDay),
      'nextStatementDate': serializer.toJson<DateTime>(nextStatementDate),
      'nextPaymentDueDate': serializer.toJson<DateTime>(nextPaymentDueDate),
    };
  }

  CreditCardDetailsTableData copyWith({
    int? accountId,
    int? statementDay,
    int? paymentDueDay,
    DateTime? nextStatementDate,
    DateTime? nextPaymentDueDate,
  }) => CreditCardDetailsTableData(
    accountId: accountId ?? this.accountId,
    statementDay: statementDay ?? this.statementDay,
    paymentDueDay: paymentDueDay ?? this.paymentDueDay,
    nextStatementDate: nextStatementDate ?? this.nextStatementDate,
    nextPaymentDueDate: nextPaymentDueDate ?? this.nextPaymentDueDate,
  );
  CreditCardDetailsTableData copyWithCompanion(
    CreditCardDetailsTableCompanion data,
  ) {
    return CreditCardDetailsTableData(
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      statementDay: data.statementDay.present
          ? data.statementDay.value
          : this.statementDay,
      paymentDueDay: data.paymentDueDay.present
          ? data.paymentDueDay.value
          : this.paymentDueDay,
      nextStatementDate: data.nextStatementDate.present
          ? data.nextStatementDate.value
          : this.nextStatementDate,
      nextPaymentDueDate: data.nextPaymentDueDate.present
          ? data.nextPaymentDueDate.value
          : this.nextPaymentDueDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CreditCardDetailsTableData(')
          ..write('accountId: $accountId, ')
          ..write('statementDay: $statementDay, ')
          ..write('paymentDueDay: $paymentDueDay, ')
          ..write('nextStatementDate: $nextStatementDate, ')
          ..write('nextPaymentDueDate: $nextPaymentDueDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    accountId,
    statementDay,
    paymentDueDay,
    nextStatementDate,
    nextPaymentDueDate,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CreditCardDetailsTableData &&
          other.accountId == this.accountId &&
          other.statementDay == this.statementDay &&
          other.paymentDueDay == this.paymentDueDay &&
          other.nextStatementDate == this.nextStatementDate &&
          other.nextPaymentDueDate == this.nextPaymentDueDate);
}

class CreditCardDetailsTableCompanion
    extends UpdateCompanion<CreditCardDetailsTableData> {
  final Value<int> accountId;
  final Value<int> statementDay;
  final Value<int> paymentDueDay;
  final Value<DateTime> nextStatementDate;
  final Value<DateTime> nextPaymentDueDate;
  const CreditCardDetailsTableCompanion({
    this.accountId = const Value.absent(),
    this.statementDay = const Value.absent(),
    this.paymentDueDay = const Value.absent(),
    this.nextStatementDate = const Value.absent(),
    this.nextPaymentDueDate = const Value.absent(),
  });
  CreditCardDetailsTableCompanion.insert({
    this.accountId = const Value.absent(),
    required int statementDay,
    required int paymentDueDay,
    required DateTime nextStatementDate,
    required DateTime nextPaymentDueDate,
  }) : statementDay = Value(statementDay),
       paymentDueDay = Value(paymentDueDay),
       nextStatementDate = Value(nextStatementDate),
       nextPaymentDueDate = Value(nextPaymentDueDate);
  static Insertable<CreditCardDetailsTableData> custom({
    Expression<int>? accountId,
    Expression<int>? statementDay,
    Expression<int>? paymentDueDay,
    Expression<DateTime>? nextStatementDate,
    Expression<DateTime>? nextPaymentDueDate,
  }) {
    return RawValuesInsertable({
      if (accountId != null) 'account_id': accountId,
      if (statementDay != null) 'statement_day': statementDay,
      if (paymentDueDay != null) 'payment_due_day': paymentDueDay,
      if (nextStatementDate != null) 'next_statement_date': nextStatementDate,
      if (nextPaymentDueDate != null)
        'next_payment_due_date': nextPaymentDueDate,
    });
  }

  CreditCardDetailsTableCompanion copyWith({
    Value<int>? accountId,
    Value<int>? statementDay,
    Value<int>? paymentDueDay,
    Value<DateTime>? nextStatementDate,
    Value<DateTime>? nextPaymentDueDate,
  }) {
    return CreditCardDetailsTableCompanion(
      accountId: accountId ?? this.accountId,
      statementDay: statementDay ?? this.statementDay,
      paymentDueDay: paymentDueDay ?? this.paymentDueDay,
      nextStatementDate: nextStatementDate ?? this.nextStatementDate,
      nextPaymentDueDate: nextPaymentDueDate ?? this.nextPaymentDueDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (accountId.present) {
      map['account_id'] = Variable<int>(accountId.value);
    }
    if (statementDay.present) {
      map['statement_day'] = Variable<int>(statementDay.value);
    }
    if (paymentDueDay.present) {
      map['payment_due_day'] = Variable<int>(paymentDueDay.value);
    }
    if (nextStatementDate.present) {
      map['next_statement_date'] = Variable<DateTime>(nextStatementDate.value);
    }
    if (nextPaymentDueDate.present) {
      map['next_payment_due_date'] = Variable<DateTime>(
        nextPaymentDueDate.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CreditCardDetailsTableCompanion(')
          ..write('accountId: $accountId, ')
          ..write('statementDay: $statementDay, ')
          ..write('paymentDueDay: $paymentDueDay, ')
          ..write('nextStatementDate: $nextStatementDate, ')
          ..write('nextPaymentDueDate: $nextPaymentDueDate')
          ..write(')'))
        .toString();
  }
}

class $InvestorProfilesTableTable extends InvestorProfilesTable
    with TableInfo<$InvestorProfilesTableTable, InvestorProfilesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvestorProfilesTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _investmentHorizonMeta = const VerificationMeta(
    'investmentHorizon',
  );
  @override
  late final GeneratedColumn<String> investmentHorizon =
      GeneratedColumn<String>(
        'investment_horizon',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _withdrawalHorizonMeta = const VerificationMeta(
    'withdrawalHorizon',
  );
  @override
  late final GeneratedColumn<String> withdrawalHorizon =
      GeneratedColumn<String>(
        'withdrawal_horizon',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _investmentKnowledgeMeta =
      const VerificationMeta('investmentKnowledge');
  @override
  late final GeneratedColumn<String> investmentKnowledge =
      GeneratedColumn<String>(
        'investment_knowledge',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _riskWillingnessMeta = const VerificationMeta(
    'riskWillingness',
  );
  @override
  late final GeneratedColumn<String> riskWillingness = GeneratedColumn<String>(
    'risk_willingness',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _investmentExperienceMeta =
      const VerificationMeta('investmentExperience');
  @override
  late final GeneratedColumn<String> investmentExperience =
      GeneratedColumn<String>(
        'investment_experience',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _marketLossReactionMeta =
      const VerificationMeta('marketLossReaction');
  @override
  late final GeneratedColumn<String> marketLossReaction =
      GeneratedColumn<String>(
        'market_loss_reaction',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _riskReturnPreferenceMeta =
      const VerificationMeta('riskReturnPreference');
  @override
  late final GeneratedColumn<String> riskReturnPreference =
      GeneratedColumn<String>(
        'risk_return_preference',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _totalScoreMeta = const VerificationMeta(
    'totalScore',
  );
  @override
  late final GeneratedColumn<int> totalScore = GeneratedColumn<int>(
    'total_score',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _investorProfileMeta = const VerificationMeta(
    'investorProfile',
  );
  @override
  late final GeneratedColumn<String> investorProfile = GeneratedColumn<String>(
    'investor_profile',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _assessedAtMeta = const VerificationMeta(
    'assessedAt',
  );
  @override
  late final GeneratedColumn<DateTime> assessedAt = GeneratedColumn<DateTime>(
    'assessed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    investmentHorizon,
    withdrawalHorizon,
    investmentKnowledge,
    riskWillingness,
    investmentExperience,
    marketLossReaction,
    riskReturnPreference,
    totalScore,
    investorProfile,
    assessedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'investor_profiles_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<InvestorProfilesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('investment_horizon')) {
      context.handle(
        _investmentHorizonMeta,
        investmentHorizon.isAcceptableOrUnknown(
          data['investment_horizon']!,
          _investmentHorizonMeta,
        ),
      );
    }
    if (data.containsKey('withdrawal_horizon')) {
      context.handle(
        _withdrawalHorizonMeta,
        withdrawalHorizon.isAcceptableOrUnknown(
          data['withdrawal_horizon']!,
          _withdrawalHorizonMeta,
        ),
      );
    }
    if (data.containsKey('investment_knowledge')) {
      context.handle(
        _investmentKnowledgeMeta,
        investmentKnowledge.isAcceptableOrUnknown(
          data['investment_knowledge']!,
          _investmentKnowledgeMeta,
        ),
      );
    }
    if (data.containsKey('risk_willingness')) {
      context.handle(
        _riskWillingnessMeta,
        riskWillingness.isAcceptableOrUnknown(
          data['risk_willingness']!,
          _riskWillingnessMeta,
        ),
      );
    }
    if (data.containsKey('investment_experience')) {
      context.handle(
        _investmentExperienceMeta,
        investmentExperience.isAcceptableOrUnknown(
          data['investment_experience']!,
          _investmentExperienceMeta,
        ),
      );
    }
    if (data.containsKey('market_loss_reaction')) {
      context.handle(
        _marketLossReactionMeta,
        marketLossReaction.isAcceptableOrUnknown(
          data['market_loss_reaction']!,
          _marketLossReactionMeta,
        ),
      );
    }
    if (data.containsKey('risk_return_preference')) {
      context.handle(
        _riskReturnPreferenceMeta,
        riskReturnPreference.isAcceptableOrUnknown(
          data['risk_return_preference']!,
          _riskReturnPreferenceMeta,
        ),
      );
    }
    if (data.containsKey('total_score')) {
      context.handle(
        _totalScoreMeta,
        totalScore.isAcceptableOrUnknown(data['total_score']!, _totalScoreMeta),
      );
    }
    if (data.containsKey('investor_profile')) {
      context.handle(
        _investorProfileMeta,
        investorProfile.isAcceptableOrUnknown(
          data['investor_profile']!,
          _investorProfileMeta,
        ),
      );
    }
    if (data.containsKey('assessed_at')) {
      context.handle(
        _assessedAtMeta,
        assessedAt.isAcceptableOrUnknown(data['assessed_at']!, _assessedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InvestorProfilesTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InvestorProfilesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      investmentHorizon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}investment_horizon'],
      ),
      withdrawalHorizon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}withdrawal_horizon'],
      ),
      investmentKnowledge: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}investment_knowledge'],
      ),
      riskWillingness: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}risk_willingness'],
      ),
      investmentExperience: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}investment_experience'],
      ),
      marketLossReaction: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}market_loss_reaction'],
      ),
      riskReturnPreference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}risk_return_preference'],
      ),
      totalScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_score'],
      ),
      investorProfile: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}investor_profile'],
      ),
      assessedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}assessed_at'],
      ),
    );
  }

  @override
  $InvestorProfilesTableTable createAlias(String alias) {
    return $InvestorProfilesTableTable(attachedDatabase, alias);
  }
}

class InvestorProfilesTableData extends DataClass
    implements Insertable<InvestorProfilesTableData> {
  final int id;
  final String? investmentHorizon;
  final String? withdrawalHorizon;
  final String? investmentKnowledge;
  final String? riskWillingness;
  final String? investmentExperience;
  final String? marketLossReaction;
  final String? riskReturnPreference;
  final int? totalScore;
  final String? investorProfile;
  final DateTime? assessedAt;
  const InvestorProfilesTableData({
    required this.id,
    this.investmentHorizon,
    this.withdrawalHorizon,
    this.investmentKnowledge,
    this.riskWillingness,
    this.investmentExperience,
    this.marketLossReaction,
    this.riskReturnPreference,
    this.totalScore,
    this.investorProfile,
    this.assessedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || investmentHorizon != null) {
      map['investment_horizon'] = Variable<String>(investmentHorizon);
    }
    if (!nullToAbsent || withdrawalHorizon != null) {
      map['withdrawal_horizon'] = Variable<String>(withdrawalHorizon);
    }
    if (!nullToAbsent || investmentKnowledge != null) {
      map['investment_knowledge'] = Variable<String>(investmentKnowledge);
    }
    if (!nullToAbsent || riskWillingness != null) {
      map['risk_willingness'] = Variable<String>(riskWillingness);
    }
    if (!nullToAbsent || investmentExperience != null) {
      map['investment_experience'] = Variable<String>(investmentExperience);
    }
    if (!nullToAbsent || marketLossReaction != null) {
      map['market_loss_reaction'] = Variable<String>(marketLossReaction);
    }
    if (!nullToAbsent || riskReturnPreference != null) {
      map['risk_return_preference'] = Variable<String>(riskReturnPreference);
    }
    if (!nullToAbsent || totalScore != null) {
      map['total_score'] = Variable<int>(totalScore);
    }
    if (!nullToAbsent || investorProfile != null) {
      map['investor_profile'] = Variable<String>(investorProfile);
    }
    if (!nullToAbsent || assessedAt != null) {
      map['assessed_at'] = Variable<DateTime>(assessedAt);
    }
    return map;
  }

  InvestorProfilesTableCompanion toCompanion(bool nullToAbsent) {
    return InvestorProfilesTableCompanion(
      id: Value(id),
      investmentHorizon: investmentHorizon == null && nullToAbsent
          ? const Value.absent()
          : Value(investmentHorizon),
      withdrawalHorizon: withdrawalHorizon == null && nullToAbsent
          ? const Value.absent()
          : Value(withdrawalHorizon),
      investmentKnowledge: investmentKnowledge == null && nullToAbsent
          ? const Value.absent()
          : Value(investmentKnowledge),
      riskWillingness: riskWillingness == null && nullToAbsent
          ? const Value.absent()
          : Value(riskWillingness),
      investmentExperience: investmentExperience == null && nullToAbsent
          ? const Value.absent()
          : Value(investmentExperience),
      marketLossReaction: marketLossReaction == null && nullToAbsent
          ? const Value.absent()
          : Value(marketLossReaction),
      riskReturnPreference: riskReturnPreference == null && nullToAbsent
          ? const Value.absent()
          : Value(riskReturnPreference),
      totalScore: totalScore == null && nullToAbsent
          ? const Value.absent()
          : Value(totalScore),
      investorProfile: investorProfile == null && nullToAbsent
          ? const Value.absent()
          : Value(investorProfile),
      assessedAt: assessedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(assessedAt),
    );
  }

  factory InvestorProfilesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InvestorProfilesTableData(
      id: serializer.fromJson<int>(json['id']),
      investmentHorizon: serializer.fromJson<String?>(
        json['investmentHorizon'],
      ),
      withdrawalHorizon: serializer.fromJson<String?>(
        json['withdrawalHorizon'],
      ),
      investmentKnowledge: serializer.fromJson<String?>(
        json['investmentKnowledge'],
      ),
      riskWillingness: serializer.fromJson<String?>(json['riskWillingness']),
      investmentExperience: serializer.fromJson<String?>(
        json['investmentExperience'],
      ),
      marketLossReaction: serializer.fromJson<String?>(
        json['marketLossReaction'],
      ),
      riskReturnPreference: serializer.fromJson<String?>(
        json['riskReturnPreference'],
      ),
      totalScore: serializer.fromJson<int?>(json['totalScore']),
      investorProfile: serializer.fromJson<String?>(json['investorProfile']),
      assessedAt: serializer.fromJson<DateTime?>(json['assessedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'investmentHorizon': serializer.toJson<String?>(investmentHorizon),
      'withdrawalHorizon': serializer.toJson<String?>(withdrawalHorizon),
      'investmentKnowledge': serializer.toJson<String?>(investmentKnowledge),
      'riskWillingness': serializer.toJson<String?>(riskWillingness),
      'investmentExperience': serializer.toJson<String?>(investmentExperience),
      'marketLossReaction': serializer.toJson<String?>(marketLossReaction),
      'riskReturnPreference': serializer.toJson<String?>(riskReturnPreference),
      'totalScore': serializer.toJson<int?>(totalScore),
      'investorProfile': serializer.toJson<String?>(investorProfile),
      'assessedAt': serializer.toJson<DateTime?>(assessedAt),
    };
  }

  InvestorProfilesTableData copyWith({
    int? id,
    Value<String?> investmentHorizon = const Value.absent(),
    Value<String?> withdrawalHorizon = const Value.absent(),
    Value<String?> investmentKnowledge = const Value.absent(),
    Value<String?> riskWillingness = const Value.absent(),
    Value<String?> investmentExperience = const Value.absent(),
    Value<String?> marketLossReaction = const Value.absent(),
    Value<String?> riskReturnPreference = const Value.absent(),
    Value<int?> totalScore = const Value.absent(),
    Value<String?> investorProfile = const Value.absent(),
    Value<DateTime?> assessedAt = const Value.absent(),
  }) => InvestorProfilesTableData(
    id: id ?? this.id,
    investmentHorizon: investmentHorizon.present
        ? investmentHorizon.value
        : this.investmentHorizon,
    withdrawalHorizon: withdrawalHorizon.present
        ? withdrawalHorizon.value
        : this.withdrawalHorizon,
    investmentKnowledge: investmentKnowledge.present
        ? investmentKnowledge.value
        : this.investmentKnowledge,
    riskWillingness: riskWillingness.present
        ? riskWillingness.value
        : this.riskWillingness,
    investmentExperience: investmentExperience.present
        ? investmentExperience.value
        : this.investmentExperience,
    marketLossReaction: marketLossReaction.present
        ? marketLossReaction.value
        : this.marketLossReaction,
    riskReturnPreference: riskReturnPreference.present
        ? riskReturnPreference.value
        : this.riskReturnPreference,
    totalScore: totalScore.present ? totalScore.value : this.totalScore,
    investorProfile: investorProfile.present
        ? investorProfile.value
        : this.investorProfile,
    assessedAt: assessedAt.present ? assessedAt.value : this.assessedAt,
  );
  InvestorProfilesTableData copyWithCompanion(
    InvestorProfilesTableCompanion data,
  ) {
    return InvestorProfilesTableData(
      id: data.id.present ? data.id.value : this.id,
      investmentHorizon: data.investmentHorizon.present
          ? data.investmentHorizon.value
          : this.investmentHorizon,
      withdrawalHorizon: data.withdrawalHorizon.present
          ? data.withdrawalHorizon.value
          : this.withdrawalHorizon,
      investmentKnowledge: data.investmentKnowledge.present
          ? data.investmentKnowledge.value
          : this.investmentKnowledge,
      riskWillingness: data.riskWillingness.present
          ? data.riskWillingness.value
          : this.riskWillingness,
      investmentExperience: data.investmentExperience.present
          ? data.investmentExperience.value
          : this.investmentExperience,
      marketLossReaction: data.marketLossReaction.present
          ? data.marketLossReaction.value
          : this.marketLossReaction,
      riskReturnPreference: data.riskReturnPreference.present
          ? data.riskReturnPreference.value
          : this.riskReturnPreference,
      totalScore: data.totalScore.present
          ? data.totalScore.value
          : this.totalScore,
      investorProfile: data.investorProfile.present
          ? data.investorProfile.value
          : this.investorProfile,
      assessedAt: data.assessedAt.present
          ? data.assessedAt.value
          : this.assessedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InvestorProfilesTableData(')
          ..write('id: $id, ')
          ..write('investmentHorizon: $investmentHorizon, ')
          ..write('withdrawalHorizon: $withdrawalHorizon, ')
          ..write('investmentKnowledge: $investmentKnowledge, ')
          ..write('riskWillingness: $riskWillingness, ')
          ..write('investmentExperience: $investmentExperience, ')
          ..write('marketLossReaction: $marketLossReaction, ')
          ..write('riskReturnPreference: $riskReturnPreference, ')
          ..write('totalScore: $totalScore, ')
          ..write('investorProfile: $investorProfile, ')
          ..write('assessedAt: $assessedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    investmentHorizon,
    withdrawalHorizon,
    investmentKnowledge,
    riskWillingness,
    investmentExperience,
    marketLossReaction,
    riskReturnPreference,
    totalScore,
    investorProfile,
    assessedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InvestorProfilesTableData &&
          other.id == this.id &&
          other.investmentHorizon == this.investmentHorizon &&
          other.withdrawalHorizon == this.withdrawalHorizon &&
          other.investmentKnowledge == this.investmentKnowledge &&
          other.riskWillingness == this.riskWillingness &&
          other.investmentExperience == this.investmentExperience &&
          other.marketLossReaction == this.marketLossReaction &&
          other.riskReturnPreference == this.riskReturnPreference &&
          other.totalScore == this.totalScore &&
          other.investorProfile == this.investorProfile &&
          other.assessedAt == this.assessedAt);
}

class InvestorProfilesTableCompanion
    extends UpdateCompanion<InvestorProfilesTableData> {
  final Value<int> id;
  final Value<String?> investmentHorizon;
  final Value<String?> withdrawalHorizon;
  final Value<String?> investmentKnowledge;
  final Value<String?> riskWillingness;
  final Value<String?> investmentExperience;
  final Value<String?> marketLossReaction;
  final Value<String?> riskReturnPreference;
  final Value<int?> totalScore;
  final Value<String?> investorProfile;
  final Value<DateTime?> assessedAt;
  const InvestorProfilesTableCompanion({
    this.id = const Value.absent(),
    this.investmentHorizon = const Value.absent(),
    this.withdrawalHorizon = const Value.absent(),
    this.investmentKnowledge = const Value.absent(),
    this.riskWillingness = const Value.absent(),
    this.investmentExperience = const Value.absent(),
    this.marketLossReaction = const Value.absent(),
    this.riskReturnPreference = const Value.absent(),
    this.totalScore = const Value.absent(),
    this.investorProfile = const Value.absent(),
    this.assessedAt = const Value.absent(),
  });
  InvestorProfilesTableCompanion.insert({
    this.id = const Value.absent(),
    this.investmentHorizon = const Value.absent(),
    this.withdrawalHorizon = const Value.absent(),
    this.investmentKnowledge = const Value.absent(),
    this.riskWillingness = const Value.absent(),
    this.investmentExperience = const Value.absent(),
    this.marketLossReaction = const Value.absent(),
    this.riskReturnPreference = const Value.absent(),
    this.totalScore = const Value.absent(),
    this.investorProfile = const Value.absent(),
    this.assessedAt = const Value.absent(),
  });
  static Insertable<InvestorProfilesTableData> custom({
    Expression<int>? id,
    Expression<String>? investmentHorizon,
    Expression<String>? withdrawalHorizon,
    Expression<String>? investmentKnowledge,
    Expression<String>? riskWillingness,
    Expression<String>? investmentExperience,
    Expression<String>? marketLossReaction,
    Expression<String>? riskReturnPreference,
    Expression<int>? totalScore,
    Expression<String>? investorProfile,
    Expression<DateTime>? assessedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (investmentHorizon != null) 'investment_horizon': investmentHorizon,
      if (withdrawalHorizon != null) 'withdrawal_horizon': withdrawalHorizon,
      if (investmentKnowledge != null)
        'investment_knowledge': investmentKnowledge,
      if (riskWillingness != null) 'risk_willingness': riskWillingness,
      if (investmentExperience != null)
        'investment_experience': investmentExperience,
      if (marketLossReaction != null)
        'market_loss_reaction': marketLossReaction,
      if (riskReturnPreference != null)
        'risk_return_preference': riskReturnPreference,
      if (totalScore != null) 'total_score': totalScore,
      if (investorProfile != null) 'investor_profile': investorProfile,
      if (assessedAt != null) 'assessed_at': assessedAt,
    });
  }

  InvestorProfilesTableCompanion copyWith({
    Value<int>? id,
    Value<String?>? investmentHorizon,
    Value<String?>? withdrawalHorizon,
    Value<String?>? investmentKnowledge,
    Value<String?>? riskWillingness,
    Value<String?>? investmentExperience,
    Value<String?>? marketLossReaction,
    Value<String?>? riskReturnPreference,
    Value<int?>? totalScore,
    Value<String?>? investorProfile,
    Value<DateTime?>? assessedAt,
  }) {
    return InvestorProfilesTableCompanion(
      id: id ?? this.id,
      investmentHorizon: investmentHorizon ?? this.investmentHorizon,
      withdrawalHorizon: withdrawalHorizon ?? this.withdrawalHorizon,
      investmentKnowledge: investmentKnowledge ?? this.investmentKnowledge,
      riskWillingness: riskWillingness ?? this.riskWillingness,
      investmentExperience: investmentExperience ?? this.investmentExperience,
      marketLossReaction: marketLossReaction ?? this.marketLossReaction,
      riskReturnPreference: riskReturnPreference ?? this.riskReturnPreference,
      totalScore: totalScore ?? this.totalScore,
      investorProfile: investorProfile ?? this.investorProfile,
      assessedAt: assessedAt ?? this.assessedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (investmentHorizon.present) {
      map['investment_horizon'] = Variable<String>(investmentHorizon.value);
    }
    if (withdrawalHorizon.present) {
      map['withdrawal_horizon'] = Variable<String>(withdrawalHorizon.value);
    }
    if (investmentKnowledge.present) {
      map['investment_knowledge'] = Variable<String>(investmentKnowledge.value);
    }
    if (riskWillingness.present) {
      map['risk_willingness'] = Variable<String>(riskWillingness.value);
    }
    if (investmentExperience.present) {
      map['investment_experience'] = Variable<String>(
        investmentExperience.value,
      );
    }
    if (marketLossReaction.present) {
      map['market_loss_reaction'] = Variable<String>(marketLossReaction.value);
    }
    if (riskReturnPreference.present) {
      map['risk_return_preference'] = Variable<String>(
        riskReturnPreference.value,
      );
    }
    if (totalScore.present) {
      map['total_score'] = Variable<int>(totalScore.value);
    }
    if (investorProfile.present) {
      map['investor_profile'] = Variable<String>(investorProfile.value);
    }
    if (assessedAt.present) {
      map['assessed_at'] = Variable<DateTime>(assessedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvestorProfilesTableCompanion(')
          ..write('id: $id, ')
          ..write('investmentHorizon: $investmentHorizon, ')
          ..write('withdrawalHorizon: $withdrawalHorizon, ')
          ..write('investmentKnowledge: $investmentKnowledge, ')
          ..write('riskWillingness: $riskWillingness, ')
          ..write('investmentExperience: $investmentExperience, ')
          ..write('marketLossReaction: $marketLossReaction, ')
          ..write('riskReturnPreference: $riskReturnPreference, ')
          ..write('totalScore: $totalScore, ')
          ..write('investorProfile: $investorProfile, ')
          ..write('assessedAt: $assessedAt')
          ..write(')'))
        .toString();
  }
}

class $GoalsTableTable extends GoalsTable
    with TableInfo<$GoalsTableTable, GoalsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoalsTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetAmountMeta = const VerificationMeta(
    'targetAmount',
  );
  @override
  late final GeneratedColumn<double> targetAmount = GeneratedColumn<double>(
    'target_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _monthlyContributionMeta =
      const VerificationMeta('monthlyContribution');
  @override
  late final GeneratedColumn<double> monthlyContribution =
      GeneratedColumn<double>(
        'monthly_contribution',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
    'due_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    type,
    name,
    targetAmount,
    monthlyContribution,
    dueDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goals_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<GoalsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('target_amount')) {
      context.handle(
        _targetAmountMeta,
        targetAmount.isAcceptableOrUnknown(
          data['target_amount']!,
          _targetAmountMeta,
        ),
      );
    }
    if (data.containsKey('monthly_contribution')) {
      context.handle(
        _monthlyContributionMeta,
        monthlyContribution.isAcceptableOrUnknown(
          data['monthly_contribution']!,
          _monthlyContributionMeta,
        ),
      );
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GoalsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GoalsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      targetAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_amount'],
      )!,
      monthlyContribution: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}monthly_contribution'],
      )!,
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_date'],
      ),
    );
  }

  @override
  $GoalsTableTable createAlias(String alias) {
    return $GoalsTableTable(attachedDatabase, alias);
  }
}

class GoalsTableData extends DataClass implements Insertable<GoalsTableData> {
  final int id;
  final String type;
  final String? name;
  final double targetAmount;
  final double monthlyContribution;
  final DateTime? dueDate;
  const GoalsTableData({
    required this.id,
    required this.type,
    this.name,
    required this.targetAmount,
    required this.monthlyContribution,
    this.dueDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    map['target_amount'] = Variable<double>(targetAmount);
    map['monthly_contribution'] = Variable<double>(monthlyContribution);
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<DateTime>(dueDate);
    }
    return map;
  }

  GoalsTableCompanion toCompanion(bool nullToAbsent) {
    return GoalsTableCompanion(
      id: Value(id),
      type: Value(type),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      targetAmount: Value(targetAmount),
      monthlyContribution: Value(monthlyContribution),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
    );
  }

  factory GoalsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GoalsTableData(
      id: serializer.fromJson<int>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      name: serializer.fromJson<String?>(json['name']),
      targetAmount: serializer.fromJson<double>(json['targetAmount']),
      monthlyContribution: serializer.fromJson<double>(
        json['monthlyContribution'],
      ),
      dueDate: serializer.fromJson<DateTime?>(json['dueDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<String>(type),
      'name': serializer.toJson<String?>(name),
      'targetAmount': serializer.toJson<double>(targetAmount),
      'monthlyContribution': serializer.toJson<double>(monthlyContribution),
      'dueDate': serializer.toJson<DateTime?>(dueDate),
    };
  }

  GoalsTableData copyWith({
    int? id,
    String? type,
    Value<String?> name = const Value.absent(),
    double? targetAmount,
    double? monthlyContribution,
    Value<DateTime?> dueDate = const Value.absent(),
  }) => GoalsTableData(
    id: id ?? this.id,
    type: type ?? this.type,
    name: name.present ? name.value : this.name,
    targetAmount: targetAmount ?? this.targetAmount,
    monthlyContribution: monthlyContribution ?? this.monthlyContribution,
    dueDate: dueDate.present ? dueDate.value : this.dueDate,
  );
  GoalsTableData copyWithCompanion(GoalsTableCompanion data) {
    return GoalsTableData(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      name: data.name.present ? data.name.value : this.name,
      targetAmount: data.targetAmount.present
          ? data.targetAmount.value
          : this.targetAmount,
      monthlyContribution: data.monthlyContribution.present
          ? data.monthlyContribution.value
          : this.monthlyContribution,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GoalsTableData(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('targetAmount: $targetAmount, ')
          ..write('monthlyContribution: $monthlyContribution, ')
          ..write('dueDate: $dueDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, type, name, targetAmount, monthlyContribution, dueDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GoalsTableData &&
          other.id == this.id &&
          other.type == this.type &&
          other.name == this.name &&
          other.targetAmount == this.targetAmount &&
          other.monthlyContribution == this.monthlyContribution &&
          other.dueDate == this.dueDate);
}

class GoalsTableCompanion extends UpdateCompanion<GoalsTableData> {
  final Value<int> id;
  final Value<String> type;
  final Value<String?> name;
  final Value<double> targetAmount;
  final Value<double> monthlyContribution;
  final Value<DateTime?> dueDate;
  const GoalsTableCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.name = const Value.absent(),
    this.targetAmount = const Value.absent(),
    this.monthlyContribution = const Value.absent(),
    this.dueDate = const Value.absent(),
  });
  GoalsTableCompanion.insert({
    this.id = const Value.absent(),
    required String type,
    this.name = const Value.absent(),
    this.targetAmount = const Value.absent(),
    this.monthlyContribution = const Value.absent(),
    this.dueDate = const Value.absent(),
  }) : type = Value(type);
  static Insertable<GoalsTableData> custom({
    Expression<int>? id,
    Expression<String>? type,
    Expression<String>? name,
    Expression<double>? targetAmount,
    Expression<double>? monthlyContribution,
    Expression<DateTime>? dueDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (name != null) 'name': name,
      if (targetAmount != null) 'target_amount': targetAmount,
      if (monthlyContribution != null)
        'monthly_contribution': monthlyContribution,
      if (dueDate != null) 'due_date': dueDate,
    });
  }

  GoalsTableCompanion copyWith({
    Value<int>? id,
    Value<String>? type,
    Value<String?>? name,
    Value<double>? targetAmount,
    Value<double>? monthlyContribution,
    Value<DateTime?>? dueDate,
  }) {
    return GoalsTableCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      name: name ?? this.name,
      targetAmount: targetAmount ?? this.targetAmount,
      monthlyContribution: monthlyContribution ?? this.monthlyContribution,
      dueDate: dueDate ?? this.dueDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (targetAmount.present) {
      map['target_amount'] = Variable<double>(targetAmount.value);
    }
    if (monthlyContribution.present) {
      map['monthly_contribution'] = Variable<double>(monthlyContribution.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoalsTableCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('targetAmount: $targetAmount, ')
          ..write('monthlyContribution: $monthlyContribution, ')
          ..write('dueDate: $dueDate')
          ..write(')'))
        .toString();
  }
}

class $GoalReservationsTableTable extends GoalReservationsTable
    with TableInfo<$GoalReservationsTableTable, GoalReservationsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoalReservationsTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _goalIdMeta = const VerificationMeta('goalId');
  @override
  late final GeneratedColumn<int> goalId = GeneratedColumn<int>(
    'goal_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES goals_table (id)',
    ),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, accountId, goalId, amount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goal_reservations_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<GoalReservationsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('goal_id')) {
      context.handle(
        _goalIdMeta,
        goalId.isAcceptableOrUnknown(data['goal_id']!, _goalIdMeta),
      );
    } else if (isInserting) {
      context.missing(_goalIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GoalReservationsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GoalReservationsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}account_id'],
      )!,
      goalId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}goal_id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
    );
  }

  @override
  $GoalReservationsTableTable createAlias(String alias) {
    return $GoalReservationsTableTable(attachedDatabase, alias);
  }
}

class GoalReservationsTableData extends DataClass
    implements Insertable<GoalReservationsTableData> {
  final int id;
  final int accountId;
  final int goalId;
  final double amount;
  const GoalReservationsTableData({
    required this.id,
    required this.accountId,
    required this.goalId,
    required this.amount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['account_id'] = Variable<int>(accountId);
    map['goal_id'] = Variable<int>(goalId);
    map['amount'] = Variable<double>(amount);
    return map;
  }

  GoalReservationsTableCompanion toCompanion(bool nullToAbsent) {
    return GoalReservationsTableCompanion(
      id: Value(id),
      accountId: Value(accountId),
      goalId: Value(goalId),
      amount: Value(amount),
    );
  }

  factory GoalReservationsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GoalReservationsTableData(
      id: serializer.fromJson<int>(json['id']),
      accountId: serializer.fromJson<int>(json['accountId']),
      goalId: serializer.fromJson<int>(json['goalId']),
      amount: serializer.fromJson<double>(json['amount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'accountId': serializer.toJson<int>(accountId),
      'goalId': serializer.toJson<int>(goalId),
      'amount': serializer.toJson<double>(amount),
    };
  }

  GoalReservationsTableData copyWith({
    int? id,
    int? accountId,
    int? goalId,
    double? amount,
  }) => GoalReservationsTableData(
    id: id ?? this.id,
    accountId: accountId ?? this.accountId,
    goalId: goalId ?? this.goalId,
    amount: amount ?? this.amount,
  );
  GoalReservationsTableData copyWithCompanion(
    GoalReservationsTableCompanion data,
  ) {
    return GoalReservationsTableData(
      id: data.id.present ? data.id.value : this.id,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      goalId: data.goalId.present ? data.goalId.value : this.goalId,
      amount: data.amount.present ? data.amount.value : this.amount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GoalReservationsTableData(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('goalId: $goalId, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, accountId, goalId, amount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GoalReservationsTableData &&
          other.id == this.id &&
          other.accountId == this.accountId &&
          other.goalId == this.goalId &&
          other.amount == this.amount);
}

class GoalReservationsTableCompanion
    extends UpdateCompanion<GoalReservationsTableData> {
  final Value<int> id;
  final Value<int> accountId;
  final Value<int> goalId;
  final Value<double> amount;
  const GoalReservationsTableCompanion({
    this.id = const Value.absent(),
    this.accountId = const Value.absent(),
    this.goalId = const Value.absent(),
    this.amount = const Value.absent(),
  });
  GoalReservationsTableCompanion.insert({
    this.id = const Value.absent(),
    required int accountId,
    required int goalId,
    this.amount = const Value.absent(),
  }) : accountId = Value(accountId),
       goalId = Value(goalId);
  static Insertable<GoalReservationsTableData> custom({
    Expression<int>? id,
    Expression<int>? accountId,
    Expression<int>? goalId,
    Expression<double>? amount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accountId != null) 'account_id': accountId,
      if (goalId != null) 'goal_id': goalId,
      if (amount != null) 'amount': amount,
    });
  }

  GoalReservationsTableCompanion copyWith({
    Value<int>? id,
    Value<int>? accountId,
    Value<int>? goalId,
    Value<double>? amount,
  }) {
    return GoalReservationsTableCompanion(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      goalId: goalId ?? this.goalId,
      amount: amount ?? this.amount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<int>(accountId.value);
    }
    if (goalId.present) {
      map['goal_id'] = Variable<int>(goalId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoalReservationsTableCompanion(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('goalId: $goalId, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }
}

class $UserProfileTableTable extends UserProfileTable
    with TableInfo<$UserProfileTableTable, UserProfileTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProfileTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _birthdayMeta = const VerificationMeta(
    'birthday',
  );
  @override
  late final GeneratedColumn<DateTime> birthday = GeneratedColumn<DateTime>(
    'birthday',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, birthday];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_profile_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserProfileTableData> instance, {
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
    }
    if (data.containsKey('birthday')) {
      context.handle(
        _birthdayMeta,
        birthday.isAcceptableOrUnknown(data['birthday']!, _birthdayMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserProfileTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProfileTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      birthday: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}birthday'],
      ),
    );
  }

  @override
  $UserProfileTableTable createAlias(String alias) {
    return $UserProfileTableTable(attachedDatabase, alias);
  }
}

class UserProfileTableData extends DataClass
    implements Insertable<UserProfileTableData> {
  final int id;
  final String? name;
  final DateTime? birthday;
  const UserProfileTableData({required this.id, this.name, this.birthday});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || birthday != null) {
      map['birthday'] = Variable<DateTime>(birthday);
    }
    return map;
  }

  UserProfileTableCompanion toCompanion(bool nullToAbsent) {
    return UserProfileTableCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      birthday: birthday == null && nullToAbsent
          ? const Value.absent()
          : Value(birthday),
    );
  }

  factory UserProfileTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProfileTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      birthday: serializer.fromJson<DateTime?>(json['birthday']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String?>(name),
      'birthday': serializer.toJson<DateTime?>(birthday),
    };
  }

  UserProfileTableData copyWith({
    int? id,
    Value<String?> name = const Value.absent(),
    Value<DateTime?> birthday = const Value.absent(),
  }) => UserProfileTableData(
    id: id ?? this.id,
    name: name.present ? name.value : this.name,
    birthday: birthday.present ? birthday.value : this.birthday,
  );
  UserProfileTableData copyWithCompanion(UserProfileTableCompanion data) {
    return UserProfileTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      birthday: data.birthday.present ? data.birthday.value : this.birthday,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProfileTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('birthday: $birthday')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, birthday);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProfileTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.birthday == this.birthday);
}

class UserProfileTableCompanion extends UpdateCompanion<UserProfileTableData> {
  final Value<int> id;
  final Value<String?> name;
  final Value<DateTime?> birthday;
  const UserProfileTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.birthday = const Value.absent(),
  });
  UserProfileTableCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.birthday = const Value.absent(),
  });
  static Insertable<UserProfileTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<DateTime>? birthday,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (birthday != null) 'birthday': birthday,
    });
  }

  UserProfileTableCompanion copyWith({
    Value<int>? id,
    Value<String?>? name,
    Value<DateTime?>? birthday,
  }) {
    return UserProfileTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      birthday: birthday ?? this.birthday,
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
    if (birthday.present) {
      map['birthday'] = Variable<DateTime>(birthday.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProfileTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('birthday: $birthday')
          ..write(')'))
        .toString();
  }
}

class $RetirementGoalsTableTable extends RetirementGoalsTable
    with TableInfo<$RetirementGoalsTableTable, RetirementGoalsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RetirementGoalsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _goalIdMeta = const VerificationMeta('goalId');
  @override
  late final GeneratedColumn<int> goalId = GeneratedColumn<int>(
    'goal_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES goals_table (id)',
    ),
  );
  static const VerificationMeta _retirementAgeMeta = const VerificationMeta(
    'retirementAge',
  );
  @override
  late final GeneratedColumn<int> retirementAge = GeneratedColumn<int>(
    'retirement_age',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fundEndAgeMeta = const VerificationMeta(
    'fundEndAge',
  );
  @override
  late final GeneratedColumn<int> fundEndAge = GeneratedColumn<int>(
    'fund_end_age',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [goalId, retirementAge, fundEndAge];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'retirement_goals_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<RetirementGoalsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('goal_id')) {
      context.handle(
        _goalIdMeta,
        goalId.isAcceptableOrUnknown(data['goal_id']!, _goalIdMeta),
      );
    }
    if (data.containsKey('retirement_age')) {
      context.handle(
        _retirementAgeMeta,
        retirementAge.isAcceptableOrUnknown(
          data['retirement_age']!,
          _retirementAgeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_retirementAgeMeta);
    }
    if (data.containsKey('fund_end_age')) {
      context.handle(
        _fundEndAgeMeta,
        fundEndAge.isAcceptableOrUnknown(
          data['fund_end_age']!,
          _fundEndAgeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fundEndAgeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {goalId};
  @override
  RetirementGoalsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RetirementGoalsTableData(
      goalId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}goal_id'],
      )!,
      retirementAge: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retirement_age'],
      )!,
      fundEndAge: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fund_end_age'],
      )!,
    );
  }

  @override
  $RetirementGoalsTableTable createAlias(String alias) {
    return $RetirementGoalsTableTable(attachedDatabase, alias);
  }
}

class RetirementGoalsTableData extends DataClass
    implements Insertable<RetirementGoalsTableData> {
  final int goalId;
  final int retirementAge;
  final int fundEndAge;
  const RetirementGoalsTableData({
    required this.goalId,
    required this.retirementAge,
    required this.fundEndAge,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['goal_id'] = Variable<int>(goalId);
    map['retirement_age'] = Variable<int>(retirementAge);
    map['fund_end_age'] = Variable<int>(fundEndAge);
    return map;
  }

  RetirementGoalsTableCompanion toCompanion(bool nullToAbsent) {
    return RetirementGoalsTableCompanion(
      goalId: Value(goalId),
      retirementAge: Value(retirementAge),
      fundEndAge: Value(fundEndAge),
    );
  }

  factory RetirementGoalsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RetirementGoalsTableData(
      goalId: serializer.fromJson<int>(json['goalId']),
      retirementAge: serializer.fromJson<int>(json['retirementAge']),
      fundEndAge: serializer.fromJson<int>(json['fundEndAge']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'goalId': serializer.toJson<int>(goalId),
      'retirementAge': serializer.toJson<int>(retirementAge),
      'fundEndAge': serializer.toJson<int>(fundEndAge),
    };
  }

  RetirementGoalsTableData copyWith({
    int? goalId,
    int? retirementAge,
    int? fundEndAge,
  }) => RetirementGoalsTableData(
    goalId: goalId ?? this.goalId,
    retirementAge: retirementAge ?? this.retirementAge,
    fundEndAge: fundEndAge ?? this.fundEndAge,
  );
  RetirementGoalsTableData copyWithCompanion(
    RetirementGoalsTableCompanion data,
  ) {
    return RetirementGoalsTableData(
      goalId: data.goalId.present ? data.goalId.value : this.goalId,
      retirementAge: data.retirementAge.present
          ? data.retirementAge.value
          : this.retirementAge,
      fundEndAge: data.fundEndAge.present
          ? data.fundEndAge.value
          : this.fundEndAge,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RetirementGoalsTableData(')
          ..write('goalId: $goalId, ')
          ..write('retirementAge: $retirementAge, ')
          ..write('fundEndAge: $fundEndAge')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(goalId, retirementAge, fundEndAge);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RetirementGoalsTableData &&
          other.goalId == this.goalId &&
          other.retirementAge == this.retirementAge &&
          other.fundEndAge == this.fundEndAge);
}

class RetirementGoalsTableCompanion
    extends UpdateCompanion<RetirementGoalsTableData> {
  final Value<int> goalId;
  final Value<int> retirementAge;
  final Value<int> fundEndAge;
  const RetirementGoalsTableCompanion({
    this.goalId = const Value.absent(),
    this.retirementAge = const Value.absent(),
    this.fundEndAge = const Value.absent(),
  });
  RetirementGoalsTableCompanion.insert({
    this.goalId = const Value.absent(),
    required int retirementAge,
    required int fundEndAge,
  }) : retirementAge = Value(retirementAge),
       fundEndAge = Value(fundEndAge);
  static Insertable<RetirementGoalsTableData> custom({
    Expression<int>? goalId,
    Expression<int>? retirementAge,
    Expression<int>? fundEndAge,
  }) {
    return RawValuesInsertable({
      if (goalId != null) 'goal_id': goalId,
      if (retirementAge != null) 'retirement_age': retirementAge,
      if (fundEndAge != null) 'fund_end_age': fundEndAge,
    });
  }

  RetirementGoalsTableCompanion copyWith({
    Value<int>? goalId,
    Value<int>? retirementAge,
    Value<int>? fundEndAge,
  }) {
    return RetirementGoalsTableCompanion(
      goalId: goalId ?? this.goalId,
      retirementAge: retirementAge ?? this.retirementAge,
      fundEndAge: fundEndAge ?? this.fundEndAge,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (goalId.present) {
      map['goal_id'] = Variable<int>(goalId.value);
    }
    if (retirementAge.present) {
      map['retirement_age'] = Variable<int>(retirementAge.value);
    }
    if (fundEndAge.present) {
      map['fund_end_age'] = Variable<int>(fundEndAge.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RetirementGoalsTableCompanion(')
          ..write('goalId: $goalId, ')
          ..write('retirementAge: $retirementAge, ')
          ..write('fundEndAge: $fundEndAge')
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
  late final $LoansTable loans = $LoansTable(this);
  late final $CashFlowPlansTable cashFlowPlans = $CashFlowPlansTable(this);
  late final $CashFlowPlanAllocationsTable cashFlowPlanAllocations =
      $CashFlowPlanAllocationsTable(this);
  late final $CreditCardBillingPeriodsTableTable creditCardBillingPeriodsTable =
      $CreditCardBillingPeriodsTableTable(this);
  late final $CreditCardStatementsTableTable creditCardStatementsTable =
      $CreditCardStatementsTableTable(this);
  late final $BillsTableTable billsTable = $BillsTableTable(this);
  late final $BillOccurrencesTableTable billOccurrencesTable =
      $BillOccurrencesTableTable(this);
  late final $CreditCardDetailsTableTable creditCardDetailsTable =
      $CreditCardDetailsTableTable(this);
  late final $InvestorProfilesTableTable investorProfilesTable =
      $InvestorProfilesTableTable(this);
  late final $GoalsTableTable goalsTable = $GoalsTableTable(this);
  late final $GoalReservationsTableTable goalReservationsTable =
      $GoalReservationsTableTable(this);
  late final $UserProfileTableTable userProfileTable = $UserProfileTableTable(
    this,
  );
  late final $RetirementGoalsTableTable retirementGoalsTable =
      $RetirementGoalsTableTable(this);
  late final TransactionsDao transactionsDao = TransactionsDao(
    this as AppDatabase,
  );
  late final AccountsDao accountsDao = AccountsDao(this as AppDatabase);
  late final PeopleBalanceDao peopleBalanceDao = PeopleBalanceDao(
    this as AppDatabase,
  );
  late final EntitiesDao entitiesDao = EntitiesDao(this as AppDatabase);
  late final CashflowPlanDao cashflowPlanDao = CashflowPlanDao(
    this as AppDatabase,
  );
  late final BillsDao billsDao = BillsDao(this as AppDatabase);
  late final CategoryDao categoryDao = CategoryDao(this as AppDatabase);
  late final CreditCardDao creditCardDao = CreditCardDao(this as AppDatabase);
  late final InvestorProfileDao investorProfileDao = InvestorProfileDao(
    this as AppDatabase,
  );
  late final GoalsDao goalsDao = GoalsDao(this as AppDatabase);
  late final GoalReservationsDao goalReservationsDao = GoalReservationsDao(
    this as AppDatabase,
  );
  late final UserProfileDao userProfileDao = UserProfileDao(
    this as AppDatabase,
  );
  late final RetirementGoalDao retirementGoalDao = RetirementGoalDao(
    this as AppDatabase,
  );
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
    loans,
    cashFlowPlans,
    cashFlowPlanAllocations,
    creditCardBillingPeriodsTable,
    creditCardStatementsTable,
    billsTable,
    billOccurrencesTable,
    creditCardDetailsTable,
    investorProfilesTable,
    goalsTable,
    goalReservationsTable,
    userProfileTable,
    retirementGoalsTable,
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
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'cash_flow_plans',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('cash_flow_plan_allocations', kind: UpdateKind.delete),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'accounts_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate(
          'credit_card_billing_periods_table',
          kind: UpdateKind.delete,
        ),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'credit_card_billing_periods_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('credit_card_statements_table', kind: UpdateKind.delete),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'accounts_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('bills_table', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'credit_card_statements_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('bills_table', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'accounts_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('credit_card_details_table', kind: UpdateKind.delete),
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
        aliasName:
            'cashflow_categories_table__id__transactions_table__category_id',
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

  static MultiTypedResultKey<$CashFlowPlansTable, List<CashFlowPlan>>
  _cashFlowPlansRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.cashFlowPlans,
    aliasName: 'cashflow_categories_table__id__cash_flow_plans__category_id',
  );

  $$CashFlowPlansTableProcessedTableManager get cashFlowPlansRefs {
    final manager = $$CashFlowPlansTableTableManager(
      $_db,
      $_db.cashFlowPlans,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_cashFlowPlansRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$BillsTableTable, List<BillsTableData>>
  _billsTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.billsTable,
    aliasName: 'cashflow_categories_table__id__bills_table__category_id',
  );

  $$BillsTableTableProcessedTableManager get billsTableRefs {
    final manager = $$BillsTableTableTableManager(
      $_db,
      $_db.billsTable,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_billsTableRefsTable($_db));
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

  Expression<bool> cashFlowPlansRefs(
    Expression<bool> Function($$CashFlowPlansTableFilterComposer f) f,
  ) {
    final $$CashFlowPlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cashFlowPlans,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CashFlowPlansTableFilterComposer(
            $db: $db,
            $table: $db.cashFlowPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> billsTableRefs(
    Expression<bool> Function($$BillsTableTableFilterComposer f) f,
  ) {
    final $$BillsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.billsTable,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BillsTableTableFilterComposer(
            $db: $db,
            $table: $db.billsTable,
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

  Expression<T> cashFlowPlansRefs<T extends Object>(
    Expression<T> Function($$CashFlowPlansTableAnnotationComposer a) f,
  ) {
    final $$CashFlowPlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cashFlowPlans,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CashFlowPlansTableAnnotationComposer(
            $db: $db,
            $table: $db.cashFlowPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> billsTableRefs<T extends Object>(
    Expression<T> Function($$BillsTableTableAnnotationComposer a) f,
  ) {
    final $$BillsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.billsTable,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BillsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.billsTable,
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
            bool cashFlowPlansRefs,
            bool billsTableRefs,
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
                cashFlowPlansRefs = false,
                billsTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (transactionsTableRefs) db.transactionsTable,
                    if (cashFlowPlansRefs) db.cashFlowPlans,
                    if (billsTableRefs) db.billsTable,
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
                      if (cashFlowPlansRefs)
                        await $_getPrefetchedData<
                          CashflowCategoriesTableData,
                          $CashflowCategoriesTableTable,
                          CashFlowPlan
                        >(
                          currentTable: table,
                          referencedTable:
                              $$CashflowCategoriesTableTableReferences
                                  ._cashFlowPlansRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CashflowCategoriesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).cashFlowPlansRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.categoryId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (billsTableRefs)
                        await $_getPrefetchedData<
                          CashflowCategoriesTableData,
                          $CashflowCategoriesTableTable,
                          BillsTableData
                        >(
                          currentTable: table,
                          referencedTable:
                              $$CashflowCategoriesTableTableReferences
                                  ._billsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CashflowCategoriesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).billsTableRefs,
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
        bool cashFlowPlansRefs,
        bool billsTableRefs,
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

final class $$AccountsTableTableReferences
    extends
        BaseReferences<_$AppDatabase, $AccountsTableTable, AccountsTableData> {
  $$AccountsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$LoansTable, List<Loan>> _loansRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.loans,
    aliasName: 'accounts_table__id__loans__default_payment_account_id',
  );

  $$LoansTableProcessedTableManager get loansRefs {
    final manager = $$LoansTableTableManager($_db, $_db.loans).filter(
      (f) => f.defaultPaymentAccountId.id.sqlEquals($_itemColumn<int>('id')!),
    );

    final cache = $_typedResult.readTableOrNull(_loansRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $CreditCardBillingPeriodsTableTable,
    List<CreditCardBillingPeriodsTableData>
  >
  _creditCardBillingPeriodsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.creditCardBillingPeriodsTable,
        aliasName:
            'accounts_table__id__credit_card_billing_periods_table__account_id',
      );

  $$CreditCardBillingPeriodsTableTableProcessedTableManager
  get creditCardBillingPeriodsTableRefs {
    final manager = $$CreditCardBillingPeriodsTableTableTableManager(
      $_db,
      $_db.creditCardBillingPeriodsTable,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _creditCardBillingPeriodsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$BillsTableTable, List<BillsTableData>>
  _billsTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.billsTable,
    aliasName: 'accounts_table__id__bills_table__account_id',
  );

  $$BillsTableTableProcessedTableManager get billsTableRefs {
    final manager = $$BillsTableTableTableManager(
      $_db,
      $_db.billsTable,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_billsTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $CreditCardDetailsTableTable,
    List<CreditCardDetailsTableData>
  >
  _creditCardDetailsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.creditCardDetailsTable,
        aliasName: 'accounts_table__id__credit_card_details_table__account_id',
      );

  $$CreditCardDetailsTableTableProcessedTableManager
  get creditCardDetailsTableRefs {
    final manager = $$CreditCardDetailsTableTableTableManager(
      $_db,
      $_db.creditCardDetailsTable,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _creditCardDetailsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $GoalReservationsTableTable,
    List<GoalReservationsTableData>
  >
  _goalReservationsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.goalReservationsTable,
        aliasName: 'accounts_table__id__goal_reservations_table__account_id',
      );

  $$GoalReservationsTableTableProcessedTableManager
  get goalReservationsTableRefs {
    final manager = $$GoalReservationsTableTableTableManager(
      $_db,
      $_db.goalReservationsTable,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _goalReservationsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

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

  Expression<bool> loansRefs(
    Expression<bool> Function($$LoansTableFilterComposer f) f,
  ) {
    final $$LoansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.loans,
      getReferencedColumn: (t) => t.defaultPaymentAccountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LoansTableFilterComposer(
            $db: $db,
            $table: $db.loans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> creditCardBillingPeriodsTableRefs(
    Expression<bool> Function(
      $$CreditCardBillingPeriodsTableTableFilterComposer f,
    )
    f,
  ) {
    final $$CreditCardBillingPeriodsTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.creditCardBillingPeriodsTable,
          getReferencedColumn: (t) => t.accountId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CreditCardBillingPeriodsTableTableFilterComposer(
                $db: $db,
                $table: $db.creditCardBillingPeriodsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> billsTableRefs(
    Expression<bool> Function($$BillsTableTableFilterComposer f) f,
  ) {
    final $$BillsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.billsTable,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BillsTableTableFilterComposer(
            $db: $db,
            $table: $db.billsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> creditCardDetailsTableRefs(
    Expression<bool> Function($$CreditCardDetailsTableTableFilterComposer f) f,
  ) {
    final $$CreditCardDetailsTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.creditCardDetailsTable,
          getReferencedColumn: (t) => t.accountId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CreditCardDetailsTableTableFilterComposer(
                $db: $db,
                $table: $db.creditCardDetailsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> goalReservationsTableRefs(
    Expression<bool> Function($$GoalReservationsTableTableFilterComposer f) f,
  ) {
    final $$GoalReservationsTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.goalReservationsTable,
          getReferencedColumn: (t) => t.accountId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$GoalReservationsTableTableFilterComposer(
                $db: $db,
                $table: $db.goalReservationsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
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

  Expression<T> loansRefs<T extends Object>(
    Expression<T> Function($$LoansTableAnnotationComposer a) f,
  ) {
    final $$LoansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.loans,
      getReferencedColumn: (t) => t.defaultPaymentAccountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LoansTableAnnotationComposer(
            $db: $db,
            $table: $db.loans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> creditCardBillingPeriodsTableRefs<T extends Object>(
    Expression<T> Function(
      $$CreditCardBillingPeriodsTableTableAnnotationComposer a,
    )
    f,
  ) {
    final $$CreditCardBillingPeriodsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.creditCardBillingPeriodsTable,
          getReferencedColumn: (t) => t.accountId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CreditCardBillingPeriodsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.creditCardBillingPeriodsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> billsTableRefs<T extends Object>(
    Expression<T> Function($$BillsTableTableAnnotationComposer a) f,
  ) {
    final $$BillsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.billsTable,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BillsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.billsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> creditCardDetailsTableRefs<T extends Object>(
    Expression<T> Function($$CreditCardDetailsTableTableAnnotationComposer a) f,
  ) {
    final $$CreditCardDetailsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.creditCardDetailsTable,
          getReferencedColumn: (t) => t.accountId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CreditCardDetailsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.creditCardDetailsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> goalReservationsTableRefs<T extends Object>(
    Expression<T> Function($$GoalReservationsTableTableAnnotationComposer a) f,
  ) {
    final $$GoalReservationsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.goalReservationsTable,
          getReferencedColumn: (t) => t.accountId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$GoalReservationsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.goalReservationsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
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
          (AccountsTableData, $$AccountsTableTableReferences),
          AccountsTableData,
          PrefetchHooks Function({
            bool loansRefs,
            bool creditCardBillingPeriodsTableRefs,
            bool billsTableRefs,
            bool creditCardDetailsTableRefs,
            bool goalReservationsTableRefs,
          })
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
              .map(
                (e) => (
                  e.readTable(table),
                  $$AccountsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                loansRefs = false,
                creditCardBillingPeriodsTableRefs = false,
                billsTableRefs = false,
                creditCardDetailsTableRefs = false,
                goalReservationsTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (loansRefs) db.loans,
                    if (creditCardBillingPeriodsTableRefs)
                      db.creditCardBillingPeriodsTable,
                    if (billsTableRefs) db.billsTable,
                    if (creditCardDetailsTableRefs) db.creditCardDetailsTable,
                    if (goalReservationsTableRefs) db.goalReservationsTable,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (loansRefs)
                        await $_getPrefetchedData<
                          AccountsTableData,
                          $AccountsTableTable,
                          Loan
                        >(
                          currentTable: table,
                          referencedTable: $$AccountsTableTableReferences
                              ._loansRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AccountsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).loansRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.defaultPaymentAccountId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (creditCardBillingPeriodsTableRefs)
                        await $_getPrefetchedData<
                          AccountsTableData,
                          $AccountsTableTable,
                          CreditCardBillingPeriodsTableData
                        >(
                          currentTable: table,
                          referencedTable: $$AccountsTableTableReferences
                              ._creditCardBillingPeriodsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AccountsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).creditCardBillingPeriodsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.accountId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (billsTableRefs)
                        await $_getPrefetchedData<
                          AccountsTableData,
                          $AccountsTableTable,
                          BillsTableData
                        >(
                          currentTable: table,
                          referencedTable: $$AccountsTableTableReferences
                              ._billsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AccountsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).billsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.accountId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (creditCardDetailsTableRefs)
                        await $_getPrefetchedData<
                          AccountsTableData,
                          $AccountsTableTable,
                          CreditCardDetailsTableData
                        >(
                          currentTable: table,
                          referencedTable: $$AccountsTableTableReferences
                              ._creditCardDetailsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AccountsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).creditCardDetailsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.accountId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (goalReservationsTableRefs)
                        await $_getPrefetchedData<
                          AccountsTableData,
                          $AccountsTableTable,
                          GoalReservationsTableData
                        >(
                          currentTable: table,
                          referencedTable: $$AccountsTableTableReferences
                              ._goalReservationsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AccountsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).goalReservationsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.accountId == item.id,
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
      (AccountsTableData, $$AccountsTableTableReferences),
      AccountsTableData,
      PrefetchHooks Function({
        bool loansRefs,
        bool creditCardBillingPeriodsTableRefs,
        bool billsTableRefs,
        bool creditCardDetailsTableRefs,
        bool goalReservationsTableRefs,
      })
    >;
typedef $$TransactionsTableTableCreateCompanionBuilder =
    TransactionsTableCompanion Function({
      Value<int> id,
      required double amount,
      required DateTime date,
      Value<String?> note,
      required String transactionType,
      Value<int?> categoryId,
      Value<int?> accountId,
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
      Value<int?> accountId,
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
        'transactions_table__category_id__cashflow_categories_table__id',
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

  static $AccountsTableTable _accountIdTable(_$AppDatabase db) => db
      .accountsTable
      .createAlias('transactions_table__account_id__accounts_table__id');

  $$AccountsTableTableProcessedTableManager? get accountId {
    final $_column = $_itemColumn<int>('account_id');
    if ($_column == null) return null;
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

  static $AccountsTableTable _linkedAccountIdTable(_$AppDatabase db) => db
      .accountsTable
      .createAlias('transactions_table__linked_account_id__accounts_table__id');

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
  _transactionParticipantsTableRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.transactionParticipantsTable,
    aliasName:
        'transactions_table__id__transaction_participants_table__transaction_id',
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
  _financialObligationsTableRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.financialObligationsTable,
    aliasName:
        'transactions_table__id__financial_obligations_table__transaction_id',
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

  static MultiTypedResultKey<
    $BillOccurrencesTableTable,
    List<BillOccurrencesTableData>
  >
  _billOccurrencesTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.billOccurrencesTable,
        aliasName:
            'transactions_table__id__bill_occurrences_table__transaction_id',
      );

  $$BillOccurrencesTableTableProcessedTableManager
  get billOccurrencesTableRefs {
    final manager = $$BillOccurrencesTableTableTableManager(
      $_db,
      $_db.billOccurrencesTable,
    ).filter((f) => f.transactionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _billOccurrencesTableRefsTable($_db),
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

  Expression<bool> billOccurrencesTableRefs(
    Expression<bool> Function($$BillOccurrencesTableTableFilterComposer f) f,
  ) {
    final $$BillOccurrencesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.billOccurrencesTable,
      getReferencedColumn: (t) => t.transactionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BillOccurrencesTableTableFilterComposer(
            $db: $db,
            $table: $db.billOccurrencesTable,
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

  Expression<T> billOccurrencesTableRefs<T extends Object>(
    Expression<T> Function($$BillOccurrencesTableTableAnnotationComposer a) f,
  ) {
    final $$BillOccurrencesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.billOccurrencesTable,
          getReferencedColumn: (t) => t.transactionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$BillOccurrencesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.billOccurrencesTable,
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
            bool billOccurrencesTableRefs,
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
                Value<int?> accountId = const Value.absent(),
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
                Value<int?> accountId = const Value.absent(),
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
                billOccurrencesTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (transactionParticipantsTableRefs)
                      db.transactionParticipantsTable,
                    if (financialObligationsTableRefs)
                      db.financialObligationsTable,
                    if (billOccurrencesTableRefs) db.billOccurrencesTable,
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
                      if (billOccurrencesTableRefs)
                        await $_getPrefetchedData<
                          TransactionsTableData,
                          $TransactionsTableTable,
                          BillOccurrencesTableData
                        >(
                          currentTable: table,
                          referencedTable: $$TransactionsTableTableReferences
                              ._billOccurrencesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TransactionsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).billOccurrencesTableRefs,
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
        bool billOccurrencesTableRefs,
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
        aliasName:
            'entities_table__id__transaction_participants_table__entity_id',
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

  static $TransactionsTableTable _transactionIdTable(
    _$AppDatabase db,
  ) => db.transactionsTable.createAlias(
    'transaction_participants_table__transaction_id__transactions_table__id',
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
        'transaction_participants_table__entity_id__entities_table__id',
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
        'financial_obligations_table__transaction_id__transactions_table__id',
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
        'financial_obligations_table__debtor_entity_id__entities_table__id',
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
        'financial_obligations_table__creditor_entity_id__entities_table__id',
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
typedef $$LoansTableCreateCompanionBuilder =
    LoansCompanion Function({
      Value<int> id,
      required String name,
      required String loanType,
      required double originalPrincipal,
      required double outstandingBalance,
      Value<double?> interestRate,
      required double paymentAmount,
      required String paymentFrequency,
      required DateTime startDate,
      Value<DateTime?> maturityDate,
      Value<int?> defaultPaymentAccountId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$LoansTableUpdateCompanionBuilder =
    LoansCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> loanType,
      Value<double> originalPrincipal,
      Value<double> outstandingBalance,
      Value<double?> interestRate,
      Value<double> paymentAmount,
      Value<String> paymentFrequency,
      Value<DateTime> startDate,
      Value<DateTime?> maturityDate,
      Value<int?> defaultPaymentAccountId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$LoansTableReferences
    extends BaseReferences<_$AppDatabase, $LoansTable, Loan> {
  $$LoansTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AccountsTableTable _defaultPaymentAccountIdTable(_$AppDatabase db) =>
      db.accountsTable.createAlias(
        'loans__default_payment_account_id__accounts_table__id',
      );

  $$AccountsTableTableProcessedTableManager? get defaultPaymentAccountId {
    final $_column = $_itemColumn<int>('default_payment_account_id');
    if ($_column == null) return null;
    final manager = $$AccountsTableTableTableManager(
      $_db,
      $_db.accountsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(
      _defaultPaymentAccountIdTable($_db),
    );
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$CashFlowPlansTable, List<CashFlowPlan>>
  _cashFlowPlansRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.cashFlowPlans,
    aliasName: 'loans__id__cash_flow_plans__loan_id',
  );

  $$CashFlowPlansTableProcessedTableManager get cashFlowPlansRefs {
    final manager = $$CashFlowPlansTableTableManager(
      $_db,
      $_db.cashFlowPlans,
    ).filter((f) => f.loanId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_cashFlowPlansRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LoansTableFilterComposer extends Composer<_$AppDatabase, $LoansTable> {
  $$LoansTableFilterComposer({
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

  ColumnFilters<String> get loanType => $composableBuilder(
    column: $table.loanType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get originalPrincipal => $composableBuilder(
    column: $table.originalPrincipal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get outstandingBalance => $composableBuilder(
    column: $table.outstandingBalance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get interestRate => $composableBuilder(
    column: $table.interestRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get paymentAmount => $composableBuilder(
    column: $table.paymentAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentFrequency => $composableBuilder(
    column: $table.paymentFrequency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get maturityDate => $composableBuilder(
    column: $table.maturityDate,
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

  $$AccountsTableTableFilterComposer get defaultPaymentAccountId {
    final $$AccountsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.defaultPaymentAccountId,
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

  Expression<bool> cashFlowPlansRefs(
    Expression<bool> Function($$CashFlowPlansTableFilterComposer f) f,
  ) {
    final $$CashFlowPlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cashFlowPlans,
      getReferencedColumn: (t) => t.loanId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CashFlowPlansTableFilterComposer(
            $db: $db,
            $table: $db.cashFlowPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LoansTableOrderingComposer
    extends Composer<_$AppDatabase, $LoansTable> {
  $$LoansTableOrderingComposer({
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

  ColumnOrderings<String> get loanType => $composableBuilder(
    column: $table.loanType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get originalPrincipal => $composableBuilder(
    column: $table.originalPrincipal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get outstandingBalance => $composableBuilder(
    column: $table.outstandingBalance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get interestRate => $composableBuilder(
    column: $table.interestRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get paymentAmount => $composableBuilder(
    column: $table.paymentAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentFrequency => $composableBuilder(
    column: $table.paymentFrequency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get maturityDate => $composableBuilder(
    column: $table.maturityDate,
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

  $$AccountsTableTableOrderingComposer get defaultPaymentAccountId {
    final $$AccountsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.defaultPaymentAccountId,
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

class $$LoansTableAnnotationComposer
    extends Composer<_$AppDatabase, $LoansTable> {
  $$LoansTableAnnotationComposer({
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

  GeneratedColumn<String> get loanType =>
      $composableBuilder(column: $table.loanType, builder: (column) => column);

  GeneratedColumn<double> get originalPrincipal => $composableBuilder(
    column: $table.originalPrincipal,
    builder: (column) => column,
  );

  GeneratedColumn<double> get outstandingBalance => $composableBuilder(
    column: $table.outstandingBalance,
    builder: (column) => column,
  );

  GeneratedColumn<double> get interestRate => $composableBuilder(
    column: $table.interestRate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get paymentAmount => $composableBuilder(
    column: $table.paymentAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paymentFrequency => $composableBuilder(
    column: $table.paymentFrequency,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get maturityDate => $composableBuilder(
    column: $table.maturityDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$AccountsTableTableAnnotationComposer get defaultPaymentAccountId {
    final $$AccountsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.defaultPaymentAccountId,
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

  Expression<T> cashFlowPlansRefs<T extends Object>(
    Expression<T> Function($$CashFlowPlansTableAnnotationComposer a) f,
  ) {
    final $$CashFlowPlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cashFlowPlans,
      getReferencedColumn: (t) => t.loanId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CashFlowPlansTableAnnotationComposer(
            $db: $db,
            $table: $db.cashFlowPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LoansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LoansTable,
          Loan,
          $$LoansTableFilterComposer,
          $$LoansTableOrderingComposer,
          $$LoansTableAnnotationComposer,
          $$LoansTableCreateCompanionBuilder,
          $$LoansTableUpdateCompanionBuilder,
          (Loan, $$LoansTableReferences),
          Loan,
          PrefetchHooks Function({
            bool defaultPaymentAccountId,
            bool cashFlowPlansRefs,
          })
        > {
  $$LoansTableTableManager(_$AppDatabase db, $LoansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LoansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LoansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LoansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> loanType = const Value.absent(),
                Value<double> originalPrincipal = const Value.absent(),
                Value<double> outstandingBalance = const Value.absent(),
                Value<double?> interestRate = const Value.absent(),
                Value<double> paymentAmount = const Value.absent(),
                Value<String> paymentFrequency = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<DateTime?> maturityDate = const Value.absent(),
                Value<int?> defaultPaymentAccountId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => LoansCompanion(
                id: id,
                name: name,
                loanType: loanType,
                originalPrincipal: originalPrincipal,
                outstandingBalance: outstandingBalance,
                interestRate: interestRate,
                paymentAmount: paymentAmount,
                paymentFrequency: paymentFrequency,
                startDate: startDate,
                maturityDate: maturityDate,
                defaultPaymentAccountId: defaultPaymentAccountId,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String loanType,
                required double originalPrincipal,
                required double outstandingBalance,
                Value<double?> interestRate = const Value.absent(),
                required double paymentAmount,
                required String paymentFrequency,
                required DateTime startDate,
                Value<DateTime?> maturityDate = const Value.absent(),
                Value<int?> defaultPaymentAccountId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => LoansCompanion.insert(
                id: id,
                name: name,
                loanType: loanType,
                originalPrincipal: originalPrincipal,
                outstandingBalance: outstandingBalance,
                interestRate: interestRate,
                paymentAmount: paymentAmount,
                paymentFrequency: paymentFrequency,
                startDate: startDate,
                maturityDate: maturityDate,
                defaultPaymentAccountId: defaultPaymentAccountId,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$LoansTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({defaultPaymentAccountId = false, cashFlowPlansRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (cashFlowPlansRefs) db.cashFlowPlans,
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
                        if (defaultPaymentAccountId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn:
                                        table.defaultPaymentAccountId,
                                    referencedTable: $$LoansTableReferences
                                        ._defaultPaymentAccountIdTable(db),
                                    referencedColumn: $$LoansTableReferences
                                        ._defaultPaymentAccountIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (cashFlowPlansRefs)
                        await $_getPrefetchedData<
                          Loan,
                          $LoansTable,
                          CashFlowPlan
                        >(
                          currentTable: table,
                          referencedTable: $$LoansTableReferences
                              ._cashFlowPlansRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LoansTableReferences(
                                db,
                                table,
                                p0,
                              ).cashFlowPlansRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.loanId == item.id,
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

typedef $$LoansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LoansTable,
      Loan,
      $$LoansTableFilterComposer,
      $$LoansTableOrderingComposer,
      $$LoansTableAnnotationComposer,
      $$LoansTableCreateCompanionBuilder,
      $$LoansTableUpdateCompanionBuilder,
      (Loan, $$LoansTableReferences),
      Loan,
      PrefetchHooks Function({
        bool defaultPaymentAccountId,
        bool cashFlowPlansRefs,
      })
    >;
typedef $$CashFlowPlansTableCreateCompanionBuilder =
    CashFlowPlansCompanion Function({
      Value<int> id,
      Value<int?> categoryId,
      Value<int?> loanId,
      required String planType,
      required double amount,
      required String period,
      required String distributionType,
      required DateTime startDate,
      Value<DateTime?> endDate,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$CashFlowPlansTableUpdateCompanionBuilder =
    CashFlowPlansCompanion Function({
      Value<int> id,
      Value<int?> categoryId,
      Value<int?> loanId,
      Value<String> planType,
      Value<double> amount,
      Value<String> period,
      Value<String> distributionType,
      Value<DateTime> startDate,
      Value<DateTime?> endDate,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$CashFlowPlansTableReferences
    extends BaseReferences<_$AppDatabase, $CashFlowPlansTable, CashFlowPlan> {
  $$CashFlowPlansTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CashflowCategoriesTableTable _categoryIdTable(_$AppDatabase db) =>
      db.cashflowCategoriesTable.createAlias(
        'cash_flow_plans__category_id__cashflow_categories_table__id',
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

  static $LoansTable _loanIdTable(_$AppDatabase db) =>
      db.loans.createAlias('cash_flow_plans__loan_id__loans__id');

  $$LoansTableProcessedTableManager? get loanId {
    final $_column = $_itemColumn<int>('loan_id');
    if ($_column == null) return null;
    final manager = $$LoansTableTableManager(
      $_db,
      $_db.loans,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_loanIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $CashFlowPlanAllocationsTable,
    List<CashFlowPlanAllocation>
  >
  _cashFlowPlanAllocationsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.cashFlowPlanAllocations,
        aliasName: 'cash_flow_plans__id__cash_flow_plan_allocations__plan_id',
      );

  $$CashFlowPlanAllocationsTableProcessedTableManager
  get cashFlowPlanAllocationsRefs {
    final manager = $$CashFlowPlanAllocationsTableTableManager(
      $_db,
      $_db.cashFlowPlanAllocations,
    ).filter((f) => f.planId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _cashFlowPlanAllocationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CashFlowPlansTableFilterComposer
    extends Composer<_$AppDatabase, $CashFlowPlansTable> {
  $$CashFlowPlansTableFilterComposer({
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

  ColumnFilters<String> get planType => $composableBuilder(
    column: $table.planType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get period => $composableBuilder(
    column: $table.period,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get distributionType => $composableBuilder(
    column: $table.distributionType,
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

  $$LoansTableFilterComposer get loanId {
    final $$LoansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.loanId,
      referencedTable: $db.loans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LoansTableFilterComposer(
            $db: $db,
            $table: $db.loans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> cashFlowPlanAllocationsRefs(
    Expression<bool> Function($$CashFlowPlanAllocationsTableFilterComposer f) f,
  ) {
    final $$CashFlowPlanAllocationsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.cashFlowPlanAllocations,
          getReferencedColumn: (t) => t.planId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CashFlowPlanAllocationsTableFilterComposer(
                $db: $db,
                $table: $db.cashFlowPlanAllocations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$CashFlowPlansTableOrderingComposer
    extends Composer<_$AppDatabase, $CashFlowPlansTable> {
  $$CashFlowPlansTableOrderingComposer({
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

  ColumnOrderings<String> get planType => $composableBuilder(
    column: $table.planType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get period => $composableBuilder(
    column: $table.period,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get distributionType => $composableBuilder(
    column: $table.distributionType,
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

  $$LoansTableOrderingComposer get loanId {
    final $$LoansTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.loanId,
      referencedTable: $db.loans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LoansTableOrderingComposer(
            $db: $db,
            $table: $db.loans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CashFlowPlansTableAnnotationComposer
    extends Composer<_$AppDatabase, $CashFlowPlansTable> {
  $$CashFlowPlansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get planType =>
      $composableBuilder(column: $table.planType, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get period =>
      $composableBuilder(column: $table.period, builder: (column) => column);

  GeneratedColumn<String> get distributionType => $composableBuilder(
    column: $table.distributionType,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

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

  $$LoansTableAnnotationComposer get loanId {
    final $$LoansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.loanId,
      referencedTable: $db.loans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LoansTableAnnotationComposer(
            $db: $db,
            $table: $db.loans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> cashFlowPlanAllocationsRefs<T extends Object>(
    Expression<T> Function($$CashFlowPlanAllocationsTableAnnotationComposer a)
    f,
  ) {
    final $$CashFlowPlanAllocationsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.cashFlowPlanAllocations,
          getReferencedColumn: (t) => t.planId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CashFlowPlanAllocationsTableAnnotationComposer(
                $db: $db,
                $table: $db.cashFlowPlanAllocations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$CashFlowPlansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CashFlowPlansTable,
          CashFlowPlan,
          $$CashFlowPlansTableFilterComposer,
          $$CashFlowPlansTableOrderingComposer,
          $$CashFlowPlansTableAnnotationComposer,
          $$CashFlowPlansTableCreateCompanionBuilder,
          $$CashFlowPlansTableUpdateCompanionBuilder,
          (CashFlowPlan, $$CashFlowPlansTableReferences),
          CashFlowPlan,
          PrefetchHooks Function({
            bool categoryId,
            bool loanId,
            bool cashFlowPlanAllocationsRefs,
          })
        > {
  $$CashFlowPlansTableTableManager(_$AppDatabase db, $CashFlowPlansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CashFlowPlansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CashFlowPlansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CashFlowPlansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> categoryId = const Value.absent(),
                Value<int?> loanId = const Value.absent(),
                Value<String> planType = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> period = const Value.absent(),
                Value<String> distributionType = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<DateTime?> endDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CashFlowPlansCompanion(
                id: id,
                categoryId: categoryId,
                loanId: loanId,
                planType: planType,
                amount: amount,
                period: period,
                distributionType: distributionType,
                startDate: startDate,
                endDate: endDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> categoryId = const Value.absent(),
                Value<int?> loanId = const Value.absent(),
                required String planType,
                required double amount,
                required String period,
                required String distributionType,
                required DateTime startDate,
                Value<DateTime?> endDate = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => CashFlowPlansCompanion.insert(
                id: id,
                categoryId: categoryId,
                loanId: loanId,
                planType: planType,
                amount: amount,
                period: period,
                distributionType: distributionType,
                startDate: startDate,
                endDate: endDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CashFlowPlansTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                categoryId = false,
                loanId = false,
                cashFlowPlanAllocationsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (cashFlowPlanAllocationsRefs) db.cashFlowPlanAllocations,
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
                                        $$CashFlowPlansTableReferences
                                            ._categoryIdTable(db),
                                    referencedColumn:
                                        $$CashFlowPlansTableReferences
                                            ._categoryIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (loanId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.loanId,
                                    referencedTable:
                                        $$CashFlowPlansTableReferences
                                            ._loanIdTable(db),
                                    referencedColumn:
                                        $$CashFlowPlansTableReferences
                                            ._loanIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (cashFlowPlanAllocationsRefs)
                        await $_getPrefetchedData<
                          CashFlowPlan,
                          $CashFlowPlansTable,
                          CashFlowPlanAllocation
                        >(
                          currentTable: table,
                          referencedTable: $$CashFlowPlansTableReferences
                              ._cashFlowPlanAllocationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CashFlowPlansTableReferences(
                                db,
                                table,
                                p0,
                              ).cashFlowPlanAllocationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.planId == item.id,
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

typedef $$CashFlowPlansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CashFlowPlansTable,
      CashFlowPlan,
      $$CashFlowPlansTableFilterComposer,
      $$CashFlowPlansTableOrderingComposer,
      $$CashFlowPlansTableAnnotationComposer,
      $$CashFlowPlansTableCreateCompanionBuilder,
      $$CashFlowPlansTableUpdateCompanionBuilder,
      (CashFlowPlan, $$CashFlowPlansTableReferences),
      CashFlowPlan,
      PrefetchHooks Function({
        bool categoryId,
        bool loanId,
        bool cashFlowPlanAllocationsRefs,
      })
    >;
typedef $$CashFlowPlanAllocationsTableCreateCompanionBuilder =
    CashFlowPlanAllocationsCompanion Function({
      Value<int> id,
      required int planId,
      required int allocationIndex,
      required double amount,
    });
typedef $$CashFlowPlanAllocationsTableUpdateCompanionBuilder =
    CashFlowPlanAllocationsCompanion Function({
      Value<int> id,
      Value<int> planId,
      Value<int> allocationIndex,
      Value<double> amount,
    });

final class $$CashFlowPlanAllocationsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CashFlowPlanAllocationsTable,
          CashFlowPlanAllocation
        > {
  $$CashFlowPlanAllocationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CashFlowPlansTable _planIdTable(_$AppDatabase db) => db.cashFlowPlans
      .createAlias('cash_flow_plan_allocations__plan_id__cash_flow_plans__id');

  $$CashFlowPlansTableProcessedTableManager get planId {
    final $_column = $_itemColumn<int>('plan_id')!;

    final manager = $$CashFlowPlansTableTableManager(
      $_db,
      $_db.cashFlowPlans,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_planIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CashFlowPlanAllocationsTableFilterComposer
    extends Composer<_$AppDatabase, $CashFlowPlanAllocationsTable> {
  $$CashFlowPlanAllocationsTableFilterComposer({
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

  ColumnFilters<int> get allocationIndex => $composableBuilder(
    column: $table.allocationIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  $$CashFlowPlansTableFilterComposer get planId {
    final $$CashFlowPlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.cashFlowPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CashFlowPlansTableFilterComposer(
            $db: $db,
            $table: $db.cashFlowPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CashFlowPlanAllocationsTableOrderingComposer
    extends Composer<_$AppDatabase, $CashFlowPlanAllocationsTable> {
  $$CashFlowPlanAllocationsTableOrderingComposer({
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

  ColumnOrderings<int> get allocationIndex => $composableBuilder(
    column: $table.allocationIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  $$CashFlowPlansTableOrderingComposer get planId {
    final $$CashFlowPlansTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.cashFlowPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CashFlowPlansTableOrderingComposer(
            $db: $db,
            $table: $db.cashFlowPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CashFlowPlanAllocationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CashFlowPlanAllocationsTable> {
  $$CashFlowPlanAllocationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get allocationIndex => $composableBuilder(
    column: $table.allocationIndex,
    builder: (column) => column,
  );

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  $$CashFlowPlansTableAnnotationComposer get planId {
    final $$CashFlowPlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.cashFlowPlans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CashFlowPlansTableAnnotationComposer(
            $db: $db,
            $table: $db.cashFlowPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CashFlowPlanAllocationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CashFlowPlanAllocationsTable,
          CashFlowPlanAllocation,
          $$CashFlowPlanAllocationsTableFilterComposer,
          $$CashFlowPlanAllocationsTableOrderingComposer,
          $$CashFlowPlanAllocationsTableAnnotationComposer,
          $$CashFlowPlanAllocationsTableCreateCompanionBuilder,
          $$CashFlowPlanAllocationsTableUpdateCompanionBuilder,
          (CashFlowPlanAllocation, $$CashFlowPlanAllocationsTableReferences),
          CashFlowPlanAllocation,
          PrefetchHooks Function({bool planId})
        > {
  $$CashFlowPlanAllocationsTableTableManager(
    _$AppDatabase db,
    $CashFlowPlanAllocationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CashFlowPlanAllocationsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$CashFlowPlanAllocationsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CashFlowPlanAllocationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> planId = const Value.absent(),
                Value<int> allocationIndex = const Value.absent(),
                Value<double> amount = const Value.absent(),
              }) => CashFlowPlanAllocationsCompanion(
                id: id,
                planId: planId,
                allocationIndex: allocationIndex,
                amount: amount,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int planId,
                required int allocationIndex,
                required double amount,
              }) => CashFlowPlanAllocationsCompanion.insert(
                id: id,
                planId: planId,
                allocationIndex: allocationIndex,
                amount: amount,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CashFlowPlanAllocationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({planId = false}) {
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
                    if (planId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.planId,
                                referencedTable:
                                    $$CashFlowPlanAllocationsTableReferences
                                        ._planIdTable(db),
                                referencedColumn:
                                    $$CashFlowPlanAllocationsTableReferences
                                        ._planIdTable(db)
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

typedef $$CashFlowPlanAllocationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CashFlowPlanAllocationsTable,
      CashFlowPlanAllocation,
      $$CashFlowPlanAllocationsTableFilterComposer,
      $$CashFlowPlanAllocationsTableOrderingComposer,
      $$CashFlowPlanAllocationsTableAnnotationComposer,
      $$CashFlowPlanAllocationsTableCreateCompanionBuilder,
      $$CashFlowPlanAllocationsTableUpdateCompanionBuilder,
      (CashFlowPlanAllocation, $$CashFlowPlanAllocationsTableReferences),
      CashFlowPlanAllocation,
      PrefetchHooks Function({bool planId})
    >;
typedef $$CreditCardBillingPeriodsTableTableCreateCompanionBuilder =
    CreditCardBillingPeriodsTableCompanion Function({
      Value<int> id,
      required int accountId,
      required DateTime startDate,
      required DateTime endDate,
      required String status,
    });
typedef $$CreditCardBillingPeriodsTableTableUpdateCompanionBuilder =
    CreditCardBillingPeriodsTableCompanion Function({
      Value<int> id,
      Value<int> accountId,
      Value<DateTime> startDate,
      Value<DateTime> endDate,
      Value<String> status,
    });

final class $$CreditCardBillingPeriodsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CreditCardBillingPeriodsTableTable,
          CreditCardBillingPeriodsTableData
        > {
  $$CreditCardBillingPeriodsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AccountsTableTable _accountIdTable(_$AppDatabase db) =>
      db.accountsTable.createAlias(
        'credit_card_billing_periods_table__account_id__accounts_table__id',
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

  static MultiTypedResultKey<
    $CreditCardStatementsTableTable,
    List<CreditCardStatementsTableData>
  >
  _creditCardStatementsTableRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.creditCardStatementsTable,
    aliasName:
        'credit_card_billing_periods_table__id__credit_card_statements_table__billing_period_id',
  );

  $$CreditCardStatementsTableTableProcessedTableManager
  get creditCardStatementsTableRefs {
    final manager = $$CreditCardStatementsTableTableTableManager(
      $_db,
      $_db.creditCardStatementsTable,
    ).filter((f) => f.billingPeriodId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _creditCardStatementsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CreditCardBillingPeriodsTableTableFilterComposer
    extends Composer<_$AppDatabase, $CreditCardBillingPeriodsTableTable> {
  $$CreditCardBillingPeriodsTableTableFilterComposer({
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

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

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

  Expression<bool> creditCardStatementsTableRefs(
    Expression<bool> Function($$CreditCardStatementsTableTableFilterComposer f)
    f,
  ) {
    final $$CreditCardStatementsTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.creditCardStatementsTable,
          getReferencedColumn: (t) => t.billingPeriodId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CreditCardStatementsTableTableFilterComposer(
                $db: $db,
                $table: $db.creditCardStatementsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$CreditCardBillingPeriodsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CreditCardBillingPeriodsTableTable> {
  $$CreditCardBillingPeriodsTableTableOrderingComposer({
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

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

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
}

class $$CreditCardBillingPeriodsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CreditCardBillingPeriodsTableTable> {
  $$CreditCardBillingPeriodsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

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

  Expression<T> creditCardStatementsTableRefs<T extends Object>(
    Expression<T> Function($$CreditCardStatementsTableTableAnnotationComposer a)
    f,
  ) {
    final $$CreditCardStatementsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.creditCardStatementsTable,
          getReferencedColumn: (t) => t.billingPeriodId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CreditCardStatementsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.creditCardStatementsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$CreditCardBillingPeriodsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CreditCardBillingPeriodsTableTable,
          CreditCardBillingPeriodsTableData,
          $$CreditCardBillingPeriodsTableTableFilterComposer,
          $$CreditCardBillingPeriodsTableTableOrderingComposer,
          $$CreditCardBillingPeriodsTableTableAnnotationComposer,
          $$CreditCardBillingPeriodsTableTableCreateCompanionBuilder,
          $$CreditCardBillingPeriodsTableTableUpdateCompanionBuilder,
          (
            CreditCardBillingPeriodsTableData,
            $$CreditCardBillingPeriodsTableTableReferences,
          ),
          CreditCardBillingPeriodsTableData,
          PrefetchHooks Function({
            bool accountId,
            bool creditCardStatementsTableRefs,
          })
        > {
  $$CreditCardBillingPeriodsTableTableTableManager(
    _$AppDatabase db,
    $CreditCardBillingPeriodsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CreditCardBillingPeriodsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$CreditCardBillingPeriodsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CreditCardBillingPeriodsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> accountId = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<DateTime> endDate = const Value.absent(),
                Value<String> status = const Value.absent(),
              }) => CreditCardBillingPeriodsTableCompanion(
                id: id,
                accountId: accountId,
                startDate: startDate,
                endDate: endDate,
                status: status,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int accountId,
                required DateTime startDate,
                required DateTime endDate,
                required String status,
              }) => CreditCardBillingPeriodsTableCompanion.insert(
                id: id,
                accountId: accountId,
                startDate: startDate,
                endDate: endDate,
                status: status,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CreditCardBillingPeriodsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({accountId = false, creditCardStatementsTableRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (creditCardStatementsTableRefs)
                      db.creditCardStatementsTable,
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
                        if (accountId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.accountId,
                                    referencedTable:
                                        $$CreditCardBillingPeriodsTableTableReferences
                                            ._accountIdTable(db),
                                    referencedColumn:
                                        $$CreditCardBillingPeriodsTableTableReferences
                                            ._accountIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (creditCardStatementsTableRefs)
                        await $_getPrefetchedData<
                          CreditCardBillingPeriodsTableData,
                          $CreditCardBillingPeriodsTableTable,
                          CreditCardStatementsTableData
                        >(
                          currentTable: table,
                          referencedTable:
                              $$CreditCardBillingPeriodsTableTableReferences
                                  ._creditCardStatementsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CreditCardBillingPeriodsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).creditCardStatementsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.billingPeriodId == item.id,
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

typedef $$CreditCardBillingPeriodsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CreditCardBillingPeriodsTableTable,
      CreditCardBillingPeriodsTableData,
      $$CreditCardBillingPeriodsTableTableFilterComposer,
      $$CreditCardBillingPeriodsTableTableOrderingComposer,
      $$CreditCardBillingPeriodsTableTableAnnotationComposer,
      $$CreditCardBillingPeriodsTableTableCreateCompanionBuilder,
      $$CreditCardBillingPeriodsTableTableUpdateCompanionBuilder,
      (
        CreditCardBillingPeriodsTableData,
        $$CreditCardBillingPeriodsTableTableReferences,
      ),
      CreditCardBillingPeriodsTableData,
      PrefetchHooks Function({
        bool accountId,
        bool creditCardStatementsTableRefs,
      })
    >;
typedef $$CreditCardStatementsTableTableCreateCompanionBuilder =
    CreditCardStatementsTableCompanion Function({
      Value<int> id,
      required int billingPeriodId,
      required double statementBalance,
      required DateTime paymentDueDate,
      Value<DateTime> generatedAt,
      required String status,
    });
typedef $$CreditCardStatementsTableTableUpdateCompanionBuilder =
    CreditCardStatementsTableCompanion Function({
      Value<int> id,
      Value<int> billingPeriodId,
      Value<double> statementBalance,
      Value<DateTime> paymentDueDate,
      Value<DateTime> generatedAt,
      Value<String> status,
    });

final class $$CreditCardStatementsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CreditCardStatementsTableTable,
          CreditCardStatementsTableData
        > {
  $$CreditCardStatementsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CreditCardBillingPeriodsTableTable _billingPeriodIdTable(
    _$AppDatabase db,
  ) => db.creditCardBillingPeriodsTable.createAlias(
    'credit_card_statements_table__billing_period_id__credit_card_billing_periods_table__id',
  );

  $$CreditCardBillingPeriodsTableTableProcessedTableManager
  get billingPeriodId {
    final $_column = $_itemColumn<int>('billing_period_id')!;

    final manager = $$CreditCardBillingPeriodsTableTableTableManager(
      $_db,
      $_db.creditCardBillingPeriodsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_billingPeriodIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$BillsTableTable, List<BillsTableData>>
  _billsTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.billsTable,
    aliasName: 'credit_card_statements_table__id__bills_table__statement_id',
  );

  $$BillsTableTableProcessedTableManager get billsTableRefs {
    final manager = $$BillsTableTableTableManager(
      $_db,
      $_db.billsTable,
    ).filter((f) => f.statementId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_billsTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CreditCardStatementsTableTableFilterComposer
    extends Composer<_$AppDatabase, $CreditCardStatementsTableTable> {
  $$CreditCardStatementsTableTableFilterComposer({
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

  ColumnFilters<double> get statementBalance => $composableBuilder(
    column: $table.statementBalance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get paymentDueDate => $composableBuilder(
    column: $table.paymentDueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  $$CreditCardBillingPeriodsTableTableFilterComposer get billingPeriodId {
    final $$CreditCardBillingPeriodsTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.billingPeriodId,
          referencedTable: $db.creditCardBillingPeriodsTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CreditCardBillingPeriodsTableTableFilterComposer(
                $db: $db,
                $table: $db.creditCardBillingPeriodsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  Expression<bool> billsTableRefs(
    Expression<bool> Function($$BillsTableTableFilterComposer f) f,
  ) {
    final $$BillsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.billsTable,
      getReferencedColumn: (t) => t.statementId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BillsTableTableFilterComposer(
            $db: $db,
            $table: $db.billsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CreditCardStatementsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CreditCardStatementsTableTable> {
  $$CreditCardStatementsTableTableOrderingComposer({
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

  ColumnOrderings<double> get statementBalance => $composableBuilder(
    column: $table.statementBalance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get paymentDueDate => $composableBuilder(
    column: $table.paymentDueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  $$CreditCardBillingPeriodsTableTableOrderingComposer get billingPeriodId {
    final $$CreditCardBillingPeriodsTableTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.billingPeriodId,
          referencedTable: $db.creditCardBillingPeriodsTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CreditCardBillingPeriodsTableTableOrderingComposer(
                $db: $db,
                $table: $db.creditCardBillingPeriodsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$CreditCardStatementsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CreditCardStatementsTableTable> {
  $$CreditCardStatementsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get statementBalance => $composableBuilder(
    column: $table.statementBalance,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get paymentDueDate => $composableBuilder(
    column: $table.paymentDueDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  $$CreditCardBillingPeriodsTableTableAnnotationComposer get billingPeriodId {
    final $$CreditCardBillingPeriodsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.billingPeriodId,
          referencedTable: $db.creditCardBillingPeriodsTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CreditCardBillingPeriodsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.creditCardBillingPeriodsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  Expression<T> billsTableRefs<T extends Object>(
    Expression<T> Function($$BillsTableTableAnnotationComposer a) f,
  ) {
    final $$BillsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.billsTable,
      getReferencedColumn: (t) => t.statementId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BillsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.billsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CreditCardStatementsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CreditCardStatementsTableTable,
          CreditCardStatementsTableData,
          $$CreditCardStatementsTableTableFilterComposer,
          $$CreditCardStatementsTableTableOrderingComposer,
          $$CreditCardStatementsTableTableAnnotationComposer,
          $$CreditCardStatementsTableTableCreateCompanionBuilder,
          $$CreditCardStatementsTableTableUpdateCompanionBuilder,
          (
            CreditCardStatementsTableData,
            $$CreditCardStatementsTableTableReferences,
          ),
          CreditCardStatementsTableData,
          PrefetchHooks Function({bool billingPeriodId, bool billsTableRefs})
        > {
  $$CreditCardStatementsTableTableTableManager(
    _$AppDatabase db,
    $CreditCardStatementsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CreditCardStatementsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$CreditCardStatementsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CreditCardStatementsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> billingPeriodId = const Value.absent(),
                Value<double> statementBalance = const Value.absent(),
                Value<DateTime> paymentDueDate = const Value.absent(),
                Value<DateTime> generatedAt = const Value.absent(),
                Value<String> status = const Value.absent(),
              }) => CreditCardStatementsTableCompanion(
                id: id,
                billingPeriodId: billingPeriodId,
                statementBalance: statementBalance,
                paymentDueDate: paymentDueDate,
                generatedAt: generatedAt,
                status: status,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int billingPeriodId,
                required double statementBalance,
                required DateTime paymentDueDate,
                Value<DateTime> generatedAt = const Value.absent(),
                required String status,
              }) => CreditCardStatementsTableCompanion.insert(
                id: id,
                billingPeriodId: billingPeriodId,
                statementBalance: statementBalance,
                paymentDueDate: paymentDueDate,
                generatedAt: generatedAt,
                status: status,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CreditCardStatementsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({billingPeriodId = false, billsTableRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [if (billsTableRefs) db.billsTable],
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
                        if (billingPeriodId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.billingPeriodId,
                                    referencedTable:
                                        $$CreditCardStatementsTableTableReferences
                                            ._billingPeriodIdTable(db),
                                    referencedColumn:
                                        $$CreditCardStatementsTableTableReferences
                                            ._billingPeriodIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (billsTableRefs)
                        await $_getPrefetchedData<
                          CreditCardStatementsTableData,
                          $CreditCardStatementsTableTable,
                          BillsTableData
                        >(
                          currentTable: table,
                          referencedTable:
                              $$CreditCardStatementsTableTableReferences
                                  ._billsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CreditCardStatementsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).billsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.statementId == item.id,
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

typedef $$CreditCardStatementsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CreditCardStatementsTableTable,
      CreditCardStatementsTableData,
      $$CreditCardStatementsTableTableFilterComposer,
      $$CreditCardStatementsTableTableOrderingComposer,
      $$CreditCardStatementsTableTableAnnotationComposer,
      $$CreditCardStatementsTableTableCreateCompanionBuilder,
      $$CreditCardStatementsTableTableUpdateCompanionBuilder,
      (
        CreditCardStatementsTableData,
        $$CreditCardStatementsTableTableReferences,
      ),
      CreditCardStatementsTableData,
      PrefetchHooks Function({bool billingPeriodId, bool billsTableRefs})
    >;
typedef $$BillsTableTableCreateCompanionBuilder =
    BillsTableCompanion Function({
      Value<int> id,
      required String name,
      Value<int?> categoryId,
      Value<int?> accountId,
      Value<double?> expectedAmount,
      required String frequency,
      Value<int?> dayOfMonth,
      Value<bool> reminderEnabled,
      Value<int?> reminderDaysBefore,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int?> statementId,
    });
typedef $$BillsTableTableUpdateCompanionBuilder =
    BillsTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int?> categoryId,
      Value<int?> accountId,
      Value<double?> expectedAmount,
      Value<String> frequency,
      Value<int?> dayOfMonth,
      Value<bool> reminderEnabled,
      Value<int?> reminderDaysBefore,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int?> statementId,
    });

final class $$BillsTableTableReferences
    extends BaseReferences<_$AppDatabase, $BillsTableTable, BillsTableData> {
  $$BillsTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CashflowCategoriesTableTable _categoryIdTable(_$AppDatabase db) => db
      .cashflowCategoriesTable
      .createAlias('bills_table__category_id__cashflow_categories_table__id');

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

  static $AccountsTableTable _accountIdTable(_$AppDatabase db) => db
      .accountsTable
      .createAlias('bills_table__account_id__accounts_table__id');

  $$AccountsTableTableProcessedTableManager? get accountId {
    final $_column = $_itemColumn<int>('account_id');
    if ($_column == null) return null;
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

  static $CreditCardStatementsTableTable _statementIdTable(_$AppDatabase db) =>
      db.creditCardStatementsTable.createAlias(
        'bills_table__statement_id__credit_card_statements_table__id',
      );

  $$CreditCardStatementsTableTableProcessedTableManager? get statementId {
    final $_column = $_itemColumn<int>('statement_id');
    if ($_column == null) return null;
    final manager = $$CreditCardStatementsTableTableTableManager(
      $_db,
      $_db.creditCardStatementsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_statementIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $BillOccurrencesTableTable,
    List<BillOccurrencesTableData>
  >
  _billOccurrencesTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.billOccurrencesTable,
        aliasName: 'bills_table__id__bill_occurrences_table__bill_id',
      );

  $$BillOccurrencesTableTableProcessedTableManager
  get billOccurrencesTableRefs {
    final manager = $$BillOccurrencesTableTableTableManager(
      $_db,
      $_db.billOccurrencesTable,
    ).filter((f) => f.billId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _billOccurrencesTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BillsTableTableFilterComposer
    extends Composer<_$AppDatabase, $BillsTableTable> {
  $$BillsTableTableFilterComposer({
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

  ColumnFilters<double> get expectedAmount => $composableBuilder(
    column: $table.expectedAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dayOfMonth => $composableBuilder(
    column: $table.dayOfMonth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get reminderEnabled => $composableBuilder(
    column: $table.reminderEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reminderDaysBefore => $composableBuilder(
    column: $table.reminderDaysBefore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
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

  $$CreditCardStatementsTableTableFilterComposer get statementId {
    final $$CreditCardStatementsTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.statementId,
          referencedTable: $db.creditCardStatementsTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CreditCardStatementsTableTableFilterComposer(
                $db: $db,
                $table: $db.creditCardStatementsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  Expression<bool> billOccurrencesTableRefs(
    Expression<bool> Function($$BillOccurrencesTableTableFilterComposer f) f,
  ) {
    final $$BillOccurrencesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.billOccurrencesTable,
      getReferencedColumn: (t) => t.billId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BillOccurrencesTableTableFilterComposer(
            $db: $db,
            $table: $db.billOccurrencesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BillsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $BillsTableTable> {
  $$BillsTableTableOrderingComposer({
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

  ColumnOrderings<double> get expectedAmount => $composableBuilder(
    column: $table.expectedAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dayOfMonth => $composableBuilder(
    column: $table.dayOfMonth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get reminderEnabled => $composableBuilder(
    column: $table.reminderEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reminderDaysBefore => $composableBuilder(
    column: $table.reminderDaysBefore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
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

  $$CreditCardStatementsTableTableOrderingComposer get statementId {
    final $$CreditCardStatementsTableTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.statementId,
          referencedTable: $db.creditCardStatementsTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CreditCardStatementsTableTableOrderingComposer(
                $db: $db,
                $table: $db.creditCardStatementsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$BillsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $BillsTableTable> {
  $$BillsTableTableAnnotationComposer({
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

  GeneratedColumn<double> get expectedAmount => $composableBuilder(
    column: $table.expectedAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get frequency =>
      $composableBuilder(column: $table.frequency, builder: (column) => column);

  GeneratedColumn<int> get dayOfMonth => $composableBuilder(
    column: $table.dayOfMonth,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get reminderEnabled => $composableBuilder(
    column: $table.reminderEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reminderDaysBefore => $composableBuilder(
    column: $table.reminderDaysBefore,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

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

  $$CreditCardStatementsTableTableAnnotationComposer get statementId {
    final $$CreditCardStatementsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.statementId,
          referencedTable: $db.creditCardStatementsTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CreditCardStatementsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.creditCardStatementsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  Expression<T> billOccurrencesTableRefs<T extends Object>(
    Expression<T> Function($$BillOccurrencesTableTableAnnotationComposer a) f,
  ) {
    final $$BillOccurrencesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.billOccurrencesTable,
          getReferencedColumn: (t) => t.billId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$BillOccurrencesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.billOccurrencesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$BillsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BillsTableTable,
          BillsTableData,
          $$BillsTableTableFilterComposer,
          $$BillsTableTableOrderingComposer,
          $$BillsTableTableAnnotationComposer,
          $$BillsTableTableCreateCompanionBuilder,
          $$BillsTableTableUpdateCompanionBuilder,
          (BillsTableData, $$BillsTableTableReferences),
          BillsTableData,
          PrefetchHooks Function({
            bool categoryId,
            bool accountId,
            bool statementId,
            bool billOccurrencesTableRefs,
          })
        > {
  $$BillsTableTableTableManager(_$AppDatabase db, $BillsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BillsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BillsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BillsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int?> categoryId = const Value.absent(),
                Value<int?> accountId = const Value.absent(),
                Value<double?> expectedAmount = const Value.absent(),
                Value<String> frequency = const Value.absent(),
                Value<int?> dayOfMonth = const Value.absent(),
                Value<bool> reminderEnabled = const Value.absent(),
                Value<int?> reminderDaysBefore = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int?> statementId = const Value.absent(),
              }) => BillsTableCompanion(
                id: id,
                name: name,
                categoryId: categoryId,
                accountId: accountId,
                expectedAmount: expectedAmount,
                frequency: frequency,
                dayOfMonth: dayOfMonth,
                reminderEnabled: reminderEnabled,
                reminderDaysBefore: reminderDaysBefore,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                statementId: statementId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<int?> categoryId = const Value.absent(),
                Value<int?> accountId = const Value.absent(),
                Value<double?> expectedAmount = const Value.absent(),
                required String frequency,
                Value<int?> dayOfMonth = const Value.absent(),
                Value<bool> reminderEnabled = const Value.absent(),
                Value<int?> reminderDaysBefore = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int?> statementId = const Value.absent(),
              }) => BillsTableCompanion.insert(
                id: id,
                name: name,
                categoryId: categoryId,
                accountId: accountId,
                expectedAmount: expectedAmount,
                frequency: frequency,
                dayOfMonth: dayOfMonth,
                reminderEnabled: reminderEnabled,
                reminderDaysBefore: reminderDaysBefore,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                statementId: statementId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BillsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                categoryId = false,
                accountId = false,
                statementId = false,
                billOccurrencesTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (billOccurrencesTableRefs) db.billOccurrencesTable,
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
                                    referencedTable: $$BillsTableTableReferences
                                        ._categoryIdTable(db),
                                    referencedColumn:
                                        $$BillsTableTableReferences
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
                                    referencedTable: $$BillsTableTableReferences
                                        ._accountIdTable(db),
                                    referencedColumn:
                                        $$BillsTableTableReferences
                                            ._accountIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (statementId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.statementId,
                                    referencedTable: $$BillsTableTableReferences
                                        ._statementIdTable(db),
                                    referencedColumn:
                                        $$BillsTableTableReferences
                                            ._statementIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (billOccurrencesTableRefs)
                        await $_getPrefetchedData<
                          BillsTableData,
                          $BillsTableTable,
                          BillOccurrencesTableData
                        >(
                          currentTable: table,
                          referencedTable: $$BillsTableTableReferences
                              ._billOccurrencesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BillsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).billOccurrencesTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.billId == item.id,
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

typedef $$BillsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BillsTableTable,
      BillsTableData,
      $$BillsTableTableFilterComposer,
      $$BillsTableTableOrderingComposer,
      $$BillsTableTableAnnotationComposer,
      $$BillsTableTableCreateCompanionBuilder,
      $$BillsTableTableUpdateCompanionBuilder,
      (BillsTableData, $$BillsTableTableReferences),
      BillsTableData,
      PrefetchHooks Function({
        bool categoryId,
        bool accountId,
        bool statementId,
        bool billOccurrencesTableRefs,
      })
    >;
typedef $$BillOccurrencesTableTableCreateCompanionBuilder =
    BillOccurrencesTableCompanion Function({
      Value<int> id,
      required int billId,
      required DateTime dueDate,
      Value<double?> expectedAmount,
      Value<double?> actualAmount,
      Value<bool> isPaid,
      Value<int?> transactionId,
      Value<DateTime> createdAt,
    });
typedef $$BillOccurrencesTableTableUpdateCompanionBuilder =
    BillOccurrencesTableCompanion Function({
      Value<int> id,
      Value<int> billId,
      Value<DateTime> dueDate,
      Value<double?> expectedAmount,
      Value<double?> actualAmount,
      Value<bool> isPaid,
      Value<int?> transactionId,
      Value<DateTime> createdAt,
    });

final class $$BillOccurrencesTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $BillOccurrencesTableTable,
          BillOccurrencesTableData
        > {
  $$BillOccurrencesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $BillsTableTable _billIdTable(_$AppDatabase db) => db.billsTable
      .createAlias('bill_occurrences_table__bill_id__bills_table__id');

  $$BillsTableTableProcessedTableManager get billId {
    final $_column = $_itemColumn<int>('bill_id')!;

    final manager = $$BillsTableTableTableManager(
      $_db,
      $_db.billsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_billIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TransactionsTableTable _transactionIdTable(_$AppDatabase db) =>
      db.transactionsTable.createAlias(
        'bill_occurrences_table__transaction_id__transactions_table__id',
      );

  $$TransactionsTableTableProcessedTableManager? get transactionId {
    final $_column = $_itemColumn<int>('transaction_id');
    if ($_column == null) return null;
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
}

class $$BillOccurrencesTableTableFilterComposer
    extends Composer<_$AppDatabase, $BillOccurrencesTableTable> {
  $$BillOccurrencesTableTableFilterComposer({
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

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get expectedAmount => $composableBuilder(
    column: $table.expectedAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get actualAmount => $composableBuilder(
    column: $table.actualAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPaid => $composableBuilder(
    column: $table.isPaid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$BillsTableTableFilterComposer get billId {
    final $$BillsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.billId,
      referencedTable: $db.billsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BillsTableTableFilterComposer(
            $db: $db,
            $table: $db.billsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

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
}

class $$BillOccurrencesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $BillOccurrencesTableTable> {
  $$BillOccurrencesTableTableOrderingComposer({
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

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get expectedAmount => $composableBuilder(
    column: $table.expectedAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get actualAmount => $composableBuilder(
    column: $table.actualAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPaid => $composableBuilder(
    column: $table.isPaid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$BillsTableTableOrderingComposer get billId {
    final $$BillsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.billId,
      referencedTable: $db.billsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BillsTableTableOrderingComposer(
            $db: $db,
            $table: $db.billsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

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
}

class $$BillOccurrencesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $BillOccurrencesTableTable> {
  $$BillOccurrencesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<double> get expectedAmount => $composableBuilder(
    column: $table.expectedAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get actualAmount => $composableBuilder(
    column: $table.actualAmount,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isPaid =>
      $composableBuilder(column: $table.isPaid, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$BillsTableTableAnnotationComposer get billId {
    final $$BillsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.billId,
      referencedTable: $db.billsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BillsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.billsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

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
}

class $$BillOccurrencesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BillOccurrencesTableTable,
          BillOccurrencesTableData,
          $$BillOccurrencesTableTableFilterComposer,
          $$BillOccurrencesTableTableOrderingComposer,
          $$BillOccurrencesTableTableAnnotationComposer,
          $$BillOccurrencesTableTableCreateCompanionBuilder,
          $$BillOccurrencesTableTableUpdateCompanionBuilder,
          (BillOccurrencesTableData, $$BillOccurrencesTableTableReferences),
          BillOccurrencesTableData,
          PrefetchHooks Function({bool billId, bool transactionId})
        > {
  $$BillOccurrencesTableTableTableManager(
    _$AppDatabase db,
    $BillOccurrencesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BillOccurrencesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BillOccurrencesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$BillOccurrencesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> billId = const Value.absent(),
                Value<DateTime> dueDate = const Value.absent(),
                Value<double?> expectedAmount = const Value.absent(),
                Value<double?> actualAmount = const Value.absent(),
                Value<bool> isPaid = const Value.absent(),
                Value<int?> transactionId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => BillOccurrencesTableCompanion(
                id: id,
                billId: billId,
                dueDate: dueDate,
                expectedAmount: expectedAmount,
                actualAmount: actualAmount,
                isPaid: isPaid,
                transactionId: transactionId,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int billId,
                required DateTime dueDate,
                Value<double?> expectedAmount = const Value.absent(),
                Value<double?> actualAmount = const Value.absent(),
                Value<bool> isPaid = const Value.absent(),
                Value<int?> transactionId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => BillOccurrencesTableCompanion.insert(
                id: id,
                billId: billId,
                dueDate: dueDate,
                expectedAmount: expectedAmount,
                actualAmount: actualAmount,
                isPaid: isPaid,
                transactionId: transactionId,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BillOccurrencesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({billId = false, transactionId = false}) {
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
                    if (billId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.billId,
                                referencedTable:
                                    $$BillOccurrencesTableTableReferences
                                        ._billIdTable(db),
                                referencedColumn:
                                    $$BillOccurrencesTableTableReferences
                                        ._billIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (transactionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.transactionId,
                                referencedTable:
                                    $$BillOccurrencesTableTableReferences
                                        ._transactionIdTable(db),
                                referencedColumn:
                                    $$BillOccurrencesTableTableReferences
                                        ._transactionIdTable(db)
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

typedef $$BillOccurrencesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BillOccurrencesTableTable,
      BillOccurrencesTableData,
      $$BillOccurrencesTableTableFilterComposer,
      $$BillOccurrencesTableTableOrderingComposer,
      $$BillOccurrencesTableTableAnnotationComposer,
      $$BillOccurrencesTableTableCreateCompanionBuilder,
      $$BillOccurrencesTableTableUpdateCompanionBuilder,
      (BillOccurrencesTableData, $$BillOccurrencesTableTableReferences),
      BillOccurrencesTableData,
      PrefetchHooks Function({bool billId, bool transactionId})
    >;
typedef $$CreditCardDetailsTableTableCreateCompanionBuilder =
    CreditCardDetailsTableCompanion Function({
      Value<int> accountId,
      required int statementDay,
      required int paymentDueDay,
      required DateTime nextStatementDate,
      required DateTime nextPaymentDueDate,
    });
typedef $$CreditCardDetailsTableTableUpdateCompanionBuilder =
    CreditCardDetailsTableCompanion Function({
      Value<int> accountId,
      Value<int> statementDay,
      Value<int> paymentDueDay,
      Value<DateTime> nextStatementDate,
      Value<DateTime> nextPaymentDueDate,
    });

final class $$CreditCardDetailsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CreditCardDetailsTableTable,
          CreditCardDetailsTableData
        > {
  $$CreditCardDetailsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AccountsTableTable _accountIdTable(_$AppDatabase db) => db
      .accountsTable
      .createAlias('credit_card_details_table__account_id__accounts_table__id');

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
}

class $$CreditCardDetailsTableTableFilterComposer
    extends Composer<_$AppDatabase, $CreditCardDetailsTableTable> {
  $$CreditCardDetailsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get statementDay => $composableBuilder(
    column: $table.statementDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get paymentDueDay => $composableBuilder(
    column: $table.paymentDueDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextStatementDate => $composableBuilder(
    column: $table.nextStatementDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextPaymentDueDate => $composableBuilder(
    column: $table.nextPaymentDueDate,
    builder: (column) => ColumnFilters(column),
  );

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
}

class $$CreditCardDetailsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CreditCardDetailsTableTable> {
  $$CreditCardDetailsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get statementDay => $composableBuilder(
    column: $table.statementDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get paymentDueDay => $composableBuilder(
    column: $table.paymentDueDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextStatementDate => $composableBuilder(
    column: $table.nextStatementDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextPaymentDueDate => $composableBuilder(
    column: $table.nextPaymentDueDate,
    builder: (column) => ColumnOrderings(column),
  );

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
}

class $$CreditCardDetailsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CreditCardDetailsTableTable> {
  $$CreditCardDetailsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get statementDay => $composableBuilder(
    column: $table.statementDay,
    builder: (column) => column,
  );

  GeneratedColumn<int> get paymentDueDay => $composableBuilder(
    column: $table.paymentDueDay,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get nextStatementDate => $composableBuilder(
    column: $table.nextStatementDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get nextPaymentDueDate => $composableBuilder(
    column: $table.nextPaymentDueDate,
    builder: (column) => column,
  );

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
}

class $$CreditCardDetailsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CreditCardDetailsTableTable,
          CreditCardDetailsTableData,
          $$CreditCardDetailsTableTableFilterComposer,
          $$CreditCardDetailsTableTableOrderingComposer,
          $$CreditCardDetailsTableTableAnnotationComposer,
          $$CreditCardDetailsTableTableCreateCompanionBuilder,
          $$CreditCardDetailsTableTableUpdateCompanionBuilder,
          (CreditCardDetailsTableData, $$CreditCardDetailsTableTableReferences),
          CreditCardDetailsTableData,
          PrefetchHooks Function({bool accountId})
        > {
  $$CreditCardDetailsTableTableTableManager(
    _$AppDatabase db,
    $CreditCardDetailsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CreditCardDetailsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$CreditCardDetailsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CreditCardDetailsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> accountId = const Value.absent(),
                Value<int> statementDay = const Value.absent(),
                Value<int> paymentDueDay = const Value.absent(),
                Value<DateTime> nextStatementDate = const Value.absent(),
                Value<DateTime> nextPaymentDueDate = const Value.absent(),
              }) => CreditCardDetailsTableCompanion(
                accountId: accountId,
                statementDay: statementDay,
                paymentDueDay: paymentDueDay,
                nextStatementDate: nextStatementDate,
                nextPaymentDueDate: nextPaymentDueDate,
              ),
          createCompanionCallback:
              ({
                Value<int> accountId = const Value.absent(),
                required int statementDay,
                required int paymentDueDay,
                required DateTime nextStatementDate,
                required DateTime nextPaymentDueDate,
              }) => CreditCardDetailsTableCompanion.insert(
                accountId: accountId,
                statementDay: statementDay,
                paymentDueDay: paymentDueDay,
                nextStatementDate: nextStatementDate,
                nextPaymentDueDate: nextPaymentDueDate,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CreditCardDetailsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({accountId = false}) {
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
                    if (accountId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.accountId,
                                referencedTable:
                                    $$CreditCardDetailsTableTableReferences
                                        ._accountIdTable(db),
                                referencedColumn:
                                    $$CreditCardDetailsTableTableReferences
                                        ._accountIdTable(db)
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

typedef $$CreditCardDetailsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CreditCardDetailsTableTable,
      CreditCardDetailsTableData,
      $$CreditCardDetailsTableTableFilterComposer,
      $$CreditCardDetailsTableTableOrderingComposer,
      $$CreditCardDetailsTableTableAnnotationComposer,
      $$CreditCardDetailsTableTableCreateCompanionBuilder,
      $$CreditCardDetailsTableTableUpdateCompanionBuilder,
      (CreditCardDetailsTableData, $$CreditCardDetailsTableTableReferences),
      CreditCardDetailsTableData,
      PrefetchHooks Function({bool accountId})
    >;
typedef $$InvestorProfilesTableTableCreateCompanionBuilder =
    InvestorProfilesTableCompanion Function({
      Value<int> id,
      Value<String?> investmentHorizon,
      Value<String?> withdrawalHorizon,
      Value<String?> investmentKnowledge,
      Value<String?> riskWillingness,
      Value<String?> investmentExperience,
      Value<String?> marketLossReaction,
      Value<String?> riskReturnPreference,
      Value<int?> totalScore,
      Value<String?> investorProfile,
      Value<DateTime?> assessedAt,
    });
typedef $$InvestorProfilesTableTableUpdateCompanionBuilder =
    InvestorProfilesTableCompanion Function({
      Value<int> id,
      Value<String?> investmentHorizon,
      Value<String?> withdrawalHorizon,
      Value<String?> investmentKnowledge,
      Value<String?> riskWillingness,
      Value<String?> investmentExperience,
      Value<String?> marketLossReaction,
      Value<String?> riskReturnPreference,
      Value<int?> totalScore,
      Value<String?> investorProfile,
      Value<DateTime?> assessedAt,
    });

class $$InvestorProfilesTableTableFilterComposer
    extends Composer<_$AppDatabase, $InvestorProfilesTableTable> {
  $$InvestorProfilesTableTableFilterComposer({
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

  ColumnFilters<String> get investmentHorizon => $composableBuilder(
    column: $table.investmentHorizon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get withdrawalHorizon => $composableBuilder(
    column: $table.withdrawalHorizon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get investmentKnowledge => $composableBuilder(
    column: $table.investmentKnowledge,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get riskWillingness => $composableBuilder(
    column: $table.riskWillingness,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get investmentExperience => $composableBuilder(
    column: $table.investmentExperience,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get marketLossReaction => $composableBuilder(
    column: $table.marketLossReaction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get riskReturnPreference => $composableBuilder(
    column: $table.riskReturnPreference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalScore => $composableBuilder(
    column: $table.totalScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get investorProfile => $composableBuilder(
    column: $table.investorProfile,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get assessedAt => $composableBuilder(
    column: $table.assessedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InvestorProfilesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $InvestorProfilesTableTable> {
  $$InvestorProfilesTableTableOrderingComposer({
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

  ColumnOrderings<String> get investmentHorizon => $composableBuilder(
    column: $table.investmentHorizon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get withdrawalHorizon => $composableBuilder(
    column: $table.withdrawalHorizon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get investmentKnowledge => $composableBuilder(
    column: $table.investmentKnowledge,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get riskWillingness => $composableBuilder(
    column: $table.riskWillingness,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get investmentExperience => $composableBuilder(
    column: $table.investmentExperience,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get marketLossReaction => $composableBuilder(
    column: $table.marketLossReaction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get riskReturnPreference => $composableBuilder(
    column: $table.riskReturnPreference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalScore => $composableBuilder(
    column: $table.totalScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get investorProfile => $composableBuilder(
    column: $table.investorProfile,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get assessedAt => $composableBuilder(
    column: $table.assessedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InvestorProfilesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvestorProfilesTableTable> {
  $$InvestorProfilesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get investmentHorizon => $composableBuilder(
    column: $table.investmentHorizon,
    builder: (column) => column,
  );

  GeneratedColumn<String> get withdrawalHorizon => $composableBuilder(
    column: $table.withdrawalHorizon,
    builder: (column) => column,
  );

  GeneratedColumn<String> get investmentKnowledge => $composableBuilder(
    column: $table.investmentKnowledge,
    builder: (column) => column,
  );

  GeneratedColumn<String> get riskWillingness => $composableBuilder(
    column: $table.riskWillingness,
    builder: (column) => column,
  );

  GeneratedColumn<String> get investmentExperience => $composableBuilder(
    column: $table.investmentExperience,
    builder: (column) => column,
  );

  GeneratedColumn<String> get marketLossReaction => $composableBuilder(
    column: $table.marketLossReaction,
    builder: (column) => column,
  );

  GeneratedColumn<String> get riskReturnPreference => $composableBuilder(
    column: $table.riskReturnPreference,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalScore => $composableBuilder(
    column: $table.totalScore,
    builder: (column) => column,
  );

  GeneratedColumn<String> get investorProfile => $composableBuilder(
    column: $table.investorProfile,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get assessedAt => $composableBuilder(
    column: $table.assessedAt,
    builder: (column) => column,
  );
}

class $$InvestorProfilesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InvestorProfilesTableTable,
          InvestorProfilesTableData,
          $$InvestorProfilesTableTableFilterComposer,
          $$InvestorProfilesTableTableOrderingComposer,
          $$InvestorProfilesTableTableAnnotationComposer,
          $$InvestorProfilesTableTableCreateCompanionBuilder,
          $$InvestorProfilesTableTableUpdateCompanionBuilder,
          (
            InvestorProfilesTableData,
            BaseReferences<
              _$AppDatabase,
              $InvestorProfilesTableTable,
              InvestorProfilesTableData
            >,
          ),
          InvestorProfilesTableData,
          PrefetchHooks Function()
        > {
  $$InvestorProfilesTableTableTableManager(
    _$AppDatabase db,
    $InvestorProfilesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvestorProfilesTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$InvestorProfilesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$InvestorProfilesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> investmentHorizon = const Value.absent(),
                Value<String?> withdrawalHorizon = const Value.absent(),
                Value<String?> investmentKnowledge = const Value.absent(),
                Value<String?> riskWillingness = const Value.absent(),
                Value<String?> investmentExperience = const Value.absent(),
                Value<String?> marketLossReaction = const Value.absent(),
                Value<String?> riskReturnPreference = const Value.absent(),
                Value<int?> totalScore = const Value.absent(),
                Value<String?> investorProfile = const Value.absent(),
                Value<DateTime?> assessedAt = const Value.absent(),
              }) => InvestorProfilesTableCompanion(
                id: id,
                investmentHorizon: investmentHorizon,
                withdrawalHorizon: withdrawalHorizon,
                investmentKnowledge: investmentKnowledge,
                riskWillingness: riskWillingness,
                investmentExperience: investmentExperience,
                marketLossReaction: marketLossReaction,
                riskReturnPreference: riskReturnPreference,
                totalScore: totalScore,
                investorProfile: investorProfile,
                assessedAt: assessedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> investmentHorizon = const Value.absent(),
                Value<String?> withdrawalHorizon = const Value.absent(),
                Value<String?> investmentKnowledge = const Value.absent(),
                Value<String?> riskWillingness = const Value.absent(),
                Value<String?> investmentExperience = const Value.absent(),
                Value<String?> marketLossReaction = const Value.absent(),
                Value<String?> riskReturnPreference = const Value.absent(),
                Value<int?> totalScore = const Value.absent(),
                Value<String?> investorProfile = const Value.absent(),
                Value<DateTime?> assessedAt = const Value.absent(),
              }) => InvestorProfilesTableCompanion.insert(
                id: id,
                investmentHorizon: investmentHorizon,
                withdrawalHorizon: withdrawalHorizon,
                investmentKnowledge: investmentKnowledge,
                riskWillingness: riskWillingness,
                investmentExperience: investmentExperience,
                marketLossReaction: marketLossReaction,
                riskReturnPreference: riskReturnPreference,
                totalScore: totalScore,
                investorProfile: investorProfile,
                assessedAt: assessedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InvestorProfilesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InvestorProfilesTableTable,
      InvestorProfilesTableData,
      $$InvestorProfilesTableTableFilterComposer,
      $$InvestorProfilesTableTableOrderingComposer,
      $$InvestorProfilesTableTableAnnotationComposer,
      $$InvestorProfilesTableTableCreateCompanionBuilder,
      $$InvestorProfilesTableTableUpdateCompanionBuilder,
      (
        InvestorProfilesTableData,
        BaseReferences<
          _$AppDatabase,
          $InvestorProfilesTableTable,
          InvestorProfilesTableData
        >,
      ),
      InvestorProfilesTableData,
      PrefetchHooks Function()
    >;
typedef $$GoalsTableTableCreateCompanionBuilder =
    GoalsTableCompanion Function({
      Value<int> id,
      required String type,
      Value<String?> name,
      Value<double> targetAmount,
      Value<double> monthlyContribution,
      Value<DateTime?> dueDate,
    });
typedef $$GoalsTableTableUpdateCompanionBuilder =
    GoalsTableCompanion Function({
      Value<int> id,
      Value<String> type,
      Value<String?> name,
      Value<double> targetAmount,
      Value<double> monthlyContribution,
      Value<DateTime?> dueDate,
    });

final class $$GoalsTableTableReferences
    extends BaseReferences<_$AppDatabase, $GoalsTableTable, GoalsTableData> {
  $$GoalsTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $GoalReservationsTableTable,
    List<GoalReservationsTableData>
  >
  _goalReservationsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.goalReservationsTable,
        aliasName: 'goals_table__id__goal_reservations_table__goal_id',
      );

  $$GoalReservationsTableTableProcessedTableManager
  get goalReservationsTableRefs {
    final manager = $$GoalReservationsTableTableTableManager(
      $_db,
      $_db.goalReservationsTable,
    ).filter((f) => f.goalId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _goalReservationsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $RetirementGoalsTableTable,
    List<RetirementGoalsTableData>
  >
  _retirementGoalsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.retirementGoalsTable,
        aliasName: 'goals_table__id__retirement_goals_table__goal_id',
      );

  $$RetirementGoalsTableTableProcessedTableManager
  get retirementGoalsTableRefs {
    final manager = $$RetirementGoalsTableTableTableManager(
      $_db,
      $_db.retirementGoalsTable,
    ).filter((f) => f.goalId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _retirementGoalsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$GoalsTableTableFilterComposer
    extends Composer<_$AppDatabase, $GoalsTableTable> {
  $$GoalsTableTableFilterComposer({
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

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetAmount => $composableBuilder(
    column: $table.targetAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get monthlyContribution => $composableBuilder(
    column: $table.monthlyContribution,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> goalReservationsTableRefs(
    Expression<bool> Function($$GoalReservationsTableTableFilterComposer f) f,
  ) {
    final $$GoalReservationsTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.goalReservationsTable,
          getReferencedColumn: (t) => t.goalId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$GoalReservationsTableTableFilterComposer(
                $db: $db,
                $table: $db.goalReservationsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> retirementGoalsTableRefs(
    Expression<bool> Function($$RetirementGoalsTableTableFilterComposer f) f,
  ) {
    final $$RetirementGoalsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.retirementGoalsTable,
      getReferencedColumn: (t) => t.goalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RetirementGoalsTableTableFilterComposer(
            $db: $db,
            $table: $db.retirementGoalsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GoalsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $GoalsTableTable> {
  $$GoalsTableTableOrderingComposer({
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

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetAmount => $composableBuilder(
    column: $table.targetAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get monthlyContribution => $composableBuilder(
    column: $table.monthlyContribution,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GoalsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $GoalsTableTable> {
  $$GoalsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get targetAmount => $composableBuilder(
    column: $table.targetAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get monthlyContribution => $composableBuilder(
    column: $table.monthlyContribution,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  Expression<T> goalReservationsTableRefs<T extends Object>(
    Expression<T> Function($$GoalReservationsTableTableAnnotationComposer a) f,
  ) {
    final $$GoalReservationsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.goalReservationsTable,
          getReferencedColumn: (t) => t.goalId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$GoalReservationsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.goalReservationsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> retirementGoalsTableRefs<T extends Object>(
    Expression<T> Function($$RetirementGoalsTableTableAnnotationComposer a) f,
  ) {
    final $$RetirementGoalsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.retirementGoalsTable,
          getReferencedColumn: (t) => t.goalId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RetirementGoalsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.retirementGoalsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$GoalsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GoalsTableTable,
          GoalsTableData,
          $$GoalsTableTableFilterComposer,
          $$GoalsTableTableOrderingComposer,
          $$GoalsTableTableAnnotationComposer,
          $$GoalsTableTableCreateCompanionBuilder,
          $$GoalsTableTableUpdateCompanionBuilder,
          (GoalsTableData, $$GoalsTableTableReferences),
          GoalsTableData,
          PrefetchHooks Function({
            bool goalReservationsTableRefs,
            bool retirementGoalsTableRefs,
          })
        > {
  $$GoalsTableTableTableManager(_$AppDatabase db, $GoalsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GoalsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GoalsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GoalsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<double> targetAmount = const Value.absent(),
                Value<double> monthlyContribution = const Value.absent(),
                Value<DateTime?> dueDate = const Value.absent(),
              }) => GoalsTableCompanion(
                id: id,
                type: type,
                name: name,
                targetAmount: targetAmount,
                monthlyContribution: monthlyContribution,
                dueDate: dueDate,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String type,
                Value<String?> name = const Value.absent(),
                Value<double> targetAmount = const Value.absent(),
                Value<double> monthlyContribution = const Value.absent(),
                Value<DateTime?> dueDate = const Value.absent(),
              }) => GoalsTableCompanion.insert(
                id: id,
                type: type,
                name: name,
                targetAmount: targetAmount,
                monthlyContribution: monthlyContribution,
                dueDate: dueDate,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$GoalsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                goalReservationsTableRefs = false,
                retirementGoalsTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (goalReservationsTableRefs) db.goalReservationsTable,
                    if (retirementGoalsTableRefs) db.retirementGoalsTable,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (goalReservationsTableRefs)
                        await $_getPrefetchedData<
                          GoalsTableData,
                          $GoalsTableTable,
                          GoalReservationsTableData
                        >(
                          currentTable: table,
                          referencedTable: $$GoalsTableTableReferences
                              ._goalReservationsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GoalsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).goalReservationsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.goalId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (retirementGoalsTableRefs)
                        await $_getPrefetchedData<
                          GoalsTableData,
                          $GoalsTableTable,
                          RetirementGoalsTableData
                        >(
                          currentTable: table,
                          referencedTable: $$GoalsTableTableReferences
                              ._retirementGoalsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GoalsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).retirementGoalsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.goalId == item.id,
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

typedef $$GoalsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GoalsTableTable,
      GoalsTableData,
      $$GoalsTableTableFilterComposer,
      $$GoalsTableTableOrderingComposer,
      $$GoalsTableTableAnnotationComposer,
      $$GoalsTableTableCreateCompanionBuilder,
      $$GoalsTableTableUpdateCompanionBuilder,
      (GoalsTableData, $$GoalsTableTableReferences),
      GoalsTableData,
      PrefetchHooks Function({
        bool goalReservationsTableRefs,
        bool retirementGoalsTableRefs,
      })
    >;
typedef $$GoalReservationsTableTableCreateCompanionBuilder =
    GoalReservationsTableCompanion Function({
      Value<int> id,
      required int accountId,
      required int goalId,
      Value<double> amount,
    });
typedef $$GoalReservationsTableTableUpdateCompanionBuilder =
    GoalReservationsTableCompanion Function({
      Value<int> id,
      Value<int> accountId,
      Value<int> goalId,
      Value<double> amount,
    });

final class $$GoalReservationsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $GoalReservationsTableTable,
          GoalReservationsTableData
        > {
  $$GoalReservationsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AccountsTableTable _accountIdTable(_$AppDatabase db) => db
      .accountsTable
      .createAlias('goal_reservations_table__account_id__accounts_table__id');

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

  static $GoalsTableTable _goalIdTable(_$AppDatabase db) => db.goalsTable
      .createAlias('goal_reservations_table__goal_id__goals_table__id');

  $$GoalsTableTableProcessedTableManager get goalId {
    final $_column = $_itemColumn<int>('goal_id')!;

    final manager = $$GoalsTableTableTableManager(
      $_db,
      $_db.goalsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_goalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$GoalReservationsTableTableFilterComposer
    extends Composer<_$AppDatabase, $GoalReservationsTableTable> {
  $$GoalReservationsTableTableFilterComposer({
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

  $$GoalsTableTableFilterComposer get goalId {
    final $$GoalsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goalsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableTableFilterComposer(
            $db: $db,
            $table: $db.goalsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GoalReservationsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $GoalReservationsTableTable> {
  $$GoalReservationsTableTableOrderingComposer({
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

  $$GoalsTableTableOrderingComposer get goalId {
    final $$GoalsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goalsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableTableOrderingComposer(
            $db: $db,
            $table: $db.goalsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GoalReservationsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $GoalReservationsTableTable> {
  $$GoalReservationsTableTableAnnotationComposer({
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

  $$GoalsTableTableAnnotationComposer get goalId {
    final $$GoalsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goalsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.goalsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GoalReservationsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GoalReservationsTableTable,
          GoalReservationsTableData,
          $$GoalReservationsTableTableFilterComposer,
          $$GoalReservationsTableTableOrderingComposer,
          $$GoalReservationsTableTableAnnotationComposer,
          $$GoalReservationsTableTableCreateCompanionBuilder,
          $$GoalReservationsTableTableUpdateCompanionBuilder,
          (GoalReservationsTableData, $$GoalReservationsTableTableReferences),
          GoalReservationsTableData,
          PrefetchHooks Function({bool accountId, bool goalId})
        > {
  $$GoalReservationsTableTableTableManager(
    _$AppDatabase db,
    $GoalReservationsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GoalReservationsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$GoalReservationsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$GoalReservationsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> accountId = const Value.absent(),
                Value<int> goalId = const Value.absent(),
                Value<double> amount = const Value.absent(),
              }) => GoalReservationsTableCompanion(
                id: id,
                accountId: accountId,
                goalId: goalId,
                amount: amount,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int accountId,
                required int goalId,
                Value<double> amount = const Value.absent(),
              }) => GoalReservationsTableCompanion.insert(
                id: id,
                accountId: accountId,
                goalId: goalId,
                amount: amount,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$GoalReservationsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({accountId = false, goalId = false}) {
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
                    if (accountId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.accountId,
                                referencedTable:
                                    $$GoalReservationsTableTableReferences
                                        ._accountIdTable(db),
                                referencedColumn:
                                    $$GoalReservationsTableTableReferences
                                        ._accountIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (goalId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.goalId,
                                referencedTable:
                                    $$GoalReservationsTableTableReferences
                                        ._goalIdTable(db),
                                referencedColumn:
                                    $$GoalReservationsTableTableReferences
                                        ._goalIdTable(db)
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

typedef $$GoalReservationsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GoalReservationsTableTable,
      GoalReservationsTableData,
      $$GoalReservationsTableTableFilterComposer,
      $$GoalReservationsTableTableOrderingComposer,
      $$GoalReservationsTableTableAnnotationComposer,
      $$GoalReservationsTableTableCreateCompanionBuilder,
      $$GoalReservationsTableTableUpdateCompanionBuilder,
      (GoalReservationsTableData, $$GoalReservationsTableTableReferences),
      GoalReservationsTableData,
      PrefetchHooks Function({bool accountId, bool goalId})
    >;
typedef $$UserProfileTableTableCreateCompanionBuilder =
    UserProfileTableCompanion Function({
      Value<int> id,
      Value<String?> name,
      Value<DateTime?> birthday,
    });
typedef $$UserProfileTableTableUpdateCompanionBuilder =
    UserProfileTableCompanion Function({
      Value<int> id,
      Value<String?> name,
      Value<DateTime?> birthday,
    });

class $$UserProfileTableTableFilterComposer
    extends Composer<_$AppDatabase, $UserProfileTableTable> {
  $$UserProfileTableTableFilterComposer({
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

  ColumnFilters<DateTime> get birthday => $composableBuilder(
    column: $table.birthday,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserProfileTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UserProfileTableTable> {
  $$UserProfileTableTableOrderingComposer({
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

  ColumnOrderings<DateTime> get birthday => $composableBuilder(
    column: $table.birthday,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserProfileTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserProfileTableTable> {
  $$UserProfileTableTableAnnotationComposer({
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

  GeneratedColumn<DateTime> get birthday =>
      $composableBuilder(column: $table.birthday, builder: (column) => column);
}

class $$UserProfileTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserProfileTableTable,
          UserProfileTableData,
          $$UserProfileTableTableFilterComposer,
          $$UserProfileTableTableOrderingComposer,
          $$UserProfileTableTableAnnotationComposer,
          $$UserProfileTableTableCreateCompanionBuilder,
          $$UserProfileTableTableUpdateCompanionBuilder,
          (
            UserProfileTableData,
            BaseReferences<
              _$AppDatabase,
              $UserProfileTableTable,
              UserProfileTableData
            >,
          ),
          UserProfileTableData,
          PrefetchHooks Function()
        > {
  $$UserProfileTableTableTableManager(
    _$AppDatabase db,
    $UserProfileTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserProfileTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserProfileTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserProfileTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<DateTime?> birthday = const Value.absent(),
              }) => UserProfileTableCompanion(
                id: id,
                name: name,
                birthday: birthday,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<DateTime?> birthday = const Value.absent(),
              }) => UserProfileTableCompanion.insert(
                id: id,
                name: name,
                birthday: birthday,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserProfileTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserProfileTableTable,
      UserProfileTableData,
      $$UserProfileTableTableFilterComposer,
      $$UserProfileTableTableOrderingComposer,
      $$UserProfileTableTableAnnotationComposer,
      $$UserProfileTableTableCreateCompanionBuilder,
      $$UserProfileTableTableUpdateCompanionBuilder,
      (
        UserProfileTableData,
        BaseReferences<
          _$AppDatabase,
          $UserProfileTableTable,
          UserProfileTableData
        >,
      ),
      UserProfileTableData,
      PrefetchHooks Function()
    >;
typedef $$RetirementGoalsTableTableCreateCompanionBuilder =
    RetirementGoalsTableCompanion Function({
      Value<int> goalId,
      required int retirementAge,
      required int fundEndAge,
    });
typedef $$RetirementGoalsTableTableUpdateCompanionBuilder =
    RetirementGoalsTableCompanion Function({
      Value<int> goalId,
      Value<int> retirementAge,
      Value<int> fundEndAge,
    });

final class $$RetirementGoalsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $RetirementGoalsTableTable,
          RetirementGoalsTableData
        > {
  $$RetirementGoalsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $GoalsTableTable _goalIdTable(_$AppDatabase db) => db.goalsTable
      .createAlias('retirement_goals_table__goal_id__goals_table__id');

  $$GoalsTableTableProcessedTableManager get goalId {
    final $_column = $_itemColumn<int>('goal_id')!;

    final manager = $$GoalsTableTableTableManager(
      $_db,
      $_db.goalsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_goalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RetirementGoalsTableTableFilterComposer
    extends Composer<_$AppDatabase, $RetirementGoalsTableTable> {
  $$RetirementGoalsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get retirementAge => $composableBuilder(
    column: $table.retirementAge,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fundEndAge => $composableBuilder(
    column: $table.fundEndAge,
    builder: (column) => ColumnFilters(column),
  );

  $$GoalsTableTableFilterComposer get goalId {
    final $$GoalsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goalsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableTableFilterComposer(
            $db: $db,
            $table: $db.goalsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RetirementGoalsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $RetirementGoalsTableTable> {
  $$RetirementGoalsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get retirementAge => $composableBuilder(
    column: $table.retirementAge,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fundEndAge => $composableBuilder(
    column: $table.fundEndAge,
    builder: (column) => ColumnOrderings(column),
  );

  $$GoalsTableTableOrderingComposer get goalId {
    final $$GoalsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goalsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableTableOrderingComposer(
            $db: $db,
            $table: $db.goalsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RetirementGoalsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $RetirementGoalsTableTable> {
  $$RetirementGoalsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get retirementAge => $composableBuilder(
    column: $table.retirementAge,
    builder: (column) => column,
  );

  GeneratedColumn<int> get fundEndAge => $composableBuilder(
    column: $table.fundEndAge,
    builder: (column) => column,
  );

  $$GoalsTableTableAnnotationComposer get goalId {
    final $$GoalsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goalsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.goalsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RetirementGoalsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RetirementGoalsTableTable,
          RetirementGoalsTableData,
          $$RetirementGoalsTableTableFilterComposer,
          $$RetirementGoalsTableTableOrderingComposer,
          $$RetirementGoalsTableTableAnnotationComposer,
          $$RetirementGoalsTableTableCreateCompanionBuilder,
          $$RetirementGoalsTableTableUpdateCompanionBuilder,
          (RetirementGoalsTableData, $$RetirementGoalsTableTableReferences),
          RetirementGoalsTableData,
          PrefetchHooks Function({bool goalId})
        > {
  $$RetirementGoalsTableTableTableManager(
    _$AppDatabase db,
    $RetirementGoalsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RetirementGoalsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RetirementGoalsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$RetirementGoalsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> goalId = const Value.absent(),
                Value<int> retirementAge = const Value.absent(),
                Value<int> fundEndAge = const Value.absent(),
              }) => RetirementGoalsTableCompanion(
                goalId: goalId,
                retirementAge: retirementAge,
                fundEndAge: fundEndAge,
              ),
          createCompanionCallback:
              ({
                Value<int> goalId = const Value.absent(),
                required int retirementAge,
                required int fundEndAge,
              }) => RetirementGoalsTableCompanion.insert(
                goalId: goalId,
                retirementAge: retirementAge,
                fundEndAge: fundEndAge,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RetirementGoalsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({goalId = false}) {
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
                    if (goalId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.goalId,
                                referencedTable:
                                    $$RetirementGoalsTableTableReferences
                                        ._goalIdTable(db),
                                referencedColumn:
                                    $$RetirementGoalsTableTableReferences
                                        ._goalIdTable(db)
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

typedef $$RetirementGoalsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RetirementGoalsTableTable,
      RetirementGoalsTableData,
      $$RetirementGoalsTableTableFilterComposer,
      $$RetirementGoalsTableTableOrderingComposer,
      $$RetirementGoalsTableTableAnnotationComposer,
      $$RetirementGoalsTableTableCreateCompanionBuilder,
      $$RetirementGoalsTableTableUpdateCompanionBuilder,
      (RetirementGoalsTableData, $$RetirementGoalsTableTableReferences),
      RetirementGoalsTableData,
      PrefetchHooks Function({bool goalId})
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
  $$LoansTableTableManager get loans =>
      $$LoansTableTableManager(_db, _db.loans);
  $$CashFlowPlansTableTableManager get cashFlowPlans =>
      $$CashFlowPlansTableTableManager(_db, _db.cashFlowPlans);
  $$CashFlowPlanAllocationsTableTableManager get cashFlowPlanAllocations =>
      $$CashFlowPlanAllocationsTableTableManager(
        _db,
        _db.cashFlowPlanAllocations,
      );
  $$CreditCardBillingPeriodsTableTableTableManager
  get creditCardBillingPeriodsTable =>
      $$CreditCardBillingPeriodsTableTableTableManager(
        _db,
        _db.creditCardBillingPeriodsTable,
      );
  $$CreditCardStatementsTableTableTableManager get creditCardStatementsTable =>
      $$CreditCardStatementsTableTableTableManager(
        _db,
        _db.creditCardStatementsTable,
      );
  $$BillsTableTableTableManager get billsTable =>
      $$BillsTableTableTableManager(_db, _db.billsTable);
  $$BillOccurrencesTableTableTableManager get billOccurrencesTable =>
      $$BillOccurrencesTableTableTableManager(_db, _db.billOccurrencesTable);
  $$CreditCardDetailsTableTableTableManager get creditCardDetailsTable =>
      $$CreditCardDetailsTableTableTableManager(
        _db,
        _db.creditCardDetailsTable,
      );
  $$InvestorProfilesTableTableTableManager get investorProfilesTable =>
      $$InvestorProfilesTableTableTableManager(_db, _db.investorProfilesTable);
  $$GoalsTableTableTableManager get goalsTable =>
      $$GoalsTableTableTableManager(_db, _db.goalsTable);
  $$GoalReservationsTableTableTableManager get goalReservationsTable =>
      $$GoalReservationsTableTableTableManager(_db, _db.goalReservationsTable);
  $$UserProfileTableTableTableManager get userProfileTable =>
      $$UserProfileTableTableTableManager(_db, _db.userProfileTable);
  $$RetirementGoalsTableTableTableManager get retirementGoalsTable =>
      $$RetirementGoalsTableTableTableManager(_db, _db.retirementGoalsTable);
}
