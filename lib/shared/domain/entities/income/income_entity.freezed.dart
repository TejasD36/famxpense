// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'income_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IncomeEntity implements DiagnosticableTreeMixin {

 String get id; String get userId; String get accountId; double get amount; IncomeSource get source; String get description; DateTime get createdAt; DateTime get updatedAt; SyncStatus get syncStatus; bool get isDeleted;
/// Create a copy of IncomeEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IncomeEntityCopyWith<IncomeEntity> get copyWith => _$IncomeEntityCopyWithImpl<IncomeEntity>(this as IncomeEntity, _$identity);

  /// Serializes this IncomeEntity to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'IncomeEntity'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('userId', userId))..add(DiagnosticsProperty('accountId', accountId))..add(DiagnosticsProperty('amount', amount))..add(DiagnosticsProperty('source', source))..add(DiagnosticsProperty('description', description))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('updatedAt', updatedAt))..add(DiagnosticsProperty('syncStatus', syncStatus))..add(DiagnosticsProperty('isDeleted', isDeleted));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IncomeEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.source, source) || other.source == source)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,accountId,amount,source,description,createdAt,updatedAt,syncStatus,isDeleted);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'IncomeEntity(id: $id, userId: $userId, accountId: $accountId, amount: $amount, source: $source, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, syncStatus: $syncStatus, isDeleted: $isDeleted)';
}


}

/// @nodoc
abstract mixin class $IncomeEntityCopyWith<$Res>  {
  factory $IncomeEntityCopyWith(IncomeEntity value, $Res Function(IncomeEntity) _then) = _$IncomeEntityCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String accountId, double amount, IncomeSource source, String description, DateTime createdAt, DateTime updatedAt, SyncStatus syncStatus, bool isDeleted
});




}
/// @nodoc
class _$IncomeEntityCopyWithImpl<$Res>
    implements $IncomeEntityCopyWith<$Res> {
  _$IncomeEntityCopyWithImpl(this._self, this._then);

  final IncomeEntity _self;
  final $Res Function(IncomeEntity) _then;

/// Create a copy of IncomeEntity
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


/// Adds pattern-matching-related methods to [IncomeEntity].
extension IncomeEntityPatterns on IncomeEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IncomeEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IncomeEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IncomeEntity value)  $default,){
final _that = this;
switch (_that) {
case _IncomeEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IncomeEntity value)?  $default,){
final _that = this;
switch (_that) {
case _IncomeEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String accountId,  double amount,  IncomeSource source,  String description,  DateTime createdAt,  DateTime updatedAt,  SyncStatus syncStatus,  bool isDeleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IncomeEntity() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String accountId,  double amount,  IncomeSource source,  String description,  DateTime createdAt,  DateTime updatedAt,  SyncStatus syncStatus,  bool isDeleted)  $default,) {final _that = this;
switch (_that) {
case _IncomeEntity():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String accountId,  double amount,  IncomeSource source,  String description,  DateTime createdAt,  DateTime updatedAt,  SyncStatus syncStatus,  bool isDeleted)?  $default,) {final _that = this;
switch (_that) {
case _IncomeEntity() when $default != null:
return $default(_that.id,_that.userId,_that.accountId,_that.amount,_that.source,_that.description,_that.createdAt,_that.updatedAt,_that.syncStatus,_that.isDeleted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IncomeEntity with DiagnosticableTreeMixin implements IncomeEntity {
  const _IncomeEntity({required this.id, required this.userId, required this.accountId, required this.amount, required this.source, required this.description, required this.createdAt, required this.updatedAt, this.syncStatus = SyncStatus.pending, this.isDeleted = false});
  factory _IncomeEntity.fromJson(Map<String, dynamic> json) => _$IncomeEntityFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String accountId;
@override final  double amount;
@override final  IncomeSource source;
@override final  String description;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override@JsonKey() final  SyncStatus syncStatus;
@override@JsonKey() final  bool isDeleted;

/// Create a copy of IncomeEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IncomeEntityCopyWith<_IncomeEntity> get copyWith => __$IncomeEntityCopyWithImpl<_IncomeEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IncomeEntityToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'IncomeEntity'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('userId', userId))..add(DiagnosticsProperty('accountId', accountId))..add(DiagnosticsProperty('amount', amount))..add(DiagnosticsProperty('source', source))..add(DiagnosticsProperty('description', description))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('updatedAt', updatedAt))..add(DiagnosticsProperty('syncStatus', syncStatus))..add(DiagnosticsProperty('isDeleted', isDeleted));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IncomeEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.source, source) || other.source == source)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,accountId,amount,source,description,createdAt,updatedAt,syncStatus,isDeleted);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'IncomeEntity(id: $id, userId: $userId, accountId: $accountId, amount: $amount, source: $source, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, syncStatus: $syncStatus, isDeleted: $isDeleted)';
}


}

/// @nodoc
abstract mixin class _$IncomeEntityCopyWith<$Res> implements $IncomeEntityCopyWith<$Res> {
  factory _$IncomeEntityCopyWith(_IncomeEntity value, $Res Function(_IncomeEntity) _then) = __$IncomeEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String accountId, double amount, IncomeSource source, String description, DateTime createdAt, DateTime updatedAt, SyncStatus syncStatus, bool isDeleted
});




}
/// @nodoc
class __$IncomeEntityCopyWithImpl<$Res>
    implements _$IncomeEntityCopyWith<$Res> {
  __$IncomeEntityCopyWithImpl(this._self, this._then);

  final _IncomeEntity _self;
  final $Res Function(_IncomeEntity) _then;

/// Create a copy of IncomeEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? accountId = null,Object? amount = null,Object? source = null,Object? description = null,Object? createdAt = null,Object? updatedAt = null,Object? syncStatus = null,Object? isDeleted = null,}) {
  return _then(_IncomeEntity(
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
