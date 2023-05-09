import 'package:dio/dio.dart';
import 'package:recipe_manager/data/network/constants/endpoints.dart';
import 'package:recipe_manager/di/service_locator.dart';
import 'package:recipe_manager/models/index.dart';
import 'package:recipe_manager/stores/index_store.dart';

class DioClient {
  final Dio _dio;

  DioClient(this._dio);

  Future<List<Index>> getIndices() async {
    List<Index> indices = [];
    try {
      Response indexData = await _dio.get('${Endpoints.baseUrl}/indices');

      for (var index in indexData.data) {
        indices.add(Index.fromJson(index));
      }
    } on DioError catch (e) {
      print(e);
    }

    return indices;
  }

  Future<Index?> saveIndex(Index index) async {
    Index? retrievedIndex;
    try {
      Response response = await _dio.post(
          '${Endpoints.baseUrl}/indices', data: index.toJson());
      print('Index created: ${response.data.toString()}');
      retrievedIndex = Index.fromJson(response.data);
    } catch (e) {
      print('Error creating index: $e');
    }
    await serviceLocator<IndexStore>().loadIndices(); // Update IndexStore
    return retrievedIndex;
  }
}
