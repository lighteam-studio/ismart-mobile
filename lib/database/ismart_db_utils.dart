import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class IsMartDatabaseUtils {
  static const String dbName = 'ismart_db.db';

  static const int dbVersion = 1;

  /// Get database patch
  static Future<String> getDatabasePath() async {
    var databasesPath = await getApplicationDocumentsDirectory();
    String path = join(databasesPath.path, dbName);
    return path;
  }

  /// Get database
  static Future<Database> getDatabase() async {
    var path = await getDatabasePath();
    // ignore: avoid_print
    print(path);

    // open the database
    Database database = await databaseFactoryFfi.openDatabase(path);

    return database;
  }
}
