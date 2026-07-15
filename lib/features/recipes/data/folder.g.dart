// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Folder _$FolderFromJson(Map<String, dynamic> json) => _Folder(
      id: json['id'] as String,
      name: json['name'] as String,
      heroColor: json['hero_color'] as String? ?? 'clay',
    );

Map<String, dynamic> _$FolderToJson(_Folder instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'hero_color': instance.heroColor,
    };
