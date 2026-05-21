// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expense_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExpenseEntity implements DiagnosticableTreeMixin {

 String get id; String get title; String? get note; double get amount; String get paidByUserId; ExpenseType get expenseType; SplitType get splitType; List<ExpenseParticipantEntity> get participants; String? get groupId; String? get accountId; DateTime get expenseDate; DateTime get createdAt; DateTime get updatedAt; SyncStatus get syncStatus; bool get isDisabled;
/// Create a copy of ExpenseEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseEntityCopyWith<ExpenseEntity> get copyWith => _$ExpenseEntityCopyWithImpl<ExpenseEntity>(this as ExpenseEntity, _$identity);

  /// Serializes this ExpenseEntity to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ExpenseEntity'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('title', title))..add(DiagnosticsProperty('note', note))..add(DiagnosticsProperty('amount', amount))..add(DiagnosticsProperty('paidByUserId', paidByUserId))..add(DiagnosticsProperty('expenseType', expenseType))..add(DiagnosticsProperty('splitType', splitType))..add(DiagnosticsProperty('participants', participants))..add(DiagnosticsProperty('groupId', groupId))..add(DiagnosticsProperty('accountId', accountId))..add(DiagnosticsProperty('expenseDate', expenseDate))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('updatedAt', updatedAt))..add(DiagnosticsProperty('syncStatus', syncStatus))..add(DiagnosticsProperty('isDisabled', isDisabled));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.note, note) || other.note == note)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.paidByUserId, paidByUserId) || other.paidByUserId == paidByUserId)&&(identical(other.expenseType, expenseType) || other.expenseType == expenseType)&&(identical(other.splitType, splitType) || other.splitType == splitType)&&const DeepCollectionEquality().equals(other.participants, participants)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.expenseDate, expenseDate) || other.expenseDate == expenseDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.isDisabled, isDisabled) || other.isDisabled == isDisabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,note,amount,paidByUserId,expenseType,splitType,const DeepCollectionEquality().hash(participants),groupId,accountId,expenseDate,createdAt,updatedAt,syncStatus,isDisabled);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ExpenseEntity(id: $id, title: $title, note: $note, amount: $amount, paidByUserId: $paidByUserId, expenseType: $expenseType, splitType: $splitType, participants: $participants, groupId: $groupId, accountId: $accountId, expenseDate: $expenseDate, createdAt: $createdAt, updatedAt: $updatedAt, syncStatus: $syncStatus, isDisabled: $isDisabled)';
}


}

/// @nodoc
abstract mixin class $ExpenseEntityCopyWith<$Res>  {
  factory $ExpenseEntityCopyWith(ExpenseEntity value, $Res Function(ExpenseEntity) _then) = _$ExpenseEntityCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? note, double amount, String paidByUserId, ExpenseType expenseType, SplitType splitType, List<ExpenseParticipantEntity> participants, String? groupId, String? accountId, DateTime expenseDate, DateTime createdAt, DateTime updatedAt, SyncStatus syncStatus, bool isDisabled
});




}
/// @nodoc
class _$ExpenseEntityCopyWithImpl<$Res>
    implements $ExpenseEntityCopyWith<$Res> {
  _$ExpenseEntityCopyWithImpl(this._self, this._then);

  final ExpenseEntity _self;
  final $Res Function(ExpenseEntity) _then;

/// Create a copy of ExpenseEntity
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
as List<ExpenseParticipantEntity>,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
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


/// Adds pattern-matching-related methods to [ExpenseEntity].
extension ExpenseEntityPatterns on ExpenseEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExpenseEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExpenseEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExpenseEntity value)  $default,){
final _that = this;
switch (_that) {
case _ExpenseEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExpenseEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ExpenseEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? note,  double amount,  String paidByUserId,  ExpenseType expenseType,  SplitType splitType,  List<ExpenseParticipantEntity> participants,  String? groupId,  String? accountId,  DateTime expenseDate,  DateTime createdAt,  DateTime updatedAt,  SyncStatus syncStatus,  bool isDisabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExpenseEntity() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? note,  double amount,  String paidByUserId,  ExpenseType expenseType,  SplitType splitType,  List<ExpenseParticipantEntity> participants,  String? groupId,  String? accountId,  DateTime expenseDate,  DateTime createdAt,  DateTime updatedAt,  SyncStatus syncStatus,  bool isDisabled)  $default,) {final _that = this;
switch (_that) {
case _ExpenseEntity():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? note,  double amount,  String paidByUserId,  ExpenseType expenseType,  SplitType splitType,  List<ExpenseParticipantEntity> participants,  String? groupId,  String? accountId,  DateTime expenseDate,  DateTime createdAt,  DateTime updatedAt,  SyncStatus syncStatus,  bool isDisabled)?  $default,) {final _that = this;
switch (_that) {
case _ExpenseEntity() when $default != null:
return $default(_that.id,_that.title,_that.note,_that.amount,_that.paidByUserId,_that.expenseType,_that.splitType,_that.participants,_that.groupId,_that.accountId,_that.expenseDate,_that.createdAt,_that.updatedAt,_that.syncStatus,_that.isDisabled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExpenseEntity with DiagnosticableTreeMixin implements ExpenseEntity {
  const _ExpenseEntity({required this.id, required this.title, this.note, required this.amount, required this.paidByUserId, required this.expenseType, required this.splitType, required final  List<ExpenseParticipantEntity> participants, this.groupId, this.accountId, required this.expenseDate, required this.createdAt, required this.updatedAt, required this.syncStatus, this.isDisabled = false}): _participants = participants;
  factory _ExpenseEntity.fromJson(Map<String, dynamic> json) => _$ExpenseEntityFromJson(json);

@override final  String id;
@override final  String title;
@override final  String? note;
@override final  double amount;
@override final  String paidByUserId;
@override final  ExpenseType expenseType;
@override final  SplitType splitType;
 final  List<ExpenseParticipantEntity> _participants;
@override List<ExpenseParticipantEntity> get participants {
  if (_participants is EqualUnmodifiableListView) return _participants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_participants);
}

@override final  String? groupId;
@override final  String? accountId;
@override final  DateTime expenseDate;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  SyncStatus syncStatus;
@override@JsonKey() final  bool isDisabled;

/// Create a copy of ExpenseEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExpenseEntityCopyWith<_ExpenseEntity> get copyWith => __$ExpenseEntityCopyWithImpl<_ExpenseEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExpenseEntityToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ExpenseEntity'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('title', title))..add(DiagnosticsProperty('note', note))..add(DiagnosticsProperty('amount', amount))..add(DiagnosticsProperty('paidByUserId', paidByUserId))..add(DiagnosticsProperty('expenseType', expenseType))..add(DiagnosticsProperty('splitType', splitType))..add(DiagnosticsProperty('participants', participants))..add(DiagnosticsProperty('groupId', groupId))..add(DiagnosticsProperty('accountId', accountId))..add(DiagnosticsProperty('expenseDate', expenseDate))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('updatedAt', updatedAt))..add(DiagnosticsProperty('syncStatus', syncStatus))..add(DiagnosticsProperty('isDisabled', isDisabled));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExpenseEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.note, note) || other.note == note)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.paidByUserId, paidByUserId) || other.paidByUserId == paidByUserId)&&(identical(other.expenseType, expenseType) || other.expenseType == expenseType)&&(identical(other.splitType, splitType) || other.splitType == splitType)&&const DeepCollectionEquality().equals(other._participants, _participants)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.expenseDate, expenseDate) || other.expenseDate == expenseDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.syncStatus, syncStatus) || other.syncStatus == syncStatus)&&(identical(other.isDisabled, isDisabled) || other.isDisabled == isDisabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,note,amount,paidByUserId,expenseType,splitType,const DeepCollectionEquality().hash(_participants),groupId,accountId,expenseDate,createdAt,updatedAt,syncStatus,isDisabled);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ExpenseEntity(id: $id, title: $title, note: $note, amount: $amount, paidByUserId: $paidByUserId, expenseType: $expenseType, splitType: $splitType, participants: $participants, groupId: $groupId, accountId: $accountId, expenseDate: $expenseDate, createdAt: $createdAt, updatedAt: $updatedAt, syncStatus: $syncStatus, isDisabled: $isDisabled)';
}


}

/// @nodoc
abstract mixin class _$ExpenseEntityCopyWith<$Res> implements $ExpenseEntityCopyWith<$Res> {
  factory _$ExpenseEntityCopyWith(_ExpenseEntity value, $Res Function(_ExpenseEntity) _then) = __$ExpenseEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? note, double amount, String paidByUserId, ExpenseType expenseType, SplitType splitType, List<ExpenseParticipantEntity> participants, String? groupId, String? accountId, DateTime expenseDate, DateTime createdAt, DateTime updatedAt, SyncStatus syncStatus, bool isDisabled
});




}
/// @nodoc
class __$ExpenseEntityCopyWithImpl<$Res>
    implements _$ExpenseEntityCopyWith<$Res> {
  __$ExpenseEntityCopyWithImpl(this._self, this._then);

  final _ExpenseEntity _self;
  final $Res Function(_ExpenseEntity) _then;

/// Create a copy of ExpenseEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? note = freezed,Object? amount = null,Object? paidByUserId = null,Object? expenseType = null,Object? splitType = null,Object? participants = null,Object? groupId = freezed,Object? accountId = freezed,Object? expenseDate = null,Object? createdAt = null,Object? updatedAt = null,Object? syncStatus = null,Object? isDisabled = null,}) {
  return _then(_ExpenseEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,paidByUserId: null == paidByUserId ? _self.paidByUserId : paidByUserId // ignore: cast_nullable_to_non_nullable
as String,expenseType: null == expenseType ? _self.expenseType : expenseType // ignore: cast_nullable_to_non_nullable
as ExpenseType,splitType: null == splitType ? _self.splitType : splitType // ignore: cast_nullable_to_non_nullable
as SplitType,participants: null == participants ? _self._participants : participants // ignore: cast_nullable_to_non_nullable
as List<ExpenseParticipantEntity>,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
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
