// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'framework.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Framework _$FrameworkFromJson(Map<String, dynamic> json) => _Framework(
      id: json['id'] as String,
      name: json['name'] as String,
      skeleton: (json['skeleton'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      slots:
          (json['slots'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      rules:
          (json['rules'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      recipeIds: (json['recipe_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      techniques: (json['techniques'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$FrameworkToJson(_Framework instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'skeleton': instance.skeleton,
      'slots': instance.slots,
      'rules': instance.rules,
      'recipe_ids': instance.recipeIds,
      'techniques': instance.techniques,
    };
