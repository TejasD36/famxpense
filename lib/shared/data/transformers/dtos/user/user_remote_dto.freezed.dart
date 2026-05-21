// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_remote_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserRemoteDto implements DiagnosticableTreeMixin {

 String get id; String get name; String get nickname; String get email; String? get profileImageUrl; DateTime get createdAt; DateTime get updatedAt; bool get isActive;
/// Create a copy of UserRemoteDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserRemoteDtoCopyWith<UserRemoteDto> get copyWith => _$UserRemoteDtoCopyWithImpl<UserRemoteDto>(this as UserRemoteDto, _$identity);

  /// Serializes this UserRemoteDto to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'UserRemoteDto'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('nickname', nickname))..add(DiagnosticsProperty('email', email))..add(DiagnosticsProperty('profileImageUrl', profileImageUrl))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('updatedAt', updatedAt))..add(DiagnosticsProperty('isActive', isActive));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserRemoteDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.email, email) || other.email == email)&&(identical(other.profileImageUrl, profileImageUrl) || other.profileImageUrl == profileImageUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,nickname,email,profileImageUrl,createdAt,updatedAt,isActive);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'UserRemoteDto(id: $id, name: $name, nickname: $nickname, email: $email, profileImageUrl: $profileImageUrl, createdAt: $createdAt, updatedAt: $updatedAt, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $UserRemoteDtoCopyWith<$Res>  {
  factory $UserRemoteDtoCopyWith(UserRemoteDto value, $Res Function(UserRemoteDto) _then) = _$UserRemoteDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name, String nickname, String email, String? profileImageUrl, DateTime createdAt, DateTime updatedAt, bool isActive
});




}
/// @nodoc
class _$UserRemoteDtoCopyWithImpl<$Res>
    implements $UserRemoteDtoCopyWith<$Res> {
  _$UserRemoteDtoCopyWithImpl(this._self, this._then);

  final UserRemoteDto _self;
  final $Res Function(UserRemoteDto) _then;

/// Create a copy of UserRemoteDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? nickname = null,Object? email = null,Object? profileImageUrl = freezed,Object? createdAt = null,Object? updatedAt = null,Object? isActive = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,profileImageUrl: freezed == profileImageUrl ? _self.profileImageUrl : profileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [UserRemoteDto].
extension UserRemoteDtoPatterns on UserRemoteDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserRemoteDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserRemoteDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserRemoteDto value)  $default,){
final _that = this;
switch (_that) {
case _UserRemoteDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserRemoteDto value)?  $default,){
final _that = this;
switch (_that) {
case _UserRemoteDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String nickname,  String email,  String? profileImageUrl,  DateTime createdAt,  DateTime updatedAt,  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserRemoteDto() when $default != null:
return $default(_that.id,_that.name,_that.nickname,_that.email,_that.profileImageUrl,_that.createdAt,_that.updatedAt,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String nickname,  String email,  String? profileImageUrl,  DateTime createdAt,  DateTime updatedAt,  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _UserRemoteDto():
return $default(_that.id,_that.name,_that.nickname,_that.email,_that.profileImageUrl,_that.createdAt,_that.updatedAt,_that.isActive);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String nickname,  String email,  String? profileImageUrl,  DateTime createdAt,  DateTime updatedAt,  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _UserRemoteDto() when $default != null:
return $default(_that.id,_that.name,_that.nickname,_that.email,_that.profileImageUrl,_that.createdAt,_that.updatedAt,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserRemoteDto with DiagnosticableTreeMixin implements UserRemoteDto {
  const _UserRemoteDto({required this.id, required this.name, required this.nickname, required this.email, this.profileImageUrl, required this.createdAt, required this.updatedAt, this.isActive = true});
  factory _UserRemoteDto.fromJson(Map<String, dynamic> json) => _$UserRemoteDtoFromJson(json);

@override final  String id;
@override final  String name;
@override final  String nickname;
@override final  String email;
@override final  String? profileImageUrl;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override@JsonKey() final  bool isActive;

/// Create a copy of UserRemoteDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserRemoteDtoCopyWith<_UserRemoteDto> get copyWith => __$UserRemoteDtoCopyWithImpl<_UserRemoteDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserRemoteDtoToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'UserRemoteDto'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('nickname', nickname))..add(DiagnosticsProperty('email', email))..add(DiagnosticsProperty('profileImageUrl', profileImageUrl))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('updatedAt', updatedAt))..add(DiagnosticsProperty('isActive', isActive));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserRemoteDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.email, email) || other.email == email)&&(identical(other.profileImageUrl, profileImageUrl) || other.profileImageUrl == profileImageUrl)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,nickname,email,profileImageUrl,createdAt,updatedAt,isActive);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'UserRemoteDto(id: $id, name: $name, nickname: $nickname, email: $email, profileImageUrl: $profileImageUrl, createdAt: $createdAt, updatedAt: $updatedAt, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$UserRemoteDtoCopyWith<$Res> implements $UserRemoteDtoCopyWith<$Res> {
  factory _$UserRemoteDtoCopyWith(_UserRemoteDto value, $Res Function(_UserRemoteDto) _then) = __$UserRemoteDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String nickname, String email, String? profileImageUrl, DateTime createdAt, DateTime updatedAt, bool isActive
});




}
/// @nodoc
class __$UserRemoteDtoCopyWithImpl<$Res>
    implements _$UserRemoteDtoCopyWith<$Res> {
  __$UserRemoteDtoCopyWithImpl(this._self, this._then);

  final _UserRemoteDto _self;
  final $Res Function(_UserRemoteDto) _then;

/// Create a copy of UserRemoteDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? nickname = null,Object? email = null,Object? profileImageUrl = freezed,Object? createdAt = null,Object? updatedAt = null,Object? isActive = null,}) {
  return _then(_UserRemoteDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,profileImageUrl: freezed == profileImageUrl ? _self.profileImageUrl : profileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
