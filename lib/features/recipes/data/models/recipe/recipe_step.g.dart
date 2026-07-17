// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_step.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StepTechnique _$StepTechniqueFromJson(Map<String, dynamic> json) =>
    _StepTechnique(
      techniqueId: json['technique_id'] as String,
      anchor: json['anchor'] as String?,
    );

Map<String, dynamic> _$StepTechniqueToJson(_StepTechnique instance) =>
    <String, dynamic>{
      'technique_id': instance.techniqueId,
      'anchor': instance.anchor,
    };

_RecipeStep _$RecipeStepFromJson(Map<String, dynamic> json) => _RecipeStep(
      text: json['text'] as String,
      tip: json['tip'] as String?,
      techniques: (json['techniques'] as List<dynamic>?)
              ?.map((e) => StepTechnique.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$RecipeStepToJson(_RecipeStep instance) =>
    <String, dynamic>{
      'text': instance.text,
      'tip': instance.tip,
      'techniques': instance.techniques.map((e) => e.toJson()).toList(),
    };
