import 'package:mobx/mobx.dart';
import 'package:recipe_manager/data/network/dio_client.dart';
import 'package:recipe_manager/di/service_locator.dart';
import 'package:recipe_manager/models/index.dart';

part 'index_store.g.dart';

class IndexStore = _IndexStore with _$IndexStore;

abstract class _IndexStore with Store {
  @observable
  List<Index> _indices = ObservableList<Index>();

  List<Index> get indices => _indices;

  @action
  Future<void> loadIndices() async {
    List<Index> response = await serviceLocator<DioClient>().getIndices();
    _indices = ObservableList.of(response);
  }
}
