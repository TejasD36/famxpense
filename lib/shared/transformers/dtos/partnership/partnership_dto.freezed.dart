// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'partnership_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PartnershipDto implements DiagnosticableTreeMixin {

@HiveField(0) String get id;@HiveField(1) String get userA;@HiveField(2) String get userB;@HiveField(3) DateTime get createdAt;@HiveField(4) bool get isAccepted;
/// Create a copy of PartnershipDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PartnershipDtoCopyWith<PartnershipDto> get copyWith => _$PartnershipDtoCopyWithImpl<PartnershipDto>(this as PartnershipDto, _$identity);

  /// Serializes this PartnershipDto to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'PartnershipDto'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('userA', userA))..add(DiagnosticsProperty('userB', userB))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('isAccepted', isAccepted));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PartnershipDto&&(identical(other.id, id) || other.id == id)&&(identical(other.userA, userA) || other.userA == userA)&&(identical(other.userB, userB) || other.userB == userB)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isAccepted, isAccepted) || other.isAccepted == isAccepted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userA,userB,createdAt,isAccepted);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PartnershipDto(id: $id, userA: $userA, userB: $userB, createdAt: $createdAt, isAccepted: $isAccepted)';
}


}

/// @nodoc
abstract mixin class $PartnershipDtoCopyWith<$Res>  {
  factory $PartnershipDtoCopyWith(PartnershipDto value, $Res Function(PartnershipDto) _then) = _$PartnershipDtoCopyWithImpl;
@useResult
$Res call({
@HiveField(0) String id,@HiveField(1) String userA,@HiveField(2) String userB,@HiveField(3) DateTime createdAt,@HiveField(4) bool isAccepted
});




}
/// @nodoc
class _$PartnershipDtoCopyWithImpl<$Res>
    implements $PartnershipDtoCopyWith<$Res> {
  _$PartnershipDtoCopyWithImpl(this._self, this._then);

  final PartnershipDto _self;
  final $Res Function(PartnershipDto) _then;

/// Create a copy of PartnershipDto
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


/// Adds pattern-matching-related methods to [PartnershipDto].
extension PartnershipDtoPatterns on PartnershipDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PartnershipDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PartnershipDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PartnershipDto value)  $default,){
final _that = this;
switch (_that) {
case _PartnershipDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PartnershipDto value)?  $default,){
final _that = this;
switch (_that) {
case _PartnershipDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  String id, @HiveField(1)  String userA, @HiveField(2)  String userB, @HiveField(3)  DateTime createdAt, @HiveField(4)  bool isAccepted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PartnershipDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  String id, @HiveField(1)  String userA, @HiveField(2)  String userB, @HiveField(3)  DateTime createdAt, @HiveField(4)  bool isAccepted)  $default,) {final _that = this;
switch (_that) {
case _PartnershipDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  String id, @HiveField(1)  String userA, @HiveField(2)  String userB, @HiveField(3)  DateTime createdAt, @HiveField(4)  bool isAccepted)?  $default,) {final _that = this;
switch (_that) {
case _PartnershipDto() when $default != null:
return $default(_that.id,_that.userA,_that.userB,_that.createdAt,_that.isAccepted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PartnershipDto with DiagnosticableTreeMixin implements PartnershipDto {
  const _PartnershipDto({@HiveField(0) required this.id, @HiveField(1) required this.userA, @HiveField(2) required this.userB, @HiveField(3) required this.createdAt, @HiveField(4) this.isAccepted = false});
  factory _PartnershipDto.fromJson(Map<String, dynamic> json) => _$PartnershipDtoFromJson(json);

@override@HiveField(0) final  String id;
@override@HiveField(1) final  String userA;
@override@HiveField(2) final  String userB;
@override@HiveField(3) final  DateTime createdAt;
@override@JsonKey()@HiveField(4) final  bool isAccepted;

/// Create a copy of PartnershipDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PartnershipDtoCopyWith<_PartnershipDto> get copyWith => __$PartnershipDtoCopyWithImpl<_PartnershipDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PartnershipDtoToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'PartnershipDto'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('userA', userA))..add(DiagnosticsProperty('userB', userB))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('isAccepted', isAccepted));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PartnershipDto&&(identical(other.id, id) || other.id == id)&&(identical(other.userA, userA) || other.userA == userA)&&(identical(other.userB, userB) || other.userB == userB)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isAccepted, isAccepted) || other.isAccepted == isAccepted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userA,userB,createdAt,isAccepted);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PartnershipDto(id: $id, userA: $userA, userB: $userB, createdAt: $createdAt, isAccepted: $isAccepted)';
}


}

/// @nodoc
abstract mixin class _$PartnershipDtoCopyWith<$Res> implements $PartnershipDtoCopyWith<$Res> {
  factory _$PartnershipDtoCopyWith(_PartnershipDto value, $Res Function(_PartnershipDto) _then) = __$PartnershipDtoCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) String id,@HiveField(1) String userA,@HiveField(2) String userB,@HiveField(3) DateTime createdAt,@HiveField(4) bool isAccepted
});




}
/// @nodoc
class __$PartnershipDtoCopyWithImpl<$Res>
    implements _$PartnershipDtoCopyWith<$Res> {
  __$PartnershipDtoCopyWithImpl(this._self, this._then);

  final _PartnershipDto _self;
  final $Res Function(_PartnershipDto) _then;

/// Create a copy of PartnershipDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userA = null,Object? userB = null,Object? createdAt = null,Object? isAccepted = null,}) {
  return _then(_PartnershipDto(
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
