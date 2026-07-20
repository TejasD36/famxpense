// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'statistics_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StatisticsEvent implements DiagnosticableTreeMixin {

 DateTime? get month;
/// Create a copy of StatisticsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatisticsEventCopyWith<StatisticsEvent> get copyWith => _$StatisticsEventCopyWithImpl<StatisticsEvent>(this as StatisticsEvent, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'StatisticsEvent'))
    ..add(DiagnosticsProperty('month', month));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatisticsEvent&&(identical(other.month, month) || other.month == month));
}


@override
int get hashCode => Object.hash(runtimeType,month);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'StatisticsEvent(month: $month)';
}


}

/// @nodoc
abstract mixin class $StatisticsEventCopyWith<$Res>  {
  factory $StatisticsEventCopyWith(StatisticsEvent value, $Res Function(StatisticsEvent) _then) = _$StatisticsEventCopyWithImpl;
@useResult
$Res call({
 DateTime? month
});




}
/// @nodoc
class _$StatisticsEventCopyWithImpl<$Res>
    implements $StatisticsEventCopyWith<$Res> {
  _$StatisticsEventCopyWithImpl(this._self, this._then);

  final StatisticsEvent _self;
  final $Res Function(StatisticsEvent) _then;

/// Create a copy of StatisticsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? month = freezed,}) {
  return _then(_self.copyWith(
month: freezed == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [StatisticsEvent].
extension StatisticsEventPatterns on StatisticsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadStatisticsEvent value)?  load,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadStatisticsEvent() when load != null:
return load(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadStatisticsEvent value)  load,}){
final _that = this;
switch (_that) {
case LoadStatisticsEvent():
return load(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadStatisticsEvent value)?  load,}){
final _that = this;
switch (_that) {
case LoadStatisticsEvent() when load != null:
return load(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( DateTime? month)?  load,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadStatisticsEvent() when load != null:
return load(_that.month);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( DateTime? month)  load,}) {final _that = this;
switch (_that) {
case LoadStatisticsEvent():
return load(_that.month);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( DateTime? month)?  load,}) {final _that = this;
switch (_that) {
case LoadStatisticsEvent() when load != null:
return load(_that.month);case _:
  return null;

}
}

}

/// @nodoc


class LoadStatisticsEvent with DiagnosticableTreeMixin implements StatisticsEvent {
  const LoadStatisticsEvent({this.month});
  

@override final  DateTime? month;

/// Create a copy of StatisticsEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadStatisticsEventCopyWith<LoadStatisticsEvent> get copyWith => _$LoadStatisticsEventCopyWithImpl<LoadStatisticsEvent>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'StatisticsEvent.load'))
    ..add(DiagnosticsProperty('month', month));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadStatisticsEvent&&(identical(other.month, month) || other.month == month));
}


@override
int get hashCode => Object.hash(runtimeType,month);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'StatisticsEvent.load(month: $month)';
}


}

/// @nodoc
abstract mixin class $LoadStatisticsEventCopyWith<$Res> implements $StatisticsEventCopyWith<$Res> {
  factory $LoadStatisticsEventCopyWith(LoadStatisticsEvent value, $Res Function(LoadStatisticsEvent) _then) = _$LoadStatisticsEventCopyWithImpl;
@override @useResult
$Res call({
 DateTime? month
});




}
/// @nodoc
class _$LoadStatisticsEventCopyWithImpl<$Res>
    implements $LoadStatisticsEventCopyWith<$Res> {
  _$LoadStatisticsEventCopyWithImpl(this._self, this._then);

  final LoadStatisticsEvent _self;
  final $Res Function(LoadStatisticsEvent) _then;

/// Create a copy of StatisticsEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? month = freezed,}) {
  return _then(LoadStatisticsEvent(
month: freezed == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$StatisticsState implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'StatisticsState'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatisticsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'StatisticsState()';
}


}

/// @nodoc
class $StatisticsStateCopyWith<$Res>  {
$StatisticsStateCopyWith(StatisticsState _, $Res Function(StatisticsState) __);
}


/// Adds pattern-matching-related methods to [StatisticsState].
extension StatisticsStatePatterns on StatisticsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( StatisticsInitial value)?  initial,TResult Function( StatisticsLoading value)?  loading,TResult Function( StatisticsLoaded value)?  loaded,TResult Function( StatisticsError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case StatisticsInitial() when initial != null:
return initial(_that);case StatisticsLoading() when loading != null:
return loading(_that);case StatisticsLoaded() when loaded != null:
return loaded(_that);case StatisticsError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( StatisticsInitial value)  initial,required TResult Function( StatisticsLoading value)  loading,required TResult Function( StatisticsLoaded value)  loaded,required TResult Function( StatisticsError value)  error,}){
final _that = this;
switch (_that) {
case StatisticsInitial():
return initial(_that);case StatisticsLoading():
return loading(_that);case StatisticsLoaded():
return loaded(_that);case StatisticsError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( StatisticsInitial value)?  initial,TResult? Function( StatisticsLoading value)?  loading,TResult? Function( StatisticsLoaded value)?  loaded,TResult? Function( StatisticsError value)?  error,}){
final _that = this;
switch (_that) {
case StatisticsInitial() when initial != null:
return initial(_that);case StatisticsLoading() when loading != null:
return loading(_that);case StatisticsLoaded() when loaded != null:
return loaded(_that);case StatisticsError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( int selectedYear,  int selectedMonth,  double totalSpent,  double totalDeposited,  int expenseCount,  int depositCount,  Map<String, double> categoryTotals,  Map<int, double> dailyTotals,  Map<String, double> expenseTypeTotals,  List<AccountStat> accountStats,  List<TransactionItem> transactions,  List<MonthComparison> monthComparisons)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case StatisticsInitial() when initial != null:
return initial();case StatisticsLoading() when loading != null:
return loading();case StatisticsLoaded() when loaded != null:
return loaded(_that.selectedYear,_that.selectedMonth,_that.totalSpent,_that.totalDeposited,_that.expenseCount,_that.depositCount,_that.categoryTotals,_that.dailyTotals,_that.expenseTypeTotals,_that.accountStats,_that.transactions,_that.monthComparisons);case StatisticsError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( int selectedYear,  int selectedMonth,  double totalSpent,  double totalDeposited,  int expenseCount,  int depositCount,  Map<String, double> categoryTotals,  Map<int, double> dailyTotals,  Map<String, double> expenseTypeTotals,  List<AccountStat> accountStats,  List<TransactionItem> transactions,  List<MonthComparison> monthComparisons)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case StatisticsInitial():
return initial();case StatisticsLoading():
return loading();case StatisticsLoaded():
return loaded(_that.selectedYear,_that.selectedMonth,_that.totalSpent,_that.totalDeposited,_that.expenseCount,_that.depositCount,_that.categoryTotals,_that.dailyTotals,_that.expenseTypeTotals,_that.accountStats,_that.transactions,_that.monthComparisons);case StatisticsError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( int selectedYear,  int selectedMonth,  double totalSpent,  double totalDeposited,  int expenseCount,  int depositCount,  Map<String, double> categoryTotals,  Map<int, double> dailyTotals,  Map<String, double> expenseTypeTotals,  List<AccountStat> accountStats,  List<TransactionItem> transactions,  List<MonthComparison> monthComparisons)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case StatisticsInitial() when initial != null:
return initial();case StatisticsLoading() when loading != null:
return loading();case StatisticsLoaded() when loaded != null:
return loaded(_that.selectedYear,_that.selectedMonth,_that.totalSpent,_that.totalDeposited,_that.expenseCount,_that.depositCount,_that.categoryTotals,_that.dailyTotals,_that.expenseTypeTotals,_that.accountStats,_that.transactions,_that.monthComparisons);case StatisticsError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class StatisticsInitial with DiagnosticableTreeMixin implements StatisticsState {
  const StatisticsInitial();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'StatisticsState.initial'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatisticsInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'StatisticsState.initial()';
}


}




/// @nodoc


class StatisticsLoading with DiagnosticableTreeMixin implements StatisticsState {
  const StatisticsLoading();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'StatisticsState.loading'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatisticsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'StatisticsState.loading()';
}


}




/// @nodoc


class StatisticsLoaded with DiagnosticableTreeMixin implements StatisticsState {
  const StatisticsLoaded({required this.selectedYear, required this.selectedMonth, required this.totalSpent, required this.totalDeposited, required this.expenseCount, required this.depositCount, required final  Map<String, double> categoryTotals, required final  Map<int, double> dailyTotals, required final  Map<String, double> expenseTypeTotals, required final  List<AccountStat> accountStats, required final  List<TransactionItem> transactions, required final  List<MonthComparison> monthComparisons}): _categoryTotals = categoryTotals,_dailyTotals = dailyTotals,_expenseTypeTotals = expenseTypeTotals,_accountStats = accountStats,_transactions = transactions,_monthComparisons = monthComparisons;
  

 final  int selectedYear;
 final  int selectedMonth;
 final  double totalSpent;
 final  double totalDeposited;
 final  int expenseCount;
 final  int depositCount;
 final  Map<String, double> _categoryTotals;
 Map<String, double> get categoryTotals {
  if (_categoryTotals is EqualUnmodifiableMapView) return _categoryTotals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_categoryTotals);
}

 final  Map<int, double> _dailyTotals;
 Map<int, double> get dailyTotals {
  if (_dailyTotals is EqualUnmodifiableMapView) return _dailyTotals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_dailyTotals);
}

 final  Map<String, double> _expenseTypeTotals;
 Map<String, double> get expenseTypeTotals {
  if (_expenseTypeTotals is EqualUnmodifiableMapView) return _expenseTypeTotals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_expenseTypeTotals);
}

 final  List<AccountStat> _accountStats;
 List<AccountStat> get accountStats {
  if (_accountStats is EqualUnmodifiableListView) return _accountStats;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_accountStats);
}

 final  List<TransactionItem> _transactions;
 List<TransactionItem> get transactions {
  if (_transactions is EqualUnmodifiableListView) return _transactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transactions);
}

 final  List<MonthComparison> _monthComparisons;
 List<MonthComparison> get monthComparisons {
  if (_monthComparisons is EqualUnmodifiableListView) return _monthComparisons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_monthComparisons);
}


/// Create a copy of StatisticsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatisticsLoadedCopyWith<StatisticsLoaded> get copyWith => _$StatisticsLoadedCopyWithImpl<StatisticsLoaded>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'StatisticsState.loaded'))
    ..add(DiagnosticsProperty('selectedYear', selectedYear))..add(DiagnosticsProperty('selectedMonth', selectedMonth))..add(DiagnosticsProperty('totalSpent', totalSpent))..add(DiagnosticsProperty('totalDeposited', totalDeposited))..add(DiagnosticsProperty('expenseCount', expenseCount))..add(DiagnosticsProperty('depositCount', depositCount))..add(DiagnosticsProperty('categoryTotals', categoryTotals))..add(DiagnosticsProperty('dailyTotals', dailyTotals))..add(DiagnosticsProperty('expenseTypeTotals', expenseTypeTotals))..add(DiagnosticsProperty('accountStats', accountStats))..add(DiagnosticsProperty('transactions', transactions))..add(DiagnosticsProperty('monthComparisons', monthComparisons));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatisticsLoaded&&(identical(other.selectedYear, selectedYear) || other.selectedYear == selectedYear)&&(identical(other.selectedMonth, selectedMonth) || other.selectedMonth == selectedMonth)&&(identical(other.totalSpent, totalSpent) || other.totalSpent == totalSpent)&&(identical(other.totalDeposited, totalDeposited) || other.totalDeposited == totalDeposited)&&(identical(other.expenseCount, expenseCount) || other.expenseCount == expenseCount)&&(identical(other.depositCount, depositCount) || other.depositCount == depositCount)&&const DeepCollectionEquality().equals(other._categoryTotals, _categoryTotals)&&const DeepCollectionEquality().equals(other._dailyTotals, _dailyTotals)&&const DeepCollectionEquality().equals(other._expenseTypeTotals, _expenseTypeTotals)&&const DeepCollectionEquality().equals(other._accountStats, _accountStats)&&const DeepCollectionEquality().equals(other._transactions, _transactions)&&const DeepCollectionEquality().equals(other._monthComparisons, _monthComparisons));
}


@override
int get hashCode => Object.hash(runtimeType,selectedYear,selectedMonth,totalSpent,totalDeposited,expenseCount,depositCount,const DeepCollectionEquality().hash(_categoryTotals),const DeepCollectionEquality().hash(_dailyTotals),const DeepCollectionEquality().hash(_expenseTypeTotals),const DeepCollectionEquality().hash(_accountStats),const DeepCollectionEquality().hash(_transactions),const DeepCollectionEquality().hash(_monthComparisons));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'StatisticsState.loaded(selectedYear: $selectedYear, selectedMonth: $selectedMonth, totalSpent: $totalSpent, totalDeposited: $totalDeposited, expenseCount: $expenseCount, depositCount: $depositCount, categoryTotals: $categoryTotals, dailyTotals: $dailyTotals, expenseTypeTotals: $expenseTypeTotals, accountStats: $accountStats, transactions: $transactions, monthComparisons: $monthComparisons)';
}


}

/// @nodoc
abstract mixin class $StatisticsLoadedCopyWith<$Res> implements $StatisticsStateCopyWith<$Res> {
  factory $StatisticsLoadedCopyWith(StatisticsLoaded value, $Res Function(StatisticsLoaded) _then) = _$StatisticsLoadedCopyWithImpl;
@useResult
$Res call({
 int selectedYear, int selectedMonth, double totalSpent, double totalDeposited, int expenseCount, int depositCount, Map<String, double> categoryTotals, Map<int, double> dailyTotals, Map<String, double> expenseTypeTotals, List<AccountStat> accountStats, List<TransactionItem> transactions, List<MonthComparison> monthComparisons
});




}
/// @nodoc
class _$StatisticsLoadedCopyWithImpl<$Res>
    implements $StatisticsLoadedCopyWith<$Res> {
  _$StatisticsLoadedCopyWithImpl(this._self, this._then);

  final StatisticsLoaded _self;
  final $Res Function(StatisticsLoaded) _then;

/// Create a copy of StatisticsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? selectedYear = null,Object? selectedMonth = null,Object? totalSpent = null,Object? totalDeposited = null,Object? expenseCount = null,Object? depositCount = null,Object? categoryTotals = null,Object? dailyTotals = null,Object? expenseTypeTotals = null,Object? accountStats = null,Object? transactions = null,Object? monthComparisons = null,}) {
  return _then(StatisticsLoaded(
selectedYear: null == selectedYear ? _self.selectedYear : selectedYear // ignore: cast_nullable_to_non_nullable
as int,selectedMonth: null == selectedMonth ? _self.selectedMonth : selectedMonth // ignore: cast_nullable_to_non_nullable
as int,totalSpent: null == totalSpent ? _self.totalSpent : totalSpent // ignore: cast_nullable_to_non_nullable
as double,totalDeposited: null == totalDeposited ? _self.totalDeposited : totalDeposited // ignore: cast_nullable_to_non_nullable
as double,expenseCount: null == expenseCount ? _self.expenseCount : expenseCount // ignore: cast_nullable_to_non_nullable
as int,depositCount: null == depositCount ? _self.depositCount : depositCount // ignore: cast_nullable_to_non_nullable
as int,categoryTotals: null == categoryTotals ? _self._categoryTotals : categoryTotals // ignore: cast_nullable_to_non_nullable
as Map<String, double>,dailyTotals: null == dailyTotals ? _self._dailyTotals : dailyTotals // ignore: cast_nullable_to_non_nullable
as Map<int, double>,expenseTypeTotals: null == expenseTypeTotals ? _self._expenseTypeTotals : expenseTypeTotals // ignore: cast_nullable_to_non_nullable
as Map<String, double>,accountStats: null == accountStats ? _self._accountStats : accountStats // ignore: cast_nullable_to_non_nullable
as List<AccountStat>,transactions: null == transactions ? _self._transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<TransactionItem>,monthComparisons: null == monthComparisons ? _self._monthComparisons : monthComparisons // ignore: cast_nullable_to_non_nullable
as List<MonthComparison>,
  ));
}


}

/// @nodoc


class StatisticsError with DiagnosticableTreeMixin implements StatisticsState {
  const StatisticsError(this.message);
  

 final  String message;

/// Create a copy of StatisticsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatisticsErrorCopyWith<StatisticsError> get copyWith => _$StatisticsErrorCopyWithImpl<StatisticsError>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'StatisticsState.error'))
    ..add(DiagnosticsProperty('message', message));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatisticsError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'StatisticsState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $StatisticsErrorCopyWith<$Res> implements $StatisticsStateCopyWith<$Res> {
  factory $StatisticsErrorCopyWith(StatisticsError value, $Res Function(StatisticsError) _then) = _$StatisticsErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$StatisticsErrorCopyWithImpl<$Res>
    implements $StatisticsErrorCopyWith<$Res> {
  _$StatisticsErrorCopyWithImpl(this._self, this._then);

  final StatisticsError _self;
  final $Res Function(StatisticsError) _then;

/// Create a copy of StatisticsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(StatisticsError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
