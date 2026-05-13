// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_expense_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AddExpenseState implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AddExpenseState'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddExpenseState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AddExpenseState()';
}


}

/// @nodoc
class $AddExpenseStateCopyWith<$Res>  {
$AddExpenseStateCopyWith(AddExpenseState _, $Res Function(AddExpenseState) __);
}


/// Adds pattern-matching-related methods to [AddExpenseState].
extension AddExpenseStatePatterns on AddExpenseState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AddExpenseInitial value)?  initial,TResult Function( AddExpenseLoading value)?  loading,TResult Function( AddExpenseSuccess value)?  success,TResult Function( AddExpenseError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AddExpenseInitial() when initial != null:
return initial(_that);case AddExpenseLoading() when loading != null:
return loading(_that);case AddExpenseSuccess() when success != null:
return success(_that);case AddExpenseError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AddExpenseInitial value)  initial,required TResult Function( AddExpenseLoading value)  loading,required TResult Function( AddExpenseSuccess value)  success,required TResult Function( AddExpenseError value)  error,}){
final _that = this;
switch (_that) {
case AddExpenseInitial():
return initial(_that);case AddExpenseLoading():
return loading(_that);case AddExpenseSuccess():
return success(_that);case AddExpenseError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AddExpenseInitial value)?  initial,TResult? Function( AddExpenseLoading value)?  loading,TResult? Function( AddExpenseSuccess value)?  success,TResult? Function( AddExpenseError value)?  error,}){
final _that = this;
switch (_that) {
case AddExpenseInitial() when initial != null:
return initial(_that);case AddExpenseLoading() when loading != null:
return loading(_that);case AddExpenseSuccess() when success != null:
return success(_that);case AddExpenseError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function()?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AddExpenseInitial() when initial != null:
return initial();case AddExpenseLoading() when loading != null:
return loading();case AddExpenseSuccess() when success != null:
return success();case AddExpenseError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function()  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case AddExpenseInitial():
return initial();case AddExpenseLoading():
return loading();case AddExpenseSuccess():
return success();case AddExpenseError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function()?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case AddExpenseInitial() when initial != null:
return initial();case AddExpenseLoading() when loading != null:
return loading();case AddExpenseSuccess() when success != null:
return success();case AddExpenseError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class AddExpenseInitial with DiagnosticableTreeMixin implements AddExpenseState {
  const AddExpenseInitial();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AddExpenseState.initial'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddExpenseInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AddExpenseState.initial()';
}


}




/// @nodoc


class AddExpenseLoading with DiagnosticableTreeMixin implements AddExpenseState {
  const AddExpenseLoading();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AddExpenseState.loading'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddExpenseLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AddExpenseState.loading()';
}


}




/// @nodoc


class AddExpenseSuccess with DiagnosticableTreeMixin implements AddExpenseState {
  const AddExpenseSuccess();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AddExpenseState.success'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddExpenseSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AddExpenseState.success()';
}


}




/// @nodoc


class AddExpenseError with DiagnosticableTreeMixin implements AddExpenseState {
  const AddExpenseError(this.message);
  

 final  String message;

/// Create a copy of AddExpenseState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddExpenseErrorCopyWith<AddExpenseError> get copyWith => _$AddExpenseErrorCopyWithImpl<AddExpenseError>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AddExpenseState.error'))
    ..add(DiagnosticsProperty('message', message));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddExpenseError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AddExpenseState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $AddExpenseErrorCopyWith<$Res> implements $AddExpenseStateCopyWith<$Res> {
  factory $AddExpenseErrorCopyWith(AddExpenseError value, $Res Function(AddExpenseError) _then) = _$AddExpenseErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$AddExpenseErrorCopyWithImpl<$Res>
    implements $AddExpenseErrorCopyWith<$Res> {
  _$AddExpenseErrorCopyWithImpl(this._self, this._then);

  final AddExpenseError _self;
  final $Res Function(AddExpenseError) _then;

/// Create a copy of AddExpenseState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(AddExpenseError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
