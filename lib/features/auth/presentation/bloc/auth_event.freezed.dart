// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthEvent implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AuthEvent'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AuthEvent()';
}


}

/// @nodoc
class $AuthEventCopyWith<$Res>  {
$AuthEventCopyWith(AuthEvent _, $Res Function(AuthEvent) __);
}


/// Adds pattern-matching-related methods to [AuthEvent].
extension AuthEventPatterns on AuthEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CheckAuthStatusEvent value)?  checkAuthStatus,TResult Function( LoginEvent value)?  login,TResult Function( RegisterEvent value)?  register,TResult Function( ForgotPasswordEvent value)?  forgotPassword,TResult Function( LogoutEvent value)?  logout,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CheckAuthStatusEvent() when checkAuthStatus != null:
return checkAuthStatus(_that);case LoginEvent() when login != null:
return login(_that);case RegisterEvent() when register != null:
return register(_that);case ForgotPasswordEvent() when forgotPassword != null:
return forgotPassword(_that);case LogoutEvent() when logout != null:
return logout(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CheckAuthStatusEvent value)  checkAuthStatus,required TResult Function( LoginEvent value)  login,required TResult Function( RegisterEvent value)  register,required TResult Function( ForgotPasswordEvent value)  forgotPassword,required TResult Function( LogoutEvent value)  logout,}){
final _that = this;
switch (_that) {
case CheckAuthStatusEvent():
return checkAuthStatus(_that);case LoginEvent():
return login(_that);case RegisterEvent():
return register(_that);case ForgotPasswordEvent():
return forgotPassword(_that);case LogoutEvent():
return logout(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CheckAuthStatusEvent value)?  checkAuthStatus,TResult? Function( LoginEvent value)?  login,TResult? Function( RegisterEvent value)?  register,TResult? Function( ForgotPasswordEvent value)?  forgotPassword,TResult? Function( LogoutEvent value)?  logout,}){
final _that = this;
switch (_that) {
case CheckAuthStatusEvent() when checkAuthStatus != null:
return checkAuthStatus(_that);case LoginEvent() when login != null:
return login(_that);case RegisterEvent() when register != null:
return register(_that);case ForgotPasswordEvent() when forgotPassword != null:
return forgotPassword(_that);case LogoutEvent() when logout != null:
return logout(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  checkAuthStatus,TResult Function( String email,  String password)?  login,TResult Function( String name,  String? nickname,  String email,  String password)?  register,TResult Function( String email)?  forgotPassword,TResult Function()?  logout,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CheckAuthStatusEvent() when checkAuthStatus != null:
return checkAuthStatus();case LoginEvent() when login != null:
return login(_that.email,_that.password);case RegisterEvent() when register != null:
return register(_that.name,_that.nickname,_that.email,_that.password);case ForgotPasswordEvent() when forgotPassword != null:
return forgotPassword(_that.email);case LogoutEvent() when logout != null:
return logout();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  checkAuthStatus,required TResult Function( String email,  String password)  login,required TResult Function( String name,  String? nickname,  String email,  String password)  register,required TResult Function( String email)  forgotPassword,required TResult Function()  logout,}) {final _that = this;
switch (_that) {
case CheckAuthStatusEvent():
return checkAuthStatus();case LoginEvent():
return login(_that.email,_that.password);case RegisterEvent():
return register(_that.name,_that.nickname,_that.email,_that.password);case ForgotPasswordEvent():
return forgotPassword(_that.email);case LogoutEvent():
return logout();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  checkAuthStatus,TResult? Function( String email,  String password)?  login,TResult? Function( String name,  String? nickname,  String email,  String password)?  register,TResult? Function( String email)?  forgotPassword,TResult? Function()?  logout,}) {final _that = this;
switch (_that) {
case CheckAuthStatusEvent() when checkAuthStatus != null:
return checkAuthStatus();case LoginEvent() when login != null:
return login(_that.email,_that.password);case RegisterEvent() when register != null:
return register(_that.name,_that.nickname,_that.email,_that.password);case ForgotPasswordEvent() when forgotPassword != null:
return forgotPassword(_that.email);case LogoutEvent() when logout != null:
return logout();case _:
  return null;

}
}

}

/// @nodoc


class CheckAuthStatusEvent with DiagnosticableTreeMixin implements AuthEvent {
  const CheckAuthStatusEvent();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AuthEvent.checkAuthStatus'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckAuthStatusEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AuthEvent.checkAuthStatus()';
}


}




/// @nodoc


class LoginEvent with DiagnosticableTreeMixin implements AuthEvent {
  const LoginEvent({required this.email, required this.password});
  

 final  String email;
 final  String password;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginEventCopyWith<LoginEvent> get copyWith => _$LoginEventCopyWithImpl<LoginEvent>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AuthEvent.login'))
    ..add(DiagnosticsProperty('email', email))..add(DiagnosticsProperty('password', password));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginEvent&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,email,password);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AuthEvent.login(email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class $LoginEventCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $LoginEventCopyWith(LoginEvent value, $Res Function(LoginEvent) _then) = _$LoginEventCopyWithImpl;
@useResult
$Res call({
 String email, String password
});




}
/// @nodoc
class _$LoginEventCopyWithImpl<$Res>
    implements $LoginEventCopyWith<$Res> {
  _$LoginEventCopyWithImpl(this._self, this._then);

  final LoginEvent _self;
  final $Res Function(LoginEvent) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,}) {
  return _then(LoginEvent(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RegisterEvent with DiagnosticableTreeMixin implements AuthEvent {
  const RegisterEvent({required this.name, this.nickname, required this.email, required this.password});
  

 final  String name;
 final  String? nickname;
 final  String email;
 final  String password;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterEventCopyWith<RegisterEvent> get copyWith => _$RegisterEventCopyWithImpl<RegisterEvent>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AuthEvent.register'))
    ..add(DiagnosticsProperty('name', name))..add(DiagnosticsProperty('nickname', nickname))..add(DiagnosticsProperty('email', email))..add(DiagnosticsProperty('password', password));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterEvent&&(identical(other.name, name) || other.name == name)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,name,nickname,email,password);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AuthEvent.register(name: $name, nickname: $nickname, email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class $RegisterEventCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $RegisterEventCopyWith(RegisterEvent value, $Res Function(RegisterEvent) _then) = _$RegisterEventCopyWithImpl;
@useResult
$Res call({
 String name, String? nickname, String email, String password
});




}
/// @nodoc
class _$RegisterEventCopyWithImpl<$Res>
    implements $RegisterEventCopyWith<$Res> {
  _$RegisterEventCopyWithImpl(this._self, this._then);

  final RegisterEvent _self;
  final $Res Function(RegisterEvent) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,Object? nickname = freezed,Object? email = null,Object? password = null,}) {
  return _then(RegisterEvent(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,nickname: freezed == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String?,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ForgotPasswordEvent with DiagnosticableTreeMixin implements AuthEvent {
  const ForgotPasswordEvent({required this.email});
  

 final  String email;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ForgotPasswordEventCopyWith<ForgotPasswordEvent> get copyWith => _$ForgotPasswordEventCopyWithImpl<ForgotPasswordEvent>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AuthEvent.forgotPassword'))
    ..add(DiagnosticsProperty('email', email));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForgotPasswordEvent&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AuthEvent.forgotPassword(email: $email)';
}


}

/// @nodoc
abstract mixin class $ForgotPasswordEventCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $ForgotPasswordEventCopyWith(ForgotPasswordEvent value, $Res Function(ForgotPasswordEvent) _then) = _$ForgotPasswordEventCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class _$ForgotPasswordEventCopyWithImpl<$Res>
    implements $ForgotPasswordEventCopyWith<$Res> {
  _$ForgotPasswordEventCopyWithImpl(this._self, this._then);

  final ForgotPasswordEvent _self;
  final $Res Function(ForgotPasswordEvent) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(ForgotPasswordEvent(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class LogoutEvent with DiagnosticableTreeMixin implements AuthEvent {
  const LogoutEvent();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AuthEvent.logout'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LogoutEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AuthEvent.logout()';
}


}




// dart format on
