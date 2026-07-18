// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sub_recipe.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubRecipe {
  String get id;
  String get name;
  List<Ingredient> get ingredients;
  List<RecipeStep> get steps;

  /// Create a copy of SubRecipe
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SubRecipeCopyWith<SubRecipe> get copyWith =>
      _$SubRecipeCopyWithImpl<SubRecipe>(this as SubRecipe, _$identity);

  /// Serializes this SubRecipe to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SubRecipe &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other.ingredients, ingredients) &&
            const DeepCollectionEquality().equals(other.steps, steps));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      const DeepCollectionEquality().hash(ingredients),
      const DeepCollectionEquality().hash(steps));

  @override
  String toString() {
    return 'SubRecipe(id: $id, name: $name, ingredients: $ingredients, steps: $steps)';
  }
}

/// @nodoc
abstract mixin class $SubRecipeCopyWith<$Res> {
  factory $SubRecipeCopyWith(SubRecipe value, $Res Function(SubRecipe) _then) =
      _$SubRecipeCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      List<Ingredient> ingredients,
      List<RecipeStep> steps});
}

/// @nodoc
class _$SubRecipeCopyWithImpl<$Res> implements $SubRecipeCopyWith<$Res> {
  _$SubRecipeCopyWithImpl(this._self, this._then);

  final SubRecipe _self;
  final $Res Function(SubRecipe) _then;

  /// Create a copy of SubRecipe
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? ingredients = null,
    Object? steps = null,
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

/// Adds pattern-matching-related methods to [SubRecipe].
extension SubRecipePatterns on SubRecipe {
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
    TResult Function(_SubRecipe value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SubRecipe() when $default != null:
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
    TResult Function(_SubRecipe value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SubRecipe():
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
    TResult? Function(_SubRecipe value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SubRecipe() when $default != null:
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
    TResult Function(String id, String name, List<Ingredient> ingredients,
            List<RecipeStep> steps)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SubRecipe() when $default != null:
        return $default(_that.id, _that.name, _that.ingredients, _that.steps);
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
    TResult Function(String id, String name, List<Ingredient> ingredients,
            List<RecipeStep> steps)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SubRecipe():
        return $default(_that.id, _that.name, _that.ingredients, _that.steps);
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
    TResult? Function(String id, String name, List<Ingredient> ingredients,
            List<RecipeStep> steps)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SubRecipe() when $default != null:
        return $default(_that.id, _that.name, _that.ingredients, _that.steps);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SubRecipe implements SubRecipe {
  const _SubRecipe(
      {required this.id,
      required this.name,
      final List<Ingredient> ingredients = const [],
      final List<RecipeStep> steps = const []})
      : _ingredients = ingredients,
        _steps = steps;
  factory _SubRecipe.fromJson(Map<String, dynamic> json) =>
      _$SubRecipeFromJson(json);

  @override
  final String id;
  @override
  final String name;
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

  /// Create a copy of SubRecipe
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SubRecipeCopyWith<_SubRecipe> get copyWith =>
      __$SubRecipeCopyWithImpl<_SubRecipe>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SubRecipeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SubRecipe &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._ingredients, _ingredients) &&
            const DeepCollectionEquality().equals(other._steps, _steps));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      const DeepCollectionEquality().hash(_ingredients),
      const DeepCollectionEquality().hash(_steps));

  @override
  String toString() {
    return 'SubRecipe(id: $id, name: $name, ingredients: $ingredients, steps: $steps)';
  }
}

/// @nodoc
abstract mixin class _$SubRecipeCopyWith<$Res>
    implements $SubRecipeCopyWith<$Res> {
  factory _$SubRecipeCopyWith(
          _SubRecipe value, $Res Function(_SubRecipe) _then) =
      __$SubRecipeCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      List<Ingredient> ingredients,
      List<RecipeStep> steps});
}

/// @nodoc
class __$SubRecipeCopyWithImpl<$Res> implements _$SubRecipeCopyWith<$Res> {
  __$SubRecipeCopyWithImpl(this._self, this._then);

  final _SubRecipe _self;
  final $Res Function(_SubRecipe) _then;

  /// Create a copy of SubRecipe
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? ingredients = null,
    Object? steps = null,
  }) {
    return _then(_SubRecipe(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
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
