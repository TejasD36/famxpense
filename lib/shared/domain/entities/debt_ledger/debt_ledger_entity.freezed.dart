// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'debt_ledger_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DebtLedgerEntity implements DiagnosticableTreeMixin {

 String get id; String get userA; String get userB; double get netBalance; DateTime get updatedAt;
/// Create a copy of DebtLedgerEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DebtLedgerEntityCopyWith<DebtLedgerEntity> get copyWith => _$DebtLedgerEntityCopyWithImpl<DebtLedgerEntity>(this as DebtLedgerEntity, _$identity);

  /// Serializes this DebtLedgerEntity to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'DebtLedgerEntity'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('userA', userA))..add(DiagnosticsProperty('userB', userB))..add(DiagnosticsProperty('netBalance', netBalance))..add(DiagnosticsProperty('updatedAt', updatedAt));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DebtLedgerEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.userA, userA) || other.userA == userA)&&(identical(other.userB, userB) || other.userB == userB)&&(identical(other.netBalance, netBalance) || other.netBalance == netBalance)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userA,userB,netBalance,updatedAt);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'DebtLedgerEntity(id: $id, userA: $userA, userB: $userB, netBalance: $netBalance, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $DebtLedgerEntityCopyWith<$Res>  {
  factory $DebtLedgerEntityCopyWith(DebtLedgerEntity value, $Res Function(DebtLedgerEntity) _then) = _$DebtLedgerEntityCopyWithImpl;
@useResult
$Res call({
 String id, String userA, String userB, double netBalance, DateTime updatedAt
});




}
/// @nodoc
class _$DebtLedgerEntityCopyWithImpl<$Res>
    implements $DebtLedgerEntityCopyWith<$Res> {
  _$DebtLedgerEntityCopyWithImpl(this._self, this._then);

  final DebtLedgerEntity _self;
  final $Res Function(DebtLedgerEntity) _then;

/// Create a copy of DebtLedgerEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userA = null,Object? userB = null,Object? netBalance = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userA: null == userA ? _self.userA : userA // ignore: cast_nullable_to_non_nullable
as String,userB: null == userB ? _self.userB : userB // ignore: cast_nullable_to_non_nullable
as String,netBalance: null == netBalance ? _self.netBalance : netBalance // ignore: cast_nullable_to_non_nullable
as double,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [DebtLedgerEntity].
extension DebtLedgerEntityPatterns on DebtLedgerEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DebtLedgerEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DebtLedgerEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DebtLedgerEntity value)  $default,){
final _that = this;
switch (_that) {
case _DebtLedgerEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DebtLedgerEntity value)?  $default,){
final _that = this;
switch (_that) {
case _DebtLedgerEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userA,  String userB,  double netBalance,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DebtLedgerEntity() when $default != null:
return $default(_that.id,_that.userA,_that.userB,_that.netBalance,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userA,  String userB,  double netBalance,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _DebtLedgerEntity():
return $default(_that.id,_that.userA,_that.userB,_that.netBalance,_that.updatedAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userA,  String userB,  double netBalance,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _DebtLedgerEntity() when $default != null:
return $default(_that.id,_that.userA,_that.userB,_that.netBalance,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DebtLedgerEntity with DiagnosticableTreeMixin implements DebtLedgerEntity {
  const _DebtLedgerEntity({required this.id, required this.userA, required this.userB, required this.netBalance, required this.updatedAt});
  factory _DebtLedgerEntity.fromJson(Map<String, dynamic> json) => _$DebtLedgerEntityFromJson(json);

@override final  String id;
@override final  String userA;
@override final  String userB;
@override final  double netBalance;
@override final  DateTime updatedAt;

/// Create a copy of DebtLedgerEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DebtLedgerEntityCopyWith<_DebtLedgerEntity> get copyWith => __$DebtLedgerEntityCopyWithImpl<_DebtLedgerEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DebtLedgerEntityToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'DebtLedgerEntity'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('userA', userA))..add(DiagnosticsProperty('userB', userB))..add(DiagnosticsProperty('netBalance', netBalance))..add(DiagnosticsProperty('updatedAt', updatedAt));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DebtLedgerEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.userA, userA) || other.userA == userA)&&(identical(other.userB, userB) || other.userB == userB)&&(identical(other.netBalance, netBalance) || other.netBalance == netBalance)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userA,userB,netBalance,updatedAt);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'DebtLedgerEntity(id: $id, userA: $userA, userB: $userB, netBalance: $netBalance, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$DebtLedgerEntityCopyWith<$Res> implements $DebtLedgerEntityCopyWith<$Res> {
  factory _$DebtLedgerEntityCopyWith(_DebtLedgerEntity value, $Res Function(_DebtLedgerEntity) _then) = __$DebtLedgerEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String userA, String userB, double netBalance, DateTime updatedAt
});




}
/// @nodoc
class __$DebtLedgerEntityCopyWithImpl<$Res>
    implements _$DebtLedgerEntityCopyWith<$Res> {
  __$DebtLedgerEntityCopyWithImpl(this._self, this._then);

  final _DebtLedgerEntity _self;
  final $Res Function(_DebtLedgerEntity) _then;

/// Create a copy of DebtLedgerEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userA = null,Object? userB = null,Object? netBalance = null,Object? updatedAt = null,}) {
  return _then(_DebtLedgerEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userA: null == userA ? _self.userA : userA // ignore: cast_nullable_to_non_nullable
as String,userB: null == userB ? _self.userB : userB // ignore: cast_nullable_to_non_nullable
as String,netBalance: null == netBalance ? _self.netBalance : netBalance // ignore: cast_nullable_to_non_nullable
as double,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
