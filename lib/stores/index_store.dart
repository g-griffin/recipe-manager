import 'package:mobx/mobx.dart';
import 'package:recipe_manager/data/network/dio_client.dart';
import 'package:recipe_manager/di/service_locator.dart';
import 'package:recipe_manager/models/index.dart';

part 'index_store.g.dart';

class IndexStore = _IndexStore with _$IndexStore;

abstract class _IndexStore with Store {
  @observable
  List<Index> indices = ObservableList<Index>();

  @action
  Future<void> loadIndices() async {
    List<Index> response = await serviceLocator<DioClient>().getIndices();
    indices = ObservableList.of(response);
  }
}
