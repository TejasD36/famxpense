// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transfer_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TransferDto implements DiagnosticableTreeMixin {

@HiveField(0) String get id;@HiveField(1) String get fromAccountId;@HiveField(2) String get toAccountId;@HiveField(3) String get fromUserId;@HiveField(4) String get toUserId;@HiveField(5) double get amount;@HiveField(6) String get description;@HiveField(7) DateTime get createdAt;@HiveField(8) DateTime get updatedAt;@HiveField(9) SyncStatus get syncStatus;
/// Create a copy of TransferDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransferDtoCopyWith<TransferDto> get copyWith => _$TransferDtoCopyWithImpl<TransferDto>(this as TransferDto, _$identity);

  /// Serializes this TransferDto to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'TransferDto'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('fromAccountId', fromAccountId))..add(DiagnosticsProperty('toAccountId', toAccountId))..add(DiagnosticsProperty('fromUserId', fromUserId))..add(DiagnosticsProperty('toUserId', toUserId))..add(DiagnosticsProperty('amount', amount))..add(DiagnosticsProperty('description', description))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('updatedAt', updatedAt))..add(DiagnosticsProperty('syncStatus', syncStatus));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransferDto&&(identical(other.id, id) || other.id == id)&&(identical(other.fromAccountId, fromAccountId) || other.fromAccountId == fromAccountId)&&(identical(other.toAccountId, toAccountId) || other.toAccountId == toAccountId)&&(identical(other.fromUserId, fromUserId) || other.fromUserId == fromUserId)&&(identical(other.toUserId, toUserId) || other.toUserId == toUserId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fromAccountId,toAccountId,fromUserId,toUserId,amount,description,createdAt,updatedAt,syncStatus);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'TransferDto(id: $id, fromAccountId: $fromAccountId, toAccountId: $toAccountId, fromUserId: $fromUserId, toUserId: $toUserId, amount: $amount, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, syncStatus: $syncStatus)';
}


}

/// @nodoc
abstract mixin class $TransferDtoCopyWith<$Res>  {
  factory $TransferDtoCopyWith(TransferDto value, $Res Function(TransferDto) _then) = _$TransferDtoCopyWithImpl;
@useResult
$Res call({
@HiveField(0) String id,@HiveField(1) String fromAccountId,@HiveField(2) String toAccountId,@HiveField(3) String fromUserId,@HiveField(4) String toUserId,@HiveField(5) double amount,@HiveField(6) String description,@HiveField(7) DateTime createdAt,@HiveField(8) DateTime updatedAt,@HiveField(9) SyncStatus syncStatus
});




}
/// @nodoc
class _$TransferDtoCopyWithImpl<$Res>
    implements $TransferDtoCopyWith<$Res> {
  _$TransferDtoCopyWithImpl(this._self, this._then);

  final TransferDto _self;
  final $Res Function(TransferDto) _then;

/// Create a copy of TransferDto
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


/// Adds pattern-matching-related methods to [TransferDto].
extension TransferDtoPatterns on TransferDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransferDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransferDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransferDto value)  $default,){
final _that = this;
switch (_that) {
case _TransferDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransferDto value)?  $default,){
final _that = this;
switch (_that) {
case _TransferDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  String id, @HiveField(1)  String fromAccountId, @HiveField(2)  String toAccountId, @HiveField(3)  String fromUserId, @HiveField(4)  String toUserId, @HiveField(5)  double amount, @HiveField(6)  String description, @HiveField(7)  DateTime createdAt, @HiveField(8)  DateTime updatedAt, @HiveField(9)  SyncStatus syncStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransferDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  String id, @HiveField(1)  String fromAccountId, @HiveField(2)  String toAccountId, @HiveField(3)  String fromUserId, @HiveField(4)  String toUserId, @HiveField(5)  double amount, @HiveField(6)  String description, @HiveField(7)  DateTime createdAt, @HiveField(8)  DateTime updatedAt, @HiveField(9)  SyncStatus syncStatus)  $default,) {final _that = this;
switch (_that) {
case _TransferDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  String id, @HiveField(1)  String fromAccountId, @HiveField(2)  String toAccountId, @HiveField(3)  String fromUserId, @HiveField(4)  String toUserId, @HiveField(5)  double amount, @HiveField(6)  String description, @HiveField(7)  DateTime createdAt, @HiveField(8)  DateTime updatedAt, @HiveField(9)  SyncStatus syncStatus)?  $default,) {final _that = this;
switch (_that) {
case _TransferDto() when $default != null:
return $default(_that.id,_that.fromAccountId,_that.toAccountId,_that.fromUserId,_that.toUserId,_that.amount,_that.description,_that.createdAt,_that.updatedAt,_that.syncStatus);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TransferDto with DiagnosticableTreeMixin implements TransferDto {
  const _TransferDto({@HiveField(0) required this.id, @HiveField(1) required this.fromAccountId, @HiveField(2) required this.toAccountId, @HiveField(3) required this.fromUserId, @HiveField(4) required this.toUserId, @HiveField(5) required this.amount, @HiveField(6) required this.description, @HiveField(7) required this.createdAt, @HiveField(8) required this.updatedAt, @HiveField(9) this.syncStatus = SyncStatus.synced});
  factory _TransferDto.fromJson(Map<String, dynamic> json) => _$TransferDtoFromJson(json);

@override@HiveField(0) final  String id;
@override@HiveField(1) final  String fromAccountId;
@override@HiveField(2) final  String toAccountId;
@override@HiveField(3) final  String fromUserId;
@override@HiveField(4) final  String toUserId;
@override@HiveField(5) final  double amount;
@override@HiveField(6) final  String description;
@override@HiveField(7) final  DateTime createdAt;
@override@HiveField(8) final  DateTime updatedAt;
@override@JsonKey()@HiveField(9) final  SyncStatus syncStatus;

/// Create a copy of TransferDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransferDtoCopyWith<_TransferDto> get copyWith => __$TransferDtoCopyWithImpl<_TransferDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransferDtoToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'TransferDto'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('fromAccountId', fromAccountId))..add(DiagnosticsProperty('toAccountId', toAccountId))..add(DiagnosticsProperty('fromUserId', fromUserId))..add(DiagnosticsProperty('toUserId', toUserId))..add(DiagnosticsProperty('amount', amount))..add(DiagnosticsProperty('description', description))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('updatedAt', updatedAt))..add(DiagnosticsProperty('syncStatus', syncStatus));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransferDto&&(identical(other.id, id) || other.id == id)&&(identical(other.fromAccountId, fromAccountId) || other.fromAccountId == fromAccountId)&&(identical(other.toAccountId, toAccountId) || other.toAccountId == toAccountId)&&(identical(other.fromUserId, fromUserId) || other.fromUserId == fromUserId)&&(identical(other.toUserId, toUserId) || other.toUserId == toUserId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fromAccountId,toAccountId,fromUserId,toUserId,amount,description,createdAt,updatedAt,syncStatus);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'TransferDto(id: $id, fromAccountId: $fromAccountId, toAccountId: $toAccountId, fromUserId: $fromUserId, toUserId: $toUserId, amount: $amount, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, syncStatus: $syncStatus)';
}


}

/// @nodoc
abstract mixin class _$TransferDtoCopyWith<$Res> implements $TransferDtoCopyWith<$Res> {
  factory _$TransferDtoCopyWith(_TransferDto value, $Res Function(_TransferDto) _then) = __$TransferDtoCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) String id,@HiveField(1) String fromAccountId,@HiveField(2) String toAccountId,@HiveField(3) String fromUserId,@HiveField(4) String toUserId,@HiveField(5) double amount,@HiveField(6) String description,@HiveField(7) DateTime createdAt,@HiveField(8) DateTime updatedAt,@HiveField(9) SyncStatus syncStatus
});




}
/// @nodoc
class __$TransferDtoCopyWithImpl<$Res>
    implements _$TransferDtoCopyWith<$Res> {
  __$TransferDtoCopyWithImpl(this._self, this._then);

  final _TransferDto _self;
  final $Res Function(_TransferDto) _then;

/// Create a copy of TransferDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fromAccountId = null,Object? toAccountId = null,Object? fromUserId = null,Object? toUserId = null,Object? amount = null,Object? description = null,Object? createdAt = null,Object? updatedAt = null,Object? syncStatus = null,}) {
  return _then(_TransferDto(
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
