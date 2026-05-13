// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_expense_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AddExpenseEvent implements DiagnosticableTreeMixin {

 ExpenseEntity get expense;
/// Create a copy of AddExpenseEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddExpenseEventCopyWith<AddExpenseEvent> get copyWith => _$AddExpenseEventCopyWithImpl<AddExpenseEvent>(this as AddExpenseEvent, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AddExpenseEvent'))
    ..add(DiagnosticsProperty('expense', expense));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddExpenseEvent&&(identical(other.expense, expense) || other.expense == expense));
}


@override
int get hashCode => Object.hash(runtimeType,expense);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AddExpenseEvent(expense: $expense)';
}


}

/// @nodoc
abstract mixin class $AddExpenseEventCopyWith<$Res>  {
  factory $AddExpenseEventCopyWith(AddExpenseEvent value, $Res Function(AddExpenseEvent) _then) = _$AddExpenseEventCopyWithImpl;
@useResult
$Res call({
 ExpenseEntity expense
});


$ExpenseEntityCopyWith<$Res> get expense;

}
/// @nodoc
class _$AddExpenseEventCopyWithImpl<$Res>
    implements $AddExpenseEventCopyWith<$Res> {
  _$AddExpenseEventCopyWithImpl(this._self, this._then);

  final AddExpenseEvent _self;
  final $Res Function(AddExpenseEvent) _then;

/// Create a copy of AddExpenseEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? expense = null,}) {
  return _then(_self.copyWith(
expense: null == expense ? _self.expense : expense // ignore: cast_nullable_to_non_nullable
as ExpenseEntity,
  ));
}
/// Create a copy of AddExpenseEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExpenseEntityCopyWith<$Res> get expense {
  
  return $ExpenseEntityCopyWith<$Res>(_self.expense, (value) {
    return _then(_self.copyWith(expense: value));
  });
}
}


/// Adds pattern-matching-related methods to [AddExpenseEvent].
extension AddExpenseEventPatterns on AddExpenseEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SubmitExpenseEvent value)?  submit,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SubmitExpenseEvent() when submit != null:
return submit(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SubmitExpenseEvent value)  submit,}){
final _that = this;
switch (_that) {
case SubmitExpenseEvent():
return submit(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SubmitExpenseEvent value)?  submit,}){
final _that = this;
switch (_that) {
case SubmitExpenseEvent() when submit != null:
return submit(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( ExpenseEntity expense)?  submit,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SubmitExpenseEvent() when submit != null:
return submit(_that.expense);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( ExpenseEntity expense)  submit,}) {final _that = this;
switch (_that) {
case SubmitExpenseEvent():
return submit(_that.expense);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( ExpenseEntity expense)?  submit,}) {final _that = this;
switch (_that) {
case SubmitExpenseEvent() when submit != null:
return submit(_that.expense);case _:
  return null;

}
}

}

/// @nodoc


class SubmitExpenseEvent with DiagnosticableTreeMixin implements AddExpenseEvent {
  const SubmitExpenseEvent(this.expense);
  

@override final  ExpenseEntity expense;

/// Create a copy of AddExpenseEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubmitExpenseEventCopyWith<SubmitExpenseEvent> get copyWith => _$SubmitExpenseEventCopyWithImpl<SubmitExpenseEvent>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AddExpenseEvent.submit'))
    ..add(DiagnosticsProperty('expense', expense));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubmitExpenseEvent&&(identical(other.expense, expense) || other.expense == expense));
}


@override
int get hashCode => Object.hash(runtimeType,expense);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AddExpenseEvent.submit(expense: $expense)';
}


}

/// @nodoc
abstract mixin class $SubmitExpenseEventCopyWith<$Res> implements $AddExpenseEventCopyWith<$Res> {
  factory $SubmitExpenseEventCopyWith(SubmitExpenseEvent value, $Res Function(SubmitExpenseEvent) _then) = _$SubmitExpenseEventCopyWithImpl;
@override @useResult
$Res call({
 ExpenseEntity expense
});


@override $ExpenseEntityCopyWith<$Res> get expense;

}
/// @nodoc
class _$SubmitExpenseEventCopyWithImpl<$Res>
    implements $SubmitExpenseEventCopyWith<$Res> {
  _$SubmitExpenseEventCopyWithImpl(this._self, this._then);

  final SubmitExpenseEvent _self;
  final $Res Function(SubmitExpenseEvent) _then;

/// Create a copy of AddExpenseEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? expense = null,}) {
  return _then(SubmitExpenseEvent(
null == expense ? _self.expense : expense // ignore: cast_nullable_to_non_nullable
as ExpenseEntity,
  ));
}

/// Create a copy of AddExpenseEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExpenseEntityCopyWith<$Res> get expense {
  
  return $ExpenseEntityCopyWith<$Res>(_self.expense, (value) {
    return _then(_self.copyWith(expense: value));
  });
}
}

// dart format on
