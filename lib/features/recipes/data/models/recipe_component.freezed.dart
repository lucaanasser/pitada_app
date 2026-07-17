// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe_component.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RecipeComponent {
  String? get name;
  List<Ingredient> get ingredients;
  List<RecipeStep> get steps;

  /// Create a copy of RecipeComponent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RecipeComponentCopyWith<RecipeComponent> get copyWith =>
      _$RecipeComponentCopyWithImpl<RecipeComponent>(
          this as RecipeComponent, _$identity);

  /// Serializes this RecipeComponent to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RecipeComponent &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other.ingredients, ingredients) &&
            const DeepCollectionEquality().equals(other.steps, steps));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      const DeepCollectionEquality().hash(ingredients),
      const DeepCollectionEquality().hash(steps));

  @override
  String toString() {
    return 'RecipeComponent(name: $name, ingredients: $ingredients, steps: $steps)';
  }
}

/// @nodoc
abstract mixin class $RecipeComponentCopyWith<$Res> {
  factory $RecipeComponentCopyWith(
          RecipeComponent value, $Res Function(RecipeComponent) _then) =
      _$RecipeComponentCopyWithImpl;
  @useResult
  $Res call(
      {String? name, List<Ingredient> ingredients, List<RecipeStep> steps});
}

/// @nodoc
class _$RecipeComponentCopyWithImpl<$Res>
    implements $RecipeComponentCopyWith<$Res> {
  _$RecipeComponentCopyWithImpl(this._self, this._then);

  final RecipeComponent _self;
  final $Res Function(RecipeComponent) _then;

  /// Create a copy of RecipeComponent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? ingredients = null,
    Object? steps = null,
  }) {
    return _then(_self.copyWith(
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      ingredients: null == ingredients
          ? _self.ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<Ingredient>,
      steps: null == steps
          ? _self.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<RecipeStep>,
    ));
  }
}

/// Adds pattern-matching-related methods to [RecipeComponent].
extension RecipeComponentPatterns on RecipeComponent {
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
    TResult Function(_RecipeComponent value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RecipeComponent() when $default != null:
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
    TResult Function(_RecipeComponent value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecipeComponent():
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
    TResult? Function(_RecipeComponent value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecipeComponent() when $default != null:
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
            String? name, List<Ingredient> ingredients, List<RecipeStep> steps)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RecipeComponent() when $default != null:
        return $default(_that.name, _that.ingredients, _that.steps);
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
            String? name, List<Ingredient> ingredients, List<RecipeStep> steps)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecipeComponent():
        return $default(_that.name, _that.ingredients, _that.steps);
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
            String? name, List<Ingredient> ingredients, List<RecipeStep> steps)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RecipeComponent() when $default != null:
        return $default(_that.name, _that.ingredients, _that.steps);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _RecipeComponent extends RecipeComponent {
  const _RecipeComponent(
      {this.name,
      final List<Ingredient> ingredients = const [],
      final List<RecipeStep> steps = const []})
      : _ingredients = ingredients,
        _steps = steps,
        super._();
  factory _RecipeComponent.fromJson(Map<String, dynamic> json) =>
      _$RecipeComponentFromJson(json);

  @override
  final String? name;
  final List<Ingredient> _ingredients;
  @override
  @JsonKey()
  List<Ingredient> get ingredients {
    if (_ingredients is EqualUnmodifiableListView) return _ingredients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ingredients);
  }

  final List<RecipeStep> _steps;
  @override
  @JsonKey()
  List<RecipeStep> get steps {
    if (_steps is EqualUnmodifiableListView) return _steps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_steps);
  }

  /// Create a copy of RecipeComponent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RecipeComponentCopyWith<_RecipeComponent> get copyWith =>
      __$RecipeComponentCopyWithImpl<_RecipeComponent>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RecipeComponentToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RecipeComponent &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._ingredients, _ingredients) &&
            const DeepCollectionEquality().equals(other._steps, _steps));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      const DeepCollectionEquality().hash(_ingredients),
      const DeepCollectionEquality().hash(_steps));

  @override
  String toString() {
    return 'RecipeComponent(name: $name, ingredients: $ingredients, steps: $steps)';
  }
}

/// @nodoc
abstract mixin class _$RecipeComponentCopyWith<$Res>
    implements $RecipeComponentCopyWith<$Res> {
  factory _$RecipeComponentCopyWith(
          _RecipeComponent value, $Res Function(_RecipeComponent) _then) =
      __$RecipeComponentCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? name, List<Ingredient> ingredients, List<RecipeStep> steps});
}

/// @nodoc
class __$RecipeComponentCopyWithImpl<$Res>
    implements _$RecipeComponentCopyWith<$Res> {
  __$RecipeComponentCopyWithImpl(this._self, this._then);

  final _RecipeComponent _self;
  final $Res Function(_RecipeComponent) _then;

  /// Create a copy of RecipeComponent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = freezed,
    Object? ingredients = null,
    Object? steps = null,
  }) {
    return _then(_RecipeComponent(
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      ingredients: null == ingredients
          ? _self._ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<Ingredient>,
      steps: null == steps
          ? _self._steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<RecipeStep>,
    ));
  }
}

// dart format on
