import 'package:mobx/mobx.dart';
import 'package:recipe_manager/data/network/dio_client.dart';
import 'package:recipe_manager/di/service_locator.dart';
import 'package:recipe_manager/models/recipe_index.dart';

part 'recipe_index_store.g.dart';

class RecipeIndexStore = _RecipeIndexStore with _$RecipeIndexStore;

abstract class _RecipeIndexStore with Store {
  @observable
  List<RecipeIndex> _recipeIndices = ObservableList<RecipeIndex>();

  List<RecipeIndex> get recipeIndices => _recipeIndices;

  @action
  Future<void> loadRecipeIndices() async {
    List<RecipeIndex> response = await serviceLocator<DioClient>().getRecipeIndices();
    _recipeIndices = ObservableList.of(response);
  }
}
