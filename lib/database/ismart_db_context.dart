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

class IsMartDatabaseContext {
  DbSet<PreferenceEntity> preferences = PreferenceDbSet();
  DbSet<ProductEntity> product = ProductDbSet();
  DbSet<ProductBarcodeEntity> productBarcode = ProductBarcodeDbSet();
  DbSet<ProductCategoryEntity> productCategory = ProductCategoryDbSet();
  DbSet<ProductGroupEntity> productGroup = ProductGroupDbSet();
  DbSet<ProductImageEntity> productImage = ProductImageDbSet();

  Future<void> createDatabase() async {}
}
