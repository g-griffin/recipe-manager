import 'package:dio/dio.dart';
import 'package:recipe_manager/data/network/constants/endpoints.dart';
import 'package:recipe_manager/di/service_locator.dart';
import 'package:recipe_manager/models/recipe_index.dart';
import 'package:recipe_manager/stores/recipe_index_store.dart';

class DioClient {
  final Dio _dio;

  DioClient(this._dio);

  Future<List<RecipeIndex>> getRecipeIndices() async {
    List<RecipeIndex> recipeIndices = [];
    try {
      Response indexData = await _dio.get('${Endpoints.baseUrl}/recipeIndices');

      for (var index in indexData.data) {
        recipeIndices.add(RecipeIndex.fromJson(index));
      }
    } on DioError catch (e) {
      print(e);
    }

    return recipeIndices;
  }

  Future<RecipeIndex?> saveRecipeIndex(RecipeIndex index) async {
    RecipeIndex? retrievedRecipeIndex;
    try {
      Response response = await _dio.post(
          '${Endpoints.baseUrl}/recipeIndices', data: index.toJson());
      print('RecipeIndex created: ${response.data.toString()}');
      retrievedRecipeIndex = RecipeIndex.fromJson(response.data);
    } catch (e) {
      print('Error creating RecipeIndex: $e');
    }
    await serviceLocator<RecipeIndexStore>().loadRecipeIndices(); // Update IndexStore
    return retrievedRecipeIndex;
  }
}
