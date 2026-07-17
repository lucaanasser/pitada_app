// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'technique.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Technique _$TechniqueFromJson(Map<String, dynamic> json) => _Technique(
      id: json['id'] as String,
      slug: json['slug'] as String,
      name: json['name'] as String,
      notion: json['notion'] as String?,
    );

Map<String, dynamic> _$TechniqueToJson(_Technique instance) =>
    <String, dynamic>{
      'id': instance.id,
      'slug': instance.slug,
      'name': instance.name,
      'notion': instance.notion,
    };
