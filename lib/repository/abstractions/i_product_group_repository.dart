import 'package:get_it/get_it.dart';
import 'package:ismart/core/entities/product_group_entity.dart';

abstract class IProductGroupRepository {
  Future<void> createGroups(List<ProductGroupEntity> groups);
  Future<List<ProductGroupEntity>> getGroups();

  static IProductGroupRepository getInstance() {
    return GetIt.instance.get<IProductGroupRepository>();
  }
}
