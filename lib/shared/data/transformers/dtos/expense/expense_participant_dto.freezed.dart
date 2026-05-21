// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expense_participant_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExpenseParticipantDto implements DiagnosticableTreeMixin {

@HiveField(0) String get userId;@HiveField(1) double get amount;@HiveField(2) bool get isSettled;@HiveField(3) DateTime? get settledAt;
/// Create a copy of ExpenseParticipantDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseParticipantDtoCopyWith<ExpenseParticipantDto> get copyWith => _$ExpenseParticipantDtoCopyWithImpl<ExpenseParticipantDto>(this as ExpenseParticipantDto, _$identity);

  /// Serializes this ExpenseParticipantDto to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ExpenseParticipantDto'))
    ..add(DiagnosticsProperty('userId', userId))..add(DiagnosticsProperty('amount', amount))..add(DiagnosticsProperty('isSettled', isSettled))..add(DiagnosticsProperty('settledAt', settledAt));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseParticipantDto&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.isSettled, isSettled) || other.isSettled == isSettled)&&(identical(other.settledAt, settledAt) || other.settledAt == settledAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,amount,isSettled,settledAt);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ExpenseParticipantDto(userId: $userId, amount: $amount, isSettled: $isSettled, settledAt: $settledAt)';
}


}

/// @nodoc
abstract mixin class $ExpenseParticipantDtoCopyWith<$Res>  {
  factory $ExpenseParticipantDtoCopyWith(ExpenseParticipantDto value, $Res Function(ExpenseParticipantDto) _then) = _$ExpenseParticipantDtoCopyWithImpl;
@useResult
$Res call({
@HiveField(0) String userId,@HiveField(1) double amount,@HiveField(2) bool isSettled,@HiveField(3) DateTime? settledAt
});




}
/// @nodoc
class _$ExpenseParticipantDtoCopyWithImpl<$Res>
    implements $ExpenseParticipantDtoCopyWith<$Res> {
  _$ExpenseParticipantDtoCopyWithImpl(this._self, this._then);

  final ExpenseParticipantDto _self;
  final $Res Function(ExpenseParticipantDto) _then;

/// Create a copy of ExpenseParticipantDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? amount = null,Object? isSettled = null,Object? settledAt = freezed,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,isSettled: null == isSettled ? _self.isSettled : isSettled // ignore: cast_nullable_to_non_nullable
as bool,settledAt: freezed == settledAt ? _self.settledAt : settledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ExpenseParticipantDto].
extension ExpenseParticipantDtoPatterns on ExpenseParticipantDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExpenseParticipantDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExpenseParticipantDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExpenseParticipantDto value)  $default,){
final _that = this;
switch (_that) {
case _ExpenseParticipantDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExpenseParticipantDto value)?  $default,){
final _that = this;
switch (_that) {
case _ExpenseParticipantDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  String userId, @HiveField(1)  double amount, @HiveField(2)  bool isSettled, @HiveField(3)  DateTime? settledAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExpenseParticipantDto() when $default != null:
return $default(_that.userId,_that.amount,_that.isSettled,_that.settledAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  String userId, @HiveField(1)  double amount, @HiveField(2)  bool isSettled, @HiveField(3)  DateTime? settledAt)  $default,) {final _that = this;
switch (_that) {
case _ExpenseParticipantDto():
return $default(_that.userId,_that.amount,_that.isSettled,_that.settledAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  String userId, @HiveField(1)  double amount, @HiveField(2)  bool isSettled, @HiveField(3)  DateTime? settledAt)?  $default,) {final _that = this;
switch (_that) {
case _ExpenseParticipantDto() when $default != null:
return $default(_that.userId,_that.amount,_that.isSettled,_that.settledAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExpenseParticipantDto with DiagnosticableTreeMixin implements ExpenseParticipantDto {
  const _ExpenseParticipantDto({@HiveField(0) required this.userId, @HiveField(1) required this.amount, @HiveField(2) this.isSettled = false, @HiveField(3) this.settledAt});
  factory _ExpenseParticipantDto.fromJson(Map<String, dynamic> json) => _$ExpenseParticipantDtoFromJson(json);

@override@HiveField(0) final  String userId;
@override@HiveField(1) final  double amount;
@override@JsonKey()@HiveField(2) final  bool isSettled;
@override@HiveField(3) final  DateTime? settledAt;

/// Create a copy of ExpenseParticipantDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExpenseParticipantDtoCopyWith<_ExpenseParticipantDto> get copyWith => __$ExpenseParticipantDtoCopyWithImpl<_ExpenseParticipantDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExpenseParticipantDtoToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ExpenseParticipantDto'))
    ..add(DiagnosticsProperty('userId', userId))..add(DiagnosticsProperty('amount', amount))..add(DiagnosticsProperty('isSettled', isSettled))..add(DiagnosticsProperty('settledAt', settledAt));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExpenseParticipantDto&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.isSettled, isSettled) || other.isSettled == isSettled)&&(identical(other.settledAt, settledAt) || other.settledAt == settledAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,amount,isSettled,settledAt);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ExpenseParticipantDto(userId: $userId, amount: $amount, isSettled: $isSettled, settledAt: $settledAt)';
}


}

/// @nodoc
abstract mixin class _$ExpenseParticipantDtoCopyWith<$Res> implements $ExpenseParticipantDtoCopyWith<$Res> {
  factory _$ExpenseParticipantDtoCopyWith(_ExpenseParticipantDto value, $Res Function(_ExpenseParticipantDto) _then) = __$ExpenseParticipantDtoCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) String userId,@HiveField(1) double amount,@HiveField(2) bool isSettled,@HiveField(3) DateTime? settledAt
});




}
/// @nodoc
class __$ExpenseParticipantDtoCopyWithImpl<$Res>
    implements _$ExpenseParticipantDtoCopyWith<$Res> {
  __$ExpenseParticipantDtoCopyWithImpl(this._self, this._then);

  final _ExpenseParticipantDto _self;
  final $Res Function(_ExpenseParticipantDto) _then;

/// Create a copy of ExpenseParticipantDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? amount = null,Object? isSettled = null,Object? settledAt = freezed,}) {
  return _then(_ExpenseParticipantDto(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,isSettled: null == isSettled ? _self.isSettled : isSettled // ignore: cast_nullable_to_non_nullable
as bool,settledAt: freezed == settledAt ? _self.settledAt : settledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
