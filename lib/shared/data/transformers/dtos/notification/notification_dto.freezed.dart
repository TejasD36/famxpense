// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationDto implements DiagnosticableTreeMixin {

@HiveField(0) String get id;@HiveField(1) String get userId;@HiveField(2) NotificationType get type;@HiveField(3) String get title;@HiveField(4) String get message;@HiveField(5) String? get relatedId;@HiveField(6) DateTime get createdAt;@HiveField(7) bool get isRead;
/// Create a copy of NotificationDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationDtoCopyWith<NotificationDto> get copyWith => _$NotificationDtoCopyWithImpl<NotificationDto>(this as NotificationDto, _$identity);

  /// Serializes this NotificationDto to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'NotificationDto'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('userId', userId))..add(DiagnosticsProperty('type', type))..add(DiagnosticsProperty('title', title))..add(DiagnosticsProperty('message', message))..add(DiagnosticsProperty('relatedId', relatedId))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('isRead', isRead));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationDto&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.message, message) || other.message == message)&&(identical(other.relatedId, relatedId) || other.relatedId == relatedId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isRead, isRead) || other.isRead == isRead));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,type,title,message,relatedId,createdAt,isRead);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'NotificationDto(id: $id, userId: $userId, type: $type, title: $title, message: $message, relatedId: $relatedId, createdAt: $createdAt, isRead: $isRead)';
}


}

/// @nodoc
abstract mixin class $NotificationDtoCopyWith<$Res>  {
  factory $NotificationDtoCopyWith(NotificationDto value, $Res Function(NotificationDto) _then) = _$NotificationDtoCopyWithImpl;
@useResult
$Res call({
@HiveField(0) String id,@HiveField(1) String userId,@HiveField(2) NotificationType type,@HiveField(3) String title,@HiveField(4) String message,@HiveField(5) String? relatedId,@HiveField(6) DateTime createdAt,@HiveField(7) bool isRead
});




}
/// @nodoc
class _$NotificationDtoCopyWithImpl<$Res>
    implements $NotificationDtoCopyWith<$Res> {
  _$NotificationDtoCopyWithImpl(this._self, this._then);

  final NotificationDto _self;
  final $Res Function(NotificationDto) _then;

/// Create a copy of NotificationDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? type = null,Object? title = null,Object? message = null,Object? relatedId = freezed,Object? createdAt = null,Object? isRead = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as NotificationType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,relatedId: freezed == relatedId ? _self.relatedId : relatedId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationDto].
extension NotificationDtoPatterns on NotificationDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationDto value)  $default,){
final _that = this;
switch (_that) {
case _NotificationDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationDto value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  String id, @HiveField(1)  String userId, @HiveField(2)  NotificationType type, @HiveField(3)  String title, @HiveField(4)  String message, @HiveField(5)  String? relatedId, @HiveField(6)  DateTime createdAt, @HiveField(7)  bool isRead)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationDto() when $default != null:
return $default(_that.id,_that.userId,_that.type,_that.title,_that.message,_that.relatedId,_that.createdAt,_that.isRead);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  String id, @HiveField(1)  String userId, @HiveField(2)  NotificationType type, @HiveField(3)  String title, @HiveField(4)  String message, @HiveField(5)  String? relatedId, @HiveField(6)  DateTime createdAt, @HiveField(7)  bool isRead)  $default,) {final _that = this;
switch (_that) {
case _NotificationDto():
return $default(_that.id,_that.userId,_that.type,_that.title,_that.message,_that.relatedId,_that.createdAt,_that.isRead);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  String id, @HiveField(1)  String userId, @HiveField(2)  NotificationType type, @HiveField(3)  String title, @HiveField(4)  String message, @HiveField(5)  String? relatedId, @HiveField(6)  DateTime createdAt, @HiveField(7)  bool isRead)?  $default,) {final _that = this;
switch (_that) {
case _NotificationDto() when $default != null:
return $default(_that.id,_that.userId,_that.type,_that.title,_that.message,_that.relatedId,_that.createdAt,_that.isRead);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationDto with DiagnosticableTreeMixin implements NotificationDto {
  const _NotificationDto({@HiveField(0) required this.id, @HiveField(1) required this.userId, @HiveField(2) required this.type, @HiveField(3) required this.title, @HiveField(4) required this.message, @HiveField(5) this.relatedId, @HiveField(6) required this.createdAt, @HiveField(7) this.isRead = false});
  factory _NotificationDto.fromJson(Map<String, dynamic> json) => _$NotificationDtoFromJson(json);

@override@HiveField(0) final  String id;
@override@HiveField(1) final  String userId;
@override@HiveField(2) final  NotificationType type;
@override@HiveField(3) final  String title;
@override@HiveField(4) final  String message;
@override@HiveField(5) final  String? relatedId;
@override@HiveField(6) final  DateTime createdAt;
@override@JsonKey()@HiveField(7) final  bool isRead;

/// Create a copy of NotificationDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationDtoCopyWith<_NotificationDto> get copyWith => __$NotificationDtoCopyWithImpl<_NotificationDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationDtoToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'NotificationDto'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('userId', userId))..add(DiagnosticsProperty('type', type))..add(DiagnosticsProperty('title', title))..add(DiagnosticsProperty('message', message))..add(DiagnosticsProperty('relatedId', relatedId))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('isRead', isRead));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationDto&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.message, message) || other.message == message)&&(identical(other.relatedId, relatedId) || other.relatedId == relatedId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isRead, isRead) || other.isRead == isRead));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,type,title,message,relatedId,createdAt,isRead);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'NotificationDto(id: $id, userId: $userId, type: $type, title: $title, message: $message, relatedId: $relatedId, createdAt: $createdAt, isRead: $isRead)';
}


}

/// @nodoc
abstract mixin class _$NotificationDtoCopyWith<$Res> implements $NotificationDtoCopyWith<$Res> {
  factory _$NotificationDtoCopyWith(_NotificationDto value, $Res Function(_NotificationDto) _then) = __$NotificationDtoCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) String id,@HiveField(1) String userId,@HiveField(2) NotificationType type,@HiveField(3) String title,@HiveField(4) String message,@HiveField(5) String? relatedId,@HiveField(6) DateTime createdAt,@HiveField(7) bool isRead
});




}
/// @nodoc
class __$NotificationDtoCopyWithImpl<$Res>
    implements _$NotificationDtoCopyWith<$Res> {
  __$NotificationDtoCopyWithImpl(this._self, this._then);

  final _NotificationDto _self;
  final $Res Function(_NotificationDto) _then;

/// Create a copy of NotificationDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? type = null,Object? title = null,Object? message = null,Object? relatedId = freezed,Object? createdAt = null,Object? isRead = null,}) {
  return _then(_NotificationDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as NotificationType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,relatedId: freezed == relatedId ? _self.relatedId : relatedId // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
