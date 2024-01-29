import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart' show rootBundle;

class IsMartDatabaseContext {
  static const String dbName = 'ismart_db.db';
  static const int dbVersion = 1;

  String get preferences => 'preferences';
  String get product => 'product';
  String get productBarcode => 'product_barcode';
  String get productCategory => 'product_category';
  String get productGroup => 'product_group';
  String get productImage => 'product_image';

  Future<String> _getDatabasePath() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);
    return path;
  }

  Future<bool> hasDatabase() async {
    var path = await _getDatabasePath();
    return await File(path).exists();
  }

  Future<Database> getDatabase() async {
    var path = await _getDatabasePath();

    // open the database
    Database database = await openDatabase(
      path,
      version: dbVersion,
      onCreate: (
        Database db,
        int version,
      ) async {
        String databaseScript = await rootBundle.loadString(
          'lib/assets/sql_scripts/v$version/builder.sql',
        );
        List<String> scripts = databaseScript
            .split('\n\n')
            .map((e) => e.trim())
            .where((element) => element.isNotEmpty) //
            .toList();

        for (var script in scripts) {
          await db.execute(script);
        }
      },
    );

    return database;
  }
}
