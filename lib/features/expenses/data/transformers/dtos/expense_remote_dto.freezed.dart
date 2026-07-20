// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expense_remote_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExpenseRemoteDto implements DiagnosticableTreeMixin {

 String get id; String get title; String? get note; double get amount; String get paidByUserId; String? get ownerUserId; String get expenseType; String get splitType; List<Map<String, dynamic>> get participants; List<String> get participantIds; String? get groupId; String? get accountId; DateTime get expenseDate; DateTime get createdAt; DateTime get updatedAt; bool get isDisabled; String? get category; double? get latitude; double? get longitude;
/// Create a copy of ExpenseRemoteDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExpenseRemoteDtoCopyWith<ExpenseRemoteDto> get copyWith => _$ExpenseRemoteDtoCopyWithImpl<ExpenseRemoteDto>(this as ExpenseRemoteDto, _$identity);

  /// Serializes this ExpenseRemoteDto to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ExpenseRemoteDto'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('title', title))..add(DiagnosticsProperty('note', note))..add(DiagnosticsProperty('amount', amount))..add(DiagnosticsProperty('paidByUserId', paidByUserId))..add(DiagnosticsProperty('ownerUserId', ownerUserId))..add(DiagnosticsProperty('expenseType', expenseType))..add(DiagnosticsProperty('splitType', splitType))..add(DiagnosticsProperty('participants', participants))..add(DiagnosticsProperty('participantIds', participantIds))..add(DiagnosticsProperty('groupId', groupId))..add(DiagnosticsProperty('accountId', accountId))..add(DiagnosticsProperty('expenseDate', expenseDate))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('updatedAt', updatedAt))..add(DiagnosticsProperty('isDisabled', isDisabled))..add(DiagnosticsProperty('category', category))..add(DiagnosticsProperty('latitude', latitude))..add(DiagnosticsProperty('longitude', longitude));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpenseRemoteDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.note, note) || other.note == note)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.paidByUserId, paidByUserId) || other.paidByUserId == paidByUserId)&&(identical(other.ownerUserId, ownerUserId) || other.ownerUserId == ownerUserId)&&(identical(other.expenseType, expenseType) || other.expenseType == expenseType)&&(identical(other.splitType, splitType) || other.splitType == splitType)&&const DeepCollectionEquality().equals(other.participants, participants)&&const DeepCollectionEquality().equals(other.participantIds, participantIds)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.expenseDate, expenseDate) || other.expenseDate == expenseDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isDisabled, isDisabled) || other.isDisabled == isDisabled)&&(identical(other.category, category) || other.category == category)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,note,amount,paidByUserId,ownerUserId,expenseType,splitType,const DeepCollectionEquality().hash(participants),const DeepCollectionEquality().hash(participantIds),groupId,accountId,expenseDate,createdAt,updatedAt,isDisabled,category,latitude,longitude]);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ExpenseRemoteDto(id: $id, title: $title, note: $note, amount: $amount, paidByUserId: $paidByUserId, ownerUserId: $ownerUserId, expenseType: $expenseType, splitType: $splitType, participants: $participants, participantIds: $participantIds, groupId: $groupId, accountId: $accountId, expenseDate: $expenseDate, createdAt: $createdAt, updatedAt: $updatedAt, isDisabled: $isDisabled, category: $category, latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class $ExpenseRemoteDtoCopyWith<$Res>  {
  factory $ExpenseRemoteDtoCopyWith(ExpenseRemoteDto value, $Res Function(ExpenseRemoteDto) _then) = _$ExpenseRemoteDtoCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? note, double amount, String paidByUserId, String? ownerUserId, String expenseType, String splitType, List<Map<String, dynamic>> participants, List<String> participantIds, String? groupId, String? accountId, DateTime expenseDate, DateTime createdAt, DateTime updatedAt, bool isDisabled, String? category, double? latitude, double? longitude
});




}
/// @nodoc
class _$ExpenseRemoteDtoCopyWithImpl<$Res>
    implements $ExpenseRemoteDtoCopyWith<$Res> {
  _$ExpenseRemoteDtoCopyWithImpl(this._self, this._then);

  final ExpenseRemoteDto _self;
  final $Res Function(ExpenseRemoteDto) _then;

/// Create a copy of ExpenseRemoteDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? note = freezed,Object? amount = null,Object? paidByUserId = null,Object? ownerUserId = freezed,Object? expenseType = null,Object? splitType = null,Object? participants = null,Object? participantIds = null,Object? groupId = freezed,Object? accountId = freezed,Object? expenseDate = null,Object? createdAt = null,Object? updatedAt = null,Object? isDisabled = null,Object? category = freezed,Object? latitude = freezed,Object? longitude = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,paidByUserId: null == paidByUserId ? _self.paidByUserId : paidByUserId // ignore: cast_nullable_to_non_nullable
as String,ownerUserId: freezed == ownerUserId ? _self.ownerUserId : ownerUserId // ignore: cast_nullable_to_non_nullable
as String?,expenseType: null == expenseType ? _self.expenseType : expenseType // ignore: cast_nullable_to_non_nullable
as String,splitType: null == splitType ? _self.splitType : splitType // ignore: cast_nullable_to_non_nullable
as String,participants: null == participants ? _self.participants : participants // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,participantIds: null == participantIds ? _self.participantIds : participantIds // ignore: cast_nullable_to_non_nullable
as List<String>,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String?,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String?,expenseDate: null == expenseDate ? _self.expenseDate : expenseDate // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,isDisabled: null == isDisabled ? _self.isDisabled : isDisabled // ignore: cast_nullable_to_non_nullable
as bool,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [ExpenseRemoteDto].
extension ExpenseRemoteDtoPatterns on ExpenseRemoteDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExpenseRemoteDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExpenseRemoteDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExpenseRemoteDto value)  $default,){
final _that = this;
switch (_that) {
case _ExpenseRemoteDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExpenseRemoteDto value)?  $default,){
final _that = this;
switch (_that) {
case _ExpenseRemoteDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? note,  double amount,  String paidByUserId,  String? ownerUserId,  String expenseType,  String splitType,  List<Map<String, dynamic>> participants,  List<String> participantIds,  String? groupId,  String? accountId,  DateTime expenseDate,  DateTime createdAt,  DateTime updatedAt,  bool isDisabled,  String? category,  double? latitude,  double? longitude)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExpenseRemoteDto() when $default != null:
return $default(_that.id,_that.title,_that.note,_that.amount,_that.paidByUserId,_that.ownerUserId,_that.expenseType,_that.splitType,_that.participants,_that.participantIds,_that.groupId,_that.accountId,_that.expenseDate,_that.createdAt,_that.updatedAt,_that.isDisabled,_that.category,_that.latitude,_that.longitude);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? note,  double amount,  String paidByUserId,  String? ownerUserId,  String expenseType,  String splitType,  List<Map<String, dynamic>> participants,  List<String> participantIds,  String? groupId,  String? accountId,  DateTime expenseDate,  DateTime createdAt,  DateTime updatedAt,  bool isDisabled,  String? category,  double? latitude,  double? longitude)  $default,) {final _that = this;
switch (_that) {
case _ExpenseRemoteDto():
return $default(_that.id,_that.title,_that.note,_that.amount,_that.paidByUserId,_that.ownerUserId,_that.expenseType,_that.splitType,_that.participants,_that.participantIds,_that.groupId,_that.accountId,_that.expenseDate,_that.createdAt,_that.updatedAt,_that.isDisabled,_that.category,_that.latitude,_that.longitude);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? note,  double amount,  String paidByUserId,  String? ownerUserId,  String expenseType,  String splitType,  List<Map<String, dynamic>> participants,  List<String> participantIds,  String? groupId,  String? accountId,  DateTime expenseDate,  DateTime createdAt,  DateTime updatedAt,  bool isDisabled,  String? category,  double? latitude,  double? longitude)?  $default,) {final _that = this;
switch (_that) {
case _ExpenseRemoteDto() when $default != null:
return $default(_that.id,_that.title,_that.note,_that.amount,_that.paidByUserId,_that.ownerUserId,_that.expenseType,_that.splitType,_that.participants,_that.participantIds,_that.groupId,_that.accountId,_that.expenseDate,_that.createdAt,_that.updatedAt,_that.isDisabled,_that.category,_that.latitude,_that.longitude);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExpenseRemoteDto with DiagnosticableTreeMixin implements ExpenseRemoteDto {
  const _ExpenseRemoteDto({required this.id, required this.title, this.note, required this.amount, required this.paidByUserId, this.ownerUserId, required this.expenseType, required this.splitType, required final  List<Map<String, dynamic>> participants, required final  List<String> participantIds, this.groupId, this.accountId, required this.expenseDate, required this.createdAt, required this.updatedAt, this.isDisabled = false, this.category, this.latitude, this.longitude}): _participants = participants,_participantIds = participantIds;
  factory _ExpenseRemoteDto.fromJson(Map<String, dynamic> json) => _$ExpenseRemoteDtoFromJson(json);

@override final  String id;
@override final  String title;
@override final  String? note;
@override final  double amount;
@override final  String paidByUserId;
@override final  String? ownerUserId;
@override final  String expenseType;
@override final  String splitType;
 final  List<Map<String, dynamic>> _participants;
@override List<Map<String, dynamic>> get participants {
  if (_participants is EqualUnmodifiableListView) return _participants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_participants);
}

 final  List<String> _participantIds;
@override List<String> get participantIds {
  if (_participantIds is EqualUnmodifiableListView) return _participantIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_participantIds);
}

@override final  String? groupId;
@override final  String? accountId;
@override final  DateTime expenseDate;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override@JsonKey() final  bool isDisabled;
@override final  String? category;
@override final  double? latitude;
@override final  double? longitude;

/// Create a copy of ExpenseRemoteDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExpenseRemoteDtoCopyWith<_ExpenseRemoteDto> get copyWith => __$ExpenseRemoteDtoCopyWithImpl<_ExpenseRemoteDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExpenseRemoteDtoToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ExpenseRemoteDto'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('title', title))..add(DiagnosticsProperty('note', note))..add(DiagnosticsProperty('amount', amount))..add(DiagnosticsProperty('paidByUserId', paidByUserId))..add(DiagnosticsProperty('ownerUserId', ownerUserId))..add(DiagnosticsProperty('expenseType', expenseType))..add(DiagnosticsProperty('splitType', splitType))..add(DiagnosticsProperty('participants', participants))..add(DiagnosticsProperty('participantIds', participantIds))..add(DiagnosticsProperty('groupId', groupId))..add(DiagnosticsProperty('accountId', accountId))..add(DiagnosticsProperty('expenseDate', expenseDate))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('updatedAt', updatedAt))..add(DiagnosticsProperty('isDisabled', isDisabled))..add(DiagnosticsProperty('category', category))..add(DiagnosticsProperty('latitude', latitude))..add(DiagnosticsProperty('longitude', longitude));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExpenseRemoteDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.note, note) || other.note == note)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.paidByUserId, paidByUserId) || other.paidByUserId == paidByUserId)&&(identical(other.ownerUserId, ownerUserId) || other.ownerUserId == ownerUserId)&&(identical(other.expenseType, expenseType) || other.expenseType == expenseType)&&(identical(other.splitType, splitType) || other.splitType == splitType)&&const DeepCollectionEquality().equals(other._participants, _participants)&&const DeepCollectionEquality().equals(other._participantIds, _participantIds)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.expenseDate, expenseDate) || other.expenseDate == expenseDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isDisabled, isDisabled) || other.isDisabled == isDisabled)&&(identical(other.category, category) || other.category == category)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,note,amount,paidByUserId,ownerUserId,expenseType,splitType,const DeepCollectionEquality().hash(_participants),const DeepCollectionEquality().hash(_participantIds),groupId,accountId,expenseDate,createdAt,updatedAt,isDisabled,category,latitude,longitude]);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ExpenseRemoteDto(id: $id, title: $title, note: $note, amount: $amount, paidByUserId: $paidByUserId, ownerUserId: $ownerUserId, expenseType: $expenseType, splitType: $splitType, participants: $participants, participantIds: $participantIds, groupId: $groupId, accountId: $accountId, expenseDate: $expenseDate, createdAt: $createdAt, updatedAt: $updatedAt, isDisabled: $isDisabled, category: $category, latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class _$ExpenseRemoteDtoCopyWith<$Res> implements $ExpenseRemoteDtoCopyWith<$Res> {
  factory _$ExpenseRemoteDtoCopyWith(_ExpenseRemoteDto value, $Res Function(_ExpenseRemoteDto) _then) = __$ExpenseRemoteDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? note, double amount, String paidByUserId, String? ownerUserId, String expenseType, String splitType, List<Map<String, dynamic>> participants, List<String> participantIds, String? groupId, String? accountId, DateTime expenseDate, DateTime createdAt, DateTime updatedAt, bool isDisabled, String? category, double? latitude, double? longitude
});




}
/// @nodoc
class __$ExpenseRemoteDtoCopyWithImpl<$Res>
    implements _$ExpenseRemoteDtoCopyWith<$Res> {
  __$ExpenseRemoteDtoCopyWithImpl(this._self, this._then);

  final _ExpenseRemoteDto _self;
  final $Res Function(_ExpenseRemoteDto) _then;

/// Create a copy of ExpenseRemoteDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? note = freezed,Object? amount = null,Object? paidByUserId = null,Object? ownerUserId = freezed,Object? expenseType = null,Object? splitType = null,Object? participants = null,Object? participantIds = null,Object? groupId = freezed,Object? accountId = freezed,Object? expenseDate = null,Object? createdAt = null,Object? updatedAt = null,Object? isDisabled = null,Object? category = freezed,Object? latitude = freezed,Object? longitude = freezed,}) {
  return _then(_ExpenseRemoteDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,paidByUserId: null == paidByUserId ? _self.paidByUserId : paidByUserId // ignore: cast_nullable_to_non_nullable
as String,ownerUserId: freezed == ownerUserId ? _self.ownerUserId : ownerUserId // ignore: cast_nullable_to_non_nullable
as String?,expenseType: null == expenseType ? _self.expenseType : expenseType // ignore: cast_nullable_to_non_nullable
as String,splitType: null == splitType ? _self.splitType : splitType // ignore: cast_nullable_to_non_nullable
as String,participants: null == participants ? _self._participants : participants // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,participantIds: null == participantIds ? _self._participantIds : participantIds // ignore: cast_nullable_to_non_nullable
as List<String>,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String?,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String?,expenseDate: null == expenseDate ? _self.expenseDate : expenseDate // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,isDisabled: null == isDisabled ? _self.isDisabled : isDisabled // ignore: cast_nullable_to_non_nullable
as bool,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
