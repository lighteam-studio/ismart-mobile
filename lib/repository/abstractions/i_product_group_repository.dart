import 'package:get_it/get_it.dart';
import 'package:ismart/core/entities/product_group_entity.dart';

abstract class IProductGroupRepository {
  Future<void> batchInsert(List<ProductGroupEntity> groups);
  Future<List<ProductGroupEntity>> select();

  static IProductGroupRepository getInstance() {
    return GetIt.instance.get<IProductGroupRepository>();
  }
}
