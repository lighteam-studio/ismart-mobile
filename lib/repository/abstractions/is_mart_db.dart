import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart' show rootBundle;

class IsMartDatabase {
  static const String dbName = 'ismart_db.db';
  static const int dbVersion = 1;

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
        String databaseScript = await rootBundle.loadString('assets/sql_scripts/database_v${version}_builder.txt');

        // When creating the db, create the table
        await db.execute(databaseScript);
      },
    );

    return database;
  }
}
