// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'monthly_saving_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MonthlySavingEntity implements DiagnosticableTreeMixin {

 String get id; String get accountId; int get year; int get month; double get goalAmount; double get savedAmount; double get openingBalance; double get closingBalance; double get achievementPercent; bool get isCompleted; String get userId; SyncStatus get syncStatus; DateTime? get updatedAt;
/// Create a copy of MonthlySavingEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MonthlySavingEntityCopyWith<MonthlySavingEntity> get copyWith => _$MonthlySavingEntityCopyWithImpl<MonthlySavingEntity>(this as MonthlySavingEntity, _$identity);

  /// Serializes this MonthlySavingEntity to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MonthlySavingEntity'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('accountId', accountId))..add(DiagnosticsProperty('year', year))..add(DiagnosticsProperty('month', month))..add(DiagnosticsProperty('goalAmount', goalAmount))..add(DiagnosticsProperty('savedAmount', savedAmount))..add(DiagnosticsProperty('openingBalance', openingBalance))..add(DiagnosticsProperty('closingBalance', closingBalance))..add(DiagnosticsProperty('achievementPercent', achievementPercent))..add(DiagnosticsProperty('isCompleted', isCompleted))..add(DiagnosticsProperty('userId', userId))..add(DiagnosticsProperty('syncStatus', syncStatus))..add(DiagnosticsProperty('updatedAt', updatedAt));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MonthlySavingEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.goalAmount, goalAmount) || other.goalAmount == goalAmount)&&(identical(other.savedAmount, savedAmount) || other.savedAmount == savedAmount)&&(identical(other.openingBalance, openingBalance) || other.openingBalance == openingBalance)&&(identical(other.closingBalance, closingBalance) || other.closingBalance == closingBalance)&&(identical(other.achievementPercent, achievementPercent) || other.achievementPercent == achievementPercent)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,accountId,year,month,goalAmount,savedAmount,openingBalance,closingBalance,achievementPercent,isCompleted,userId,syncStatus,updatedAt);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MonthlySavingEntity(id: $id, accountId: $accountId, year: $year, month: $month, goalAmount: $goalAmount, savedAmount: $savedAmount, openingBalance: $openingBalance, closingBalance: $closingBalance, achievementPercent: $achievementPercent, isCompleted: $isCompleted, userId: $userId, syncStatus: $syncStatus, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $MonthlySavingEntityCopyWith<$Res>  {
  factory $MonthlySavingEntityCopyWith(MonthlySavingEntity value, $Res Function(MonthlySavingEntity) _then) = _$MonthlySavingEntityCopyWithImpl;
@useResult
$Res call({
 String id, String accountId, int year, int month, double goalAmount, double savedAmount, double openingBalance, double closingBalance, double achievementPercent, bool isCompleted, String userId, SyncStatus syncStatus, DateTime? updatedAt
});




}
/// @nodoc
class _$MonthlySavingEntityCopyWithImpl<$Res>
    implements $MonthlySavingEntityCopyWith<$Res> {
  _$MonthlySavingEntityCopyWithImpl(this._self, this._then);

  final MonthlySavingEntity _self;
  final $Res Function(MonthlySavingEntity) _then;

/// Create a copy of MonthlySavingEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? accountId = null,Object? year = null,Object? month = null,Object? goalAmount = null,Object? savedAmount = null,Object? openingBalance = null,Object? closingBalance = null,Object? achievementPercent = null,Object? isCompleted = null,Object? userId = null,Object? syncStatus = null,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,goalAmount: null == goalAmount ? _self.goalAmount : goalAmount // ignore: cast_nullable_to_non_nullable
as double,savedAmount: null == savedAmount ? _self.savedAmount : savedAmount // ignore: cast_nullable_to_non_nullable
as double,openingBalance: null == openingBalance ? _self.openingBalance : openingBalance // ignore: cast_nullable_to_non_nullable
as double,closingBalance: null == closingBalance ? _self.closingBalance : closingBalance // ignore: cast_nullable_to_non_nullable
as double,achievementPercent: null == achievementPercent ? _self.achievementPercent : achievementPercent // ignore: cast_nullable_to_non_nullable
as double,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SyncStatus,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [MonthlySavingEntity].
extension MonthlySavingEntityPatterns on MonthlySavingEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MonthlySavingEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MonthlySavingEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MonthlySavingEntity value)  $default,){
final _that = this;
switch (_that) {
case _MonthlySavingEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MonthlySavingEntity value)?  $default,){
final _that = this;
switch (_that) {
case _MonthlySavingEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String accountId,  int year,  int month,  double goalAmount,  double savedAmount,  double openingBalance,  double closingBalance,  double achievementPercent,  bool isCompleted,  String userId,  SyncStatus syncStatus,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MonthlySavingEntity() when $default != null:
return $default(_that.id,_that.accountId,_that.year,_that.month,_that.goalAmount,_that.savedAmount,_that.openingBalance,_that.closingBalance,_that.achievementPercent,_that.isCompleted,_that.userId,_that.syncStatus,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String accountId,  int year,  int month,  double goalAmount,  double savedAmount,  double openingBalance,  double closingBalance,  double achievementPercent,  bool isCompleted,  String userId,  SyncStatus syncStatus,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _MonthlySavingEntity():
return $default(_that.id,_that.accountId,_that.year,_that.month,_that.goalAmount,_that.savedAmount,_that.openingBalance,_that.closingBalance,_that.achievementPercent,_that.isCompleted,_that.userId,_that.syncStatus,_that.updatedAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String accountId,  int year,  int month,  double goalAmount,  double savedAmount,  double openingBalance,  double closingBalance,  double achievementPercent,  bool isCompleted,  String userId,  SyncStatus syncStatus,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _MonthlySavingEntity() when $default != null:
return $default(_that.id,_that.accountId,_that.year,_that.month,_that.goalAmount,_that.savedAmount,_that.openingBalance,_that.closingBalance,_that.achievementPercent,_that.isCompleted,_that.userId,_that.syncStatus,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MonthlySavingEntity with DiagnosticableTreeMixin implements MonthlySavingEntity {
  const _MonthlySavingEntity({required this.id, required this.accountId, required this.year, required this.month, required this.goalAmount, required this.savedAmount, required this.openingBalance, required this.closingBalance, required this.achievementPercent, this.isCompleted = false, this.userId = '', this.syncStatus = SyncStatus.synced, this.updatedAt});
  factory _MonthlySavingEntity.fromJson(Map<String, dynamic> json) => _$MonthlySavingEntityFromJson(json);

@override final  String id;
@override final  String accountId;
@override final  int year;
@override final  int month;
@override final  double goalAmount;
@override final  double savedAmount;
@override final  double openingBalance;
@override final  double closingBalance;
@override final  double achievementPercent;
@override@JsonKey() final  bool isCompleted;
@override@JsonKey() final  String userId;
@override@JsonKey() final  SyncStatus syncStatus;
@override final  DateTime? updatedAt;

/// Create a copy of MonthlySavingEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MonthlySavingEntityCopyWith<_MonthlySavingEntity> get copyWith => __$MonthlySavingEntityCopyWithImpl<_MonthlySavingEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MonthlySavingEntityToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MonthlySavingEntity'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('accountId', accountId))..add(DiagnosticsProperty('year', year))..add(DiagnosticsProperty('month', month))..add(DiagnosticsProperty('goalAmount', goalAmount))..add(DiagnosticsProperty('savedAmount', savedAmount))..add(DiagnosticsProperty('openingBalance', openingBalance))..add(DiagnosticsProperty('closingBalance', closingBalance))..add(DiagnosticsProperty('achievementPercent', achievementPercent))..add(DiagnosticsProperty('isCompleted', isCompleted))..add(DiagnosticsProperty('userId', userId))..add(DiagnosticsProperty('syncStatus', syncStatus))..add(DiagnosticsProperty('updatedAt', updatedAt));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MonthlySavingEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.goalAmount, goalAmount) || other.goalAmount == goalAmount)&&(identical(other.savedAmount, savedAmount) || other.savedAmount == savedAmount)&&(identical(other.openingBalance, openingBalance) || other.openingBalance == openingBalance)&&(identical(other.closingBalance, closingBalance) || other.closingBalance == closingBalance)&&(identical(other.achievementPercent, achievementPercent) || other.achievementPercent == achievementPercent)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,accountId,year,month,goalAmount,savedAmount,openingBalance,closingBalance,achievementPercent,isCompleted,userId,syncStatus,updatedAt);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MonthlySavingEntity(id: $id, accountId: $accountId, year: $year, month: $month, goalAmount: $goalAmount, savedAmount: $savedAmount, openingBalance: $openingBalance, closingBalance: $closingBalance, achievementPercent: $achievementPercent, isCompleted: $isCompleted, userId: $userId, syncStatus: $syncStatus, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$MonthlySavingEntityCopyWith<$Res> implements $MonthlySavingEntityCopyWith<$Res> {
  factory _$MonthlySavingEntityCopyWith(_MonthlySavingEntity value, $Res Function(_MonthlySavingEntity) _then) = __$MonthlySavingEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String accountId, int year, int month, double goalAmount, double savedAmount, double openingBalance, double closingBalance, double achievementPercent, bool isCompleted, String userId, SyncStatus syncStatus, DateTime? updatedAt
});




}
/// @nodoc
class __$MonthlySavingEntityCopyWithImpl<$Res>
    implements _$MonthlySavingEntityCopyWith<$Res> {
  __$MonthlySavingEntityCopyWithImpl(this._self, this._then);

  final _MonthlySavingEntity _self;
  final $Res Function(_MonthlySavingEntity) _then;

/// Create a copy of MonthlySavingEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? accountId = null,Object? year = null,Object? month = null,Object? goalAmount = null,Object? savedAmount = null,Object? openingBalance = null,Object? closingBalance = null,Object? achievementPercent = null,Object? isCompleted = null,Object? userId = null,Object? syncStatus = null,Object? updatedAt = freezed,}) {
  return _then(_MonthlySavingEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,year: null == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as int,month: null == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int,goalAmount: null == goalAmount ? _self.goalAmount : goalAmount // ignore: cast_nullable_to_non_nullable
as double,savedAmount: null == savedAmount ? _self.savedAmount : savedAmount // ignore: cast_nullable_to_non_nullable
as double,openingBalance: null == openingBalance ? _self.openingBalance : openingBalance // ignore: cast_nullable_to_non_nullable
as double,closingBalance: null == closingBalance ? _self.closingBalance : closingBalance // ignore: cast_nullable_to_non_nullable
as double,achievementPercent: null == achievementPercent ? _self.achievementPercent : achievementPercent // ignore: cast_nullable_to_non_nullable
as double,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SyncStatus,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
