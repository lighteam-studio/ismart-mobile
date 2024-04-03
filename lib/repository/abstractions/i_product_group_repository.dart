import 'package:get_it/get_it.dart';
import 'package:ismart/core/entities/product_group_entity.dart';
import 'package:ismart/core/query/query.dart';

abstract class IProductGroupRepository {
  Future<ProductGroupEntity?> getGroup(String id);
  Future<void> createGroups(List<ProductGroupEntity> groups);
  Future<void> upsertGroup(ProductGroupEntity group);
  Future<List<ProductGroupEntity>> getGroups(Query query);

  static IProductGroupRepository getInstance() {
    return GetIt.instance.get<IProductGroupRepository>();
  }
}
