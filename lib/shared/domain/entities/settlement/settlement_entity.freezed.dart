// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settlement_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SettlementEntity implements DiagnosticableTreeMixin {

 String get id; String get fromUserId; String get toUserId; double get amount; SettlementStatus get status; DateTime get createdAt; DateTime? get confirmedAt; List<String>? get relatedExpenseIds;
/// Create a copy of SettlementEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettlementEntityCopyWith<SettlementEntity> get copyWith => _$SettlementEntityCopyWithImpl<SettlementEntity>(this as SettlementEntity, _$identity);

  /// Serializes this SettlementEntity to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'SettlementEntity'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('fromUserId', fromUserId))..add(DiagnosticsProperty('toUserId', toUserId))..add(DiagnosticsProperty('amount', amount))..add(DiagnosticsProperty('status', status))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('confirmedAt', confirmedAt))..add(DiagnosticsProperty('relatedExpenseIds', relatedExpenseIds));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettlementEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.fromUserId, fromUserId) || other.fromUserId == fromUserId)&&(identical(other.toUserId, toUserId) || other.toUserId == toUserId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.confirmedAt, confirmedAt) || other.confirmedAt == confirmedAt)&&const DeepCollectionEquality().equals(other.relatedExpenseIds, relatedExpenseIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fromUserId,toUserId,amount,status,createdAt,confirmedAt,const DeepCollectionEquality().hash(relatedExpenseIds));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'SettlementEntity(id: $id, fromUserId: $fromUserId, toUserId: $toUserId, amount: $amount, status: $status, createdAt: $createdAt, confirmedAt: $confirmedAt, relatedExpenseIds: $relatedExpenseIds)';
}


}

/// @nodoc
abstract mixin class $SettlementEntityCopyWith<$Res>  {
  factory $SettlementEntityCopyWith(SettlementEntity value, $Res Function(SettlementEntity) _then) = _$SettlementEntityCopyWithImpl;
@useResult
$Res call({
 String id, String fromUserId, String toUserId, double amount, SettlementStatus status, DateTime createdAt, DateTime? confirmedAt, List<String>? relatedExpenseIds
});




}
/// @nodoc
class _$SettlementEntityCopyWithImpl<$Res>
    implements $SettlementEntityCopyWith<$Res> {
  _$SettlementEntityCopyWithImpl(this._self, this._then);

  final SettlementEntity _self;
  final $Res Function(SettlementEntity) _then;

/// Create a copy of SettlementEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fromUserId = null,Object? toUserId = null,Object? amount = null,Object? status = null,Object? createdAt = null,Object? confirmedAt = freezed,Object? relatedExpenseIds = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fromUserId: null == fromUserId ? _self.fromUserId : fromUserId // ignore: cast_nullable_to_non_nullable
as String,toUserId: null == toUserId ? _self.toUserId : toUserId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SettlementStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,confirmedAt: freezed == confirmedAt ? _self.confirmedAt : confirmedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,relatedExpenseIds: freezed == relatedExpenseIds ? _self.relatedExpenseIds : relatedExpenseIds // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [SettlementEntity].
extension SettlementEntityPatterns on SettlementEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SettlementEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SettlementEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SettlementEntity value)  $default,){
final _that = this;
switch (_that) {
case _SettlementEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SettlementEntity value)?  $default,){
final _that = this;
switch (_that) {
case _SettlementEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String fromUserId,  String toUserId,  double amount,  SettlementStatus status,  DateTime createdAt,  DateTime? confirmedAt,  List<String>? relatedExpenseIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettlementEntity() when $default != null:
return $default(_that.id,_that.fromUserId,_that.toUserId,_that.amount,_that.status,_that.createdAt,_that.confirmedAt,_that.relatedExpenseIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String fromUserId,  String toUserId,  double amount,  SettlementStatus status,  DateTime createdAt,  DateTime? confirmedAt,  List<String>? relatedExpenseIds)  $default,) {final _that = this;
switch (_that) {
case _SettlementEntity():
return $default(_that.id,_that.fromUserId,_that.toUserId,_that.amount,_that.status,_that.createdAt,_that.confirmedAt,_that.relatedExpenseIds);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String fromUserId,  String toUserId,  double amount,  SettlementStatus status,  DateTime createdAt,  DateTime? confirmedAt,  List<String>? relatedExpenseIds)?  $default,) {final _that = this;
switch (_that) {
case _SettlementEntity() when $default != null:
return $default(_that.id,_that.fromUserId,_that.toUserId,_that.amount,_that.status,_that.createdAt,_that.confirmedAt,_that.relatedExpenseIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SettlementEntity with DiagnosticableTreeMixin implements SettlementEntity {
  const _SettlementEntity({required this.id, required this.fromUserId, required this.toUserId, required this.amount, required this.status, required this.createdAt, this.confirmedAt, final  List<String>? relatedExpenseIds}): _relatedExpenseIds = relatedExpenseIds;
  factory _SettlementEntity.fromJson(Map<String, dynamic> json) => _$SettlementEntityFromJson(json);

@override final  String id;
@override final  String fromUserId;
@override final  String toUserId;
@override final  double amount;
@override final  SettlementStatus status;
@override final  DateTime createdAt;
@override final  DateTime? confirmedAt;
 final  List<String>? _relatedExpenseIds;
@override List<String>? get relatedExpenseIds {
  final value = _relatedExpenseIds;
  if (value == null) return null;
  if (_relatedExpenseIds is EqualUnmodifiableListView) return _relatedExpenseIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of SettlementEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettlementEntityCopyWith<_SettlementEntity> get copyWith => __$SettlementEntityCopyWithImpl<_SettlementEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SettlementEntityToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'SettlementEntity'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('fromUserId', fromUserId))..add(DiagnosticsProperty('toUserId', toUserId))..add(DiagnosticsProperty('amount', amount))..add(DiagnosticsProperty('status', status))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('confirmedAt', confirmedAt))..add(DiagnosticsProperty('relatedExpenseIds', relatedExpenseIds));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettlementEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.fromUserId, fromUserId) || other.fromUserId == fromUserId)&&(identical(other.toUserId, toUserId) || other.toUserId == toUserId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.confirmedAt, confirmedAt) || other.confirmedAt == confirmedAt)&&const DeepCollectionEquality().equals(other._relatedExpenseIds, _relatedExpenseIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fromUserId,toUserId,amount,status,createdAt,confirmedAt,const DeepCollectionEquality().hash(_relatedExpenseIds));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'SettlementEntity(id: $id, fromUserId: $fromUserId, toUserId: $toUserId, amount: $amount, status: $status, createdAt: $createdAt, confirmedAt: $confirmedAt, relatedExpenseIds: $relatedExpenseIds)';
}


}

/// @nodoc
abstract mixin class _$SettlementEntityCopyWith<$Res> implements $SettlementEntityCopyWith<$Res> {
  factory _$SettlementEntityCopyWith(_SettlementEntity value, $Res Function(_SettlementEntity) _then) = __$SettlementEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String fromUserId, String toUserId, double amount, SettlementStatus status, DateTime createdAt, DateTime? confirmedAt, List<String>? relatedExpenseIds
});




}
/// @nodoc
class __$SettlementEntityCopyWithImpl<$Res>
    implements _$SettlementEntityCopyWith<$Res> {
  __$SettlementEntityCopyWithImpl(this._self, this._then);

  final _SettlementEntity _self;
  final $Res Function(_SettlementEntity) _then;

/// Create a copy of SettlementEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fromUserId = null,Object? toUserId = null,Object? amount = null,Object? status = null,Object? createdAt = null,Object? confirmedAt = freezed,Object? relatedExpenseIds = freezed,}) {
  return _then(_SettlementEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fromUserId: null == fromUserId ? _self.fromUserId : fromUserId // ignore: cast_nullable_to_non_nullable
as String,toUserId: null == toUserId ? _self.toUserId : toUserId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SettlementStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,confirmedAt: freezed == confirmedAt ? _self.confirmedAt : confirmedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,relatedExpenseIds: freezed == relatedExpenseIds ? _self._relatedExpenseIds : relatedExpenseIds // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}

// dart format on
