// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'manual_deposit_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ManualDepositDto implements DiagnosticableTreeMixin {

@HiveField(0) String get id;@HiveField(1) String get accountId;@HiveField(2) double get amount;@HiveField(3) String get description;@HiveField(4) DateTime get createdAt;@HiveField(5) bool get balanceApplied;@HiveField(6) String get userId;@HiveField(7) double? get previousBalance;@HiveField(8) double? get newBalance;@HiveField(9) bool get isBalanceEdit;@HiveField(10) bool get synced;
/// Create a copy of ManualDepositDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ManualDepositDtoCopyWith<ManualDepositDto> get copyWith => _$ManualDepositDtoCopyWithImpl<ManualDepositDto>(this as ManualDepositDto, _$identity);

  /// Serializes this ManualDepositDto to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ManualDepositDto'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('accountId', accountId))..add(DiagnosticsProperty('amount', amount))..add(DiagnosticsProperty('description', description))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('balanceApplied', balanceApplied))..add(DiagnosticsProperty('userId', userId))..add(DiagnosticsProperty('previousBalance', previousBalance))..add(DiagnosticsProperty('newBalance', newBalance))..add(DiagnosticsProperty('isBalanceEdit', isBalanceEdit))..add(DiagnosticsProperty('synced', synced));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ManualDepositDto&&(identical(other.id, id) || other.id == id)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.balanceApplied, balanceApplied) || other.balanceApplied == balanceApplied)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.previousBalance, previousBalance) || other.previousBalance == previousBalance)&&(identical(other.newBalance, newBalance) || other.newBalance == newBalance)&&(identical(other.isBalanceEdit, isBalanceEdit) || other.isBalanceEdit == isBalanceEdit)&&(identical(other.synced, synced) || other.synced == synced));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,accountId,amount,description,createdAt,balanceApplied,userId,previousBalance,newBalance,isBalanceEdit,synced);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ManualDepositDto(id: $id, accountId: $accountId, amount: $amount, description: $description, createdAt: $createdAt, balanceApplied: $balanceApplied, userId: $userId, previousBalance: $previousBalance, newBalance: $newBalance, isBalanceEdit: $isBalanceEdit, synced: $synced)';
}


}

/// @nodoc
abstract mixin class $ManualDepositDtoCopyWith<$Res>  {
  factory $ManualDepositDtoCopyWith(ManualDepositDto value, $Res Function(ManualDepositDto) _then) = _$ManualDepositDtoCopyWithImpl;
@useResult
$Res call({
@HiveField(0) String id,@HiveField(1) String accountId,@HiveField(2) double amount,@HiveField(3) String description,@HiveField(4) DateTime createdAt,@HiveField(5) bool balanceApplied,@HiveField(6) String userId,@HiveField(7) double? previousBalance,@HiveField(8) double? newBalance,@HiveField(9) bool isBalanceEdit,@HiveField(10) bool synced
});




}
/// @nodoc
class _$ManualDepositDtoCopyWithImpl<$Res>
    implements $ManualDepositDtoCopyWith<$Res> {
  _$ManualDepositDtoCopyWithImpl(this._self, this._then);

  final ManualDepositDto _self;
  final $Res Function(ManualDepositDto) _then;

/// Create a copy of ManualDepositDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? accountId = null,Object? amount = null,Object? description = null,Object? createdAt = null,Object? balanceApplied = null,Object? userId = null,Object? previousBalance = freezed,Object? newBalance = freezed,Object? isBalanceEdit = null,Object? synced = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,balanceApplied: null == balanceApplied ? _self.balanceApplied : balanceApplied // ignore: cast_nullable_to_non_nullable
as bool,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,previousBalance: freezed == previousBalance ? _self.previousBalance : previousBalance // ignore: cast_nullable_to_non_nullable
as double?,newBalance: freezed == newBalance ? _self.newBalance : newBalance // ignore: cast_nullable_to_non_nullable
as double?,isBalanceEdit: null == isBalanceEdit ? _self.isBalanceEdit : isBalanceEdit // ignore: cast_nullable_to_non_nullable
as bool,synced: null == synced ? _self.synced : synced // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ManualDepositDto].
extension ManualDepositDtoPatterns on ManualDepositDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ManualDepositDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ManualDepositDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ManualDepositDto value)  $default,){
final _that = this;
switch (_that) {
case _ManualDepositDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ManualDepositDto value)?  $default,){
final _that = this;
switch (_that) {
case _ManualDepositDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  String id, @HiveField(1)  String accountId, @HiveField(2)  double amount, @HiveField(3)  String description, @HiveField(4)  DateTime createdAt, @HiveField(5)  bool balanceApplied, @HiveField(6)  String userId, @HiveField(7)  double? previousBalance, @HiveField(8)  double? newBalance, @HiveField(9)  bool isBalanceEdit, @HiveField(10)  bool synced)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ManualDepositDto() when $default != null:
return $default(_that.id,_that.accountId,_that.amount,_that.description,_that.createdAt,_that.balanceApplied,_that.userId,_that.previousBalance,_that.newBalance,_that.isBalanceEdit,_that.synced);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  String id, @HiveField(1)  String accountId, @HiveField(2)  double amount, @HiveField(3)  String description, @HiveField(4)  DateTime createdAt, @HiveField(5)  bool balanceApplied, @HiveField(6)  String userId, @HiveField(7)  double? previousBalance, @HiveField(8)  double? newBalance, @HiveField(9)  bool isBalanceEdit, @HiveField(10)  bool synced)  $default,) {final _that = this;
switch (_that) {
case _ManualDepositDto():
return $default(_that.id,_that.accountId,_that.amount,_that.description,_that.createdAt,_that.balanceApplied,_that.userId,_that.previousBalance,_that.newBalance,_that.isBalanceEdit,_that.synced);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  String id, @HiveField(1)  String accountId, @HiveField(2)  double amount, @HiveField(3)  String description, @HiveField(4)  DateTime createdAt, @HiveField(5)  bool balanceApplied, @HiveField(6)  String userId, @HiveField(7)  double? previousBalance, @HiveField(8)  double? newBalance, @HiveField(9)  bool isBalanceEdit, @HiveField(10)  bool synced)?  $default,) {final _that = this;
switch (_that) {
case _ManualDepositDto() when $default != null:
return $default(_that.id,_that.accountId,_that.amount,_that.description,_that.createdAt,_that.balanceApplied,_that.userId,_that.previousBalance,_that.newBalance,_that.isBalanceEdit,_that.synced);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ManualDepositDto with DiagnosticableTreeMixin implements ManualDepositDto {
  const _ManualDepositDto({@HiveField(0) required this.id, @HiveField(1) required this.accountId, @HiveField(2) required this.amount, @HiveField(3) required this.description, @HiveField(4) required this.createdAt, @HiveField(5) this.balanceApplied = true, @HiveField(6) this.userId = '', @HiveField(7) this.previousBalance, @HiveField(8) this.newBalance, @HiveField(9) this.isBalanceEdit = false, @HiveField(10) this.synced = false});
  factory _ManualDepositDto.fromJson(Map<String, dynamic> json) => _$ManualDepositDtoFromJson(json);

@override@HiveField(0) final  String id;
@override@HiveField(1) final  String accountId;
@override@HiveField(2) final  double amount;
@override@HiveField(3) final  String description;
@override@HiveField(4) final  DateTime createdAt;
@override@JsonKey()@HiveField(5) final  bool balanceApplied;
@override@JsonKey()@HiveField(6) final  String userId;
@override@HiveField(7) final  double? previousBalance;
@override@HiveField(8) final  double? newBalance;
@override@JsonKey()@HiveField(9) final  bool isBalanceEdit;
@override@JsonKey()@HiveField(10) final  bool synced;

/// Create a copy of ManualDepositDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ManualDepositDtoCopyWith<_ManualDepositDto> get copyWith => __$ManualDepositDtoCopyWithImpl<_ManualDepositDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ManualDepositDtoToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ManualDepositDto'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('accountId', accountId))..add(DiagnosticsProperty('amount', amount))..add(DiagnosticsProperty('description', description))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('balanceApplied', balanceApplied))..add(DiagnosticsProperty('userId', userId))..add(DiagnosticsProperty('previousBalance', previousBalance))..add(DiagnosticsProperty('newBalance', newBalance))..add(DiagnosticsProperty('isBalanceEdit', isBalanceEdit))..add(DiagnosticsProperty('synced', synced));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ManualDepositDto&&(identical(other.id, id) || other.id == id)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.balanceApplied, balanceApplied) || other.balanceApplied == balanceApplied)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.previousBalance, previousBalance) || other.previousBalance == previousBalance)&&(identical(other.newBalance, newBalance) || other.newBalance == newBalance)&&(identical(other.isBalanceEdit, isBalanceEdit) || other.isBalanceEdit == isBalanceEdit)&&(identical(other.synced, synced) || other.synced == synced));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,accountId,amount,description,createdAt,balanceApplied,userId,previousBalance,newBalance,isBalanceEdit,synced);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ManualDepositDto(id: $id, accountId: $accountId, amount: $amount, description: $description, createdAt: $createdAt, balanceApplied: $balanceApplied, userId: $userId, previousBalance: $previousBalance, newBalance: $newBalance, isBalanceEdit: $isBalanceEdit, synced: $synced)';
}


}

/// @nodoc
abstract mixin class _$ManualDepositDtoCopyWith<$Res> implements $ManualDepositDtoCopyWith<$Res> {
  factory _$ManualDepositDtoCopyWith(_ManualDepositDto value, $Res Function(_ManualDepositDto) _then) = __$ManualDepositDtoCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) String id,@HiveField(1) String accountId,@HiveField(2) double amount,@HiveField(3) String description,@HiveField(4) DateTime createdAt,@HiveField(5) bool balanceApplied,@HiveField(6) String userId,@HiveField(7) double? previousBalance,@HiveField(8) double? newBalance,@HiveField(9) bool isBalanceEdit,@HiveField(10) bool synced
});




}
/// @nodoc
class __$ManualDepositDtoCopyWithImpl<$Res>
    implements _$ManualDepositDtoCopyWith<$Res> {
  __$ManualDepositDtoCopyWithImpl(this._self, this._then);

  final _ManualDepositDto _self;
  final $Res Function(_ManualDepositDto) _then;

/// Create a copy of ManualDepositDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? accountId = null,Object? amount = null,Object? description = null,Object? createdAt = null,Object? balanceApplied = null,Object? userId = null,Object? previousBalance = freezed,Object? newBalance = freezed,Object? isBalanceEdit = null,Object? synced = null,}) {
  return _then(_ManualDepositDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,balanceApplied: null == balanceApplied ? _self.balanceApplied : balanceApplied // ignore: cast_nullable_to_non_nullable
as bool,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,previousBalance: freezed == previousBalance ? _self.previousBalance : previousBalance // ignore: cast_nullable_to_non_nullable
as double?,newBalance: freezed == newBalance ? _self.newBalance : newBalance // ignore: cast_nullable_to_non_nullable
as double?,isBalanceEdit: null == isBalanceEdit ? _self.isBalanceEdit : isBalanceEdit // ignore: cast_nullable_to_non_nullable
as bool,synced: null == synced ? _self.synced : synced // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
