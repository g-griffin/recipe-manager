// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_index.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeIndex _$RecipeIndexFromJson(Map<String, dynamic> json) => RecipeIndex(
      id: json['id'] as int?,
      recipeIndexText: json['recipeIndexText'] as String,
    );

Map<String, dynamic> _$RecipeIndexToJson(RecipeIndex instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['recipeIndexText'] = instance.recipeIndexText;
  return val;
}
