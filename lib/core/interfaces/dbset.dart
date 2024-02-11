import 'package:ismart/core/query/query.dart';

abstract class DbSet<T, Q extends Query> {
  String get tableName;

  String createTable();

  Future<void> insert(T entity);

  Future<T> find(String id);

  Future<void> batchInsert(List<T> values);

  Future<List<T>> search([Q? query]);
}
