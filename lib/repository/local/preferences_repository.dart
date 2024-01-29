import 'package:ismart/core/enums/preferences.dart';
import 'package:ismart/repository/abstractions/i_preferences_repository.dart';
import 'package:ismart/repository/is_mart_db_context.dart';
import 'package:sqflite/sqflite.dart';

class PreferencesRepository implements IPreferencesRepository {
  final IsMartDatabaseContext _context = IsMartDatabaseContext();

  @override
  Future<void> upsertPreference({required Preference preference, required String value}) async {
    var database = await _context.getDatabase();

    // Set preferences
    await database.insert(
      _context.preferences,
      {
        "key": Preference.shopName.name,
        "value": value,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    await database.close();
  }

  @override
  Future<String> getPreference(Preference preference) async {
    var database = await _context.getDatabase();

    var value = await database.query(
      _context.preferences,
      where: "key = ?",
      whereArgs: [preference.name],
    );

    if (value.isEmpty) {
      return "";
    }
    return value.first['value'] as String;
  }
}
