// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_index_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RecipeIndexStore on _RecipeIndexStore, Store {
  late final _$_recipeIndicesAtom =
      Atom(name: '_RecipeIndexStore._recipeIndices', context: context);

  @override
  List<RecipeIndex> get _recipeIndices {
    _$_recipeIndicesAtom.reportRead();
    return super._recipeIndices;
  }

  @override
  set _recipeIndices(List<RecipeIndex> value) {
    _$_recipeIndicesAtom.reportWrite(value, super._recipeIndices, () {
      super._recipeIndices = value;
    });
  }

  late final _$loadRecipeIndicesAsyncAction =
      AsyncAction('_RecipeIndexStore.loadRecipeIndices', context: context);

  @override
  Future<void> loadRecipeIndices() {
    return _$loadRecipeIndicesAsyncAction.run(() => super.loadRecipeIndices());
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
