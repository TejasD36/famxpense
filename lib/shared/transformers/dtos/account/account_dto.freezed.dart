// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AccountDto implements DiagnosticableTreeMixin {

@HiveField(0) String get id;@HiveField(1) String get userId;@HiveField(2) String get accountName;@HiveField(3) AccountType get accountType;@HiveField(4) double get currentBalance;@HiveField(5) DateTime get createdAt;@HiveField(6) DateTime get updatedAt;@HiveField(7) bool get isArchived;
/// Create a copy of AccountDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountDtoCopyWith<AccountDto> get copyWith => _$AccountDtoCopyWithImpl<AccountDto>(this as AccountDto, _$identity);

  /// Serializes this AccountDto to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AccountDto'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('userId', userId))..add(DiagnosticsProperty('accountName', accountName))..add(DiagnosticsProperty('accountType', accountType))..add(DiagnosticsProperty('currentBalance', currentBalance))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('updatedAt', updatedAt))..add(DiagnosticsProperty('isArchived', isArchived));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountDto&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.accountType, accountType) || other.accountType == accountType)&&(identical(other.currentBalance, currentBalance) || other.currentBalance == currentBalance)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,accountName,accountType,currentBalance,createdAt,updatedAt,isArchived);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AccountDto(id: $id, userId: $userId, accountName: $accountName, accountType: $accountType, currentBalance: $currentBalance, createdAt: $createdAt, updatedAt: $updatedAt, isArchived: $isArchived)';
}


}

/// @nodoc
abstract mixin class $AccountDtoCopyWith<$Res>  {
  factory $AccountDtoCopyWith(AccountDto value, $Res Function(AccountDto) _then) = _$AccountDtoCopyWithImpl;
@useResult
$Res call({
@HiveField(0) String id,@HiveField(1) String userId,@HiveField(2) String accountName,@HiveField(3) AccountType accountType,@HiveField(4) double currentBalance,@HiveField(5) DateTime createdAt,@HiveField(6) DateTime updatedAt,@HiveField(7) bool isArchived
});




}
/// @nodoc
class _$AccountDtoCopyWithImpl<$Res>
    implements $AccountDtoCopyWith<$Res> {
  _$AccountDtoCopyWithImpl(this._self, this._then);

  final AccountDto _self;
  final $Res Function(AccountDto) _then;

/// Create a copy of AccountDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? accountName = null,Object? accountType = null,Object? currentBalance = null,Object? createdAt = null,Object? updatedAt = null,Object? isArchived = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,accountName: null == accountName ? _self.accountName : accountName // ignore: cast_nullable_to_non_nullable
as String,accountType: null == accountType ? _self.accountType : accountType // ignore: cast_nullable_to_non_nullable
as AccountType,currentBalance: null == currentBalance ? _self.currentBalance : currentBalance // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AccountDto].
extension AccountDtoPatterns on AccountDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountDto value)  $default,){
final _that = this;
switch (_that) {
case _AccountDto():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountDto value)?  $default,){
final _that = this;
switch (_that) {
case _AccountDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  String id, @HiveField(1)  String userId, @HiveField(2)  String accountName, @HiveField(3)  AccountType accountType, @HiveField(4)  double currentBalance, @HiveField(5)  DateTime createdAt, @HiveField(6)  DateTime updatedAt, @HiveField(7)  bool isArchived)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountDto() when $default != null:
return $default(_that.id,_that.userId,_that.accountName,_that.accountType,_that.currentBalance,_that.createdAt,_that.updatedAt,_that.isArchived);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  String id, @HiveField(1)  String userId, @HiveField(2)  String accountName, @HiveField(3)  AccountType accountType, @HiveField(4)  double currentBalance, @HiveField(5)  DateTime createdAt, @HiveField(6)  DateTime updatedAt, @HiveField(7)  bool isArchived)  $default,) {final _that = this;
switch (_that) {
case _AccountDto():
return $default(_that.id,_that.userId,_that.accountName,_that.accountType,_that.currentBalance,_that.createdAt,_that.updatedAt,_that.isArchived);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  String id, @HiveField(1)  String userId, @HiveField(2)  String accountName, @HiveField(3)  AccountType accountType, @HiveField(4)  double currentBalance, @HiveField(5)  DateTime createdAt, @HiveField(6)  DateTime updatedAt, @HiveField(7)  bool isArchived)?  $default,) {final _that = this;
switch (_that) {
case _AccountDto() when $default != null:
return $default(_that.id,_that.userId,_that.accountName,_that.accountType,_that.currentBalance,_that.createdAt,_that.updatedAt,_that.isArchived);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AccountDto with DiagnosticableTreeMixin implements AccountDto {
  const _AccountDto({@HiveField(0) required this.id, @HiveField(1) required this.userId, @HiveField(2) required this.accountName, @HiveField(3) required this.accountType, @HiveField(4) required this.currentBalance, @HiveField(5) required this.createdAt, @HiveField(6) required this.updatedAt, @HiveField(7) this.isArchived = false});
  factory _AccountDto.fromJson(Map<String, dynamic> json) => _$AccountDtoFromJson(json);

@override@HiveField(0) final  String id;
@override@HiveField(1) final  String userId;
@override@HiveField(2) final  String accountName;
@override@HiveField(3) final  AccountType accountType;
@override@HiveField(4) final  double currentBalance;
@override@HiveField(5) final  DateTime createdAt;
@override@HiveField(6) final  DateTime updatedAt;
@override@JsonKey()@HiveField(7) final  bool isArchived;

/// Create a copy of AccountDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountDtoCopyWith<_AccountDto> get copyWith => __$AccountDtoCopyWithImpl<_AccountDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AccountDtoToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AccountDto'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('userId', userId))..add(DiagnosticsProperty('accountName', accountName))..add(DiagnosticsProperty('accountType', accountType))..add(DiagnosticsProperty('currentBalance', currentBalance))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('updatedAt', updatedAt))..add(DiagnosticsProperty('isArchived', isArchived));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountDto&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.accountType, accountType) || other.accountType == accountType)&&(identical(other.currentBalance, currentBalance) || other.currentBalance == currentBalance)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,accountName,accountType,currentBalance,createdAt,updatedAt,isArchived);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AccountDto(id: $id, userId: $userId, accountName: $accountName, accountType: $accountType, currentBalance: $currentBalance, createdAt: $createdAt, updatedAt: $updatedAt, isArchived: $isArchived)';
}


}

/// @nodoc
abstract mixin class _$AccountDtoCopyWith<$Res> implements $AccountDtoCopyWith<$Res> {
  factory _$AccountDtoCopyWith(_AccountDto value, $Res Function(_AccountDto) _then) = __$AccountDtoCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) String id,@HiveField(1) String userId,@HiveField(2) String accountName,@HiveField(3) AccountType accountType,@HiveField(4) double currentBalance,@HiveField(5) DateTime createdAt,@HiveField(6) DateTime updatedAt,@HiveField(7) bool isArchived
});




}
/// @nodoc
class __$AccountDtoCopyWithImpl<$Res>
    implements _$AccountDtoCopyWith<$Res> {
  __$AccountDtoCopyWithImpl(this._self, this._then);

  final _AccountDto _self;
  final $Res Function(_AccountDto) _then;

/// Create a copy of AccountDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? accountName = null,Object? accountType = null,Object? currentBalance = null,Object? createdAt = null,Object? updatedAt = null,Object? isArchived = null,}) {
  return _then(_AccountDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,accountName: null == accountName ? _self.accountName : accountName // ignore: cast_nullable_to_non_nullable
as String,accountType: null == accountType ? _self.accountType : accountType // ignore: cast_nullable_to_non_nullable
as AccountType,currentBalance: null == currentBalance ? _self.currentBalance : currentBalance // ignore: cast_nullable_to_non_nullable
as double,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
