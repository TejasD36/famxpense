// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transfer_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TransferEntity implements DiagnosticableTreeMixin {

 String get id; String get fromAccountId; String get toAccountId; String get fromUserId; String get toUserId; double get amount; String get description; DateTime get createdAt; DateTime get updatedAt; SyncStatus get syncStatus;
/// Create a copy of TransferEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransferEntityCopyWith<TransferEntity> get copyWith => _$TransferEntityCopyWithImpl<TransferEntity>(this as TransferEntity, _$identity);

  /// Serializes this TransferEntity to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'TransferEntity'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('fromAccountId', fromAccountId))..add(DiagnosticsProperty('toAccountId', toAccountId))..add(DiagnosticsProperty('fromUserId', fromUserId))..add(DiagnosticsProperty('toUserId', toUserId))..add(DiagnosticsProperty('amount', amount))..add(DiagnosticsProperty('description', description))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('updatedAt', updatedAt))..add(DiagnosticsProperty('syncStatus', syncStatus));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransferEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.fromAccountId, fromAccountId) || other.fromAccountId == fromAccountId)&&(identical(other.toAccountId, toAccountId) || other.toAccountId == toAccountId)&&(identical(other.fromUserId, fromUserId) || other.fromUserId == fromUserId)&&(identical(other.toUserId, toUserId) || other.toUserId == toUserId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fromAccountId,toAccountId,fromUserId,toUserId,amount,description,createdAt,updatedAt,syncStatus);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'TransferEntity(id: $id, fromAccountId: $fromAccountId, toAccountId: $toAccountId, fromUserId: $fromUserId, toUserId: $toUserId, amount: $amount, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, syncStatus: $syncStatus)';
}


}

/// @nodoc
abstract mixin class $TransferEntityCopyWith<$Res>  {
  factory $TransferEntityCopyWith(TransferEntity value, $Res Function(TransferEntity) _then) = _$TransferEntityCopyWithImpl;
@useResult
$Res call({
 String id, String fromAccountId, String toAccountId, String fromUserId, String toUserId, double amount, String description, DateTime createdAt, DateTime updatedAt, SyncStatus syncStatus
});




}
/// @nodoc
class _$TransferEntityCopyWithImpl<$Res>
    implements $TransferEntityCopyWith<$Res> {
  _$TransferEntityCopyWithImpl(this._self, this._then);

  final TransferEntity _self;
  final $Res Function(TransferEntity) _then;

/// Create a copy of TransferEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fromAccountId = null,Object? toAccountId = null,Object? fromUserId = null,Object? toUserId = null,Object? amount = null,Object? description = null,Object? createdAt = null,Object? updatedAt = null,Object? syncStatus = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fromAccountId: null == fromAccountId ? _self.fromAccountId : fromAccountId // ignore: cast_nullable_to_non_nullable
as String,toAccountId: null == toAccountId ? _self.toAccountId : toAccountId // ignore: cast_nullable_to_non_nullable
as String,fromUserId: null == fromUserId ? _self.fromUserId : fromUserId // ignore: cast_nullable_to_non_nullable
as String,toUserId: null == toUserId ? _self.toUserId : toUserId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SyncStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [TransferEntity].
extension TransferEntityPatterns on TransferEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransferEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransferEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransferEntity value)  $default,){
final _that = this;
switch (_that) {
case _TransferEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransferEntity value)?  $default,){
final _that = this;
switch (_that) {
case _TransferEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String fromAccountId,  String toAccountId,  String fromUserId,  String toUserId,  double amount,  String description,  DateTime createdAt,  DateTime updatedAt,  SyncStatus syncStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransferEntity() when $default != null:
return $default(_that.id,_that.fromAccountId,_that.toAccountId,_that.fromUserId,_that.toUserId,_that.amount,_that.description,_that.createdAt,_that.updatedAt,_that.syncStatus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String fromAccountId,  String toAccountId,  String fromUserId,  String toUserId,  double amount,  String description,  DateTime createdAt,  DateTime updatedAt,  SyncStatus syncStatus)  $default,) {final _that = this;
switch (_that) {
case _TransferEntity():
return $default(_that.id,_that.fromAccountId,_that.toAccountId,_that.fromUserId,_that.toUserId,_that.amount,_that.description,_that.createdAt,_that.updatedAt,_that.syncStatus);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String fromAccountId,  String toAccountId,  String fromUserId,  String toUserId,  double amount,  String description,  DateTime createdAt,  DateTime updatedAt,  SyncStatus syncStatus)?  $default,) {final _that = this;
switch (_that) {
case _TransferEntity() when $default != null:
return $default(_that.id,_that.fromAccountId,_that.toAccountId,_that.fromUserId,_that.toUserId,_that.amount,_that.description,_that.createdAt,_that.updatedAt,_that.syncStatus);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TransferEntity with DiagnosticableTreeMixin implements TransferEntity {
  const _TransferEntity({required this.id, required this.fromAccountId, required this.toAccountId, required this.fromUserId, required this.toUserId, required this.amount, required this.description, required this.createdAt, required this.updatedAt, this.syncStatus = SyncStatus.synced});
  factory _TransferEntity.fromJson(Map<String, dynamic> json) => _$TransferEntityFromJson(json);

@override final  String id;
@override final  String fromAccountId;
@override final  String toAccountId;
@override final  String fromUserId;
@override final  String toUserId;
@override final  double amount;
@override final  String description;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override@JsonKey() final  SyncStatus syncStatus;

/// Create a copy of TransferEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransferEntityCopyWith<_TransferEntity> get copyWith => __$TransferEntityCopyWithImpl<_TransferEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransferEntityToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'TransferEntity'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('fromAccountId', fromAccountId))..add(DiagnosticsProperty('toAccountId', toAccountId))..add(DiagnosticsProperty('fromUserId', fromUserId))..add(DiagnosticsProperty('toUserId', toUserId))..add(DiagnosticsProperty('amount', amount))..add(DiagnosticsProperty('description', description))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('updatedAt', updatedAt))..add(DiagnosticsProperty('syncStatus', syncStatus));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransferEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.fromAccountId, fromAccountId) || other.fromAccountId == fromAccountId)&&(identical(other.toAccountId, toAccountId) || other.toAccountId == toAccountId)&&(identical(other.fromUserId, fromUserId) || other.fromUserId == fromUserId)&&(identical(other.toUserId, toUserId) || other.toUserId == toUserId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fromAccountId,toAccountId,fromUserId,toUserId,amount,description,createdAt,updatedAt,syncStatus);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'TransferEntity(id: $id, fromAccountId: $fromAccountId, toAccountId: $toAccountId, fromUserId: $fromUserId, toUserId: $toUserId, amount: $amount, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, syncStatus: $syncStatus)';
}


}

/// @nodoc
abstract mixin class _$TransferEntityCopyWith<$Res> implements $TransferEntityCopyWith<$Res> {
  factory _$TransferEntityCopyWith(_TransferEntity value, $Res Function(_TransferEntity) _then) = __$TransferEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String fromAccountId, String toAccountId, String fromUserId, String toUserId, double amount, String description, DateTime createdAt, DateTime updatedAt, SyncStatus syncStatus
});




}
/// @nodoc
class __$TransferEntityCopyWithImpl<$Res>
    implements _$TransferEntityCopyWith<$Res> {
  __$TransferEntityCopyWithImpl(this._self, this._then);

  final _TransferEntity _self;
  final $Res Function(_TransferEntity) _then;

/// Create a copy of TransferEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fromAccountId = null,Object? toAccountId = null,Object? fromUserId = null,Object? toUserId = null,Object? amount = null,Object? description = null,Object? createdAt = null,Object? updatedAt = null,Object? syncStatus = null,}) {
  return _then(_TransferEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fromAccountId: null == fromAccountId ? _self.fromAccountId : fromAccountId // ignore: cast_nullable_to_non_nullable
as String,toAccountId: null == toAccountId ? _self.toAccountId : toAccountId // ignore: cast_nullable_to_non_nullable
as String,fromUserId: null == fromUserId ? _self.fromUserId : fromUserId // ignore: cast_nullable_to_non_nullable
as String,toUserId: null == toUserId ? _self.toUserId : toUserId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SyncStatus,
  ));
}


}

// dart format on
