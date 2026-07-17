// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Recipe {
  String get id;
  String get title;
  RecipeSource get source;
  String? get sourceUrl;
  int get servings;
  int? get timeMinutes;
  int get kcal;
  num get protein;
  num get carb;
  num get fat;
  String get heroColor;
  int get photoCount;
  String? get notes;
  List<String> get folderIds;
  List<String> get techniques;
  List<Ingredient> get ingredients;
  List<RecipeStep> get steps;
  List<RecipeComponent> get components;
  int get version;
  String? get versionGroupId;

  /// Create a copy of Recipe
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RecipeCopyWith<Recipe> get copyWith =>
      _$RecipeCopyWithImpl<Recipe>(this as Recipe, _$identity);

  /// Serializes this Recipe to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Recipe &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.sourceUrl, sourceUrl) ||
                other.sourceUrl == sourceUrl) &&
            (identical(other.servings, servings) ||
                other.servings == servings) &&
            (identical(other.timeMinutes, timeMinutes) ||
                other.timeMinutes == timeMinutes) &&
            (identical(other.kcal, kcal) || other.kcal == kcal) &&
            (identical(other.protein, protein) || other.protein == protein) &&
            (identical(other.carb, carb) || other.carb == carb) &&
            (identical(other.fat, fat) || other.fat == fat) &&
            (identical(other.heroColor, heroColor) ||
                other.heroColor == heroColor) &&
            (identical(other.photoCount, photoCount) ||
                other.photoCount == photoCount) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality().equals(other.folderIds, folderIds) &&
            const DeepCollectionEquality()
                .equals(other.techniques, techniques) &&
            const DeepCollectionEquality()
                .equals(other.ingredients, ingredients) &&
            const DeepCollectionEquality().equals(other.steps, steps) &&
            const DeepCollectionEquality()
                .equals(other.components, components) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.versionGroupId, versionGroupId) ||
                other.versionGroupId == versionGroupId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        title,
        source,
        sourceUrl,
        servings,
        timeMinutes,
        kcal,
        protein,
        carb,
        fat,
        heroColor,
        photoCount,
        notes,
        const DeepCollectionEquality().hash(folderIds),
        const DeepCollectionEquality().hash(techniques),
        const DeepCollectionEquality().hash(ingredients),
        const DeepCollectionEquality().hash(steps),
        const DeepCollectionEquality().hash(components),
        version,
        versionGroupId
      ]);

  @override
  String toString() {
    return 'Recipe(id: $id, title: $title, source: $source, sourceUrl: $sourceUrl, servings: $servings, timeMinutes: $timeMinutes, kcal: $kcal, protein: $protein, carb: $carb, fat: $fat, heroColor: $heroColor, photoCount: $photoCount, notes: $notes, folderIds: $folderIds, techniques: $techniques, ingredients: $ingredients, steps: $steps, components: $components, version: $version, versionGroupId: $versionGroupId)';
  }
}

/// @nodoc
abstract mixin class $RecipeCopyWith<$Res> {
  factory $RecipeCopyWith(Recipe value, $Res Function(Recipe) _then) =
      _$RecipeCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String title,
      RecipeSource source,
      String? sourceUrl,
      int servings,
      int? timeMinutes,
      int kcal,
      num protein,
      num carb,
      num fat,
      String heroColor,
      int photoCount,
      String? notes,
      List<String> folderIds,
      List<String> techniques,
      List<Ingredient> ingredients,
      List<RecipeStep> steps,
      List<RecipeComponent> components,
      int version,
      String? versionGroupId});
}

/// @nodoc
class _$RecipeCopyWithImpl<$Res> implements $RecipeCopyWith<$Res> {
  _$RecipeCopyWithImpl(this._self, this._then);

  final Recipe _self;
  final $Res Function(Recipe) _then;

  /// Create a copy of Recipe
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? source = null,
    Object? sourceUrl = freezed,
    Object? servings = null,
    Object? timeMinutes = freezed,
    Object? kcal = null,
    Object? protein = null,
    Object? carb = null,
    Object? fat = null,
    Object? heroColor = null,
    Object? photoCount = null,
    Object? notes = freezed,
    Object? folderIds = null,
    Object? techniques = null,
    Object? ingredients = null,
    Object? steps = null,
    Object? components = null,
    Object? version = null,
    Object? versionGroupId = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _self.source
          : source // ignore: cast_nullable_to_non_nullable
              as RecipeSource,
      sourceUrl: freezed == sourceUrl
          ? _self.sourceUrl
          : sourceUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      servings: null == servings
          ? _self.servings
          : servings // ignore: cast_nullable_to_non_nullable
              as int,
      timeMinutes: freezed == timeMinutes
          ? _self.timeMinutes
          : timeMinutes // ignore: cast_nullable_to_non_nullable
              as int?,
      kcal: null == kcal
          ? _self.kcal
          : kcal // ignore: cast_nullable_to_non_nullable
              as int,
      protein: null == protein
          ? _self.protein
          : protein // ignore: cast_nullable_to_non_nullable
              as num,
      carb: null == carb
          ? _self.carb
          : carb // ignore: cast_nullable_to_non_nullable
              as num,
      fat: null == fat
          ? _self.fat
          : fat // ignore: cast_nullable_to_non_nullable
              as num,
      heroColor: null == heroColor
          ? _self.heroColor
          : heroColor // ignore: cast_nullable_to_non_nullable
              as String,
      photoCount: null == photoCount
          ? _self.photoCount
          : photoCount // ignore: cast_nullable_to_non_nullable
              as int,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      folderIds: null == folderIds
          ? _self.folderIds
          : folderIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      techniques: null == techniques
          ? _self.techniques
          : techniques // ignore: cast_nullable_to_non_nullable
              as List<String>,
      ingredients: null == ingredients
          ? _self.ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<Ingredient>,
      steps: null == steps
          ? _self.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<RecipeStep>,
      components: null == components
          ? _self.components
          : components // ignore: cast_nullable_to_non_nullable
              as List<RecipeComponent>,
      version: null == version
          ? _self.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      versionGroupId: freezed == versionGroupId
          ? _self.versionGroupId
          : versionGroupId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Recipe].
extension RecipePatterns on Recipe {
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
    TResult Function(_Recipe value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Recipe() when $default != null:
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
    TResult Function(_Recipe value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Recipe():
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
    TResult? Function(_Recipe value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Recipe() when $default != null:
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
            String title,
            RecipeSource source,
            String? sourceUrl,
            int servings,
            int? timeMinutes,
            int kcal,
            num protein,
            num carb,
            num fat,
            String heroColor,
            int photoCount,
            String? notes,
            List<String> folderIds,
            List<String> techniques,
            List<Ingredient> ingredients,
            List<RecipeStep> steps,
            List<RecipeComponent> components,
            int version,
            String? versionGroupId)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Recipe() when $default != null:
        return $default(
            _that.id,
            _that.title,
            _that.source,
            _that.sourceUrl,
            _that.servings,
            _that.timeMinutes,
            _that.kcal,
            _that.protein,
            _that.carb,
            _that.fat,
            _that.heroColor,
            _that.photoCount,
            _that.notes,
            _that.folderIds,
            _that.techniques,
            _that.ingredients,
            _that.steps,
            _that.components,
            _that.version,
            _that.versionGroupId);
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
            String title,
            RecipeSource source,
            String? sourceUrl,
            int servings,
            int? timeMinutes,
            int kcal,
            num protein,
            num carb,
            num fat,
            String heroColor,
            int photoCount,
            String? notes,
            List<String> folderIds,
            List<String> techniques,
            List<Ingredient> ingredients,
            List<RecipeStep> steps,
            List<RecipeComponent> components,
            int version,
            String? versionGroupId)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Recipe():
        return $default(
            _that.id,
            _that.title,
            _that.source,
            _that.sourceUrl,
            _that.servings,
            _that.timeMinutes,
            _that.kcal,
            _that.protein,
            _that.carb,
            _that.fat,
            _that.heroColor,
            _that.photoCount,
            _that.notes,
            _that.folderIds,
            _that.techniques,
            _that.ingredients,
            _that.steps,
            _that.components,
            _that.version,
            _that.versionGroupId);
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
            String title,
            RecipeSource source,
            String? sourceUrl,
            int servings,
            int? timeMinutes,
            int kcal,
            num protein,
            num carb,
            num fat,
            String heroColor,
            int photoCount,
            String? notes,
            List<String> folderIds,
            List<String> techniques,
            List<Ingredient> ingredients,
            List<RecipeStep> steps,
            List<RecipeComponent> components,
            int version,
            String? versionGroupId)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Recipe() when $default != null:
        return $default(
            _that.id,
            _that.title,
            _that.source,
            _that.sourceUrl,
            _that.servings,
            _that.timeMinutes,
            _that.kcal,
            _that.protein,
            _that.carb,
            _that.fat,
            _that.heroColor,
            _that.photoCount,
            _that.notes,
            _that.folderIds,
            _that.techniques,
            _that.ingredients,
            _that.steps,
            _that.components,
            _that.version,
            _that.versionGroupId);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Recipe extends Recipe {
  const _Recipe(
      {required this.id,
      required this.title,
      this.source = RecipeSource.manual,
      this.sourceUrl,
      this.servings = 2,
      this.timeMinutes,
      required this.kcal,
      this.protein = 0,
      this.carb = 0,
      this.fat = 0,
      this.heroColor = 'clay',
      this.photoCount = 0,
      this.notes,
      final List<String> folderIds = const [],
      final List<String> techniques = const [],
      final List<Ingredient> ingredients = const [],
      final List<RecipeStep> steps = const [],
      final List<RecipeComponent> components = const [],
      this.version = 1,
      this.versionGroupId})
      : _folderIds = folderIds,
        _techniques = techniques,
        _ingredients = ingredients,
        _steps = steps,
        _components = components,
        super._();
  factory _Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  @JsonKey()
  final RecipeSource source;
  @override
  final String? sourceUrl;
  @override
  @JsonKey()
  final int servings;
  @override
  final int? timeMinutes;
  @override
  final int kcal;
  @override
  @JsonKey()
  final num protein;
  @override
  @JsonKey()
  final num carb;
  @override
  @JsonKey()
  final num fat;
  @override
  @JsonKey()
  final String heroColor;
  @override
  @JsonKey()
  final int photoCount;
  @override
  final String? notes;
  final List<String> _folderIds;
  @override
  @JsonKey()
  List<String> get folderIds {
    if (_folderIds is EqualUnmodifiableListView) return _folderIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_folderIds);
  }

  final List<String> _techniques;
  @override
  @JsonKey()
  List<String> get techniques {
    if (_techniques is EqualUnmodifiableListView) return _techniques;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_techniques);
  }

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

  final List<RecipeComponent> _components;
  @override
  @JsonKey()
  List<RecipeComponent> get components {
    if (_components is EqualUnmodifiableListView) return _components;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_components);
  }

  @override
  @JsonKey()
  final int version;
  @override
  final String? versionGroupId;

  /// Create a copy of Recipe
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RecipeCopyWith<_Recipe> get copyWith =>
      __$RecipeCopyWithImpl<_Recipe>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RecipeToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Recipe &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.sourceUrl, sourceUrl) ||
                other.sourceUrl == sourceUrl) &&
            (identical(other.servings, servings) ||
                other.servings == servings) &&
            (identical(other.timeMinutes, timeMinutes) ||
                other.timeMinutes == timeMinutes) &&
            (identical(other.kcal, kcal) || other.kcal == kcal) &&
            (identical(other.protein, protein) || other.protein == protein) &&
            (identical(other.carb, carb) || other.carb == carb) &&
            (identical(other.fat, fat) || other.fat == fat) &&
            (identical(other.heroColor, heroColor) ||
                other.heroColor == heroColor) &&
            (identical(other.photoCount, photoCount) ||
                other.photoCount == photoCount) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality()
                .equals(other._folderIds, _folderIds) &&
            const DeepCollectionEquality()
                .equals(other._techniques, _techniques) &&
            const DeepCollectionEquality()
                .equals(other._ingredients, _ingredients) &&
            const DeepCollectionEquality().equals(other._steps, _steps) &&
            const DeepCollectionEquality()
                .equals(other._components, _components) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.versionGroupId, versionGroupId) ||
                other.versionGroupId == versionGroupId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        title,
        source,
        sourceUrl,
        servings,
        timeMinutes,
        kcal,
        protein,
        carb,
        fat,
        heroColor,
        photoCount,
        notes,
        const DeepCollectionEquality().hash(_folderIds),
        const DeepCollectionEquality().hash(_techniques),
        const DeepCollectionEquality().hash(_ingredients),
        const DeepCollectionEquality().hash(_steps),
        const DeepCollectionEquality().hash(_components),
        version,
        versionGroupId
      ]);

  @override
  String toString() {
    return 'Recipe(id: $id, title: $title, source: $source, sourceUrl: $sourceUrl, servings: $servings, timeMinutes: $timeMinutes, kcal: $kcal, protein: $protein, carb: $carb, fat: $fat, heroColor: $heroColor, photoCount: $photoCount, notes: $notes, folderIds: $folderIds, techniques: $techniques, ingredients: $ingredients, steps: $steps, components: $components, version: $version, versionGroupId: $versionGroupId)';
  }
}

/// @nodoc
abstract mixin class _$RecipeCopyWith<$Res> implements $RecipeCopyWith<$Res> {
  factory _$RecipeCopyWith(_Recipe value, $Res Function(_Recipe) _then) =
      __$RecipeCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      RecipeSource source,
      String? sourceUrl,
      int servings,
      int? timeMinutes,
      int kcal,
      num protein,
      num carb,
      num fat,
      String heroColor,
      int photoCount,
      String? notes,
      List<String> folderIds,
      List<String> techniques,
      List<Ingredient> ingredients,
      List<RecipeStep> steps,
      List<RecipeComponent> components,
      int version,
      String? versionGroupId});
}

/// @nodoc
class __$RecipeCopyWithImpl<$Res> implements _$RecipeCopyWith<$Res> {
  __$RecipeCopyWithImpl(this._self, this._then);

  final _Recipe _self;
  final $Res Function(_Recipe) _then;

  /// Create a copy of Recipe
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? source = null,
    Object? sourceUrl = freezed,
    Object? servings = null,
    Object? timeMinutes = freezed,
    Object? kcal = null,
    Object? protein = null,
    Object? carb = null,
    Object? fat = null,
    Object? heroColor = null,
    Object? photoCount = null,
    Object? notes = freezed,
    Object? folderIds = null,
    Object? techniques = null,
    Object? ingredients = null,
    Object? steps = null,
    Object? components = null,
    Object? version = null,
    Object? versionGroupId = freezed,
  }) {
    return _then(_Recipe(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _self.source
          : source // ignore: cast_nullable_to_non_nullable
              as RecipeSource,
      sourceUrl: freezed == sourceUrl
          ? _self.sourceUrl
          : sourceUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      servings: null == servings
          ? _self.servings
          : servings // ignore: cast_nullable_to_non_nullable
              as int,
      timeMinutes: freezed == timeMinutes
          ? _self.timeMinutes
          : timeMinutes // ignore: cast_nullable_to_non_nullable
              as int?,
      kcal: null == kcal
          ? _self.kcal
          : kcal // ignore: cast_nullable_to_non_nullable
              as int,
      protein: null == protein
          ? _self.protein
          : protein // ignore: cast_nullable_to_non_nullable
              as num,
      carb: null == carb
          ? _self.carb
          : carb // ignore: cast_nullable_to_non_nullable
              as num,
      fat: null == fat
          ? _self.fat
          : fat // ignore: cast_nullable_to_non_nullable
              as num,
      heroColor: null == heroColor
          ? _self.heroColor
          : heroColor // ignore: cast_nullable_to_non_nullable
              as String,
      photoCount: null == photoCount
          ? _self.photoCount
          : photoCount // ignore: cast_nullable_to_non_nullable
              as int,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      folderIds: null == folderIds
          ? _self._folderIds
          : folderIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      techniques: null == techniques
          ? _self._techniques
          : techniques // ignore: cast_nullable_to_non_nullable
              as List<String>,
      ingredients: null == ingredients
          ? _self._ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<Ingredient>,
      steps: null == steps
          ? _self._steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<RecipeStep>,
      components: null == components
          ? _self._components
          : components // ignore: cast_nullable_to_non_nullable
              as List<RecipeComponent>,
      version: null == version
          ? _self.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      versionGroupId: freezed == versionGroupId
          ? _self.versionGroupId
          : versionGroupId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
