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
      flavors: (json['flavors'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$FlavorAxisEnumMap, e))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$IngredientToJson(_Ingredient instance) =>
    <String, dynamic>{
      'name': instance.name,
      'grams': instance.grams,
      'human_qty': instance.humanQty,
      'human_unit': instance.humanUnit,
      'flavors': instance.flavors.map((e) => _$FlavorAxisEnumMap[e]!).toList(),
    };

const _$FlavorAxisEnumMap = {
  FlavorAxis.acid: 'acid',
  FlavorAxis.umami: 'umami',
  FlavorAxis.fat: 'fat',
  FlavorAxis.sweet: 'sweet',
  FlavorAxis.bitter: 'bitter',
  FlavorAxis.salt: 'salt',
  FlavorAxis.fresh: 'fresh',
};
