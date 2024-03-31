import 'package:ismart/core/entities/preference_entity.dart';
import 'package:ismart/core/enums/preferences.dart';
import 'package:ismart/repository/abstractions/i_preferences_repository.dart';
import 'package:ismart/database/ismart_db_context.dart';

class PreferencesRepository implements IPreferencesRepository {
  final IsMartDatabaseContext _context = IsMartDatabaseContext();

  @override
  Future<void> updatePreference({required Preference preference, required String value}) async {
    await _context.preferences.insert(
      PreferenceEntity(key: preference.name, value: value),
    );
  }

  @override
  Future<String> getPreference(Preference preference) async {
    var resp = await _context.preferences.find(preference.name);
    if (resp == null) return '';
    return resp.value;
  }
}
