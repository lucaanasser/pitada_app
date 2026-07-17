// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_component.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RecipeComponent _$RecipeComponentFromJson(Map<String, dynamic> json) =>
    _RecipeComponent(
      name: json['name'] as String?,
      ingredients: (json['ingredients'] as List<dynamic>?)
              ?.map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      steps: (json['steps'] as List<dynamic>?)
              ?.map((e) => RecipeStep.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$RecipeComponentToJson(_RecipeComponent instance) =>
    <String, dynamic>{
      'name': instance.name,
      'ingredients': instance.ingredients.map((e) => e.toJson()).toList(),
      'steps': instance.steps.map((e) => e.toJson()).toList(),
    };
