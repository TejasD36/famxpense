// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'partnership_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PartnershipDto implements DiagnosticableTreeMixin {

@HiveField(0) String get id;/// SENDER
@HiveField(1) String get senderId;@HiveField(2) String get senderEmail;@HiveField(3) String get senderNickname;/// RECEIVER
@HiveField(4) String get receiverId;@HiveField(5) String get receiverEmail;@HiveField(6) String get receiverNickname;/// STATUS
@HiveField(7) PartnershipStatus get status;@HiveField(8) DateTime get createdAt;@HiveField(9) DateTime get updatedAt;
/// Create a copy of PartnershipDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PartnershipDtoCopyWith<PartnershipDto> get copyWith => _$PartnershipDtoCopyWithImpl<PartnershipDto>(this as PartnershipDto, _$identity);

  /// Serializes this PartnershipDto to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'PartnershipDto'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('senderId', senderId))..add(DiagnosticsProperty('senderEmail', senderEmail))..add(DiagnosticsProperty('senderNickname', senderNickname))..add(DiagnosticsProperty('receiverId', receiverId))..add(DiagnosticsProperty('receiverEmail', receiverEmail))..add(DiagnosticsProperty('receiverNickname', receiverNickname))..add(DiagnosticsProperty('status', status))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('updatedAt', updatedAt));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PartnershipDto&&(identical(other.id, id) || other.id == id)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderEmail, senderEmail) || other.senderEmail == senderEmail)&&(identical(other.senderNickname, senderNickname) || other.senderNickname == senderNickname)&&(identical(other.receiverId, receiverId) || other.receiverId == receiverId)&&(identical(other.receiverEmail, receiverEmail) || other.receiverEmail == receiverEmail)&&(identical(other.receiverNickname, receiverNickname) || other.receiverNickname == receiverNickname)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,senderId,senderEmail,senderNickname,receiverId,receiverEmail,receiverNickname,status,createdAt,updatedAt);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PartnershipDto(id: $id, senderId: $senderId, senderEmail: $senderEmail, senderNickname: $senderNickname, receiverId: $receiverId, receiverEmail: $receiverEmail, receiverNickname: $receiverNickname, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $PartnershipDtoCopyWith<$Res>  {
  factory $PartnershipDtoCopyWith(PartnershipDto value, $Res Function(PartnershipDto) _then) = _$PartnershipDtoCopyWithImpl;
@useResult
$Res call({
@HiveField(0) String id,@HiveField(1) String senderId,@HiveField(2) String senderEmail,@HiveField(3) String senderNickname,@HiveField(4) String receiverId,@HiveField(5) String receiverEmail,@HiveField(6) String receiverNickname,@HiveField(7) PartnershipStatus status,@HiveField(8) DateTime createdAt,@HiveField(9) DateTime updatedAt
});




}
/// @nodoc
class _$PartnershipDtoCopyWithImpl<$Res>
    implements $PartnershipDtoCopyWith<$Res> {
  _$PartnershipDtoCopyWithImpl(this._self, this._then);

  final PartnershipDto _self;
  final $Res Function(PartnershipDto) _then;

/// Create a copy of PartnershipDto
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


/// Adds pattern-matching-related methods to [PartnershipDto].
extension PartnershipDtoPatterns on PartnershipDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PartnershipDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PartnershipDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PartnershipDto value)  $default,){
final _that = this;
switch (_that) {
case _PartnershipDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PartnershipDto value)?  $default,){
final _that = this;
switch (_that) {
case _PartnershipDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  String id, @HiveField(1)  String senderId, @HiveField(2)  String senderEmail, @HiveField(3)  String senderNickname, @HiveField(4)  String receiverId, @HiveField(5)  String receiverEmail, @HiveField(6)  String receiverNickname, @HiveField(7)  PartnershipStatus status, @HiveField(8)  DateTime createdAt, @HiveField(9)  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PartnershipDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  String id, @HiveField(1)  String senderId, @HiveField(2)  String senderEmail, @HiveField(3)  String senderNickname, @HiveField(4)  String receiverId, @HiveField(5)  String receiverEmail, @HiveField(6)  String receiverNickname, @HiveField(7)  PartnershipStatus status, @HiveField(8)  DateTime createdAt, @HiveField(9)  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _PartnershipDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  String id, @HiveField(1)  String senderId, @HiveField(2)  String senderEmail, @HiveField(3)  String senderNickname, @HiveField(4)  String receiverId, @HiveField(5)  String receiverEmail, @HiveField(6)  String receiverNickname, @HiveField(7)  PartnershipStatus status, @HiveField(8)  DateTime createdAt, @HiveField(9)  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _PartnershipDto() when $default != null:
return $default(_that.id,_that.senderId,_that.senderEmail,_that.senderNickname,_that.receiverId,_that.receiverEmail,_that.receiverNickname,_that.status,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PartnershipDto with DiagnosticableTreeMixin implements PartnershipDto {
  const _PartnershipDto({@HiveField(0) required this.id, @HiveField(1) required this.senderId, @HiveField(2) required this.senderEmail, @HiveField(3) required this.senderNickname, @HiveField(4) required this.receiverId, @HiveField(5) required this.receiverEmail, @HiveField(6) required this.receiverNickname, @HiveField(7) required this.status, @HiveField(8) required this.createdAt, @HiveField(9) required this.updatedAt});
  factory _PartnershipDto.fromJson(Map<String, dynamic> json) => _$PartnershipDtoFromJson(json);

@override@HiveField(0) final  String id;
/// SENDER
@override@HiveField(1) final  String senderId;
@override@HiveField(2) final  String senderEmail;
@override@HiveField(3) final  String senderNickname;
/// RECEIVER
@override@HiveField(4) final  String receiverId;
@override@HiveField(5) final  String receiverEmail;
@override@HiveField(6) final  String receiverNickname;
/// STATUS
@override@HiveField(7) final  PartnershipStatus status;
@override@HiveField(8) final  DateTime createdAt;
@override@HiveField(9) final  DateTime updatedAt;

/// Create a copy of PartnershipDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PartnershipDtoCopyWith<_PartnershipDto> get copyWith => __$PartnershipDtoCopyWithImpl<_PartnershipDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PartnershipDtoToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'PartnershipDto'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('senderId', senderId))..add(DiagnosticsProperty('senderEmail', senderEmail))..add(DiagnosticsProperty('senderNickname', senderNickname))..add(DiagnosticsProperty('receiverId', receiverId))..add(DiagnosticsProperty('receiverEmail', receiverEmail))..add(DiagnosticsProperty('receiverNickname', receiverNickname))..add(DiagnosticsProperty('status', status))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('updatedAt', updatedAt));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PartnershipDto&&(identical(other.id, id) || other.id == id)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderEmail, senderEmail) || other.senderEmail == senderEmail)&&(identical(other.senderNickname, senderNickname) || other.senderNickname == senderNickname)&&(identical(other.receiverId, receiverId) || other.receiverId == receiverId)&&(identical(other.receiverEmail, receiverEmail) || other.receiverEmail == receiverEmail)&&(identical(other.receiverNickname, receiverNickname) || other.receiverNickname == receiverNickname)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,senderId,senderEmail,senderNickname,receiverId,receiverEmail,receiverNickname,status,createdAt,updatedAt);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PartnershipDto(id: $id, senderId: $senderId, senderEmail: $senderEmail, senderNickname: $senderNickname, receiverId: $receiverId, receiverEmail: $receiverEmail, receiverNickname: $receiverNickname, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$PartnershipDtoCopyWith<$Res> implements $PartnershipDtoCopyWith<$Res> {
  factory _$PartnershipDtoCopyWith(_PartnershipDto value, $Res Function(_PartnershipDto) _then) = __$PartnershipDtoCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) String id,@HiveField(1) String senderId,@HiveField(2) String senderEmail,@HiveField(3) String senderNickname,@HiveField(4) String receiverId,@HiveField(5) String receiverEmail,@HiveField(6) String receiverNickname,@HiveField(7) PartnershipStatus status,@HiveField(8) DateTime createdAt,@HiveField(9) DateTime updatedAt
});




}
/// @nodoc
class __$PartnershipDtoCopyWithImpl<$Res>
    implements _$PartnershipDtoCopyWith<$Res> {
  __$PartnershipDtoCopyWithImpl(this._self, this._then);

  final _PartnershipDto _self;
  final $Res Function(_PartnershipDto) _then;

/// Create a copy of PartnershipDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? senderId = null,Object? senderEmail = null,Object? senderNickname = null,Object? receiverId = null,Object? receiverEmail = null,Object? receiverNickname = null,Object? status = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_PartnershipDto(
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
