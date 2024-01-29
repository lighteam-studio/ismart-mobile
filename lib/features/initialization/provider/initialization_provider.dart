import 'package:flutter/material.dart';
import 'package:ismart/core/enums/preferences.dart';
import 'package:ismart/repository/abstractions/i_preferences_repository.dart';
import 'package:ismart/router/app_router.dart';

class InitializationProvider extends ChangeNotifier {
  final IPreferencesRepository _repository = IPreferencesRepository.getInstance();

  void initialize(BuildContext context) async {
    var onboardingFinished = await _repository.getPreference(Preference.onboardingFinished);
    if (onboardingFinished.isEmpty) {
      Navigator.of(context).pushReplacementNamed(AppRouter.onboardingFeature);
    }
  }
}
