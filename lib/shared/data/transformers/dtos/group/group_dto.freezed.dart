// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GroupDto implements DiagnosticableTreeMixin {

@HiveField(0) String get id;@HiveField(1) String get title;@HiveField(2) String? get description;@HiveField(3) String get createdBy;@HiveField(4) List<String> get memberIds;@HiveField(5) DateTime get createdAt;@HiveField(6) DateTime? get closedAt;@HiveField(7) bool get isClosed;
/// Create a copy of GroupDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupDtoCopyWith<GroupDto> get copyWith => _$GroupDtoCopyWithImpl<GroupDto>(this as GroupDto, _$identity);

  /// Serializes this GroupDto to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'GroupDto'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('title', title))..add(DiagnosticsProperty('description', description))..add(DiagnosticsProperty('createdBy', createdBy))..add(DiagnosticsProperty('memberIds', memberIds))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('closedAt', closedAt))..add(DiagnosticsProperty('isClosed', isClosed));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&const DeepCollectionEquality().equals(other.memberIds, memberIds)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.closedAt, closedAt) || other.closedAt == closedAt)&&(identical(other.isClosed, isClosed) || other.isClosed == isClosed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,createdBy,const DeepCollectionEquality().hash(memberIds),createdAt,closedAt,isClosed);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'GroupDto(id: $id, title: $title, description: $description, createdBy: $createdBy, memberIds: $memberIds, createdAt: $createdAt, closedAt: $closedAt, isClosed: $isClosed)';
}


}

/// @nodoc
abstract mixin class $GroupDtoCopyWith<$Res>  {
  factory $GroupDtoCopyWith(GroupDto value, $Res Function(GroupDto) _then) = _$GroupDtoCopyWithImpl;
@useResult
$Res call({
@HiveField(0) String id,@HiveField(1) String title,@HiveField(2) String? description,@HiveField(3) String createdBy,@HiveField(4) List<String> memberIds,@HiveField(5) DateTime createdAt,@HiveField(6) DateTime? closedAt,@HiveField(7) bool isClosed
});




}
/// @nodoc
class _$GroupDtoCopyWithImpl<$Res>
    implements $GroupDtoCopyWith<$Res> {
  _$GroupDtoCopyWithImpl(this._self, this._then);

  final GroupDto _self;
  final $Res Function(GroupDto) _then;

/// Create a copy of GroupDto
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


/// Adds pattern-matching-related methods to [GroupDto].
extension GroupDtoPatterns on GroupDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GroupDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GroupDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GroupDto value)  $default,){
final _that = this;
switch (_that) {
case _GroupDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GroupDto value)?  $default,){
final _that = this;
switch (_that) {
case _GroupDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@HiveField(0)  String id, @HiveField(1)  String title, @HiveField(2)  String? description, @HiveField(3)  String createdBy, @HiveField(4)  List<String> memberIds, @HiveField(5)  DateTime createdAt, @HiveField(6)  DateTime? closedAt, @HiveField(7)  bool isClosed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GroupDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@HiveField(0)  String id, @HiveField(1)  String title, @HiveField(2)  String? description, @HiveField(3)  String createdBy, @HiveField(4)  List<String> memberIds, @HiveField(5)  DateTime createdAt, @HiveField(6)  DateTime? closedAt, @HiveField(7)  bool isClosed)  $default,) {final _that = this;
switch (_that) {
case _GroupDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@HiveField(0)  String id, @HiveField(1)  String title, @HiveField(2)  String? description, @HiveField(3)  String createdBy, @HiveField(4)  List<String> memberIds, @HiveField(5)  DateTime createdAt, @HiveField(6)  DateTime? closedAt, @HiveField(7)  bool isClosed)?  $default,) {final _that = this;
switch (_that) {
case _GroupDto() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.createdBy,_that.memberIds,_that.createdAt,_that.closedAt,_that.isClosed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GroupDto with DiagnosticableTreeMixin implements GroupDto {
  const _GroupDto({@HiveField(0) required this.id, @HiveField(1) required this.title, @HiveField(2) this.description, @HiveField(3) required this.createdBy, @HiveField(4) required final  List<String> memberIds, @HiveField(5) required this.createdAt, @HiveField(6) this.closedAt, @HiveField(7) this.isClosed = false}): _memberIds = memberIds;
  factory _GroupDto.fromJson(Map<String, dynamic> json) => _$GroupDtoFromJson(json);

@override@HiveField(0) final  String id;
@override@HiveField(1) final  String title;
@override@HiveField(2) final  String? description;
@override@HiveField(3) final  String createdBy;
 final  List<String> _memberIds;
@override@HiveField(4) List<String> get memberIds {
  if (_memberIds is EqualUnmodifiableListView) return _memberIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_memberIds);
}

@override@HiveField(5) final  DateTime createdAt;
@override@HiveField(6) final  DateTime? closedAt;
@override@JsonKey()@HiveField(7) final  bool isClosed;

/// Create a copy of GroupDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupDtoCopyWith<_GroupDto> get copyWith => __$GroupDtoCopyWithImpl<_GroupDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GroupDtoToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'GroupDto'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('title', title))..add(DiagnosticsProperty('description', description))..add(DiagnosticsProperty('createdBy', createdBy))..add(DiagnosticsProperty('memberIds', memberIds))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('closedAt', closedAt))..add(DiagnosticsProperty('isClosed', isClosed));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&const DeepCollectionEquality().equals(other._memberIds, _memberIds)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.closedAt, closedAt) || other.closedAt == closedAt)&&(identical(other.isClosed, isClosed) || other.isClosed == isClosed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,createdBy,const DeepCollectionEquality().hash(_memberIds),createdAt,closedAt,isClosed);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'GroupDto(id: $id, title: $title, description: $description, createdBy: $createdBy, memberIds: $memberIds, createdAt: $createdAt, closedAt: $closedAt, isClosed: $isClosed)';
}


}

/// @nodoc
abstract mixin class _$GroupDtoCopyWith<$Res> implements $GroupDtoCopyWith<$Res> {
  factory _$GroupDtoCopyWith(_GroupDto value, $Res Function(_GroupDto) _then) = __$GroupDtoCopyWithImpl;
@override @useResult
$Res call({
@HiveField(0) String id,@HiveField(1) String title,@HiveField(2) String? description,@HiveField(3) String createdBy,@HiveField(4) List<String> memberIds,@HiveField(5) DateTime createdAt,@HiveField(6) DateTime? closedAt,@HiveField(7) bool isClosed
});




}
/// @nodoc
class __$GroupDtoCopyWithImpl<$Res>
    implements _$GroupDtoCopyWith<$Res> {
  __$GroupDtoCopyWithImpl(this._self, this._then);

  final _GroupDto _self;
  final $Res Function(_GroupDto) _then;

/// Create a copy of GroupDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? createdBy = null,Object? memberIds = null,Object? createdAt = null,Object? closedAt = freezed,Object? isClosed = null,}) {
  return _then(_GroupDto(
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
