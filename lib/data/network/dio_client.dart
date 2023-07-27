import 'package:dio/dio.dart';
import 'package:recipe_manager/constants/strings.dart';
import 'package:recipe_manager/data/network/constants/endpoints.dart';
import 'package:recipe_manager/di/service_locator.dart';
import 'package:recipe_manager/models/recipe_index.dart';
import 'package:recipe_manager/stores/recipe_index_store.dart';
import 'package:recipe_manager/utils/errors.dart';
import 'package:recipe_manager/utils/navigator_key.dart';

class DioClient {
  final Dio _dio;

  final String _path = '${Endpoints.baseUrl}/recipeIndices';

  DioClient(this._dio);

  Future<List<RecipeIndex>> getRecipeIndices() async {
    List<RecipeIndex> recipeIndices = [];
    try {
      Response indexData = await _dio.get(_path);

      for (var index in indexData.data) {
        recipeIndices.add(RecipeIndex.fromJson(index));
      }
    } on DioError catch (e) {
      logError(e.response!.statusCode.toString(), Strings.getErrorLogMessage);
      showInSnackBar(navigatorKey.currentContext!, Strings.getErrorUserMessage);
    }

    return recipeIndices;
  }

  Future<RecipeIndex?> saveRecipeIndex(RecipeIndex index) async {
    RecipeIndex? retrievedRecipeIndex;
    try {
      Response response = await _dio.post(_path, data: index.toJson());
      print('RecipeIndex created: ${response.data.toString()}');
      retrievedRecipeIndex = RecipeIndex.fromJson(response.data);
    } on DioError catch (e) {
      logError(e.response!.statusCode.toString(),
          Strings.putErrorLogMessage + index.toString());
      showInSnackBar(navigatorKey.currentContext!, Strings.putErrorUserMessage);
    }
    await serviceLocator<RecipeIndexStore>().loadRecipeIndices(); // Update IndexStore
    return retrievedRecipeIndex;
  }
}
