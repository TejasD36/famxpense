// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'partnership_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PartnershipEntity implements DiagnosticableTreeMixin {

 String get id;/// REQUEST OWNER
 String get senderId; String get senderEmail; String get senderNickname;/// REQUEST RECEIVER
 String get receiverId; String get receiverEmail; String get receiverNickname;/// STATUS
 PartnershipStatus get status; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of PartnershipEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PartnershipEntityCopyWith<PartnershipEntity> get copyWith => _$PartnershipEntityCopyWithImpl<PartnershipEntity>(this as PartnershipEntity, _$identity);

  /// Serializes this PartnershipEntity to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'PartnershipEntity'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('senderId', senderId))..add(DiagnosticsProperty('senderEmail', senderEmail))..add(DiagnosticsProperty('senderNickname', senderNickname))..add(DiagnosticsProperty('receiverId', receiverId))..add(DiagnosticsProperty('receiverEmail', receiverEmail))..add(DiagnosticsProperty('receiverNickname', receiverNickname))..add(DiagnosticsProperty('status', status))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('updatedAt', updatedAt));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PartnershipEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderEmail, senderEmail) || other.senderEmail == senderEmail)&&(identical(other.senderNickname, senderNickname) || other.senderNickname == senderNickname)&&(identical(other.receiverId, receiverId) || other.receiverId == receiverId)&&(identical(other.receiverEmail, receiverEmail) || other.receiverEmail == receiverEmail)&&(identical(other.receiverNickname, receiverNickname) || other.receiverNickname == receiverNickname)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,senderId,senderEmail,senderNickname,receiverId,receiverEmail,receiverNickname,status,createdAt,updatedAt);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PartnershipEntity(id: $id, senderId: $senderId, senderEmail: $senderEmail, senderNickname: $senderNickname, receiverId: $receiverId, receiverEmail: $receiverEmail, receiverNickname: $receiverNickname, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $PartnershipEntityCopyWith<$Res>  {
  factory $PartnershipEntityCopyWith(PartnershipEntity value, $Res Function(PartnershipEntity) _then) = _$PartnershipEntityCopyWithImpl;
@useResult
$Res call({
 String id, String senderId, String senderEmail, String senderNickname, String receiverId, String receiverEmail, String receiverNickname, PartnershipStatus status, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$PartnershipEntityCopyWithImpl<$Res>
    implements $PartnershipEntityCopyWith<$Res> {
  _$PartnershipEntityCopyWithImpl(this._self, this._then);

  final PartnershipEntity _self;
  final $Res Function(PartnershipEntity) _then;

/// Create a copy of PartnershipEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? senderId = null,Object? senderEmail = null,Object? senderNickname = null,Object? receiverId = null,Object? receiverEmail = null,Object? receiverNickname = null,Object? status = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,senderEmail: null == senderEmail ? _self.senderEmail : senderEmail // ignore: cast_nullable_to_non_nullable
as String,senderNickname: null == senderNickname ? _self.senderNickname : senderNickname // ignore: cast_nullable_to_non_nullable
as String,receiverId: null == receiverId ? _self.receiverId : receiverId // ignore: cast_nullable_to_non_nullable
as String,receiverEmail: null == receiverEmail ? _self.receiverEmail : receiverEmail // ignore: cast_nullable_to_non_nullable
as String,receiverNickname: null == receiverNickname ? _self.receiverNickname : receiverNickname // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PartnershipStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [PartnershipEntity].
extension PartnershipEntityPatterns on PartnershipEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PartnershipEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PartnershipEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PartnershipEntity value)  $default,){
final _that = this;
switch (_that) {
case _PartnershipEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PartnershipEntity value)?  $default,){
final _that = this;
switch (_that) {
case _PartnershipEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String senderId,  String senderEmail,  String senderNickname,  String receiverId,  String receiverEmail,  String receiverNickname,  PartnershipStatus status,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PartnershipEntity() when $default != null:
return $default(_that.id,_that.senderId,_that.senderEmail,_that.senderNickname,_that.receiverId,_that.receiverEmail,_that.receiverNickname,_that.status,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String senderId,  String senderEmail,  String senderNickname,  String receiverId,  String receiverEmail,  String receiverNickname,  PartnershipStatus status,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _PartnershipEntity():
return $default(_that.id,_that.senderId,_that.senderEmail,_that.senderNickname,_that.receiverId,_that.receiverEmail,_that.receiverNickname,_that.status,_that.createdAt,_that.updatedAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String senderId,  String senderEmail,  String senderNickname,  String receiverId,  String receiverEmail,  String receiverNickname,  PartnershipStatus status,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _PartnershipEntity() when $default != null:
return $default(_that.id,_that.senderId,_that.senderEmail,_that.senderNickname,_that.receiverId,_that.receiverEmail,_that.receiverNickname,_that.status,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PartnershipEntity with DiagnosticableTreeMixin implements PartnershipEntity {
  const _PartnershipEntity({required this.id, required this.senderId, required this.senderEmail, required this.senderNickname, required this.receiverId, required this.receiverEmail, required this.receiverNickname, required this.status, required this.createdAt, required this.updatedAt});
  factory _PartnershipEntity.fromJson(Map<String, dynamic> json) => _$PartnershipEntityFromJson(json);

@override final  String id;
/// REQUEST OWNER
@override final  String senderId;
@override final  String senderEmail;
@override final  String senderNickname;
/// REQUEST RECEIVER
@override final  String receiverId;
@override final  String receiverEmail;
@override final  String receiverNickname;
/// STATUS
@override final  PartnershipStatus status;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of PartnershipEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PartnershipEntityCopyWith<_PartnershipEntity> get copyWith => __$PartnershipEntityCopyWithImpl<_PartnershipEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PartnershipEntityToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'PartnershipEntity'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('senderId', senderId))..add(DiagnosticsProperty('senderEmail', senderEmail))..add(DiagnosticsProperty('senderNickname', senderNickname))..add(DiagnosticsProperty('receiverId', receiverId))..add(DiagnosticsProperty('receiverEmail', receiverEmail))..add(DiagnosticsProperty('receiverNickname', receiverNickname))..add(DiagnosticsProperty('status', status))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('updatedAt', updatedAt));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PartnershipEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderEmail, senderEmail) || other.senderEmail == senderEmail)&&(identical(other.senderNickname, senderNickname) || other.senderNickname == senderNickname)&&(identical(other.receiverId, receiverId) || other.receiverId == receiverId)&&(identical(other.receiverEmail, receiverEmail) || other.receiverEmail == receiverEmail)&&(identical(other.receiverNickname, receiverNickname) || other.receiverNickname == receiverNickname)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,senderId,senderEmail,senderNickname,receiverId,receiverEmail,receiverNickname,status,createdAt,updatedAt);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PartnershipEntity(id: $id, senderId: $senderId, senderEmail: $senderEmail, senderNickname: $senderNickname, receiverId: $receiverId, receiverEmail: $receiverEmail, receiverNickname: $receiverNickname, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$PartnershipEntityCopyWith<$Res> implements $PartnershipEntityCopyWith<$Res> {
  factory _$PartnershipEntityCopyWith(_PartnershipEntity value, $Res Function(_PartnershipEntity) _then) = __$PartnershipEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String senderId, String senderEmail, String senderNickname, String receiverId, String receiverEmail, String receiverNickname, PartnershipStatus status, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$PartnershipEntityCopyWithImpl<$Res>
    implements _$PartnershipEntityCopyWith<$Res> {
  __$PartnershipEntityCopyWithImpl(this._self, this._then);

  final _PartnershipEntity _self;
  final $Res Function(_PartnershipEntity) _then;

/// Create a copy of PartnershipEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? senderId = null,Object? senderEmail = null,Object? senderNickname = null,Object? receiverId = null,Object? receiverEmail = null,Object? receiverNickname = null,Object? status = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_PartnershipEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,senderEmail: null == senderEmail ? _self.senderEmail : senderEmail // ignore: cast_nullable_to_non_nullable
as String,senderNickname: null == senderNickname ? _self.senderNickname : senderNickname // ignore: cast_nullable_to_non_nullable
as String,receiverId: null == receiverId ? _self.receiverId : receiverId // ignore: cast_nullable_to_non_nullable
as String,receiverEmail: null == receiverEmail ? _self.receiverEmail : receiverEmail // ignore: cast_nullable_to_non_nullable
as String,receiverNickname: null == receiverNickname ? _self.receiverNickname : receiverNickname // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PartnershipStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
