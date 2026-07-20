// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationEvent implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'NotificationEvent'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'NotificationEvent()';
}


}

/// @nodoc
class $NotificationEventCopyWith<$Res>  {
$NotificationEventCopyWith(NotificationEvent _, $Res Function(NotificationEvent) __);
}


/// Adds pattern-matching-related methods to [NotificationEvent].
extension NotificationEventPatterns on NotificationEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadNotificationsEvent value)?  loadNotifications,TResult Function( MarkNotificationReadEvent value)?  markAsRead,TResult Function( DeleteNotificationEvent value)?  delete,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadNotificationsEvent() when loadNotifications != null:
return loadNotifications(_that);case MarkNotificationReadEvent() when markAsRead != null:
return markAsRead(_that);case DeleteNotificationEvent() when delete != null:
return delete(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadNotificationsEvent value)  loadNotifications,required TResult Function( MarkNotificationReadEvent value)  markAsRead,required TResult Function( DeleteNotificationEvent value)  delete,}){
final _that = this;
switch (_that) {
case LoadNotificationsEvent():
return loadNotifications(_that);case MarkNotificationReadEvent():
return markAsRead(_that);case DeleteNotificationEvent():
return delete(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadNotificationsEvent value)?  loadNotifications,TResult? Function( MarkNotificationReadEvent value)?  markAsRead,TResult? Function( DeleteNotificationEvent value)?  delete,}){
final _that = this;
switch (_that) {
case LoadNotificationsEvent() when loadNotifications != null:
return loadNotifications(_that);case MarkNotificationReadEvent() when markAsRead != null:
return markAsRead(_that);case DeleteNotificationEvent() when delete != null:
return delete(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadNotifications,TResult Function( String notificationId)?  markAsRead,TResult Function( String notificationId)?  delete,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadNotificationsEvent() when loadNotifications != null:
return loadNotifications();case MarkNotificationReadEvent() when markAsRead != null:
return markAsRead(_that.notificationId);case DeleteNotificationEvent() when delete != null:
return delete(_that.notificationId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadNotifications,required TResult Function( String notificationId)  markAsRead,required TResult Function( String notificationId)  delete,}) {final _that = this;
switch (_that) {
case LoadNotificationsEvent():
return loadNotifications();case MarkNotificationReadEvent():
return markAsRead(_that.notificationId);case DeleteNotificationEvent():
return delete(_that.notificationId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadNotifications,TResult? Function( String notificationId)?  markAsRead,TResult? Function( String notificationId)?  delete,}) {final _that = this;
switch (_that) {
case LoadNotificationsEvent() when loadNotifications != null:
return loadNotifications();case MarkNotificationReadEvent() when markAsRead != null:
return markAsRead(_that.notificationId);case DeleteNotificationEvent() when delete != null:
return delete(_that.notificationId);case _:
  return null;

}
}

}

/// @nodoc


class LoadNotificationsEvent with DiagnosticableTreeMixin implements NotificationEvent {
  const LoadNotificationsEvent();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'NotificationEvent.loadNotifications'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadNotificationsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'NotificationEvent.loadNotifications()';
}


}




/// @nodoc


class MarkNotificationReadEvent with DiagnosticableTreeMixin implements NotificationEvent {
  const MarkNotificationReadEvent({required this.notificationId});
  

 final  String notificationId;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarkNotificationReadEventCopyWith<MarkNotificationReadEvent> get copyWith => _$MarkNotificationReadEventCopyWithImpl<MarkNotificationReadEvent>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'NotificationEvent.markAsRead'))
    ..add(DiagnosticsProperty('notificationId', notificationId));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarkNotificationReadEvent&&(identical(other.notificationId, notificationId) || other.notificationId == notificationId));
}


@override
int get hashCode => Object.hash(runtimeType,notificationId);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'NotificationEvent.markAsRead(notificationId: $notificationId)';
}


}

/// @nodoc
abstract mixin class $MarkNotificationReadEventCopyWith<$Res> implements $NotificationEventCopyWith<$Res> {
  factory $MarkNotificationReadEventCopyWith(MarkNotificationReadEvent value, $Res Function(MarkNotificationReadEvent) _then) = _$MarkNotificationReadEventCopyWithImpl;
@useResult
$Res call({
 String notificationId
});




}
/// @nodoc
class _$MarkNotificationReadEventCopyWithImpl<$Res>
    implements $MarkNotificationReadEventCopyWith<$Res> {
  _$MarkNotificationReadEventCopyWithImpl(this._self, this._then);

  final MarkNotificationReadEvent _self;
  final $Res Function(MarkNotificationReadEvent) _then;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? notificationId = null,}) {
  return _then(MarkNotificationReadEvent(
notificationId: null == notificationId ? _self.notificationId : notificationId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class DeleteNotificationEvent with DiagnosticableTreeMixin implements NotificationEvent {
  const DeleteNotificationEvent({required this.notificationId});
  

 final  String notificationId;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeleteNotificationEventCopyWith<DeleteNotificationEvent> get copyWith => _$DeleteNotificationEventCopyWithImpl<DeleteNotificationEvent>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'NotificationEvent.delete'))
    ..add(DiagnosticsProperty('notificationId', notificationId));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeleteNotificationEvent&&(identical(other.notificationId, notificationId) || other.notificationId == notificationId));
}


@override
int get hashCode => Object.hash(runtimeType,notificationId);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'NotificationEvent.delete(notificationId: $notificationId)';
}


}

/// @nodoc
abstract mixin class $DeleteNotificationEventCopyWith<$Res> implements $NotificationEventCopyWith<$Res> {
  factory $DeleteNotificationEventCopyWith(DeleteNotificationEvent value, $Res Function(DeleteNotificationEvent) _then) = _$DeleteNotificationEventCopyWithImpl;
@useResult
$Res call({
 String notificationId
});




}
/// @nodoc
class _$DeleteNotificationEventCopyWithImpl<$Res>
    implements $DeleteNotificationEventCopyWith<$Res> {
  _$DeleteNotificationEventCopyWithImpl(this._self, this._then);

  final DeleteNotificationEvent _self;
  final $Res Function(DeleteNotificationEvent) _then;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? notificationId = null,}) {
  return _then(DeleteNotificationEvent(
notificationId: null == notificationId ? _self.notificationId : notificationId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$NotificationState implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'NotificationState'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'NotificationState()';
}


}

/// @nodoc
class $NotificationStateCopyWith<$Res>  {
$NotificationStateCopyWith(NotificationState _, $Res Function(NotificationState) __);
}


/// Adds pattern-matching-related methods to [NotificationState].
extension NotificationStatePatterns on NotificationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( NotificationInitial value)?  initial,TResult Function( NotificationLoading value)?  loading,TResult Function( NotificationLoaded value)?  loaded,TResult Function( NotificationError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case NotificationInitial() when initial != null:
return initial(_that);case NotificationLoading() when loading != null:
return loading(_that);case NotificationLoaded() when loaded != null:
return loaded(_that);case NotificationError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( NotificationInitial value)  initial,required TResult Function( NotificationLoading value)  loading,required TResult Function( NotificationLoaded value)  loaded,required TResult Function( NotificationError value)  error,}){
final _that = this;
switch (_that) {
case NotificationInitial():
return initial(_that);case NotificationLoading():
return loading(_that);case NotificationLoaded():
return loaded(_that);case NotificationError():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( NotificationInitial value)?  initial,TResult? Function( NotificationLoading value)?  loading,TResult? Function( NotificationLoaded value)?  loaded,TResult? Function( NotificationError value)?  error,}){
final _that = this;
switch (_that) {
case NotificationInitial() when initial != null:
return initial(_that);case NotificationLoading() when loading != null:
return loading(_that);case NotificationLoaded() when loaded != null:
return loaded(_that);case NotificationError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<NotificationDto> notifications)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case NotificationInitial() when initial != null:
return initial();case NotificationLoading() when loading != null:
return loading();case NotificationLoaded() when loaded != null:
return loaded(_that.notifications);case NotificationError() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<NotificationDto> notifications)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case NotificationInitial():
return initial();case NotificationLoading():
return loading();case NotificationLoaded():
return loaded(_that.notifications);case NotificationError():
return error(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<NotificationDto> notifications)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case NotificationInitial() when initial != null:
return initial();case NotificationLoading() when loading != null:
return loading();case NotificationLoaded() when loaded != null:
return loaded(_that.notifications);case NotificationError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class NotificationInitial with DiagnosticableTreeMixin implements NotificationState {
  const NotificationInitial();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'NotificationState.initial'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'NotificationState.initial()';
}


}




/// @nodoc


class NotificationLoading with DiagnosticableTreeMixin implements NotificationState {
  const NotificationLoading();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'NotificationState.loading'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'NotificationState.loading()';
}


}




/// @nodoc


class NotificationLoaded with DiagnosticableTreeMixin implements NotificationState {
  const NotificationLoaded(final  List<NotificationDto> notifications): _notifications = notifications;
  

 final  List<NotificationDto> _notifications;
 List<NotificationDto> get notifications {
  if (_notifications is EqualUnmodifiableListView) return _notifications;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notifications);
}


/// Create a copy of NotificationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationLoadedCopyWith<NotificationLoaded> get copyWith => _$NotificationLoadedCopyWithImpl<NotificationLoaded>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'NotificationState.loaded'))
    ..add(DiagnosticsProperty('notifications', notifications));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationLoaded&&const DeepCollectionEquality().equals(other._notifications, _notifications));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_notifications));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'NotificationState.loaded(notifications: $notifications)';
}


}

/// @nodoc
abstract mixin class $NotificationLoadedCopyWith<$Res> implements $NotificationStateCopyWith<$Res> {
  factory $NotificationLoadedCopyWith(NotificationLoaded value, $Res Function(NotificationLoaded) _then) = _$NotificationLoadedCopyWithImpl;
@useResult
$Res call({
 List<NotificationDto> notifications
});




}
/// @nodoc
class _$NotificationLoadedCopyWithImpl<$Res>
    implements $NotificationLoadedCopyWith<$Res> {
  _$NotificationLoadedCopyWithImpl(this._self, this._then);

  final NotificationLoaded _self;
  final $Res Function(NotificationLoaded) _then;

/// Create a copy of NotificationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? notifications = null,}) {
  return _then(NotificationLoaded(
null == notifications ? _self._notifications : notifications // ignore: cast_nullable_to_non_nullable
as List<NotificationDto>,
  ));
}


}

/// @nodoc


class NotificationError with DiagnosticableTreeMixin implements NotificationState {
  const NotificationError(this.message);
  

 final  String message;

/// Create a copy of NotificationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationErrorCopyWith<NotificationError> get copyWith => _$NotificationErrorCopyWithImpl<NotificationError>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'NotificationState.error'))
    ..add(DiagnosticsProperty('message', message));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'NotificationState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $NotificationErrorCopyWith<$Res> implements $NotificationStateCopyWith<$Res> {
  factory $NotificationErrorCopyWith(NotificationError value, $Res Function(NotificationError) _then) = _$NotificationErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$NotificationErrorCopyWithImpl<$Res>
    implements $NotificationErrorCopyWith<$Res> {
  _$NotificationErrorCopyWithImpl(this._self, this._then);

  final NotificationError _self;
  final $Res Function(NotificationError) _then;

/// Create a copy of NotificationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(NotificationError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
