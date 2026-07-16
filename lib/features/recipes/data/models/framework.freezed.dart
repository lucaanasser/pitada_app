// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'framework.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Framework {
  String get id;
  String get name;
  List<String> get skeleton;
  List<String> get slots;
  List<String> get rules;
  List<String> get recipeIds;
  List<String> get techniques;

  /// Create a copy of Framework
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FrameworkCopyWith<Framework> get copyWith =>
      _$FrameworkCopyWithImpl<Framework>(this as Framework, _$identity);

  /// Serializes this Framework to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Framework &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other.skeleton, skeleton) &&
            const DeepCollectionEquality().equals(other.slots, slots) &&
            const DeepCollectionEquality().equals(other.rules, rules) &&
            const DeepCollectionEquality().equals(other.recipeIds, recipeIds) &&
            const DeepCollectionEquality()
                .equals(other.techniques, techniques));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      const DeepCollectionEquality().hash(skeleton),
      const DeepCollectionEquality().hash(slots),
      const DeepCollectionEquality().hash(rules),
      const DeepCollectionEquality().hash(recipeIds),
      const DeepCollectionEquality().hash(techniques));

  @override
  String toString() {
    return 'Framework(id: $id, name: $name, skeleton: $skeleton, slots: $slots, rules: $rules, recipeIds: $recipeIds, techniques: $techniques)';
  }
}

/// @nodoc
abstract mixin class $FrameworkCopyWith<$Res> {
  factory $FrameworkCopyWith(Framework value, $Res Function(Framework) _then) =
      _$FrameworkCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      List<String> skeleton,
      List<String> slots,
      List<String> rules,
      List<String> recipeIds,
      List<String> techniques});
}

/// @nodoc
class _$FrameworkCopyWithImpl<$Res> implements $FrameworkCopyWith<$Res> {
  _$FrameworkCopyWithImpl(this._self, this._then);

  final Framework _self;
  final $Res Function(Framework) _then;

  /// Create a copy of Framework
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? skeleton = null,
    Object? slots = null,
    Object? rules = null,
    Object? recipeIds = null,
    Object? techniques = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      skeleton: null == skeleton
          ? _self.skeleton
          : skeleton // ignore: cast_nullable_to_non_nullable
              as List<String>,
      slots: null == slots
          ? _self.slots
          : slots // ignore: cast_nullable_to_non_nullable
              as List<String>,
      rules: null == rules
          ? _self.rules
          : rules // ignore: cast_nullable_to_non_nullable
              as List<String>,
      recipeIds: null == recipeIds
          ? _self.recipeIds
          : recipeIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      techniques: null == techniques
          ? _self.techniques
          : techniques // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// Adds pattern-matching-related methods to [Framework].
extension FrameworkPatterns on Framework {
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Framework value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Framework() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Framework value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Framework():
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Framework value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Framework() when $default != null:
        return $default(_that);
      case _:
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String name,
            List<String> skeleton,
            List<String> slots,
            List<String> rules,
            List<String> recipeIds,
            List<String> techniques)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Framework() when $default != null:
        return $default(_that.id, _that.name, _that.skeleton, _that.slots,
            _that.rules, _that.recipeIds, _that.techniques);
      case _:
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String name,
            List<String> skeleton,
            List<String> slots,
            List<String> rules,
            List<String> recipeIds,
            List<String> techniques)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Framework():
        return $default(_that.id, _that.name, _that.skeleton, _that.slots,
            _that.rules, _that.recipeIds, _that.techniques);
      case _:
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String name,
            List<String> skeleton,
            List<String> slots,
            List<String> rules,
            List<String> recipeIds,
            List<String> techniques)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Framework() when $default != null:
        return $default(_that.id, _that.name, _that.skeleton, _that.slots,
            _that.rules, _that.recipeIds, _that.techniques);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Framework implements Framework {
  const _Framework(
      {required this.id,
      required this.name,
      final List<String> skeleton = const [],
      final List<String> slots = const [],
      final List<String> rules = const [],
      final List<String> recipeIds = const [],
      final List<String> techniques = const []})
      : _skeleton = skeleton,
        _slots = slots,
        _rules = rules,
        _recipeIds = recipeIds,
        _techniques = techniques;
  factory _Framework.fromJson(Map<String, dynamic> json) =>
      _$FrameworkFromJson(json);

  @override
  final String id;
  @override
  final String name;
  final List<String> _skeleton;
  @override
  @JsonKey()
  List<String> get skeleton {
    if (_skeleton is EqualUnmodifiableListView) return _skeleton;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_skeleton);
  }

  final List<String> _slots;
  @override
  @JsonKey()
  List<String> get slots {
    if (_slots is EqualUnmodifiableListView) return _slots;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_slots);
  }

  final List<String> _rules;
  @override
  @JsonKey()
  List<String> get rules {
    if (_rules is EqualUnmodifiableListView) return _rules;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rules);
  }

  final List<String> _recipeIds;
  @override
  @JsonKey()
  List<String> get recipeIds {
    if (_recipeIds is EqualUnmodifiableListView) return _recipeIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recipeIds);
  }

  final List<String> _techniques;
  @override
  @JsonKey()
  List<String> get techniques {
    if (_techniques is EqualUnmodifiableListView) return _techniques;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_techniques);
  }

  /// Create a copy of Framework
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FrameworkCopyWith<_Framework> get copyWith =>
      __$FrameworkCopyWithImpl<_Framework>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$FrameworkToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Framework &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._skeleton, _skeleton) &&
            const DeepCollectionEquality().equals(other._slots, _slots) &&
            const DeepCollectionEquality().equals(other._rules, _rules) &&
            const DeepCollectionEquality()
                .equals(other._recipeIds, _recipeIds) &&
            const DeepCollectionEquality()
                .equals(other._techniques, _techniques));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      const DeepCollectionEquality().hash(_skeleton),
      const DeepCollectionEquality().hash(_slots),
      const DeepCollectionEquality().hash(_rules),
      const DeepCollectionEquality().hash(_recipeIds),
      const DeepCollectionEquality().hash(_techniques));

  @override
  String toString() {
    return 'Framework(id: $id, name: $name, skeleton: $skeleton, slots: $slots, rules: $rules, recipeIds: $recipeIds, techniques: $techniques)';
  }
}

/// @nodoc
abstract mixin class _$FrameworkCopyWith<$Res>
    implements $FrameworkCopyWith<$Res> {
  factory _$FrameworkCopyWith(
          _Framework value, $Res Function(_Framework) _then) =
      __$FrameworkCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      List<String> skeleton,
      List<String> slots,
      List<String> rules,
      List<String> recipeIds,
      List<String> techniques});
}

/// @nodoc
class __$FrameworkCopyWithImpl<$Res> implements _$FrameworkCopyWith<$Res> {
  __$FrameworkCopyWithImpl(this._self, this._then);

  final _Framework _self;
  final $Res Function(_Framework) _then;

  /// Create a copy of Framework
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? skeleton = null,
    Object? slots = null,
    Object? rules = null,
    Object? recipeIds = null,
    Object? techniques = null,
  }) {
    return _then(_Framework(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      skeleton: null == skeleton
          ? _self._skeleton
          : skeleton // ignore: cast_nullable_to_non_nullable
              as List<String>,
      slots: null == slots
          ? _self._slots
          : slots // ignore: cast_nullable_to_non_nullable
              as List<String>,
      rules: null == rules
          ? _self._rules
          : rules // ignore: cast_nullable_to_non_nullable
              as List<String>,
      recipeIds: null == recipeIds
          ? _self._recipeIds
          : recipeIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      techniques: null == techniques
          ? _self._techniques
          : techniques // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on
