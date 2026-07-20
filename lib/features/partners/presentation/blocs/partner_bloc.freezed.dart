// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'partner_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PartnerEvent implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'PartnerEvent'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PartnerEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PartnerEvent()';
}


}

/// @nodoc
class $PartnerEventCopyWith<$Res>  {
$PartnerEventCopyWith(PartnerEvent _, $Res Function(PartnerEvent) __);
}


/// Adds pattern-matching-related methods to [PartnerEvent].
extension PartnerEventPatterns on PartnerEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _SearchUser value)?  searchUser,TResult Function( _SendRequest value)?  sendRequest,TResult Function( _LoadPartners value)?  loadPartners,TResult Function( _AcceptRequest value)?  acceptRequest,TResult Function( _RejectRequest value)?  rejectRequest,TResult Function( _RemovePartner value)?  removePartner,TResult Function( _ClearSearch value)?  clearSearch,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchUser() when searchUser != null:
return searchUser(_that);case _SendRequest() when sendRequest != null:
return sendRequest(_that);case _LoadPartners() when loadPartners != null:
return loadPartners(_that);case _AcceptRequest() when acceptRequest != null:
return acceptRequest(_that);case _RejectRequest() when rejectRequest != null:
return rejectRequest(_that);case _RemovePartner() when removePartner != null:
return removePartner(_that);case _ClearSearch() when clearSearch != null:
return clearSearch(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _SearchUser value)  searchUser,required TResult Function( _SendRequest value)  sendRequest,required TResult Function( _LoadPartners value)  loadPartners,required TResult Function( _AcceptRequest value)  acceptRequest,required TResult Function( _RejectRequest value)  rejectRequest,required TResult Function( _RemovePartner value)  removePartner,required TResult Function( _ClearSearch value)  clearSearch,}){
final _that = this;
switch (_that) {
case _SearchUser():
return searchUser(_that);case _SendRequest():
return sendRequest(_that);case _LoadPartners():
return loadPartners(_that);case _AcceptRequest():
return acceptRequest(_that);case _RejectRequest():
return rejectRequest(_that);case _RemovePartner():
return removePartner(_that);case _ClearSearch():
return clearSearch(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _SearchUser value)?  searchUser,TResult? Function( _SendRequest value)?  sendRequest,TResult? Function( _LoadPartners value)?  loadPartners,TResult? Function( _AcceptRequest value)?  acceptRequest,TResult? Function( _RejectRequest value)?  rejectRequest,TResult? Function( _RemovePartner value)?  removePartner,TResult? Function( _ClearSearch value)?  clearSearch,}){
final _that = this;
switch (_that) {
case _SearchUser() when searchUser != null:
return searchUser(_that);case _SendRequest() when sendRequest != null:
return sendRequest(_that);case _LoadPartners() when loadPartners != null:
return loadPartners(_that);case _AcceptRequest() when acceptRequest != null:
return acceptRequest(_that);case _RejectRequest() when rejectRequest != null:
return rejectRequest(_that);case _RemovePartner() when removePartner != null:
return removePartner(_that);case _ClearSearch() when clearSearch != null:
return clearSearch(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String query)?  searchUser,TResult Function( UserEntity user)?  sendRequest,TResult Function()?  loadPartners,TResult Function( PartnershipEntity partnership)?  acceptRequest,TResult Function( PartnershipEntity partnership)?  rejectRequest,TResult Function( String partnershipId)?  removePartner,TResult Function()?  clearSearch,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchUser() when searchUser != null:
return searchUser(_that.query);case _SendRequest() when sendRequest != null:
return sendRequest(_that.user);case _LoadPartners() when loadPartners != null:
return loadPartners();case _AcceptRequest() when acceptRequest != null:
return acceptRequest(_that.partnership);case _RejectRequest() when rejectRequest != null:
return rejectRequest(_that.partnership);case _RemovePartner() when removePartner != null:
return removePartner(_that.partnershipId);case _ClearSearch() when clearSearch != null:
return clearSearch();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String query)  searchUser,required TResult Function( UserEntity user)  sendRequest,required TResult Function()  loadPartners,required TResult Function( PartnershipEntity partnership)  acceptRequest,required TResult Function( PartnershipEntity partnership)  rejectRequest,required TResult Function( String partnershipId)  removePartner,required TResult Function()  clearSearch,}) {final _that = this;
switch (_that) {
case _SearchUser():
return searchUser(_that.query);case _SendRequest():
return sendRequest(_that.user);case _LoadPartners():
return loadPartners();case _AcceptRequest():
return acceptRequest(_that.partnership);case _RejectRequest():
return rejectRequest(_that.partnership);case _RemovePartner():
return removePartner(_that.partnershipId);case _ClearSearch():
return clearSearch();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String query)?  searchUser,TResult? Function( UserEntity user)?  sendRequest,TResult? Function()?  loadPartners,TResult? Function( PartnershipEntity partnership)?  acceptRequest,TResult? Function( PartnershipEntity partnership)?  rejectRequest,TResult? Function( String partnershipId)?  removePartner,TResult? Function()?  clearSearch,}) {final _that = this;
switch (_that) {
case _SearchUser() when searchUser != null:
return searchUser(_that.query);case _SendRequest() when sendRequest != null:
return sendRequest(_that.user);case _LoadPartners() when loadPartners != null:
return loadPartners();case _AcceptRequest() when acceptRequest != null:
return acceptRequest(_that.partnership);case _RejectRequest() when rejectRequest != null:
return rejectRequest(_that.partnership);case _RemovePartner() when removePartner != null:
return removePartner(_that.partnershipId);case _ClearSearch() when clearSearch != null:
return clearSearch();case _:
  return null;

}
}

}

/// @nodoc


class _SearchUser with DiagnosticableTreeMixin implements PartnerEvent {
  const _SearchUser({required this.query});
  

 final  String query;

/// Create a copy of PartnerEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchUserCopyWith<_SearchUser> get copyWith => __$SearchUserCopyWithImpl<_SearchUser>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'PartnerEvent.searchUser'))
    ..add(DiagnosticsProperty('query', query));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchUser&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PartnerEvent.searchUser(query: $query)';
}


}

/// @nodoc
abstract mixin class _$SearchUserCopyWith<$Res> implements $PartnerEventCopyWith<$Res> {
  factory _$SearchUserCopyWith(_SearchUser value, $Res Function(_SearchUser) _then) = __$SearchUserCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class __$SearchUserCopyWithImpl<$Res>
    implements _$SearchUserCopyWith<$Res> {
  __$SearchUserCopyWithImpl(this._self, this._then);

  final _SearchUser _self;
  final $Res Function(_SearchUser) _then;

/// Create a copy of PartnerEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(_SearchUser(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SendRequest with DiagnosticableTreeMixin implements PartnerEvent {
  const _SendRequest({required this.user});
  

 final  UserEntity user;

/// Create a copy of PartnerEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SendRequestCopyWith<_SendRequest> get copyWith => __$SendRequestCopyWithImpl<_SendRequest>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'PartnerEvent.sendRequest'))
    ..add(DiagnosticsProperty('user', user));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendRequest&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,user);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PartnerEvent.sendRequest(user: $user)';
}


}

/// @nodoc
abstract mixin class _$SendRequestCopyWith<$Res> implements $PartnerEventCopyWith<$Res> {
  factory _$SendRequestCopyWith(_SendRequest value, $Res Function(_SendRequest) _then) = __$SendRequestCopyWithImpl;
@useResult
$Res call({
 UserEntity user
});


$UserEntityCopyWith<$Res> get user;

}
/// @nodoc
class __$SendRequestCopyWithImpl<$Res>
    implements _$SendRequestCopyWith<$Res> {
  __$SendRequestCopyWithImpl(this._self, this._then);

  final _SendRequest _self;
  final $Res Function(_SendRequest) _then;

/// Create a copy of PartnerEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = null,}) {
  return _then(_SendRequest(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserEntity,
  ));
}

/// Create a copy of PartnerEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserEntityCopyWith<$Res> get user {
  
  return $UserEntityCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

/// @nodoc


class _LoadPartners with DiagnosticableTreeMixin implements PartnerEvent {
  const _LoadPartners();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'PartnerEvent.loadPartners'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadPartners);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PartnerEvent.loadPartners()';
}


}




/// @nodoc


class _AcceptRequest with DiagnosticableTreeMixin implements PartnerEvent {
  const _AcceptRequest({required this.partnership});
  

 final  PartnershipEntity partnership;

/// Create a copy of PartnerEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AcceptRequestCopyWith<_AcceptRequest> get copyWith => __$AcceptRequestCopyWithImpl<_AcceptRequest>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'PartnerEvent.acceptRequest'))
    ..add(DiagnosticsProperty('partnership', partnership));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AcceptRequest&&(identical(other.partnership, partnership) || other.partnership == partnership));
}


@override
int get hashCode => Object.hash(runtimeType,partnership);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PartnerEvent.acceptRequest(partnership: $partnership)';
}


}

/// @nodoc
abstract mixin class _$AcceptRequestCopyWith<$Res> implements $PartnerEventCopyWith<$Res> {
  factory _$AcceptRequestCopyWith(_AcceptRequest value, $Res Function(_AcceptRequest) _then) = __$AcceptRequestCopyWithImpl;
@useResult
$Res call({
 PartnershipEntity partnership
});


$PartnershipEntityCopyWith<$Res> get partnership;

}
/// @nodoc
class __$AcceptRequestCopyWithImpl<$Res>
    implements _$AcceptRequestCopyWith<$Res> {
  __$AcceptRequestCopyWithImpl(this._self, this._then);

  final _AcceptRequest _self;
  final $Res Function(_AcceptRequest) _then;

/// Create a copy of PartnerEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? partnership = null,}) {
  return _then(_AcceptRequest(
partnership: null == partnership ? _self.partnership : partnership // ignore: cast_nullable_to_non_nullable
as PartnershipEntity,
  ));
}

/// Create a copy of PartnerEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PartnershipEntityCopyWith<$Res> get partnership {
  
  return $PartnershipEntityCopyWith<$Res>(_self.partnership, (value) {
    return _then(_self.copyWith(partnership: value));
  });
}
}

/// @nodoc


class _RejectRequest with DiagnosticableTreeMixin implements PartnerEvent {
  const _RejectRequest({required this.partnership});
  

 final  PartnershipEntity partnership;

/// Create a copy of PartnerEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RejectRequestCopyWith<_RejectRequest> get copyWith => __$RejectRequestCopyWithImpl<_RejectRequest>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'PartnerEvent.rejectRequest'))
    ..add(DiagnosticsProperty('partnership', partnership));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RejectRequest&&(identical(other.partnership, partnership) || other.partnership == partnership));
}


@override
int get hashCode => Object.hash(runtimeType,partnership);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PartnerEvent.rejectRequest(partnership: $partnership)';
}


}

/// @nodoc
abstract mixin class _$RejectRequestCopyWith<$Res> implements $PartnerEventCopyWith<$Res> {
  factory _$RejectRequestCopyWith(_RejectRequest value, $Res Function(_RejectRequest) _then) = __$RejectRequestCopyWithImpl;
@useResult
$Res call({
 PartnershipEntity partnership
});


$PartnershipEntityCopyWith<$Res> get partnership;

}
/// @nodoc
class __$RejectRequestCopyWithImpl<$Res>
    implements _$RejectRequestCopyWith<$Res> {
  __$RejectRequestCopyWithImpl(this._self, this._then);

  final _RejectRequest _self;
  final $Res Function(_RejectRequest) _then;

/// Create a copy of PartnerEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? partnership = null,}) {
  return _then(_RejectRequest(
partnership: null == partnership ? _self.partnership : partnership // ignore: cast_nullable_to_non_nullable
as PartnershipEntity,
  ));
}

/// Create a copy of PartnerEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PartnershipEntityCopyWith<$Res> get partnership {
  
  return $PartnershipEntityCopyWith<$Res>(_self.partnership, (value) {
    return _then(_self.copyWith(partnership: value));
  });
}
}

/// @nodoc


class _RemovePartner with DiagnosticableTreeMixin implements PartnerEvent {
  const _RemovePartner({required this.partnershipId});
  

 final  String partnershipId;

/// Create a copy of PartnerEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RemovePartnerCopyWith<_RemovePartner> get copyWith => __$RemovePartnerCopyWithImpl<_RemovePartner>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'PartnerEvent.removePartner'))
    ..add(DiagnosticsProperty('partnershipId', partnershipId));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RemovePartner&&(identical(other.partnershipId, partnershipId) || other.partnershipId == partnershipId));
}


@override
int get hashCode => Object.hash(runtimeType,partnershipId);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PartnerEvent.removePartner(partnershipId: $partnershipId)';
}


}

/// @nodoc
abstract mixin class _$RemovePartnerCopyWith<$Res> implements $PartnerEventCopyWith<$Res> {
  factory _$RemovePartnerCopyWith(_RemovePartner value, $Res Function(_RemovePartner) _then) = __$RemovePartnerCopyWithImpl;
@useResult
$Res call({
 String partnershipId
});




}
/// @nodoc
class __$RemovePartnerCopyWithImpl<$Res>
    implements _$RemovePartnerCopyWith<$Res> {
  __$RemovePartnerCopyWithImpl(this._self, this._then);

  final _RemovePartner _self;
  final $Res Function(_RemovePartner) _then;

/// Create a copy of PartnerEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? partnershipId = null,}) {
  return _then(_RemovePartner(
partnershipId: null == partnershipId ? _self.partnershipId : partnershipId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ClearSearch with DiagnosticableTreeMixin implements PartnerEvent {
  const _ClearSearch();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'PartnerEvent.clearSearch'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClearSearch);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PartnerEvent.clearSearch()';
}


}




/// @nodoc
mixin _$PartnerState implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'PartnerState'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PartnerState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PartnerState()';
}


}

/// @nodoc
class $PartnerStateCopyWith<$Res>  {
$PartnerStateCopyWith(PartnerState _, $Res Function(PartnerState) __);
}


/// Adds pattern-matching-related methods to [PartnerState].
extension PartnerStatePatterns on PartnerState {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( UserEntity? searchedUser,  List<PartnershipEntity> connectedPartners,  List<PartnershipEntity> incomingRequests,  List<PartnershipEntity> outgoingRequests)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.searchedUser,_that.connectedPartners,_that.incomingRequests,_that.outgoingRequests);case _Error() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( UserEntity? searchedUser,  List<PartnershipEntity> connectedPartners,  List<PartnershipEntity> incomingRequests,  List<PartnershipEntity> outgoingRequests)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Loaded():
return loaded(_that.searchedUser,_that.connectedPartners,_that.incomingRequests,_that.outgoingRequests);case _Error():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( UserEntity? searchedUser,  List<PartnershipEntity> connectedPartners,  List<PartnershipEntity> incomingRequests,  List<PartnershipEntity> outgoingRequests)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.searchedUser,_that.connectedPartners,_that.incomingRequests,_that.outgoingRequests);case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial with DiagnosticableTreeMixin implements PartnerState {
  const _Initial();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'PartnerState.initial'))
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
  return 'PartnerState.initial()';
}


}




/// @nodoc


class _Loading with DiagnosticableTreeMixin implements PartnerState {
  const _Loading();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'PartnerState.loading'))
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
  return 'PartnerState.loading()';
}


}




/// @nodoc


class _Loaded with DiagnosticableTreeMixin implements PartnerState {
  const _Loaded({this.searchedUser, final  List<PartnershipEntity> connectedPartners = const [], final  List<PartnershipEntity> incomingRequests = const [], final  List<PartnershipEntity> outgoingRequests = const []}): _connectedPartners = connectedPartners,_incomingRequests = incomingRequests,_outgoingRequests = outgoingRequests;
  

/// SEARCH RESULT
 final  UserEntity? searchedUser;
/// CONNECTED
 final  List<PartnershipEntity> _connectedPartners;
/// CONNECTED
@JsonKey() List<PartnershipEntity> get connectedPartners {
  if (_connectedPartners is EqualUnmodifiableListView) return _connectedPartners;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_connectedPartners);
}

/// INCOMING
 final  List<PartnershipEntity> _incomingRequests;
/// INCOMING
@JsonKey() List<PartnershipEntity> get incomingRequests {
  if (_incomingRequests is EqualUnmodifiableListView) return _incomingRequests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_incomingRequests);
}

/// OUTGOING
 final  List<PartnershipEntity> _outgoingRequests;
/// OUTGOING
@JsonKey() List<PartnershipEntity> get outgoingRequests {
  if (_outgoingRequests is EqualUnmodifiableListView) return _outgoingRequests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_outgoingRequests);
}


/// Create a copy of PartnerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'PartnerState.loaded'))
    ..add(DiagnosticsProperty('searchedUser', searchedUser))..add(DiagnosticsProperty('connectedPartners', connectedPartners))..add(DiagnosticsProperty('incomingRequests', incomingRequests))..add(DiagnosticsProperty('outgoingRequests', outgoingRequests));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&(identical(other.searchedUser, searchedUser) || other.searchedUser == searchedUser)&&const DeepCollectionEquality().equals(other._connectedPartners, _connectedPartners)&&const DeepCollectionEquality().equals(other._incomingRequests, _incomingRequests)&&const DeepCollectionEquality().equals(other._outgoingRequests, _outgoingRequests));
}


@override
int get hashCode => Object.hash(runtimeType,searchedUser,const DeepCollectionEquality().hash(_connectedPartners),const DeepCollectionEquality().hash(_incomingRequests),const DeepCollectionEquality().hash(_outgoingRequests));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'PartnerState.loaded(searchedUser: $searchedUser, connectedPartners: $connectedPartners, incomingRequests: $incomingRequests, outgoingRequests: $outgoingRequests)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $PartnerStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 UserEntity? searchedUser, List<PartnershipEntity> connectedPartners, List<PartnershipEntity> incomingRequests, List<PartnershipEntity> outgoingRequests
});


$UserEntityCopyWith<$Res>? get searchedUser;

}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of PartnerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? searchedUser = freezed,Object? connectedPartners = null,Object? incomingRequests = null,Object? outgoingRequests = null,}) {
  return _then(_Loaded(
searchedUser: freezed == searchedUser ? _self.searchedUser : searchedUser // ignore: cast_nullable_to_non_nullable
as UserEntity?,connectedPartners: null == connectedPartners ? _self._connectedPartners : connectedPartners // ignore: cast_nullable_to_non_nullable
as List<PartnershipEntity>,incomingRequests: null == incomingRequests ? _self._incomingRequests : incomingRequests // ignore: cast_nullable_to_non_nullable
as List<PartnershipEntity>,outgoingRequests: null == outgoingRequests ? _self._outgoingRequests : outgoingRequests // ignore: cast_nullable_to_non_nullable
as List<PartnershipEntity>,
  ));
}

/// Create a copy of PartnerState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserEntityCopyWith<$Res>? get searchedUser {
    if (_self.searchedUser == null) {
    return null;
  }

  return $UserEntityCopyWith<$Res>(_self.searchedUser!, (value) {
    return _then(_self.copyWith(searchedUser: value));
  });
}
}

/// @nodoc


class _Error with DiagnosticableTreeMixin implements PartnerState {
  const _Error({required this.message});
  

 final  String message;

/// Create a copy of PartnerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'PartnerState.error'))
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
  return 'PartnerState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $PartnerStateCopyWith<$Res> {
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

/// Create a copy of PartnerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
