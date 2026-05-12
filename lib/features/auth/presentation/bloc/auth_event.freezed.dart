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
mixin _$AuthEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AuthCheckAuthStatus value)?  checkAuthStatus,TResult Function( AuthLogin value)?  login,TResult Function( AuthLogout value)?  logout,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AuthCheckAuthStatus() when checkAuthStatus != null:
return checkAuthStatus(_that);case AuthLogin() when login != null:
return login(_that);case AuthLogout() when logout != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AuthCheckAuthStatus value)  checkAuthStatus,required TResult Function( AuthLogin value)  login,required TResult Function( AuthLogout value)  logout,}){
final _that = this;
switch (_that) {
case AuthCheckAuthStatus():
return checkAuthStatus(_that);case AuthLogin():
return login(_that);case AuthLogout():
return logout(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AuthCheckAuthStatus value)?  checkAuthStatus,TResult? Function( AuthLogin value)?  login,TResult? Function( AuthLogout value)?  logout,}){
final _that = this;
switch (_that) {
case AuthCheckAuthStatus() when checkAuthStatus != null:
return checkAuthStatus(_that);case AuthLogin() when login != null:
return login(_that);case AuthLogout() when logout != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  checkAuthStatus,TResult Function( String email,  String password)?  login,TResult Function()?  logout,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AuthCheckAuthStatus() when checkAuthStatus != null:
return checkAuthStatus();case AuthLogin() when login != null:
return login(_that.email,_that.password);case AuthLogout() when logout != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  checkAuthStatus,required TResult Function( String email,  String password)  login,required TResult Function()  logout,}) {final _that = this;
switch (_that) {
case AuthCheckAuthStatus():
return checkAuthStatus();case AuthLogin():
return login(_that.email,_that.password);case AuthLogout():
return logout();case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  checkAuthStatus,TResult? Function( String email,  String password)?  login,TResult? Function()?  logout,}) {final _that = this;
switch (_that) {
case AuthCheckAuthStatus() when checkAuthStatus != null:
return checkAuthStatus();case AuthLogin() when login != null:
return login(_that.email,_that.password);case AuthLogout() when logout != null:
return logout();case _:
  return null;

}
}

}

/// @nodoc


class AuthCheckAuthStatus implements AuthEvent {
  const AuthCheckAuthStatus();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthCheckAuthStatus);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.checkAuthStatus()';
}


}




/// @nodoc


class AuthLogin implements AuthEvent {
  const AuthLogin({required this.email, required this.password});
  

 final  String email;
 final  String password;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthLoginCopyWith<AuthLogin> get copyWith => _$AuthLoginCopyWithImpl<AuthLogin>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthLogin&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,email,password);

@override
String toString() {
  return 'AuthEvent.login(email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class $AuthLoginCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $AuthLoginCopyWith(AuthLogin value, $Res Function(AuthLogin) _then) = _$AuthLoginCopyWithImpl;
@useResult
$Res call({
 String email, String password
});




}
/// @nodoc
class _$AuthLoginCopyWithImpl<$Res>
    implements $AuthLoginCopyWith<$Res> {
  _$AuthLoginCopyWithImpl(this._self, this._then);

  final AuthLogin _self;
  final $Res Function(AuthLogin) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,}) {
  return _then(AuthLogin(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AuthLogout implements AuthEvent {
  const AuthLogout();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthLogout);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.logout()';
}


}




// dart format on
