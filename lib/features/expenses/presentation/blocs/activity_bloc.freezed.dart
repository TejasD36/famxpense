// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'activity_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ActivityEvent implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ActivityEvent'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ActivityEvent()';
}


}

/// @nodoc
class $ActivityEventCopyWith<$Res>  {
$ActivityEventCopyWith(ActivityEvent _, $Res Function(ActivityEvent) __);
}


/// Adds pattern-matching-related methods to [ActivityEvent].
extension ActivityEventPatterns on ActivityEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadExpensesEvent value)?  loadExpenses,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadExpensesEvent() when loadExpenses != null:
return loadExpenses(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadExpensesEvent value)  loadExpenses,}){
final _that = this;
switch (_that) {
case LoadExpensesEvent():
return loadExpenses(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadExpensesEvent value)?  loadExpenses,}){
final _that = this;
switch (_that) {
case LoadExpensesEvent() when loadExpenses != null:
return loadExpenses(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadExpenses,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadExpensesEvent() when loadExpenses != null:
return loadExpenses();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadExpenses,}) {final _that = this;
switch (_that) {
case LoadExpensesEvent():
return loadExpenses();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadExpenses,}) {final _that = this;
switch (_that) {
case LoadExpensesEvent() when loadExpenses != null:
return loadExpenses();case _:
  return null;

}
}

}

/// @nodoc


class LoadExpensesEvent with DiagnosticableTreeMixin implements ActivityEvent {
  const LoadExpensesEvent();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ActivityEvent.loadExpenses'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadExpensesEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ActivityEvent.loadExpenses()';
}


}




/// @nodoc
mixin _$ActivityState implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ActivityState'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ActivityState()';
}


}

/// @nodoc
class $ActivityStateCopyWith<$Res>  {
$ActivityStateCopyWith(ActivityState _, $Res Function(ActivityState) __);
}


/// Adds pattern-matching-related methods to [ActivityState].
extension ActivityStatePatterns on ActivityState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ActivityInitial value)?  initial,TResult Function( ActivityLoading value)?  loading,TResult Function( ActivityLoaded value)?  loaded,TResult Function( ActivityEmpty value)?  empty,TResult Function( ActivityError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ActivityInitial() when initial != null:
return initial(_that);case ActivityLoading() when loading != null:
return loading(_that);case ActivityLoaded() when loaded != null:
return loaded(_that);case ActivityEmpty() when empty != null:
return empty(_that);case ActivityError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ActivityInitial value)  initial,required TResult Function( ActivityLoading value)  loading,required TResult Function( ActivityLoaded value)  loaded,required TResult Function( ActivityEmpty value)  empty,required TResult Function( ActivityError value)  error,}){
final _that = this;
switch (_that) {
case ActivityInitial():
return initial(_that);case ActivityLoading():
return loading(_that);case ActivityLoaded():
return loaded(_that);case ActivityEmpty():
return empty(_that);case ActivityError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ActivityInitial value)?  initial,TResult? Function( ActivityLoading value)?  loading,TResult? Function( ActivityLoaded value)?  loaded,TResult? Function( ActivityEmpty value)?  empty,TResult? Function( ActivityError value)?  error,}){
final _that = this;
switch (_that) {
case ActivityInitial() when initial != null:
return initial(_that);case ActivityLoading() when loading != null:
return loading(_that);case ActivityLoaded() when loaded != null:
return loaded(_that);case ActivityEmpty() when empty != null:
return empty(_that);case ActivityError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<ExpenseEntity> expenses)?  loaded,TResult Function()?  empty,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ActivityInitial() when initial != null:
return initial();case ActivityLoading() when loading != null:
return loading();case ActivityLoaded() when loaded != null:
return loaded(_that.expenses);case ActivityEmpty() when empty != null:
return empty();case ActivityError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<ExpenseEntity> expenses)  loaded,required TResult Function()  empty,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case ActivityInitial():
return initial();case ActivityLoading():
return loading();case ActivityLoaded():
return loaded(_that.expenses);case ActivityEmpty():
return empty();case ActivityError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<ExpenseEntity> expenses)?  loaded,TResult? Function()?  empty,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case ActivityInitial() when initial != null:
return initial();case ActivityLoading() when loading != null:
return loading();case ActivityLoaded() when loaded != null:
return loaded(_that.expenses);case ActivityEmpty() when empty != null:
return empty();case ActivityError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ActivityInitial with DiagnosticableTreeMixin implements ActivityState {
  const ActivityInitial();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ActivityState.initial'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ActivityState.initial()';
}


}




/// @nodoc


class ActivityLoading with DiagnosticableTreeMixin implements ActivityState {
  const ActivityLoading();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ActivityState.loading'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ActivityState.loading()';
}


}




/// @nodoc


class ActivityLoaded with DiagnosticableTreeMixin implements ActivityState {
  const ActivityLoaded(final  List<ExpenseEntity> expenses): _expenses = expenses;
  

 final  List<ExpenseEntity> _expenses;
 List<ExpenseEntity> get expenses {
  if (_expenses is EqualUnmodifiableListView) return _expenses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_expenses);
}


/// Create a copy of ActivityState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityLoadedCopyWith<ActivityLoaded> get copyWith => _$ActivityLoadedCopyWithImpl<ActivityLoaded>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ActivityState.loaded'))
    ..add(DiagnosticsProperty('expenses', expenses));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityLoaded&&const DeepCollectionEquality().equals(other._expenses, _expenses));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_expenses));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ActivityState.loaded(expenses: $expenses)';
}


}

/// @nodoc
abstract mixin class $ActivityLoadedCopyWith<$Res> implements $ActivityStateCopyWith<$Res> {
  factory $ActivityLoadedCopyWith(ActivityLoaded value, $Res Function(ActivityLoaded) _then) = _$ActivityLoadedCopyWithImpl;
@useResult
$Res call({
 List<ExpenseEntity> expenses
});




}
/// @nodoc
class _$ActivityLoadedCopyWithImpl<$Res>
    implements $ActivityLoadedCopyWith<$Res> {
  _$ActivityLoadedCopyWithImpl(this._self, this._then);

  final ActivityLoaded _self;
  final $Res Function(ActivityLoaded) _then;

/// Create a copy of ActivityState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? expenses = null,}) {
  return _then(ActivityLoaded(
null == expenses ? _self._expenses : expenses // ignore: cast_nullable_to_non_nullable
as List<ExpenseEntity>,
  ));
}


}

/// @nodoc


class ActivityEmpty with DiagnosticableTreeMixin implements ActivityState {
  const ActivityEmpty();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ActivityState.empty'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityEmpty);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ActivityState.empty()';
}


}




/// @nodoc


class ActivityError with DiagnosticableTreeMixin implements ActivityState {
  const ActivityError(this.message);
  

 final  String message;

/// Create a copy of ActivityState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActivityErrorCopyWith<ActivityError> get copyWith => _$ActivityErrorCopyWithImpl<ActivityError>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ActivityState.error'))
    ..add(DiagnosticsProperty('message', message));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActivityError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ActivityState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ActivityErrorCopyWith<$Res> implements $ActivityStateCopyWith<$Res> {
  factory $ActivityErrorCopyWith(ActivityError value, $Res Function(ActivityError) _then) = _$ActivityErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ActivityErrorCopyWithImpl<$Res>
    implements $ActivityErrorCopyWith<$Res> {
  _$ActivityErrorCopyWithImpl(this._self, this._then);

  final ActivityError _self;
  final $Res Function(ActivityError) _then;

/// Create a copy of ActivityState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ActivityError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
