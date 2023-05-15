import 'package:json_annotation/json_annotation.dart';

part 'recipe_index.g.dart';

@JsonSerializable(includeIfNull: false)
class RecipeIndex {
  final int? id;
  final String recipeIndexText;

  const RecipeIndex({this.id, required this.recipeIndexText});

  factory RecipeIndex.fromJson(Map<String, dynamic> json) => _$RecipeIndexFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeIndexToJson(this);
}
