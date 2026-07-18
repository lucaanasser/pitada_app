// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubRecipe _$SubRecipeFromJson(Map<String, dynamic> json) => _SubRecipe(
      id: json['id'] as String,
      name: json['name'] as String,
      ingredients: (json['ingredients'] as List<dynamic>?)
              ?.map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      steps: (json['steps'] as List<dynamic>?)
              ?.map((e) => RecipeStep.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$SubRecipeToJson(_SubRecipe instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'ingredients': instance.ingredients.map((e) => e.toJson()).toList(),
      'steps': instance.steps.map((e) => e.toJson()).toList(),
    };
