// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Recipe _$RecipeFromJson(Map<String, dynamic> json) => _Recipe(
      id: json['id'] as String,
      title: json['title'] as String,
      source: $enumDecodeNullable(_$RecipeSourceEnumMap, json['source']) ??
          RecipeSource.manual,
      sourceUrl: json['source_url'] as String?,
      servings: (json['servings'] as num?)?.toInt() ?? 2,
      timeMinutes: (json['time_minutes'] as num?)?.toInt(),
      kcal: (json['kcal'] as num).toInt(),
      protein: json['protein'] as num? ?? 0,
      carb: json['carb'] as num? ?? 0,
      fat: json['fat'] as num? ?? 0,
      difficulty: json['difficulty'] as String?,
      heroColor: json['hero_color'] as String? ?? 'clay',
      photoCount: (json['photo_count'] as num?)?.toInt() ?? 0,
      notes: json['notes'] as String?,
      folderIds: (json['folder_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      techniques: (json['techniques'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      ingredients: (json['ingredients'] as List<dynamic>?)
              ?.map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      steps: (json['steps'] as List<dynamic>?)
              ?.map((e) => RecipeStep.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      version: (json['version'] as num?)?.toInt() ?? 1,
      versionGroupId: json['version_group_id'] as String?,
    );

Map<String, dynamic> _$RecipeToJson(_Recipe instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'source': _$RecipeSourceEnumMap[instance.source]!,
      'source_url': instance.sourceUrl,
      'servings': instance.servings,
      'time_minutes': instance.timeMinutes,
      'kcal': instance.kcal,
      'protein': instance.protein,
      'carb': instance.carb,
      'fat': instance.fat,
      'difficulty': instance.difficulty,
      'hero_color': instance.heroColor,
      'photo_count': instance.photoCount,
      'notes': instance.notes,
      'folder_ids': instance.folderIds,
      'techniques': instance.techniques,
      'ingredients': instance.ingredients.map((e) => e.toJson()).toList(),
      'steps': instance.steps.map((e) => e.toJson()).toList(),
      'version': instance.version,
      'version_group_id': instance.versionGroupId,
    };

const _$RecipeSourceEnumMap = {
  RecipeSource.youtube: 'youtube',
  RecipeSource.instagram: 'instagram',
  RecipeSource.site: 'site',
  RecipeSource.pdf: 'pdf',
  RecipeSource.photo: 'photo',
  RecipeSource.manual: 'manual',
};
