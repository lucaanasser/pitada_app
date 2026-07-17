// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe_step.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StepTechnique {
  String get techniqueId;
  String? get anchor;

  /// Create a copy of StepTechnique
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $StepTechniqueCopyWith<StepTechnique> get copyWith =>
      _$StepTechniqueCopyWithImpl<StepTechnique>(
          this as StepTechnique, _$identity);

  /// Serializes this StepTechnique to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StepTechnique &&
            (identical(other.techniqueId, techniqueId) ||
                other.techniqueId == techniqueId) &&
            (identical(other.anchor, anchor) || other.anchor == anchor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, techniqueId, anchor);

  @override
  String toString() {
    return 'StepTechnique(techniqueId: $techniqueId, anchor: $anchor)';
  }
}

/// @nodoc
abstract mixin class $StepTechniqueCopyWith<$Res> {
  factory $StepTechniqueCopyWith(
          StepTechnique value, $Res Function(StepTechnique) _then) =
      _$StepTechniqueCopyWithImpl;
  @useResult
  $Res call({String techniqueId, String? anchor});
}

/// @nodoc
class _$StepTechniqueCopyWithImpl<$Res>
    implements $StepTechniqueCopyWith<$Res> {
  _$StepTechniqueCopyWithImpl(this._self, this._then);

  final StepTechnique _self;
  final $Res Function(StepTechnique) _then;

  /// Create a copy of StepTechnique
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? techniqueId = null,
    Object? anchor = freezed,
  }) {
    return _then(_self.copyWith(
      techniqueId: null == techniqueId
          ? _self.techniqueId
          : techniqueId // ignore: cast_nullable_to_non_nullable
              as String,
      anchor: freezed == anchor
          ? _self.anchor
          : anchor // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [StepTechnique].
extension StepTechniquePatterns on StepTechnique {
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
    TResult Function(_StepTechnique value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StepTechnique() when $default != null:
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
    TResult Function(_StepTechnique value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StepTechnique():
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
    TResult? Function(_StepTechnique value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StepTechnique() when $default != null:
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
    TResult Function(String techniqueId, String? anchor)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _StepTechnique() when $default != null:
        return $default(_that.techniqueId, _that.anchor);
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
    TResult Function(String techniqueId, String? anchor) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StepTechnique():
        return $default(_that.techniqueId, _that.anchor);
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
    TResult? Function(String techniqueId, String? anchor)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _StepTechnique() when $default != null:
        return $default(_that.techniqueId, _that.anchor);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _StepTechnique implements StepTechnique {
  const _StepTechnique({required this.techniqueId, this.anchor});
  factory _StepTechnique.fromJson(Map<String, dynamic> json) =>
      _$StepTechniqueFromJson(json);

  @override
  final String techniqueId;
  @override
  final String? anchor;

  /// Create a copy of StepTechnique
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$StepTechniqueCopyWith<_StepTechnique> get copyWith =>
      __$StepTechniqueCopyWithImpl<_StepTechnique>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$StepTechniqueToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _StepTechnique &&
            (identical(other.techniqueId, techniqueId) ||
                other.techniqueId == techniqueId) &&
            (identical(other.anchor, anchor) || other.anchor == anchor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, techniqueId, anchor);

  @override
  String toString() {
    return 'StepTechnique(techniqueId: $techniqueId, anchor: $anchor)';
  }
}

/// @nodoc
abstract mixin class _$StepTechniqueCopyWith<$Res>
    implements $StepTechniqueCopyWith<$Res> {
  factory _$StepTechniqueCopyWith(
          _StepTechnique value, $Res Function(_StepTechnique) _then) =
      __$StepTechniqueCopyWithImpl;
  @override
  @useResult
  $Res call({String techniqueId, String? anchor});
}

/// @nodoc
class __$StepTechniqueCopyWithImpl<$Res>
    implements _$StepTechniqueCopyWith<$Res> {
  __$StepTechniqueCopyWithImpl(this._self, this._then);

  final _StepTechnique _self;
  final $Res Function(_StepTechnique) _then;

  /// Create a copy of StepTechnique
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? techniqueId = null,
    Object? anchor = freezed,
  }) {
    return _then(_StepTechnique(
      techniqueId: null == techniqueId
          ? _self.techniqueId
          : techniqueId // ignore: cast_nullable_to_non_nullable
              as String,
      anchor: freezed == anchor
          ? _self.anchor
          : anchor // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$RecipeStep {
  String get text;
  String? get tip;
  List<StepTechnique> get techniques;

  /// Create a copy of RecipeStep
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RecipeStepCopyWith<RecipeStep> get copyWith =>
      _$RecipeStepCopyWithImpl<RecipeStep>(this as RecipeStep, _$identity);

  /// Serializes this RecipeStep to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RecipeStep &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.tip, tip) || other.tip == tip) &&
            const DeepCollectionEquality()
                .equals(other.techniques, techniques));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, text, tip, const DeepCollectionEquality().hash(techniques));

  @override
  String toString() {
    return 'RecipeStep(text: $text, tip: $tip, techniques: $techniques)';
  }
}

/// @nodoc
abstract mixin class $RecipeStepCopyWith<$Res> {
  factory $RecipeStepCopyWith(
          RecipeStep value, $Res Function(RecipeStep) _then) =
      _$RecipeStepCopyWithImpl;
  @useResult
  $Res call({String text, String? tip, List<StepTechnique> techniques});
}

/// @nodoc
class _$RecipeStepCopyWithImpl<$Res> implements $RecipeStepCopyWith<$Res> {
  _$RecipeStepCopyWithImpl(this._self, this._then);

  final RecipeStep _self;
  final $Res Function(RecipeStep) _then;

  /// Create a copy of RecipeStep
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? tip = freezed,
    Object? techniques = null,
  }) {
    return _then(_self.copyWith(
      text: null == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      tip: freezed == tip
          ? _self.tip
          : tip // ignore: cast_nullable_to_non_nullable
              as String?,
      techniques: null == techniques
          ? _self.techniques
          : techniques // ignore: cast_nullable_to_non_nullable
              as List<StepTechnique>,
    ));
  }
}

/// Adds pattern-matching-related methods to [RecipeStep].
extension RecipeStepPatterns on RecipeStep {
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
    TResult Function(_RecipeStep value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RecipeStep() when $default != null:
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
    TResult Function(_RecipeStep value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecipeStep():
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
    TResult? Function(_RecipeStep value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecipeStep() when $default != null:
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
    TResult Function(String text, String? tip, List<StepTechnique> techniques)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RecipeStep() when $default != null:
        return $default(_that.text, _that.tip, _that.techniques);
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
    TResult Function(String text, String? tip, List<StepTechnique> techniques)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecipeStep():
        return $default(_that.text, _that.tip, _that.techniques);
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
    TResult? Function(String text, String? tip, List<StepTechnique> techniques)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecipeStep() when $default != null:
        return $default(_that.text, _that.tip, _that.techniques);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _RecipeStep implements RecipeStep {
  const _RecipeStep(
      {required this.text,
      this.tip,
      final List<StepTechnique> techniques = const []})
      : _techniques = techniques;
  factory _RecipeStep.fromJson(Map<String, dynamic> json) =>
      _$RecipeStepFromJson(json);

  @override
  final String text;
  @override
  final String? tip;
  final List<StepTechnique> _techniques;
  @override
  @JsonKey()
  List<StepTechnique> get techniques {
    if (_techniques is EqualUnmodifiableListView) return _techniques;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_techniques);
  }

  /// Create a copy of RecipeStep
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RecipeStepCopyWith<_RecipeStep> get copyWith =>
      __$RecipeStepCopyWithImpl<_RecipeStep>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RecipeStepToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RecipeStep &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.tip, tip) || other.tip == tip) &&
            const DeepCollectionEquality()
                .equals(other._techniques, _techniques));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, text, tip, const DeepCollectionEquality().hash(_techniques));

  @override
  String toString() {
    return 'RecipeStep(text: $text, tip: $tip, techniques: $techniques)';
  }
}

/// @nodoc
abstract mixin class _$RecipeStepCopyWith<$Res>
    implements $RecipeStepCopyWith<$Res> {
  factory _$RecipeStepCopyWith(
          _RecipeStep value, $Res Function(_RecipeStep) _then) =
      __$RecipeStepCopyWithImpl;
  @override
  @useResult
  $Res call({String text, String? tip, List<StepTechnique> techniques});
}

/// @nodoc
class __$RecipeStepCopyWithImpl<$Res> implements _$RecipeStepCopyWith<$Res> {
  __$RecipeStepCopyWithImpl(this._self, this._then);

  final _RecipeStep _self;
  final $Res Function(_RecipeStep) _then;

  /// Create a copy of RecipeStep
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? text = null,
    Object? tip = freezed,
    Object? techniques = null,
  }) {
    return _then(_RecipeStep(
      text: null == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      tip: freezed == tip
          ? _self.tip
          : tip // ignore: cast_nullable_to_non_nullable
              as String?,
      techniques: null == techniques
          ? _self._techniques
          : techniques // ignore: cast_nullable_to_non_nullable
              as List<StepTechnique>,
    ));
  }
}

// dart format on
