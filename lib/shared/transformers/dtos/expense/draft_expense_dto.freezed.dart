// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'draft_expense_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DraftExpenseDto implements DiagnosticableTreeMixin {

@HiveField(0) String get userId;@HiveField(1) String? get title;@HiveField(2) String? get note;@HiveField(3) double? get amount;@HiveField(4) DateTime? get expenseDate;@HiveField(5) String? get groupId;@HiveField(6) String? get accountId;@HiveField(7) DateTime? get updatedAt;
/// Create a copy of DraftExpenseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DraftExpenseDtoCopyWith<DraftExpenseDto> get copyWith => _$DraftExpenseDtoCopyWithImpl<DraftExpenseDto>(this as DraftExpenseDto, _$identity);

  /// Serializes this DraftExpenseDto to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'DraftExpenseDto'))
    ..add(DiagnosticsProperty('userId', userId))..add(DiagnosticsProperty('title', title))..add(DiagnosticsProperty('note', note))..add(DiagnosticsProperty('amount', amount))..add(DiagnosticsProperty('expenseDate', expenseDate))..add(DiagnosticsProperty('groupId', groupId))..add(DiagnosticsProperty('accountId', accountId))..add(DiagnosticsProperty('updatedAt', updatedAt));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DraftExpenseDto&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.title, title) || other.title == title)&&(identical(other.note, note) || other.note == note)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.expenseDate, expenseDate) || other.expenseDate == expenseDate)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,title,note,amount,expenseDate,groupId,accountId,updatedAt);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'DraftExpenseDto(userId: $userId, title: $title, note: $note, amount: $amount, expenseDate: $expenseDate, groupId: $groupId, accountId: $accountId, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $DraftExpenseDtoCopyWith<$Res>  {
  factory $DraftExpenseDtoCopyWith(DraftExpenseDto value, $Res Function(DraftExpenseDto) _then) = _$DraftExpenseDtoCopyWithImpl;
@useResult
$Res call({
@HiveField(0) String userId,@HiveField(1) String? title,@HiveField(2) String? note,@HiveField(3) double? amount,@HiveField(4) DateTime? expenseDate,@HiveField(5) String? groupId,@HiveField(6) String? accountId,@HiveField(7) DateTime? updatedAt
});




}
/// @nodoc
class _$DraftExpenseDtoCopyWithImpl<$Res>
    implements $DraftExpenseDtoCopyWith<$Res> {
  _$DraftExpenseDtoCopyWithImpl(this._self, this._then);

  final DraftExpenseDto _self;
  final $Res Function(DraftExpenseDto) _then;

/// Create a copy of DraftExpenseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? title = freezed,Object? note = freezed,Object? amount = freezed,Object? expenseDate = freezed,Object? groupId = freezed,Object? accountId = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double?,expenseDate: freezed == expenseDate ? _self.expenseDate : expenseDate // ignore: cast_nullable_to_non_nullable
as DateTime?,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String?,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [DraftExpenseDto].
extension DraftExpenseDtoPatterns on DraftExpenseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DraftExpenseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DraftExpenseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DraftExpenseDto value)  $default,){
final _that = this;
switch (_that) {
case _DraftExpenseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DraftExpenseDto value)?  $default,){
final _that = this;
switch (_that) {
case _DraftExpenseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  String userId, @HiveField(1)  String? title, @HiveField(2)  String? note, @HiveField(3)  double? amount, @HiveField(4)  DateTime? expenseDate, @HiveField(5)  String? groupId, @HiveField(6)  String? accountId, @HiveField(7)  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DraftExpenseDto() when $default != null:
return $default(_that.userId,_that.title,_that.note,_that.amount,_that.expenseDate,_that.groupId,_that.accountId,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  String userId, @HiveField(1)  String? title, @HiveField(2)  String? note, @HiveField(3)  double? amount, @HiveField(4)  DateTime? expenseDate, @HiveField(5)  String? groupId, @HiveField(6)  String? accountId, @HiveField(7)  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _DraftExpenseDto():
return $default(_that.userId,_that.title,_that.note,_that.amount,_that.expenseDate,_that.groupId,_that.accountId,_that.updatedAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  String userId, @HiveField(1)  String? title, @HiveField(2)  String? note, @HiveField(3)  double? amount, @HiveField(4)  DateTime? expenseDate, @HiveField(5)  String? groupId, @HiveField(6)  String? accountId, @HiveField(7)  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _DraftExpenseDto() when $default != null:
return $default(_that.userId,_that.title,_that.note,_that.amount,_that.expenseDate,_that.groupId,_that.accountId,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DraftExpenseDto with DiagnosticableTreeMixin implements DraftExpenseDto {
  const _DraftExpenseDto({@HiveField(0) required this.userId, @HiveField(1) this.title, @HiveField(2) this.note, @HiveField(3) this.amount, @HiveField(4) this.expenseDate, @HiveField(5) this.groupId, @HiveField(6) this.accountId, @HiveField(7) this.updatedAt});
  factory _DraftExpenseDto.fromJson(Map<String, dynamic> json) => _$DraftExpenseDtoFromJson(json);

@override@HiveField(0) final  String userId;
@override@HiveField(1) final  String? title;
@override@HiveField(2) final  String? note;
@override@HiveField(3) final  double? amount;
@override@HiveField(4) final  DateTime? expenseDate;
@override@HiveField(5) final  String? groupId;
@override@HiveField(6) final  String? accountId;
@override@HiveField(7) final  DateTime? updatedAt;

/// Create a copy of DraftExpenseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DraftExpenseDtoCopyWith<_DraftExpenseDto> get copyWith => __$DraftExpenseDtoCopyWithImpl<_DraftExpenseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DraftExpenseDtoToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'DraftExpenseDto'))
    ..add(DiagnosticsProperty('userId', userId))..add(DiagnosticsProperty('title', title))..add(DiagnosticsProperty('note', note))..add(DiagnosticsProperty('amount', amount))..add(DiagnosticsProperty('expenseDate', expenseDate))..add(DiagnosticsProperty('groupId', groupId))..add(DiagnosticsProperty('accountId', accountId))..add(DiagnosticsProperty('updatedAt', updatedAt));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DraftExpenseDto&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.title, title) || other.title == title)&&(identical(other.note, note) || other.note == note)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.expenseDate, expenseDate) || other.expenseDate == expenseDate)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,title,note,amount,expenseDate,groupId,accountId,updatedAt);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'DraftExpenseDto(userId: $userId, title: $title, note: $note, amount: $amount, expenseDate: $expenseDate, groupId: $groupId, accountId: $accountId, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$DraftExpenseDtoCopyWith<$Res> implements $DraftExpenseDtoCopyWith<$Res> {
  factory _$DraftExpenseDtoCopyWith(_DraftExpenseDto value, $Res Function(_DraftExpenseDto) _then) = __$DraftExpenseDtoCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) String userId,@HiveField(1) String? title,@HiveField(2) String? note,@HiveField(3) double? amount,@HiveField(4) DateTime? expenseDate,@HiveField(5) String? groupId,@HiveField(6) String? accountId,@HiveField(7) DateTime? updatedAt
});




}
/// @nodoc
class __$DraftExpenseDtoCopyWithImpl<$Res>
    implements _$DraftExpenseDtoCopyWith<$Res> {
  __$DraftExpenseDtoCopyWithImpl(this._self, this._then);

  final _DraftExpenseDto _self;
  final $Res Function(_DraftExpenseDto) _then;

/// Create a copy of DraftExpenseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? title = freezed,Object? note = freezed,Object? amount = freezed,Object? expenseDate = freezed,Object? groupId = freezed,Object? accountId = freezed,Object? updatedAt = freezed,}) {
  return _then(_DraftExpenseDto(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double?,expenseDate: freezed == expenseDate ? _self.expenseDate : expenseDate // ignore: cast_nullable_to_non_nullable
as DateTime?,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String?,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
