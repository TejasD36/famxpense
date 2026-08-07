// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'monthly_saving_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MonthlySavingDto implements DiagnosticableTreeMixin {

@HiveField(0) String get id;@HiveField(1) String get accountId;@HiveField(2) int get year;@HiveField(3) int get month;@HiveField(4) double get goalAmount;@HiveField(5) double get savedAmount;@HiveField(6) double get openingBalance;@HiveField(7) double get closingBalance;@HiveField(8) double get achievementPercent;@HiveField(9) bool get isCompleted;@HiveField(10) String get userId;@HiveField(11) SyncStatus get syncStatus;@HiveField(12) DateTime? get updatedAt;
/// Create a copy of MonthlySavingDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MonthlySavingDtoCopyWith<MonthlySavingDto> get copyWith => _$MonthlySavingDtoCopyWithImpl<MonthlySavingDto>(this as MonthlySavingDto, _$identity);

  /// Serializes this MonthlySavingDto to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MonthlySavingDto'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('accountId', accountId))..add(DiagnosticsProperty('year', year))..add(DiagnosticsProperty('month', month))..add(DiagnosticsProperty('goalAmount', goalAmount))..add(DiagnosticsProperty('savedAmount', savedAmount))..add(DiagnosticsProperty('openingBalance', openingBalance))..add(DiagnosticsProperty('closingBalance', closingBalance))..add(DiagnosticsProperty('achievementPercent', achievementPercent))..add(DiagnosticsProperty('isCompleted', isCompleted))..add(DiagnosticsProperty('userId', userId))..add(DiagnosticsProperty('syncStatus', syncStatus))..add(DiagnosticsProperty('updatedAt', updatedAt));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MonthlySavingDto&&(identical(other.id, id) || other.id == id)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.goalAmount, goalAmount) || other.goalAmount == goalAmount)&&(identical(other.savedAmount, savedAmount) || other.savedAmount == savedAmount)&&(identical(other.openingBalance, openingBalance) || other.openingBalance == openingBalance)&&(identical(other.closingBalance, closingBalance) || other.closingBalance == closingBalance)&&(identical(other.achievementPercent, achievementPercent) || other.achievementPercent == achievementPercent)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,accountId,year,month,goalAmount,savedAmount,openingBalance,closingBalance,achievementPercent,isCompleted,userId,syncStatus,updatedAt);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MonthlySavingDto(id: $id, accountId: $accountId, year: $year, month: $month, goalAmount: $goalAmount, savedAmount: $savedAmount, openingBalance: $openingBalance, closingBalance: $closingBalance, achievementPercent: $achievementPercent, isCompleted: $isCompleted, userId: $userId, syncStatus: $syncStatus, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $MonthlySavingDtoCopyWith<$Res>  {
  factory $MonthlySavingDtoCopyWith(MonthlySavingDto value, $Res Function(MonthlySavingDto) _then) = _$MonthlySavingDtoCopyWithImpl;
@useResult
$Res call({
@HiveField(0) String id,@HiveField(1) String accountId,@HiveField(2) int year,@HiveField(3) int month,@HiveField(4) double goalAmount,@HiveField(5) double savedAmount,@HiveField(6) double openingBalance,@HiveField(7) double closingBalance,@HiveField(8) double achievementPercent,@HiveField(9) bool isCompleted,@HiveField(10) String userId,@HiveField(11) SyncStatus syncStatus,@HiveField(12) DateTime? updatedAt
});




}
/// @nodoc
class _$MonthlySavingDtoCopyWithImpl<$Res>
    implements $MonthlySavingDtoCopyWith<$Res> {
  _$MonthlySavingDtoCopyWithImpl(this._self, this._then);

  final MonthlySavingDto _self;
  final $Res Function(MonthlySavingDto) _then;

/// Create a copy of MonthlySavingDto
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


/// Adds pattern-matching-related methods to [MonthlySavingDto].
extension MonthlySavingDtoPatterns on MonthlySavingDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MonthlySavingDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MonthlySavingDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MonthlySavingDto value)  $default,){
final _that = this;
switch (_that) {
case _MonthlySavingDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MonthlySavingDto value)?  $default,){
final _that = this;
switch (_that) {
case _MonthlySavingDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  String id, @HiveField(1)  String accountId, @HiveField(2)  int year, @HiveField(3)  int month, @HiveField(4)  double goalAmount, @HiveField(5)  double savedAmount, @HiveField(6)  double openingBalance, @HiveField(7)  double closingBalance, @HiveField(8)  double achievementPercent, @HiveField(9)  bool isCompleted, @HiveField(10)  String userId, @HiveField(11)  SyncStatus syncStatus, @HiveField(12)  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MonthlySavingDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  String id, @HiveField(1)  String accountId, @HiveField(2)  int year, @HiveField(3)  int month, @HiveField(4)  double goalAmount, @HiveField(5)  double savedAmount, @HiveField(6)  double openingBalance, @HiveField(7)  double closingBalance, @HiveField(8)  double achievementPercent, @HiveField(9)  bool isCompleted, @HiveField(10)  String userId, @HiveField(11)  SyncStatus syncStatus, @HiveField(12)  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _MonthlySavingDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  String id, @HiveField(1)  String accountId, @HiveField(2)  int year, @HiveField(3)  int month, @HiveField(4)  double goalAmount, @HiveField(5)  double savedAmount, @HiveField(6)  double openingBalance, @HiveField(7)  double closingBalance, @HiveField(8)  double achievementPercent, @HiveField(9)  bool isCompleted, @HiveField(10)  String userId, @HiveField(11)  SyncStatus syncStatus, @HiveField(12)  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _MonthlySavingDto() when $default != null:
return $default(_that.id,_that.accountId,_that.year,_that.month,_that.goalAmount,_that.savedAmount,_that.openingBalance,_that.closingBalance,_that.achievementPercent,_that.isCompleted,_that.userId,_that.syncStatus,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MonthlySavingDto with DiagnosticableTreeMixin implements MonthlySavingDto {
  const _MonthlySavingDto({@HiveField(0) required this.id, @HiveField(1) required this.accountId, @HiveField(2) required this.year, @HiveField(3) required this.month, @HiveField(4) required this.goalAmount, @HiveField(5) required this.savedAmount, @HiveField(6) required this.openingBalance, @HiveField(7) required this.closingBalance, @HiveField(8) required this.achievementPercent, @HiveField(9) this.isCompleted = false, @HiveField(10) this.userId = '', @HiveField(11) this.syncStatus = SyncStatus.synced, @HiveField(12) this.updatedAt});
  factory _MonthlySavingDto.fromJson(Map<String, dynamic> json) => _$MonthlySavingDtoFromJson(json);

@override@HiveField(0) final  String id;
@override@HiveField(1) final  String accountId;
@override@HiveField(2) final  int year;
@override@HiveField(3) final  int month;
@override@HiveField(4) final  double goalAmount;
@override@HiveField(5) final  double savedAmount;
@override@HiveField(6) final  double openingBalance;
@override@HiveField(7) final  double closingBalance;
@override@HiveField(8) final  double achievementPercent;
@override@JsonKey()@HiveField(9) final  bool isCompleted;
@override@JsonKey()@HiveField(10) final  String userId;
@override@JsonKey()@HiveField(11) final  SyncStatus syncStatus;
@override@HiveField(12) final  DateTime? updatedAt;

/// Create a copy of MonthlySavingDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MonthlySavingDtoCopyWith<_MonthlySavingDto> get copyWith => __$MonthlySavingDtoCopyWithImpl<_MonthlySavingDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MonthlySavingDtoToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MonthlySavingDto'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('accountId', accountId))..add(DiagnosticsProperty('year', year))..add(DiagnosticsProperty('month', month))..add(DiagnosticsProperty('goalAmount', goalAmount))..add(DiagnosticsProperty('savedAmount', savedAmount))..add(DiagnosticsProperty('openingBalance', openingBalance))..add(DiagnosticsProperty('closingBalance', closingBalance))..add(DiagnosticsProperty('achievementPercent', achievementPercent))..add(DiagnosticsProperty('isCompleted', isCompleted))..add(DiagnosticsProperty('userId', userId))..add(DiagnosticsProperty('syncStatus', syncStatus))..add(DiagnosticsProperty('updatedAt', updatedAt));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MonthlySavingDto&&(identical(other.id, id) || other.id == id)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.year, year) || other.year == year)&&(identical(other.month, month) || other.month == month)&&(identical(other.goalAmount, goalAmount) || other.goalAmount == goalAmount)&&(identical(other.savedAmount, savedAmount) || other.savedAmount == savedAmount)&&(identical(other.openingBalance, openingBalance) || other.openingBalance == openingBalance)&&(identical(other.closingBalance, closingBalance) || other.closingBalance == closingBalance)&&(identical(other.achievementPercent, achievementPercent) || other.achievementPercent == achievementPercent)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,accountId,year,month,goalAmount,savedAmount,openingBalance,closingBalance,achievementPercent,isCompleted,userId,syncStatus,updatedAt);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MonthlySavingDto(id: $id, accountId: $accountId, year: $year, month: $month, goalAmount: $goalAmount, savedAmount: $savedAmount, openingBalance: $openingBalance, closingBalance: $closingBalance, achievementPercent: $achievementPercent, isCompleted: $isCompleted, userId: $userId, syncStatus: $syncStatus, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$MonthlySavingDtoCopyWith<$Res> implements $MonthlySavingDtoCopyWith<$Res> {
  factory _$MonthlySavingDtoCopyWith(_MonthlySavingDto value, $Res Function(_MonthlySavingDto) _then) = __$MonthlySavingDtoCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) String id,@HiveField(1) String accountId,@HiveField(2) int year,@HiveField(3) int month,@HiveField(4) double goalAmount,@HiveField(5) double savedAmount,@HiveField(6) double openingBalance,@HiveField(7) double closingBalance,@HiveField(8) double achievementPercent,@HiveField(9) bool isCompleted,@HiveField(10) String userId,@HiveField(11) SyncStatus syncStatus,@HiveField(12) DateTime? updatedAt
});




}
/// @nodoc
class __$MonthlySavingDtoCopyWithImpl<$Res>
    implements _$MonthlySavingDtoCopyWith<$Res> {
  __$MonthlySavingDtoCopyWithImpl(this._self, this._then);

  final _MonthlySavingDto _self;
  final $Res Function(_MonthlySavingDto) _then;

/// Create a copy of MonthlySavingDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? accountId = null,Object? year = null,Object? month = null,Object? goalAmount = null,Object? savedAmount = null,Object? openingBalance = null,Object? closingBalance = null,Object? achievementPercent = null,Object? isCompleted = null,Object? userId = null,Object? syncStatus = null,Object? updatedAt = freezed,}) {
  return _then(_MonthlySavingDto(
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
