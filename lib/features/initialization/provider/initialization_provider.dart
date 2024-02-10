import 'package:flutter/material.dart';
import 'package:ismart/core/enums/preferences.dart';
import 'package:ismart/database/ismart_db_context.dart';
import 'package:ismart/repository/abstractions/i_preferences_repository.dart';
import 'package:ismart/router/app_router.dart';

class InitializationProvider extends ChangeNotifier {
  final IsMartDatabaseContext _context = IsMartDatabaseContext();
  final IPreferencesRepository _repository = IPreferencesRepository.getInstance();

  void initialize(BuildContext context) async {
    var hasDatabase = await _context.hasDatabase();
    if (!hasDatabase) {
      await _context.createDatabase();
    }

    var onboardingFinishedPreference = await _repository.getPreference(Preference.onboardingFinished);
    var onboardingFinished = (bool.tryParse(onboardingFinishedPreference) ?? false);

    onboardingFinished
        ? Navigator.of(context).pushReplacementNamed(AppRouter.appShell)
        : Navigator.of(context).pushReplacementNamed(AppRouter.onboardingFeature);
  }
}
