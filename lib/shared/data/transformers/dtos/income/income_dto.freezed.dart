// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'income_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IncomeDto implements DiagnosticableTreeMixin {

@HiveField(0) String get id;@HiveField(1) String get userId;@HiveField(2) String get accountId;@HiveField(3) double get amount;@HiveField(4) IncomeSource get source;@HiveField(5) String get description;@HiveField(6) DateTime get createdAt;@HiveField(7) DateTime get updatedAt;@HiveField(8) SyncStatus get syncStatus;@HiveField(9) bool get isDeleted;
/// Create a copy of IncomeDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IncomeDtoCopyWith<IncomeDto> get copyWith => _$IncomeDtoCopyWithImpl<IncomeDto>(this as IncomeDto, _$identity);

  /// Serializes this IncomeDto to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'IncomeDto'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('userId', userId))..add(DiagnosticsProperty('accountId', accountId))..add(DiagnosticsProperty('amount', amount))..add(DiagnosticsProperty('source', source))..add(DiagnosticsProperty('description', description))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('updatedAt', updatedAt))..add(DiagnosticsProperty('syncStatus', syncStatus))..add(DiagnosticsProperty('isDeleted', isDeleted));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IncomeDto&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.source, source) || other.source == source)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,accountId,amount,source,description,createdAt,updatedAt,syncStatus,isDeleted);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'IncomeDto(id: $id, userId: $userId, accountId: $accountId, amount: $amount, source: $source, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, syncStatus: $syncStatus, isDeleted: $isDeleted)';
}


}

/// @nodoc
abstract mixin class $IncomeDtoCopyWith<$Res>  {
  factory $IncomeDtoCopyWith(IncomeDto value, $Res Function(IncomeDto) _then) = _$IncomeDtoCopyWithImpl;
@useResult
$Res call({
@HiveField(0) String id,@HiveField(1) String userId,@HiveField(2) String accountId,@HiveField(3) double amount,@HiveField(4) IncomeSource source,@HiveField(5) String description,@HiveField(6) DateTime createdAt,@HiveField(7) DateTime updatedAt,@HiveField(8) SyncStatus syncStatus,@HiveField(9) bool isDeleted
});




}
/// @nodoc
class _$IncomeDtoCopyWithImpl<$Res>
    implements $IncomeDtoCopyWith<$Res> {
  _$IncomeDtoCopyWithImpl(this._self, this._then);

  final IncomeDto _self;
  final $Res Function(IncomeDto) _then;

/// Create a copy of IncomeDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? accountId = null,Object? amount = null,Object? source = null,Object? description = null,Object? createdAt = null,Object? updatedAt = null,Object? syncStatus = null,Object? isDeleted = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as IncomeSource,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SyncStatus,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [IncomeDto].
extension IncomeDtoPatterns on IncomeDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IncomeDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IncomeDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IncomeDto value)  $default,){
final _that = this;
switch (_that) {
case _IncomeDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IncomeDto value)?  $default,){
final _that = this;
switch (_that) {
case _IncomeDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  String id, @HiveField(1)  String userId, @HiveField(2)  String accountId, @HiveField(3)  double amount, @HiveField(4)  IncomeSource source, @HiveField(5)  String description, @HiveField(6)  DateTime createdAt, @HiveField(7)  DateTime updatedAt, @HiveField(8)  SyncStatus syncStatus, @HiveField(9)  bool isDeleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IncomeDto() when $default != null:
return $default(_that.id,_that.userId,_that.accountId,_that.amount,_that.source,_that.description,_that.createdAt,_that.updatedAt,_that.syncStatus,_that.isDeleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  String id, @HiveField(1)  String userId, @HiveField(2)  String accountId, @HiveField(3)  double amount, @HiveField(4)  IncomeSource source, @HiveField(5)  String description, @HiveField(6)  DateTime createdAt, @HiveField(7)  DateTime updatedAt, @HiveField(8)  SyncStatus syncStatus, @HiveField(9)  bool isDeleted)  $default,) {final _that = this;
switch (_that) {
case _IncomeDto():
return $default(_that.id,_that.userId,_that.accountId,_that.amount,_that.source,_that.description,_that.createdAt,_that.updatedAt,_that.syncStatus,_that.isDeleted);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  String id, @HiveField(1)  String userId, @HiveField(2)  String accountId, @HiveField(3)  double amount, @HiveField(4)  IncomeSource source, @HiveField(5)  String description, @HiveField(6)  DateTime createdAt, @HiveField(7)  DateTime updatedAt, @HiveField(8)  SyncStatus syncStatus, @HiveField(9)  bool isDeleted)?  $default,) {final _that = this;
switch (_that) {
case _IncomeDto() when $default != null:
return $default(_that.id,_that.userId,_that.accountId,_that.amount,_that.source,_that.description,_that.createdAt,_that.updatedAt,_that.syncStatus,_that.isDeleted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IncomeDto with DiagnosticableTreeMixin implements IncomeDto {
  const _IncomeDto({@HiveField(0) required this.id, @HiveField(1) required this.userId, @HiveField(2) required this.accountId, @HiveField(3) required this.amount, @HiveField(4) required this.source, @HiveField(5) required this.description, @HiveField(6) required this.createdAt, @HiveField(7) required this.updatedAt, @HiveField(8) this.syncStatus = SyncStatus.pending, @HiveField(9) this.isDeleted = false});
  factory _IncomeDto.fromJson(Map<String, dynamic> json) => _$IncomeDtoFromJson(json);

@override@HiveField(0) final  String id;
@override@HiveField(1) final  String userId;
@override@HiveField(2) final  String accountId;
@override@HiveField(3) final  double amount;
@override@HiveField(4) final  IncomeSource source;
@override@HiveField(5) final  String description;
@override@HiveField(6) final  DateTime createdAt;
@override@HiveField(7) final  DateTime updatedAt;
@override@JsonKey()@HiveField(8) final  SyncStatus syncStatus;
@override@JsonKey()@HiveField(9) final  bool isDeleted;

/// Create a copy of IncomeDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IncomeDtoCopyWith<_IncomeDto> get copyWith => __$IncomeDtoCopyWithImpl<_IncomeDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IncomeDtoToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'IncomeDto'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('userId', userId))..add(DiagnosticsProperty('accountId', accountId))..add(DiagnosticsProperty('amount', amount))..add(DiagnosticsProperty('source', source))..add(DiagnosticsProperty('description', description))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('updatedAt', updatedAt))..add(DiagnosticsProperty('syncStatus', syncStatus))..add(DiagnosticsProperty('isDeleted', isDeleted));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IncomeDto&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.source, source) || other.source == source)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,accountId,amount,source,description,createdAt,updatedAt,syncStatus,isDeleted);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'IncomeDto(id: $id, userId: $userId, accountId: $accountId, amount: $amount, source: $source, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, syncStatus: $syncStatus, isDeleted: $isDeleted)';
}


}

/// @nodoc
abstract mixin class _$IncomeDtoCopyWith<$Res> implements $IncomeDtoCopyWith<$Res> {
  factory _$IncomeDtoCopyWith(_IncomeDto value, $Res Function(_IncomeDto) _then) = __$IncomeDtoCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) String id,@HiveField(1) String userId,@HiveField(2) String accountId,@HiveField(3) double amount,@HiveField(4) IncomeSource source,@HiveField(5) String description,@HiveField(6) DateTime createdAt,@HiveField(7) DateTime updatedAt,@HiveField(8) SyncStatus syncStatus,@HiveField(9) bool isDeleted
});




}
/// @nodoc
class __$IncomeDtoCopyWithImpl<$Res>
    implements _$IncomeDtoCopyWith<$Res> {
  __$IncomeDtoCopyWithImpl(this._self, this._then);

  final _IncomeDto _self;
  final $Res Function(_IncomeDto) _then;

/// Create a copy of IncomeDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? accountId = null,Object? amount = null,Object? source = null,Object? description = null,Object? createdAt = null,Object? updatedAt = null,Object? syncStatus = null,Object? isDeleted = null,}) {
  return _then(_IncomeDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as IncomeSource,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SyncStatus,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
