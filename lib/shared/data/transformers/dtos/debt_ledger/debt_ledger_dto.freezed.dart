// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'debt_ledger_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DebtLedgerDto implements DiagnosticableTreeMixin {

@HiveField(0) String get id;@HiveField(1) String get userA;@HiveField(2) String get userB;@HiveField(3) double get netBalance;@HiveField(4) DateTime get updatedAt;@HiveField(5) Map<String, double> get pendingMutations;@HiveField(6) List<String> get appliedMutationIds;
/// Create a copy of DebtLedgerDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DebtLedgerDtoCopyWith<DebtLedgerDto> get copyWith => _$DebtLedgerDtoCopyWithImpl<DebtLedgerDto>(this as DebtLedgerDto, _$identity);

  /// Serializes this DebtLedgerDto to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'DebtLedgerDto'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('userA', userA))..add(DiagnosticsProperty('userB', userB))..add(DiagnosticsProperty('netBalance', netBalance))..add(DiagnosticsProperty('updatedAt', updatedAt))..add(DiagnosticsProperty('pendingMutations', pendingMutations))..add(DiagnosticsProperty('appliedMutationIds', appliedMutationIds));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DebtLedgerDto&&(identical(other.id, id) || other.id == id)&&(identical(other.userA, userA) || other.userA == userA)&&(identical(other.userB, userB) || other.userB == userB)&&(identical(other.netBalance, netBalance) || other.netBalance == netBalance)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.pendingMutations, pendingMutations)&&const DeepCollectionEquality().equals(other.appliedMutationIds, appliedMutationIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userA,userB,netBalance,updatedAt,const DeepCollectionEquality().hash(pendingMutations),const DeepCollectionEquality().hash(appliedMutationIds));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'DebtLedgerDto(id: $id, userA: $userA, userB: $userB, netBalance: $netBalance, updatedAt: $updatedAt, pendingMutations: $pendingMutations, appliedMutationIds: $appliedMutationIds)';
}


}

/// @nodoc
abstract mixin class $DebtLedgerDtoCopyWith<$Res>  {
  factory $DebtLedgerDtoCopyWith(DebtLedgerDto value, $Res Function(DebtLedgerDto) _then) = _$DebtLedgerDtoCopyWithImpl;
@useResult
$Res call({
@HiveField(0) String id,@HiveField(1) String userA,@HiveField(2) String userB,@HiveField(3) double netBalance,@HiveField(4) DateTime updatedAt,@HiveField(5) Map<String, double> pendingMutations,@HiveField(6) List<String> appliedMutationIds
});




}
/// @nodoc
class _$DebtLedgerDtoCopyWithImpl<$Res>
    implements $DebtLedgerDtoCopyWith<$Res> {
  _$DebtLedgerDtoCopyWithImpl(this._self, this._then);

  final DebtLedgerDto _self;
  final $Res Function(DebtLedgerDto) _then;

/// Create a copy of DebtLedgerDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userA = null,Object? userB = null,Object? netBalance = null,Object? updatedAt = null,Object? pendingMutations = null,Object? appliedMutationIds = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userA: null == userA ? _self.userA : userA // ignore: cast_nullable_to_non_nullable
as String,userB: null == userB ? _self.userB : userB // ignore: cast_nullable_to_non_nullable
as String,netBalance: null == netBalance ? _self.netBalance : netBalance // ignore: cast_nullable_to_non_nullable
as double,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,pendingMutations: null == pendingMutations ? _self.pendingMutations : pendingMutations // ignore: cast_nullable_to_non_nullable
as Map<String, double>,appliedMutationIds: null == appliedMutationIds ? _self.appliedMutationIds : appliedMutationIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [DebtLedgerDto].
extension DebtLedgerDtoPatterns on DebtLedgerDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DebtLedgerDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DebtLedgerDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DebtLedgerDto value)  $default,){
final _that = this;
switch (_that) {
case _DebtLedgerDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DebtLedgerDto value)?  $default,){
final _that = this;
switch (_that) {
case _DebtLedgerDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  String id, @HiveField(1)  String userA, @HiveField(2)  String userB, @HiveField(3)  double netBalance, @HiveField(4)  DateTime updatedAt, @HiveField(5)  Map<String, double> pendingMutations, @HiveField(6)  List<String> appliedMutationIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DebtLedgerDto() when $default != null:
return $default(_that.id,_that.userA,_that.userB,_that.netBalance,_that.updatedAt,_that.pendingMutations,_that.appliedMutationIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  String id, @HiveField(1)  String userA, @HiveField(2)  String userB, @HiveField(3)  double netBalance, @HiveField(4)  DateTime updatedAt, @HiveField(5)  Map<String, double> pendingMutations, @HiveField(6)  List<String> appliedMutationIds)  $default,) {final _that = this;
switch (_that) {
case _DebtLedgerDto():
return $default(_that.id,_that.userA,_that.userB,_that.netBalance,_that.updatedAt,_that.pendingMutations,_that.appliedMutationIds);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  String id, @HiveField(1)  String userA, @HiveField(2)  String userB, @HiveField(3)  double netBalance, @HiveField(4)  DateTime updatedAt, @HiveField(5)  Map<String, double> pendingMutations, @HiveField(6)  List<String> appliedMutationIds)?  $default,) {final _that = this;
switch (_that) {
case _DebtLedgerDto() when $default != null:
return $default(_that.id,_that.userA,_that.userB,_that.netBalance,_that.updatedAt,_that.pendingMutations,_that.appliedMutationIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DebtLedgerDto with DiagnosticableTreeMixin implements DebtLedgerDto {
  const _DebtLedgerDto({@HiveField(0) required this.id, @HiveField(1) required this.userA, @HiveField(2) required this.userB, @HiveField(3) required this.netBalance, @HiveField(4) required this.updatedAt, @HiveField(5) final  Map<String, double> pendingMutations = const {}, @HiveField(6) final  List<String> appliedMutationIds = const []}): _pendingMutations = pendingMutations,_appliedMutationIds = appliedMutationIds;
  factory _DebtLedgerDto.fromJson(Map<String, dynamic> json) => _$DebtLedgerDtoFromJson(json);

@override@HiveField(0) final  String id;
@override@HiveField(1) final  String userA;
@override@HiveField(2) final  String userB;
@override@HiveField(3) final  double netBalance;
@override@HiveField(4) final  DateTime updatedAt;
 final  Map<String, double> _pendingMutations;
@override@JsonKey()@HiveField(5) Map<String, double> get pendingMutations {
  if (_pendingMutations is EqualUnmodifiableMapView) return _pendingMutations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_pendingMutations);
}

 final  List<String> _appliedMutationIds;
@override@JsonKey()@HiveField(6) List<String> get appliedMutationIds {
  if (_appliedMutationIds is EqualUnmodifiableListView) return _appliedMutationIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_appliedMutationIds);
}


/// Create a copy of DebtLedgerDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DebtLedgerDtoCopyWith<_DebtLedgerDto> get copyWith => __$DebtLedgerDtoCopyWithImpl<_DebtLedgerDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DebtLedgerDtoToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'DebtLedgerDto'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('userA', userA))..add(DiagnosticsProperty('userB', userB))..add(DiagnosticsProperty('netBalance', netBalance))..add(DiagnosticsProperty('updatedAt', updatedAt))..add(DiagnosticsProperty('pendingMutations', pendingMutations))..add(DiagnosticsProperty('appliedMutationIds', appliedMutationIds));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DebtLedgerDto&&(identical(other.id, id) || other.id == id)&&(identical(other.userA, userA) || other.userA == userA)&&(identical(other.userB, userB) || other.userB == userB)&&(identical(other.netBalance, netBalance) || other.netBalance == netBalance)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._pendingMutations, _pendingMutations)&&const DeepCollectionEquality().equals(other._appliedMutationIds, _appliedMutationIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userA,userB,netBalance,updatedAt,const DeepCollectionEquality().hash(_pendingMutations),const DeepCollectionEquality().hash(_appliedMutationIds));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'DebtLedgerDto(id: $id, userA: $userA, userB: $userB, netBalance: $netBalance, updatedAt: $updatedAt, pendingMutations: $pendingMutations, appliedMutationIds: $appliedMutationIds)';
}


}

/// @nodoc
abstract mixin class _$DebtLedgerDtoCopyWith<$Res> implements $DebtLedgerDtoCopyWith<$Res> {
  factory _$DebtLedgerDtoCopyWith(_DebtLedgerDto value, $Res Function(_DebtLedgerDto) _then) = __$DebtLedgerDtoCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) String id,@HiveField(1) String userA,@HiveField(2) String userB,@HiveField(3) double netBalance,@HiveField(4) DateTime updatedAt,@HiveField(5) Map<String, double> pendingMutations,@HiveField(6) List<String> appliedMutationIds
});




}
/// @nodoc
class __$DebtLedgerDtoCopyWithImpl<$Res>
    implements _$DebtLedgerDtoCopyWith<$Res> {
  __$DebtLedgerDtoCopyWithImpl(this._self, this._then);

  final _DebtLedgerDto _self;
  final $Res Function(_DebtLedgerDto) _then;

/// Create a copy of DebtLedgerDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userA = null,Object? userB = null,Object? netBalance = null,Object? updatedAt = null,Object? pendingMutations = null,Object? appliedMutationIds = null,}) {
  return _then(_DebtLedgerDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userA: null == userA ? _self.userA : userA // ignore: cast_nullable_to_non_nullable
as String,userB: null == userB ? _self.userB : userB // ignore: cast_nullable_to_non_nullable
as String,netBalance: null == netBalance ? _self.netBalance : netBalance // ignore: cast_nullable_to_non_nullable
as double,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,pendingMutations: null == pendingMutations ? _self._pendingMutations : pendingMutations // ignore: cast_nullable_to_non_nullable
as Map<String, double>,appliedMutationIds: null == appliedMutationIds ? _self._appliedMutationIds : appliedMutationIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
