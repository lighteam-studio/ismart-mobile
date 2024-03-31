import 'package:flutter/material.dart';
import 'package:ismart/core/entities/product_category_entity.dart';
import 'package:ismart/core/entities/product_group_entity.dart';
import 'package:ismart/core/interfaces/group.dart';
import 'package:ismart/core/query/query.dart';
import 'package:ismart/features/products/categories/components/category_detail_dialog.dart';
import 'package:ismart/features/products/categories/components/group_detail_dialog.dart';
import 'package:ismart/repository/abstractions/i_product_category_repository.dart';
import 'package:ismart/repository/abstractions/i_product_group_repository.dart';
import 'package:ismart/utils/helper_functions.dart';
import 'package:rxdart/rxdart.dart';

class CategoriesProvider extends ChangeNotifier {
  final IProductCategoryRepository _repository = IProductCategoryRepository.getInstance();
  final IProductGroupRepository _groupRepository = IProductGroupRepository.getInstance();

  /// Categories Stream
  late BehaviorSubject<List<Group<ProductCategoryEntity>>> _groupsController;
  Stream<List<Group<ProductCategoryEntity>>> get groupsStream => _groupsController.stream;

  String _search = "";
  String get search => _search;

  /// Load categories
  void _loadCategories() async {
    try {
      var groups = await _groupRepository.getGroups(Query(search: _search));

      var result = groups
          .map((e) => Group(
                id: e.productGroupId,
                title: e.title,
                items: e.categories!,
              ))
          .toList();

      _groupsController.sink.add(result);
    } catch (e) {
      _groupsController.sink.addError(e);
    }
  }

  CategoriesProvider() {
    _groupsController = BehaviorSubject(onListen: _loadCategories);
  }

  void searchContent(String value) {
    _search = value;
    _loadCategories();
  }

  /// Create new category
  void upsertCategory(BuildContext context, String groupId, {ProductCategoryEntity? category}) async {
    var newCategory = await showBottomSheetHelper(
      context,
      child: CategoryDetailDialog(
        groupId: groupId,
        category: category,
      ),
    );

    if (newCategory is ProductCategoryEntity) {
      await _repository.upsertCategory(newCategory);
      _loadCategories();
    }
  }

  /// Create new category
  void upsertGroup(BuildContext context, {String? groupId}) async {
    var group = groupId != null
        ? await _groupRepository.getGroup(groupId) //
        : null;

    var newGroup = await showBottomSheetHelper(
      context,
      child: GroupDetailDialog(
        group: group,
      ),
    );

    if (newGroup is ProductGroupEntity) {
      await _groupRepository.upsertGroup(newGroup);
      _loadCategories();
    }
  }

  @override
  void dispose() {
    _groupsController.close();
    super.dispose();
  }
}
