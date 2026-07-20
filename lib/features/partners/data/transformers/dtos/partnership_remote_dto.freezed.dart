// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'partnership_remote_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PartnershipRemoteDto implements DiagnosticableTreeMixin {

 String get id; String get senderId; String get receiverId; String get senderEmail; String get receiverEmail; String get senderNickname; String get receiverNickname; String get status; DateTime get createdAt; DateTime get updatedAt; List<String> get participantIds;
/// Create a copy of PartnershipRemoteDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PartnershipRemoteDtoCopyWith<PartnershipRemoteDto> get copyWith => _$PartnershipRemoteDtoCopyWithImpl<PartnershipRemoteDto>(this as PartnershipRemoteDto, _$identity);

  /// Serializes this PartnershipRemoteDto to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'PartnershipRemoteDto'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('senderId', senderId))..add(DiagnosticsProperty('receiverId', receiverId))..add(DiagnosticsProperty('senderEmail', senderEmail))..add(DiagnosticsProperty('receiverEmail', receiverEmail))..add(DiagnosticsProperty('senderNickname', senderNickname))..add(DiagnosticsProperty('receiverNickname', receiverNickname))..add(DiagnosticsProperty('status', status))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('updatedAt', updatedAt))..add(DiagnosticsProperty('participantIds', participantIds));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PartnershipRemoteDto&&(identical(other.id, id) || other.id == id)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.receiverId, receiverId) || other.receiverId == receiverId)&&(identical(other.senderEmail, senderEmail) || other.senderEmail == senderEmail)&&(identical(other.receiverEmail, receiverEmail) || other.receiverEmail == receiverEmail)&&(identical(other.senderNickname, senderNickname) || other.senderNickname == senderNickname)&&(identical(other.receiverNickname, receiverNickname) || other.receiverNickname == receiverNickname)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.participantIds, participantIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,senderId,receiverId,senderEmail,receiverEmail,senderNickname,receiverNickname,status,createdAt,updatedAt,const DeepCollectionEquality().hash(participantIds));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PartnershipRemoteDto(id: $id, senderId: $senderId, receiverId: $receiverId, senderEmail: $senderEmail, receiverEmail: $receiverEmail, senderNickname: $senderNickname, receiverNickname: $receiverNickname, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, participantIds: $participantIds)';
}


}

/// @nodoc
abstract mixin class $PartnershipRemoteDtoCopyWith<$Res>  {
  factory $PartnershipRemoteDtoCopyWith(PartnershipRemoteDto value, $Res Function(PartnershipRemoteDto) _then) = _$PartnershipRemoteDtoCopyWithImpl;
@useResult
$Res call({
 String id, String senderId, String receiverId, String senderEmail, String receiverEmail, String senderNickname, String receiverNickname, String status, DateTime createdAt, DateTime updatedAt, List<String> participantIds
});




}
/// @nodoc
class _$PartnershipRemoteDtoCopyWithImpl<$Res>
    implements $PartnershipRemoteDtoCopyWith<$Res> {
  _$PartnershipRemoteDtoCopyWithImpl(this._self, this._then);

  final PartnershipRemoteDto _self;
  final $Res Function(PartnershipRemoteDto) _then;

/// Create a copy of PartnershipRemoteDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? senderId = null,Object? receiverId = null,Object? senderEmail = null,Object? receiverEmail = null,Object? senderNickname = null,Object? receiverNickname = null,Object? status = null,Object? createdAt = null,Object? updatedAt = null,Object? participantIds = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,receiverId: null == receiverId ? _self.receiverId : receiverId // ignore: cast_nullable_to_non_nullable
as String,senderEmail: null == senderEmail ? _self.senderEmail : senderEmail // ignore: cast_nullable_to_non_nullable
as String,receiverEmail: null == receiverEmail ? _self.receiverEmail : receiverEmail // ignore: cast_nullable_to_non_nullable
as String,senderNickname: null == senderNickname ? _self.senderNickname : senderNickname // ignore: cast_nullable_to_non_nullable
as String,receiverNickname: null == receiverNickname ? _self.receiverNickname : receiverNickname // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,participantIds: null == participantIds ? _self.participantIds : participantIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [PartnershipRemoteDto].
extension PartnershipRemoteDtoPatterns on PartnershipRemoteDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PartnershipRemoteDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PartnershipRemoteDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PartnershipRemoteDto value)  $default,){
final _that = this;
switch (_that) {
case _PartnershipRemoteDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PartnershipRemoteDto value)?  $default,){
final _that = this;
switch (_that) {
case _PartnershipRemoteDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String senderId,  String receiverId,  String senderEmail,  String receiverEmail,  String senderNickname,  String receiverNickname,  String status,  DateTime createdAt,  DateTime updatedAt,  List<String> participantIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PartnershipRemoteDto() when $default != null:
return $default(_that.id,_that.senderId,_that.receiverId,_that.senderEmail,_that.receiverEmail,_that.senderNickname,_that.receiverNickname,_that.status,_that.createdAt,_that.updatedAt,_that.participantIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String senderId,  String receiverId,  String senderEmail,  String receiverEmail,  String senderNickname,  String receiverNickname,  String status,  DateTime createdAt,  DateTime updatedAt,  List<String> participantIds)  $default,) {final _that = this;
switch (_that) {
case _PartnershipRemoteDto():
return $default(_that.id,_that.senderId,_that.receiverId,_that.senderEmail,_that.receiverEmail,_that.senderNickname,_that.receiverNickname,_that.status,_that.createdAt,_that.updatedAt,_that.participantIds);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String senderId,  String receiverId,  String senderEmail,  String receiverEmail,  String senderNickname,  String receiverNickname,  String status,  DateTime createdAt,  DateTime updatedAt,  List<String> participantIds)?  $default,) {final _that = this;
switch (_that) {
case _PartnershipRemoteDto() when $default != null:
return $default(_that.id,_that.senderId,_that.receiverId,_that.senderEmail,_that.receiverEmail,_that.senderNickname,_that.receiverNickname,_that.status,_that.createdAt,_that.updatedAt,_that.participantIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PartnershipRemoteDto with DiagnosticableTreeMixin implements PartnershipRemoteDto {
  const _PartnershipRemoteDto({required this.id, required this.senderId, required this.receiverId, required this.senderEmail, required this.receiverEmail, required this.senderNickname, required this.receiverNickname, required this.status, required this.createdAt, required this.updatedAt, final  List<String> participantIds = const []}): _participantIds = participantIds;
  factory _PartnershipRemoteDto.fromJson(Map<String, dynamic> json) => _$PartnershipRemoteDtoFromJson(json);

@override final  String id;
@override final  String senderId;
@override final  String receiverId;
@override final  String senderEmail;
@override final  String receiverEmail;
@override final  String senderNickname;
@override final  String receiverNickname;
@override final  String status;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
 final  List<String> _participantIds;
@override@JsonKey() List<String> get participantIds {
  if (_participantIds is EqualUnmodifiableListView) return _participantIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_participantIds);
}


/// Create a copy of PartnershipRemoteDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PartnershipRemoteDtoCopyWith<_PartnershipRemoteDto> get copyWith => __$PartnershipRemoteDtoCopyWithImpl<_PartnershipRemoteDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PartnershipRemoteDtoToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'PartnershipRemoteDto'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('senderId', senderId))..add(DiagnosticsProperty('receiverId', receiverId))..add(DiagnosticsProperty('senderEmail', senderEmail))..add(DiagnosticsProperty('receiverEmail', receiverEmail))..add(DiagnosticsProperty('senderNickname', senderNickname))..add(DiagnosticsProperty('receiverNickname', receiverNickname))..add(DiagnosticsProperty('status', status))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('updatedAt', updatedAt))..add(DiagnosticsProperty('participantIds', participantIds));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PartnershipRemoteDto&&(identical(other.id, id) || other.id == id)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.receiverId, receiverId) || other.receiverId == receiverId)&&(identical(other.senderEmail, senderEmail) || other.senderEmail == senderEmail)&&(identical(other.receiverEmail, receiverEmail) || other.receiverEmail == receiverEmail)&&(identical(other.senderNickname, senderNickname) || other.senderNickname == senderNickname)&&(identical(other.receiverNickname, receiverNickname) || other.receiverNickname == receiverNickname)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._participantIds, _participantIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,senderId,receiverId,senderEmail,receiverEmail,senderNickname,receiverNickname,status,createdAt,updatedAt,const DeepCollectionEquality().hash(_participantIds));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PartnershipRemoteDto(id: $id, senderId: $senderId, receiverId: $receiverId, senderEmail: $senderEmail, receiverEmail: $receiverEmail, senderNickname: $senderNickname, receiverNickname: $receiverNickname, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, participantIds: $participantIds)';
}


}

/// @nodoc
abstract mixin class _$PartnershipRemoteDtoCopyWith<$Res> implements $PartnershipRemoteDtoCopyWith<$Res> {
  factory _$PartnershipRemoteDtoCopyWith(_PartnershipRemoteDto value, $Res Function(_PartnershipRemoteDto) _then) = __$PartnershipRemoteDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String senderId, String receiverId, String senderEmail, String receiverEmail, String senderNickname, String receiverNickname, String status, DateTime createdAt, DateTime updatedAt, List<String> participantIds
});




}
/// @nodoc
class __$PartnershipRemoteDtoCopyWithImpl<$Res>
    implements _$PartnershipRemoteDtoCopyWith<$Res> {
  __$PartnershipRemoteDtoCopyWithImpl(this._self, this._then);

  final _PartnershipRemoteDto _self;
  final $Res Function(_PartnershipRemoteDto) _then;

/// Create a copy of PartnershipRemoteDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? senderId = null,Object? receiverId = null,Object? senderEmail = null,Object? receiverEmail = null,Object? senderNickname = null,Object? receiverNickname = null,Object? status = null,Object? createdAt = null,Object? updatedAt = null,Object? participantIds = null,}) {
  return _then(_PartnershipRemoteDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,receiverId: null == receiverId ? _self.receiverId : receiverId // ignore: cast_nullable_to_non_nullable
as String,senderEmail: null == senderEmail ? _self.senderEmail : senderEmail // ignore: cast_nullable_to_non_nullable
as String,receiverEmail: null == receiverEmail ? _self.receiverEmail : receiverEmail // ignore: cast_nullable_to_non_nullable
as String,senderNickname: null == senderNickname ? _self.senderNickname : senderNickname // ignore: cast_nullable_to_non_nullable
as String,receiverNickname: null == receiverNickname ? _self.receiverNickname : receiverNickname // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,participantIds: null == participantIds ? _self._participantIds : participantIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
