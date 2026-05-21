// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GroupEntity implements DiagnosticableTreeMixin {

 String get id; String get title; String? get description; String get createdBy; List<String> get memberIds; DateTime get createdAt; DateTime? get closedAt; bool get isClosed;
/// Create a copy of GroupEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupEntityCopyWith<GroupEntity> get copyWith => _$GroupEntityCopyWithImpl<GroupEntity>(this as GroupEntity, _$identity);

  /// Serializes this GroupEntity to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'GroupEntity'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('title', title))..add(DiagnosticsProperty('description', description))..add(DiagnosticsProperty('createdBy', createdBy))..add(DiagnosticsProperty('memberIds', memberIds))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('closedAt', closedAt))..add(DiagnosticsProperty('isClosed', isClosed));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&const DeepCollectionEquality().equals(other.memberIds, memberIds)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.closedAt, closedAt) || other.closedAt == closedAt)&&(identical(other.isClosed, isClosed) || other.isClosed == isClosed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,createdBy,const DeepCollectionEquality().hash(memberIds),createdAt,closedAt,isClosed);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'GroupEntity(id: $id, title: $title, description: $description, createdBy: $createdBy, memberIds: $memberIds, createdAt: $createdAt, closedAt: $closedAt, isClosed: $isClosed)';
}


}

/// @nodoc
abstract mixin class $GroupEntityCopyWith<$Res>  {
  factory $GroupEntityCopyWith(GroupEntity value, $Res Function(GroupEntity) _then) = _$GroupEntityCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? description, String createdBy, List<String> memberIds, DateTime createdAt, DateTime? closedAt, bool isClosed
});




}
/// @nodoc
class _$GroupEntityCopyWithImpl<$Res>
    implements $GroupEntityCopyWith<$Res> {
  _$GroupEntityCopyWithImpl(this._self, this._then);

  final GroupEntity _self;
  final $Res Function(GroupEntity) _then;

/// Create a copy of GroupEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? createdBy = null,Object? memberIds = null,Object? createdAt = null,Object? closedAt = freezed,Object? isClosed = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,memberIds: null == memberIds ? _self.memberIds : memberIds // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,closedAt: freezed == closedAt ? _self.closedAt : closedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isClosed: null == isClosed ? _self.isClosed : isClosed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [GroupEntity].
extension GroupEntityPatterns on GroupEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GroupEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GroupEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GroupEntity value)  $default,){
final _that = this;
switch (_that) {
case _GroupEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GroupEntity value)?  $default,){
final _that = this;
switch (_that) {
case _GroupEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? description,  String createdBy,  List<String> memberIds,  DateTime createdAt,  DateTime? closedAt,  bool isClosed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GroupEntity() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.createdBy,_that.memberIds,_that.createdAt,_that.closedAt,_that.isClosed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? description,  String createdBy,  List<String> memberIds,  DateTime createdAt,  DateTime? closedAt,  bool isClosed)  $default,) {final _that = this;
switch (_that) {
case _GroupEntity():
return $default(_that.id,_that.title,_that.description,_that.createdBy,_that.memberIds,_that.createdAt,_that.closedAt,_that.isClosed);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? description,  String createdBy,  List<String> memberIds,  DateTime createdAt,  DateTime? closedAt,  bool isClosed)?  $default,) {final _that = this;
switch (_that) {
case _GroupEntity() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.createdBy,_that.memberIds,_that.createdAt,_that.closedAt,_that.isClosed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GroupEntity with DiagnosticableTreeMixin implements GroupEntity {
  const _GroupEntity({required this.id, required this.title, this.description, required this.createdBy, required final  List<String> memberIds, required this.createdAt, this.closedAt, this.isClosed = false}): _memberIds = memberIds;
  factory _GroupEntity.fromJson(Map<String, dynamic> json) => _$GroupEntityFromJson(json);

@override final  String id;
@override final  String title;
@override final  String? description;
@override final  String createdBy;
 final  List<String> _memberIds;
@override List<String> get memberIds {
  if (_memberIds is EqualUnmodifiableListView) return _memberIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_memberIds);
}

@override final  DateTime createdAt;
@override final  DateTime? closedAt;
@override@JsonKey() final  bool isClosed;

/// Create a copy of GroupEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupEntityCopyWith<_GroupEntity> get copyWith => __$GroupEntityCopyWithImpl<_GroupEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GroupEntityToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'GroupEntity'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('title', title))..add(DiagnosticsProperty('description', description))..add(DiagnosticsProperty('createdBy', createdBy))..add(DiagnosticsProperty('memberIds', memberIds))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('closedAt', closedAt))..add(DiagnosticsProperty('isClosed', isClosed));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&const DeepCollectionEquality().equals(other._memberIds, _memberIds)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.closedAt, closedAt) || other.closedAt == closedAt)&&(identical(other.isClosed, isClosed) || other.isClosed == isClosed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,createdBy,const DeepCollectionEquality().hash(_memberIds),createdAt,closedAt,isClosed);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'GroupEntity(id: $id, title: $title, description: $description, createdBy: $createdBy, memberIds: $memberIds, createdAt: $createdAt, closedAt: $closedAt, isClosed: $isClosed)';
}


}

/// @nodoc
abstract mixin class _$GroupEntityCopyWith<$Res> implements $GroupEntityCopyWith<$Res> {
  factory _$GroupEntityCopyWith(_GroupEntity value, $Res Function(_GroupEntity) _then) = __$GroupEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? description, String createdBy, List<String> memberIds, DateTime createdAt, DateTime? closedAt, bool isClosed
});




}
/// @nodoc
class __$GroupEntityCopyWithImpl<$Res>
    implements _$GroupEntityCopyWith<$Res> {
  __$GroupEntityCopyWithImpl(this._self, this._then);

  final _GroupEntity _self;
  final $Res Function(_GroupEntity) _then;

/// Create a copy of GroupEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? createdBy = null,Object? memberIds = null,Object? createdAt = null,Object? closedAt = freezed,Object? isClosed = null,}) {
  return _then(_GroupEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,memberIds: null == memberIds ? _self._memberIds : memberIds // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,closedAt: freezed == closedAt ? _self.closedAt : closedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isClosed: null == isClosed ? _self.isClosed : isClosed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
