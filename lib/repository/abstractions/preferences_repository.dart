import 'package:get_it/get_it.dart';
import 'package:ismart/core/enums/preferences.dart';

abstract class PreferencesRepository {
  Future<void> updatePreference({required Preference preference, required String value});

  Future<String> getPreference(Preference preference);

  static getInstance() {
    return GetIt.instance.get<PreferencesRepository>();
  }
}
