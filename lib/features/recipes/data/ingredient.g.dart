// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Ingredient _$IngredientFromJson(Map<String, dynamic> json) => _Ingredient(
      name: json['name'] as String,
      grams: json['grams'] as num?,
      humanQty: json['human_qty'] as num?,
      humanUnit: json['human_unit'] as String?,
    );

Map<String, dynamic> _$IngredientToJson(_Ingredient instance) =>
    <String, dynamic>{
      'name': instance.name,
      'grams': instance.grams,
      'human_qty': instance.humanQty,
      'human_unit': instance.humanUnit,
    };
