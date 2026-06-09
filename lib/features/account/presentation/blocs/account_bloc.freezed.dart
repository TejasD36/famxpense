// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AccountEvent implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AccountEvent'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AccountEvent()';
}


}

/// @nodoc
class $AccountEventCopyWith<$Res>  {
$AccountEventCopyWith(AccountEvent _, $Res Function(AccountEvent) __);
}


/// Adds pattern-matching-related methods to [AccountEvent].
extension AccountEventPatterns on AccountEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadAccounts value)?  loadAccounts,TResult Function( _SaveAccount value)?  saveAccount,TResult Function( _DeleteAccount value)?  deleteAccount,TResult Function( _UpdateBalance value)?  updateBalance,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadAccounts() when loadAccounts != null:
return loadAccounts(_that);case _SaveAccount() when saveAccount != null:
return saveAccount(_that);case _DeleteAccount() when deleteAccount != null:
return deleteAccount(_that);case _UpdateBalance() when updateBalance != null:
return updateBalance(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadAccounts value)  loadAccounts,required TResult Function( _SaveAccount value)  saveAccount,required TResult Function( _DeleteAccount value)  deleteAccount,required TResult Function( _UpdateBalance value)  updateBalance,}){
final _that = this;
switch (_that) {
case _LoadAccounts():
return loadAccounts(_that);case _SaveAccount():
return saveAccount(_that);case _DeleteAccount():
return deleteAccount(_that);case _UpdateBalance():
return updateBalance(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadAccounts value)?  loadAccounts,TResult? Function( _SaveAccount value)?  saveAccount,TResult? Function( _DeleteAccount value)?  deleteAccount,TResult? Function( _UpdateBalance value)?  updateBalance,}){
final _that = this;
switch (_that) {
case _LoadAccounts() when loadAccounts != null:
return loadAccounts(_that);case _SaveAccount() when saveAccount != null:
return saveAccount(_that);case _DeleteAccount() when deleteAccount != null:
return deleteAccount(_that);case _UpdateBalance() when updateBalance != null:
return updateBalance(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadAccounts,TResult Function( AccountEntity account)?  saveAccount,TResult Function( String accountId)?  deleteAccount,TResult Function( String accountId,  double newBalance)?  updateBalance,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadAccounts() when loadAccounts != null:
return loadAccounts();case _SaveAccount() when saveAccount != null:
return saveAccount(_that.account);case _DeleteAccount() when deleteAccount != null:
return deleteAccount(_that.accountId);case _UpdateBalance() when updateBalance != null:
return updateBalance(_that.accountId,_that.newBalance);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadAccounts,required TResult Function( AccountEntity account)  saveAccount,required TResult Function( String accountId)  deleteAccount,required TResult Function( String accountId,  double newBalance)  updateBalance,}) {final _that = this;
switch (_that) {
case _LoadAccounts():
return loadAccounts();case _SaveAccount():
return saveAccount(_that.account);case _DeleteAccount():
return deleteAccount(_that.accountId);case _UpdateBalance():
return updateBalance(_that.accountId,_that.newBalance);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadAccounts,TResult? Function( AccountEntity account)?  saveAccount,TResult? Function( String accountId)?  deleteAccount,TResult? Function( String accountId,  double newBalance)?  updateBalance,}) {final _that = this;
switch (_that) {
case _LoadAccounts() when loadAccounts != null:
return loadAccounts();case _SaveAccount() when saveAccount != null:
return saveAccount(_that.account);case _DeleteAccount() when deleteAccount != null:
return deleteAccount(_that.accountId);case _UpdateBalance() when updateBalance != null:
return updateBalance(_that.accountId,_that.newBalance);case _:
  return null;

}
}

}

/// @nodoc


class _LoadAccounts with DiagnosticableTreeMixin implements AccountEvent {
  const _LoadAccounts();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AccountEvent.loadAccounts'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadAccounts);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AccountEvent.loadAccounts()';
}


}




/// @nodoc


class _SaveAccount with DiagnosticableTreeMixin implements AccountEvent {
  const _SaveAccount({required this.account});
  

 final  AccountEntity account;

/// Create a copy of AccountEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SaveAccountCopyWith<_SaveAccount> get copyWith => __$SaveAccountCopyWithImpl<_SaveAccount>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AccountEvent.saveAccount'))
    ..add(DiagnosticsProperty('account', account));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SaveAccount&&(identical(other.account, account) || other.account == account));
}


@override
int get hashCode => Object.hash(runtimeType,account);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AccountEvent.saveAccount(account: $account)';
}


}

/// @nodoc
abstract mixin class _$SaveAccountCopyWith<$Res> implements $AccountEventCopyWith<$Res> {
  factory _$SaveAccountCopyWith(_SaveAccount value, $Res Function(_SaveAccount) _then) = __$SaveAccountCopyWithImpl;
@useResult
$Res call({
 AccountEntity account
});


$AccountEntityCopyWith<$Res> get account;

}
/// @nodoc
class __$SaveAccountCopyWithImpl<$Res>
    implements _$SaveAccountCopyWith<$Res> {
  __$SaveAccountCopyWithImpl(this._self, this._then);

  final _SaveAccount _self;
  final $Res Function(_SaveAccount) _then;

/// Create a copy of AccountEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? account = null,}) {
  return _then(_SaveAccount(
account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as AccountEntity,
  ));
}

/// Create a copy of AccountEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AccountEntityCopyWith<$Res> get account {
  
  return $AccountEntityCopyWith<$Res>(_self.account, (value) {
    return _then(_self.copyWith(account: value));
  });
}
}

/// @nodoc


class _DeleteAccount with DiagnosticableTreeMixin implements AccountEvent {
  const _DeleteAccount({required this.accountId});
  

 final  String accountId;

/// Create a copy of AccountEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeleteAccountCopyWith<_DeleteAccount> get copyWith => __$DeleteAccountCopyWithImpl<_DeleteAccount>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AccountEvent.deleteAccount'))
    ..add(DiagnosticsProperty('accountId', accountId));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeleteAccount&&(identical(other.accountId, accountId) || other.accountId == accountId));
}


@override
int get hashCode => Object.hash(runtimeType,accountId);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AccountEvent.deleteAccount(accountId: $accountId)';
}


}

/// @nodoc
abstract mixin class _$DeleteAccountCopyWith<$Res> implements $AccountEventCopyWith<$Res> {
  factory _$DeleteAccountCopyWith(_DeleteAccount value, $Res Function(_DeleteAccount) _then) = __$DeleteAccountCopyWithImpl;
@useResult
$Res call({
 String accountId
});




}
/// @nodoc
class __$DeleteAccountCopyWithImpl<$Res>
    implements _$DeleteAccountCopyWith<$Res> {
  __$DeleteAccountCopyWithImpl(this._self, this._then);

  final _DeleteAccount _self;
  final $Res Function(_DeleteAccount) _then;

/// Create a copy of AccountEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? accountId = null,}) {
  return _then(_DeleteAccount(
accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _UpdateBalance with DiagnosticableTreeMixin implements AccountEvent {
  const _UpdateBalance({required this.accountId, required this.newBalance});
  

 final  String accountId;
 final  double newBalance;

/// Create a copy of AccountEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateBalanceCopyWith<_UpdateBalance> get copyWith => __$UpdateBalanceCopyWithImpl<_UpdateBalance>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AccountEvent.updateBalance'))
    ..add(DiagnosticsProperty('accountId', accountId))..add(DiagnosticsProperty('newBalance', newBalance));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateBalance&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.newBalance, newBalance) || other.newBalance == newBalance));
}


@override
int get hashCode => Object.hash(runtimeType,accountId,newBalance);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AccountEvent.updateBalance(accountId: $accountId, newBalance: $newBalance)';
}


}

/// @nodoc
abstract mixin class _$UpdateBalanceCopyWith<$Res> implements $AccountEventCopyWith<$Res> {
  factory _$UpdateBalanceCopyWith(_UpdateBalance value, $Res Function(_UpdateBalance) _then) = __$UpdateBalanceCopyWithImpl;
@useResult
$Res call({
 String accountId, double newBalance
});




}
/// @nodoc
class __$UpdateBalanceCopyWithImpl<$Res>
    implements _$UpdateBalanceCopyWith<$Res> {
  __$UpdateBalanceCopyWithImpl(this._self, this._then);

  final _UpdateBalance _self;
  final $Res Function(_UpdateBalance) _then;

/// Create a copy of AccountEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? accountId = null,Object? newBalance = null,}) {
  return _then(_UpdateBalance(
accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,newBalance: null == newBalance ? _self.newBalance : newBalance // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc
mixin _$AccountState implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AccountState'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AccountState()';
}


}

/// @nodoc
class $AccountStateCopyWith<$Res>  {
$AccountStateCopyWith(AccountState _, $Res Function(AccountState) __);
}


/// Adds pattern-matching-related methods to [AccountState].
extension AccountStatePatterns on AccountState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _Error():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _Error() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<AccountEntity> accounts)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.accounts);case _Error() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<AccountEntity> accounts)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Loaded():
return loaded(_that.accounts);case _Error():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<AccountEntity> accounts)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.accounts);case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial with DiagnosticableTreeMixin implements AccountState {
  const _Initial();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AccountState.initial'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AccountState.initial()';
}


}




/// @nodoc


class _Loading with DiagnosticableTreeMixin implements AccountState {
  const _Loading();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AccountState.loading'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AccountState.loading()';
}


}




/// @nodoc


class _Loaded with DiagnosticableTreeMixin implements AccountState {
  const _Loaded({final  List<AccountEntity> accounts = const []}): _accounts = accounts;
  

 final  List<AccountEntity> _accounts;
@JsonKey() List<AccountEntity> get accounts {
  if (_accounts is EqualUnmodifiableListView) return _accounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_accounts);
}


/// Create a copy of AccountState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AccountState.loaded'))
    ..add(DiagnosticsProperty('accounts', accounts));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other._accounts, _accounts));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_accounts));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AccountState.loaded(accounts: $accounts)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $AccountStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 List<AccountEntity> accounts
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of AccountState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? accounts = null,}) {
  return _then(_Loaded(
accounts: null == accounts ? _self._accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<AccountEntity>,
  ));
}


}

/// @nodoc


class _Error with DiagnosticableTreeMixin implements AccountState {
  const _Error({required this.message});
  

 final  String message;

/// Create a copy of AccountState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AccountState.error'))
    ..add(DiagnosticsProperty('message', message));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AccountState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $AccountStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of AccountState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
