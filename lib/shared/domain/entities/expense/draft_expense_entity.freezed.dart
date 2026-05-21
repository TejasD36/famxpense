// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'draft_expense_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DraftExpenseEntity implements DiagnosticableTreeMixin {

 String get userId; String? get title; String? get note; double? get amount; DateTime? get expenseDate; String? get groupId; String? get accountId; DateTime? get updatedAt;
/// Create a copy of DraftExpenseEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DraftExpenseEntityCopyWith<DraftExpenseEntity> get copyWith => _$DraftExpenseEntityCopyWithImpl<DraftExpenseEntity>(this as DraftExpenseEntity, _$identity);

  /// Serializes this DraftExpenseEntity to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'DraftExpenseEntity'))
    ..add(DiagnosticsProperty('userId', userId))..add(DiagnosticsProperty('title', title))..add(DiagnosticsProperty('note', note))..add(DiagnosticsProperty('amount', amount))..add(DiagnosticsProperty('expenseDate', expenseDate))..add(DiagnosticsProperty('groupId', groupId))..add(DiagnosticsProperty('accountId', accountId))..add(DiagnosticsProperty('updatedAt', updatedAt));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DraftExpenseEntity&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.title, title) || other.title == title)&&(identical(other.note, note) || other.note == note)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.expenseDate, expenseDate) || other.expenseDate == expenseDate)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,title,note,amount,expenseDate,groupId,accountId,updatedAt);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'DraftExpenseEntity(userId: $userId, title: $title, note: $note, amount: $amount, expenseDate: $expenseDate, groupId: $groupId, accountId: $accountId, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $DraftExpenseEntityCopyWith<$Res>  {
  factory $DraftExpenseEntityCopyWith(DraftExpenseEntity value, $Res Function(DraftExpenseEntity) _then) = _$DraftExpenseEntityCopyWithImpl;
@useResult
$Res call({
 String userId, String? title, String? note, double? amount, DateTime? expenseDate, String? groupId, String? accountId, DateTime? updatedAt
});




}
/// @nodoc
class _$DraftExpenseEntityCopyWithImpl<$Res>
    implements $DraftExpenseEntityCopyWith<$Res> {
  _$DraftExpenseEntityCopyWithImpl(this._self, this._then);

  final DraftExpenseEntity _self;
  final $Res Function(DraftExpenseEntity) _then;

/// Create a copy of DraftExpenseEntity
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


/// Adds pattern-matching-related methods to [DraftExpenseEntity].
extension DraftExpenseEntityPatterns on DraftExpenseEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DraftExpenseEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DraftExpenseEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DraftExpenseEntity value)  $default,){
final _that = this;
switch (_that) {
case _DraftExpenseEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DraftExpenseEntity value)?  $default,){
final _that = this;
switch (_that) {
case _DraftExpenseEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String? title,  String? note,  double? amount,  DateTime? expenseDate,  String? groupId,  String? accountId,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DraftExpenseEntity() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String? title,  String? note,  double? amount,  DateTime? expenseDate,  String? groupId,  String? accountId,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _DraftExpenseEntity():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String? title,  String? note,  double? amount,  DateTime? expenseDate,  String? groupId,  String? accountId,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _DraftExpenseEntity() when $default != null:
return $default(_that.userId,_that.title,_that.note,_that.amount,_that.expenseDate,_that.groupId,_that.accountId,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DraftExpenseEntity with DiagnosticableTreeMixin implements DraftExpenseEntity {
  const _DraftExpenseEntity({required this.userId, this.title, this.note, this.amount, this.expenseDate, this.groupId, this.accountId, this.updatedAt});
  factory _DraftExpenseEntity.fromJson(Map<String, dynamic> json) => _$DraftExpenseEntityFromJson(json);

@override final  String userId;
@override final  String? title;
@override final  String? note;
@override final  double? amount;
@override final  DateTime? expenseDate;
@override final  String? groupId;
@override final  String? accountId;
@override final  DateTime? updatedAt;

/// Create a copy of DraftExpenseEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DraftExpenseEntityCopyWith<_DraftExpenseEntity> get copyWith => __$DraftExpenseEntityCopyWithImpl<_DraftExpenseEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DraftExpenseEntityToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'DraftExpenseEntity'))
    ..add(DiagnosticsProperty('userId', userId))..add(DiagnosticsProperty('title', title))..add(DiagnosticsProperty('note', note))..add(DiagnosticsProperty('amount', amount))..add(DiagnosticsProperty('expenseDate', expenseDate))..add(DiagnosticsProperty('groupId', groupId))..add(DiagnosticsProperty('accountId', accountId))..add(DiagnosticsProperty('updatedAt', updatedAt));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DraftExpenseEntity&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.title, title) || other.title == title)&&(identical(other.note, note) || other.note == note)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.expenseDate, expenseDate) || other.expenseDate == expenseDate)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,title,note,amount,expenseDate,groupId,accountId,updatedAt);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'DraftExpenseEntity(userId: $userId, title: $title, note: $note, amount: $amount, expenseDate: $expenseDate, groupId: $groupId, accountId: $accountId, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$DraftExpenseEntityCopyWith<$Res> implements $DraftExpenseEntityCopyWith<$Res> {
  factory _$DraftExpenseEntityCopyWith(_DraftExpenseEntity value, $Res Function(_DraftExpenseEntity) _then) = __$DraftExpenseEntityCopyWithImpl;
@override @useResult
$Res call({
 String userId, String? title, String? note, double? amount, DateTime? expenseDate, String? groupId, String? accountId, DateTime? updatedAt
});




}
/// @nodoc
class __$DraftExpenseEntityCopyWithImpl<$Res>
    implements _$DraftExpenseEntityCopyWith<$Res> {
  __$DraftExpenseEntityCopyWithImpl(this._self, this._then);

  final _DraftExpenseEntity _self;
  final $Res Function(_DraftExpenseEntity) _then;

/// Create a copy of DraftExpenseEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? title = freezed,Object? note = freezed,Object? amount = freezed,Object? expenseDate = freezed,Object? groupId = freezed,Object? accountId = freezed,Object? updatedAt = freezed,}) {
  return _then(_DraftExpenseEntity(
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
