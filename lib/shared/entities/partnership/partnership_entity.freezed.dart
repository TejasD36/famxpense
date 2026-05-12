// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'partnership_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PartnershipEntity implements DiagnosticableTreeMixin {

 String get id; String get userA; String get userB; DateTime get createdAt; bool get isAccepted;
/// Create a copy of PartnershipEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PartnershipEntityCopyWith<PartnershipEntity> get copyWith => _$PartnershipEntityCopyWithImpl<PartnershipEntity>(this as PartnershipEntity, _$identity);

  /// Serializes this PartnershipEntity to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'PartnershipEntity'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('userA', userA))..add(DiagnosticsProperty('userB', userB))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('isAccepted', isAccepted));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PartnershipEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.userA, userA) || other.userA == userA)&&(identical(other.userB, userB) || other.userB == userB)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isAccepted, isAccepted) || other.isAccepted == isAccepted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userA,userB,createdAt,isAccepted);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PartnershipEntity(id: $id, userA: $userA, userB: $userB, createdAt: $createdAt, isAccepted: $isAccepted)';
}


}

/// @nodoc
abstract mixin class $PartnershipEntityCopyWith<$Res>  {
  factory $PartnershipEntityCopyWith(PartnershipEntity value, $Res Function(PartnershipEntity) _then) = _$PartnershipEntityCopyWithImpl;
@useResult
$Res call({
 String id, String userA, String userB, DateTime createdAt, bool isAccepted
});




}
/// @nodoc
class _$PartnershipEntityCopyWithImpl<$Res>
    implements $PartnershipEntityCopyWith<$Res> {
  _$PartnershipEntityCopyWithImpl(this._self, this._then);

  final PartnershipEntity _self;
  final $Res Function(PartnershipEntity) _then;

/// Create a copy of PartnershipEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userA = null,Object? userB = null,Object? createdAt = null,Object? isAccepted = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userA: null == userA ? _self.userA : userA // ignore: cast_nullable_to_non_nullable
as String,userB: null == userB ? _self.userB : userB // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,isAccepted: null == isAccepted ? _self.isAccepted : isAccepted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PartnershipEntity].
extension PartnershipEntityPatterns on PartnershipEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PartnershipEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PartnershipEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PartnershipEntity value)  $default,){
final _that = this;
switch (_that) {
case _PartnershipEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PartnershipEntity value)?  $default,){
final _that = this;
switch (_that) {
case _PartnershipEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userA,  String userB,  DateTime createdAt,  bool isAccepted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PartnershipEntity() when $default != null:
return $default(_that.id,_that.userA,_that.userB,_that.createdAt,_that.isAccepted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userA,  String userB,  DateTime createdAt,  bool isAccepted)  $default,) {final _that = this;
switch (_that) {
case _PartnershipEntity():
return $default(_that.id,_that.userA,_that.userB,_that.createdAt,_that.isAccepted);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userA,  String userB,  DateTime createdAt,  bool isAccepted)?  $default,) {final _that = this;
switch (_that) {
case _PartnershipEntity() when $default != null:
return $default(_that.id,_that.userA,_that.userB,_that.createdAt,_that.isAccepted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PartnershipEntity with DiagnosticableTreeMixin implements PartnershipEntity {
  const _PartnershipEntity({required this.id, required this.userA, required this.userB, required this.createdAt, this.isAccepted = false});
  factory _PartnershipEntity.fromJson(Map<String, dynamic> json) => _$PartnershipEntityFromJson(json);

@override final  String id;
@override final  String userA;
@override final  String userB;
@override final  DateTime createdAt;
@override@JsonKey() final  bool isAccepted;

/// Create a copy of PartnershipEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PartnershipEntityCopyWith<_PartnershipEntity> get copyWith => __$PartnershipEntityCopyWithImpl<_PartnershipEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PartnershipEntityToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'PartnershipEntity'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('userA', userA))..add(DiagnosticsProperty('userB', userB))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('isAccepted', isAccepted));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PartnershipEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.userA, userA) || other.userA == userA)&&(identical(other.userB, userB) || other.userB == userB)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isAccepted, isAccepted) || other.isAccepted == isAccepted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userA,userB,createdAt,isAccepted);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PartnershipEntity(id: $id, userA: $userA, userB: $userB, createdAt: $createdAt, isAccepted: $isAccepted)';
}


}

/// @nodoc
abstract mixin class _$PartnershipEntityCopyWith<$Res> implements $PartnershipEntityCopyWith<$Res> {
  factory _$PartnershipEntityCopyWith(_PartnershipEntity value, $Res Function(_PartnershipEntity) _then) = __$PartnershipEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String userA, String userB, DateTime createdAt, bool isAccepted
});




}
/// @nodoc
class __$PartnershipEntityCopyWithImpl<$Res>
    implements _$PartnershipEntityCopyWith<$Res> {
  __$PartnershipEntityCopyWithImpl(this._self, this._then);

  final _PartnershipEntity _self;
  final $Res Function(_PartnershipEntity) _then;

/// Create a copy of PartnershipEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userA = null,Object? userB = null,Object? createdAt = null,Object? isAccepted = null,}) {
  return _then(_PartnershipEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userA: null == userA ? _self.userA : userA // ignore: cast_nullable_to_non_nullable
as String,userB: null == userB ? _self.userB : userB // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,isAccepted: null == isAccepted ? _self.isAccepted : isAccepted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
