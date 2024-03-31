import 'dart:io';

import 'package:ismart/core/entities/preference_entity.dart';
import 'package:ismart/core/entities/product_barcode_entity.dart';
import 'package:ismart/core/entities/product_category_entity.dart';
import 'package:ismart/core/entities/product_entity.dart';
import 'package:ismart/core/entities/product_group_entity.dart';
import 'package:ismart/core/entities/media_entity.dart';
import 'package:ismart/core/entities/product_image_entity.dart';
import 'package:ismart/core/entities/product_property_entity.dart';
import 'package:ismart/core/entities/product_variation_entity.dart';
import 'package:ismart/core/entities/product_variation_property_value_entity.dart';
import 'package:ismart/core/interfaces/dbset.dart';
import 'package:ismart/core/query/query.dart';
import 'package:ismart/database/dbsets/media_dbset.dart';
import 'package:ismart/database/dbsets/preferences_dbset.dart';
import 'package:ismart/database/dbsets/product_barcode_dbset.dart';
import 'package:ismart/database/dbsets/product_category_dbset.dart';
import 'package:ismart/database/dbsets/product_dbset.dart';
import 'package:ismart/database/dbsets/product_group_dbset.dart';
import 'package:ismart/database/dbsets/product_image_dbset.dart';
import 'package:ismart/database/dbsets/product_property_dbset.dart';
import 'package:ismart/database/dbsets/product_variation_dbset.dart';
import 'package:ismart/database/dbsets/product_variation_property_value_dbset.dart';
import 'package:ismart/database/ismart_db_utils.dart';

class IsMartDatabaseContext {
  DbSet<MediaEntity, Query> image = MediaDbSet();
  DbSet<PreferenceEntity, Query> preferences = PreferenceDbSet();
  DbSet<ProductEntity, Query> product = ProductDbSet();
  DbSet<ProductBarcodeEntity, Query> productBarcode = ProductBarcodeDbSet();
  DbSet<ProductCategoryEntity, Query> productCategory = ProductCategoryDbSet();
  DbSet<ProductGroupEntity, Query> productGroup = ProductGroupDbSet();
  DbSet<ProductImageEntity, Query> productImage = ProductImageDbSet();
  DbSet<ProductPropertyEntity, Query> productProperty = ProductPropertyDbset();
  DbSet<ProductVariationEntity, Query> productVariation = ProductVariationDbSet();
  DbSet<ProductVariationPropertyValueEntity, Query> productVariationPropertyValue =
      ProductVariationPropertyValueDbSet();

  Future<void> createDatabase() async {
    var database = await IsMartDatabaseUtils.getDatabase();

    await database.transaction((txn) async {
      await txn.execute(image.createTable());
      await txn.execute(preferences.createTable());
      await txn.execute(product.createTable());
      await txn.execute(productBarcode.createTable());
      await txn.execute(productCategory.createTable());
      await txn.execute(productGroup.createTable());
      await txn.execute(productImage.createTable());
      await txn.execute(productProperty.createTable());
      await txn.execute(productVariation.createTable());
      await txn.execute(productVariationPropertyValue.createTable());
    });
  }

  /// Check if database exists
  Future<bool> hasDatabase() async {
    var path = await IsMartDatabaseUtils.getDatabasePath();
    return await File(path).exists();
  }

  Future<void> deleteDatabase() async {
    var path = await IsMartDatabaseUtils.getDatabasePath();
    var databaseFile = File(path);
    await databaseFile.delete();
  }
}
