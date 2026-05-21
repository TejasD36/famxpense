// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expense_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExpenseDto implements DiagnosticableTreeMixin {

@HiveField(0) String get id;@HiveField(1) String get title;@HiveField(2) String? get note;@HiveField(3) double get amount;@HiveField(4) String get paidByUserId;@HiveField(5) ExpenseType get expenseType;@HiveField(6) SplitType get splitType;@HiveField(7) List<ExpenseParticipantDto> get participants;@HiveField(8) String? get groupId;@HiveField(9) String? get accountId;@HiveField(10) DateTime get expenseDate;@HiveField(11) DateTime get createdAt;@HiveField(12) DateTime get updatedAt;@HiveField(13) SyncStatus get syncStatus;@HiveField(14) bool get isDisabled;
/// Create a copy of ExpenseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseDtoCopyWith<ExpenseDto> get copyWith => _$ExpenseDtoCopyWithImpl<ExpenseDto>(this as ExpenseDto, _$identity);

  /// Serializes this ExpenseDto to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ExpenseDto'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('title', title))..add(DiagnosticsProperty('note', note))..add(DiagnosticsProperty('amount', amount))..add(DiagnosticsProperty('paidByUserId', paidByUserId))..add(DiagnosticsProperty('expenseType', expenseType))..add(DiagnosticsProperty('splitType', splitType))..add(DiagnosticsProperty('participants', participants))..add(DiagnosticsProperty('groupId', groupId))..add(DiagnosticsProperty('accountId', accountId))..add(DiagnosticsProperty('expenseDate', expenseDate))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('updatedAt', updatedAt))..add(DiagnosticsProperty('syncStatus', syncStatus))..add(DiagnosticsProperty('isDisabled', isDisabled));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.note, note) || other.note == note)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.paidByUserId, paidByUserId) || other.paidByUserId == paidByUserId)&&(identical(other.expenseType, expenseType) || other.expenseType == expenseType)&&(identical(other.splitType, splitType) || other.splitType == splitType)&&const DeepCollectionEquality().equals(other.participants, participants)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.expenseDate, expenseDate) || other.expenseDate == expenseDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.isDisabled, isDisabled) || other.isDisabled == isDisabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,note,amount,paidByUserId,expenseType,splitType,const DeepCollectionEquality().hash(participants),groupId,accountId,expenseDate,createdAt,updatedAt,syncStatus,isDisabled);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ExpenseDto(id: $id, title: $title, note: $note, amount: $amount, paidByUserId: $paidByUserId, expenseType: $expenseType, splitType: $splitType, participants: $participants, groupId: $groupId, accountId: $accountId, expenseDate: $expenseDate, createdAt: $createdAt, updatedAt: $updatedAt, syncStatus: $syncStatus, isDisabled: $isDisabled)';
}


}

/// @nodoc
abstract mixin class $ExpenseDtoCopyWith<$Res>  {
  factory $ExpenseDtoCopyWith(ExpenseDto value, $Res Function(ExpenseDto) _then) = _$ExpenseDtoCopyWithImpl;
@useResult
$Res call({
@HiveField(0) String id,@HiveField(1) String title,@HiveField(2) String? note,@HiveField(3) double amount,@HiveField(4) String paidByUserId,@HiveField(5) ExpenseType expenseType,@HiveField(6) SplitType splitType,@HiveField(7) List<ExpenseParticipantDto> participants,@HiveField(8) String? groupId,@HiveField(9) String? accountId,@HiveField(10) DateTime expenseDate,@HiveField(11) DateTime createdAt,@HiveField(12) DateTime updatedAt,@HiveField(13) SyncStatus syncStatus,@HiveField(14) bool isDisabled
});




}
/// @nodoc
class _$ExpenseDtoCopyWithImpl<$Res>
    implements $ExpenseDtoCopyWith<$Res> {
  _$ExpenseDtoCopyWithImpl(this._self, this._then);

  final ExpenseDto _self;
  final $Res Function(ExpenseDto) _then;

/// Create a copy of ExpenseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? note = freezed,Object? amount = null,Object? paidByUserId = null,Object? expenseType = null,Object? splitType = null,Object? participants = null,Object? groupId = freezed,Object? accountId = freezed,Object? expenseDate = null,Object? createdAt = null,Object? updatedAt = null,Object? syncStatus = null,Object? isDisabled = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,paidByUserId: null == paidByUserId ? _self.paidByUserId : paidByUserId // ignore: cast_nullable_to_non_nullable
as String,expenseType: null == expenseType ? _self.expenseType : expenseType // ignore: cast_nullable_to_non_nullable
as ExpenseType,splitType: null == splitType ? _self.splitType : splitType // ignore: cast_nullable_to_non_nullable
as SplitType,participants: null == participants ? _self.participants : participants // ignore: cast_nullable_to_non_nullable
as List<ExpenseParticipantDto>,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String?,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String?,expenseDate: null == expenseDate ? _self.expenseDate : expenseDate // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SyncStatus,isDisabled: null == isDisabled ? _self.isDisabled : isDisabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ExpenseDto].
extension ExpenseDtoPatterns on ExpenseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExpenseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExpenseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExpenseDto value)  $default,){
final _that = this;
switch (_that) {
case _ExpenseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExpenseDto value)?  $default,){
final _that = this;
switch (_that) {
case _ExpenseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  String id, @HiveField(1)  String title, @HiveField(2)  String? note, @HiveField(3)  double amount, @HiveField(4)  String paidByUserId, @HiveField(5)  ExpenseType expenseType, @HiveField(6)  SplitType splitType, @HiveField(7)  List<ExpenseParticipantDto> participants, @HiveField(8)  String? groupId, @HiveField(9)  String? accountId, @HiveField(10)  DateTime expenseDate, @HiveField(11)  DateTime createdAt, @HiveField(12)  DateTime updatedAt, @HiveField(13)  SyncStatus syncStatus, @HiveField(14)  bool isDisabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExpenseDto() when $default != null:
return $default(_that.id,_that.title,_that.note,_that.amount,_that.paidByUserId,_that.expenseType,_that.splitType,_that.participants,_that.groupId,_that.accountId,_that.expenseDate,_that.createdAt,_that.updatedAt,_that.syncStatus,_that.isDisabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  String id, @HiveField(1)  String title, @HiveField(2)  String? note, @HiveField(3)  double amount, @HiveField(4)  String paidByUserId, @HiveField(5)  ExpenseType expenseType, @HiveField(6)  SplitType splitType, @HiveField(7)  List<ExpenseParticipantDto> participants, @HiveField(8)  String? groupId, @HiveField(9)  String? accountId, @HiveField(10)  DateTime expenseDate, @HiveField(11)  DateTime createdAt, @HiveField(12)  DateTime updatedAt, @HiveField(13)  SyncStatus syncStatus, @HiveField(14)  bool isDisabled)  $default,) {final _that = this;
switch (_that) {
case _ExpenseDto():
return $default(_that.id,_that.title,_that.note,_that.amount,_that.paidByUserId,_that.expenseType,_that.splitType,_that.participants,_that.groupId,_that.accountId,_that.expenseDate,_that.createdAt,_that.updatedAt,_that.syncStatus,_that.isDisabled);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  String id, @HiveField(1)  String title, @HiveField(2)  String? note, @HiveField(3)  double amount, @HiveField(4)  String paidByUserId, @HiveField(5)  ExpenseType expenseType, @HiveField(6)  SplitType splitType, @HiveField(7)  List<ExpenseParticipantDto> participants, @HiveField(8)  String? groupId, @HiveField(9)  String? accountId, @HiveField(10)  DateTime expenseDate, @HiveField(11)  DateTime createdAt, @HiveField(12)  DateTime updatedAt, @HiveField(13)  SyncStatus syncStatus, @HiveField(14)  bool isDisabled)?  $default,) {final _that = this;
switch (_that) {
case _ExpenseDto() when $default != null:
return $default(_that.id,_that.title,_that.note,_that.amount,_that.paidByUserId,_that.expenseType,_that.splitType,_that.participants,_that.groupId,_that.accountId,_that.expenseDate,_that.createdAt,_that.updatedAt,_that.syncStatus,_that.isDisabled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExpenseDto with DiagnosticableTreeMixin implements ExpenseDto {
  const _ExpenseDto({@HiveField(0) required this.id, @HiveField(1) required this.title, @HiveField(2) this.note, @HiveField(3) required this.amount, @HiveField(4) required this.paidByUserId, @HiveField(5) required this.expenseType, @HiveField(6) required this.splitType, @HiveField(7) required final  List<ExpenseParticipantDto> participants, @HiveField(8) this.groupId, @HiveField(9) this.accountId, @HiveField(10) required this.expenseDate, @HiveField(11) required this.createdAt, @HiveField(12) required this.updatedAt, @HiveField(13) required this.syncStatus, @HiveField(14) this.isDisabled = false}): _participants = participants;
  factory _ExpenseDto.fromJson(Map<String, dynamic> json) => _$ExpenseDtoFromJson(json);

@override@HiveField(0) final  String id;
@override@HiveField(1) final  String title;
@override@HiveField(2) final  String? note;
@override@HiveField(3) final  double amount;
@override@HiveField(4) final  String paidByUserId;
@override@HiveField(5) final  ExpenseType expenseType;
@override@HiveField(6) final  SplitType splitType;
 final  List<ExpenseParticipantDto> _participants;
@override@HiveField(7) List<ExpenseParticipantDto> get participants {
  if (_participants is EqualUnmodifiableListView) return _participants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_participants);
}

@override@HiveField(8) final  String? groupId;
@override@HiveField(9) final  String? accountId;
@override@HiveField(10) final  DateTime expenseDate;
@override@HiveField(11) final  DateTime createdAt;
@override@HiveField(12) final  DateTime updatedAt;
@override@HiveField(13) final  SyncStatus syncStatus;
@override@JsonKey()@HiveField(14) final  bool isDisabled;

/// Create a copy of ExpenseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExpenseDtoCopyWith<_ExpenseDto> get copyWith => __$ExpenseDtoCopyWithImpl<_ExpenseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExpenseDtoToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ExpenseDto'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('title', title))..add(DiagnosticsProperty('note', note))..add(DiagnosticsProperty('amount', amount))..add(DiagnosticsProperty('paidByUserId', paidByUserId))..add(DiagnosticsProperty('expenseType', expenseType))..add(DiagnosticsProperty('splitType', splitType))..add(DiagnosticsProperty('participants', participants))..add(DiagnosticsProperty('groupId', groupId))..add(DiagnosticsProperty('accountId', accountId))..add(DiagnosticsProperty('expenseDate', expenseDate))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('updatedAt', updatedAt))..add(DiagnosticsProperty('syncStatus', syncStatus))..add(DiagnosticsProperty('isDisabled', isDisabled));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExpenseDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.note, note) || other.note == note)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.paidByUserId, paidByUserId) || other.paidByUserId == paidByUserId)&&(identical(other.expenseType, expenseType) || other.expenseType == expenseType)&&(identical(other.splitType, splitType) || other.splitType == splitType)&&const DeepCollectionEquality().equals(other._participants, _participants)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.expenseDate, expenseDate) || other.expenseDate == expenseDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.isDisabled, isDisabled) || other.isDisabled == isDisabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,note,amount,paidByUserId,expenseType,splitType,const DeepCollectionEquality().hash(_participants),groupId,accountId,expenseDate,createdAt,updatedAt,syncStatus,isDisabled);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ExpenseDto(id: $id, title: $title, note: $note, amount: $amount, paidByUserId: $paidByUserId, expenseType: $expenseType, splitType: $splitType, participants: $participants, groupId: $groupId, accountId: $accountId, expenseDate: $expenseDate, createdAt: $createdAt, updatedAt: $updatedAt, syncStatus: $syncStatus, isDisabled: $isDisabled)';
}


}

/// @nodoc
abstract mixin class _$ExpenseDtoCopyWith<$Res> implements $ExpenseDtoCopyWith<$Res> {
  factory _$ExpenseDtoCopyWith(_ExpenseDto value, $Res Function(_ExpenseDto) _then) = __$ExpenseDtoCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) String id,@HiveField(1) String title,@HiveField(2) String? note,@HiveField(3) double amount,@HiveField(4) String paidByUserId,@HiveField(5) ExpenseType expenseType,@HiveField(6) SplitType splitType,@HiveField(7) List<ExpenseParticipantDto> participants,@HiveField(8) String? groupId,@HiveField(9) String? accountId,@HiveField(10) DateTime expenseDate,@HiveField(11) DateTime createdAt,@HiveField(12) DateTime updatedAt,@HiveField(13) SyncStatus syncStatus,@HiveField(14) bool isDisabled
});




}
/// @nodoc
class __$ExpenseDtoCopyWithImpl<$Res>
    implements _$ExpenseDtoCopyWith<$Res> {
  __$ExpenseDtoCopyWithImpl(this._self, this._then);

  final _ExpenseDto _self;
  final $Res Function(_ExpenseDto) _then;

/// Create a copy of ExpenseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? note = freezed,Object? amount = null,Object? paidByUserId = null,Object? expenseType = null,Object? splitType = null,Object? participants = null,Object? groupId = freezed,Object? accountId = freezed,Object? expenseDate = null,Object? createdAt = null,Object? updatedAt = null,Object? syncStatus = null,Object? isDisabled = null,}) {
  return _then(_ExpenseDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,paidByUserId: null == paidByUserId ? _self.paidByUserId : paidByUserId // ignore: cast_nullable_to_non_nullable
as String,expenseType: null == expenseType ? _self.expenseType : expenseType // ignore: cast_nullable_to_non_nullable
as ExpenseType,splitType: null == splitType ? _self.splitType : splitType // ignore: cast_nullable_to_non_nullable
as SplitType,participants: null == participants ? _self._participants : participants // ignore: cast_nullable_to_non_nullable
as List<ExpenseParticipantDto>,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String?,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String?,expenseDate: null == expenseDate ? _self.expenseDate : expenseDate // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,syncStatus: null == syncStatus ? _self.syncStatus : syncStatus // ignore: cast_nullable_to_non_nullable
as SyncStatus,isDisabled: null == isDisabled ? _self.isDisabled : isDisabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
