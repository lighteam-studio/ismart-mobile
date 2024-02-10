import 'dart:io';

import 'package:ismart/core/entities/preference_entity.dart';
import 'package:ismart/core/entities/product_barcode_entity.dart';
import 'package:ismart/core/entities/product_category_entity.dart';
import 'package:ismart/core/entities/product_entity.dart';
import 'package:ismart/core/entities/product_group_entity.dart';
import 'package:ismart/core/entities/product_image_entity.dart';
import 'package:ismart/core/interfaces/dbset.dart';
import 'package:ismart/database/dbsets/preference_dbset.dart';
import 'package:ismart/database/dbsets/product_barcode_dbset.dart';
import 'package:ismart/database/dbsets/product_category_dbset.dart';
import 'package:ismart/database/dbsets/product_dbset.dart';
import 'package:ismart/database/dbsets/product_group_dbset.dart';
import 'package:ismart/database/dbsets/product_image_dbset.dart';
import 'package:ismart/database/ismart_db_utils.dart';

class IsMartDatabaseContext {
  DbSet<PreferenceEntity> preferences = PreferenceDbSet();
  DbSet<ProductEntity> product = ProductDbSet();
  DbSet<ProductBarcodeEntity> productBarcode = ProductBarcodeDbSet();
  DbSet<ProductCategoryEntity> productCategory = ProductCategoryDbSet();
  DbSet<ProductGroupEntity> productGroup = ProductGroupDbSet();
  DbSet<ProductImageEntity> productImage = ProductImageDbSet();

  Future<void> createDatabase() async {
    var database = await IsMartDatabaseUtils.getDatabase();

    await database.transaction((txn) async {
      await txn.execute(preferences.createTable());
      await txn.execute(product.createTable());
      await txn.execute(productBarcode.createTable());
      await txn.execute(productCategory.createTable());
      await txn.execute(productGroup.createTable());
      await txn.execute(productImage.createTable());
    });
  }

  /// Check if database exists
  Future<bool> hasDatabase() async {
    var path = await IsMartDatabaseUtils.getDatabasePath();
    return await File(path).exists();
  }
}
