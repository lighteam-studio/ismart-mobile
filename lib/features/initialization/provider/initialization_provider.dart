import 'package:flutter/material.dart';
import 'package:ismart/core/enums/preferences.dart';
import 'package:ismart/repository/abstractions/i_preferences_repository.dart';
import 'package:ismart/router/app_router.dart';

class InitializationProvider extends ChangeNotifier {
  final IPreferencesRepository _repository = IPreferencesRepository.getInstance();

  void initialize(BuildContext context) async {
    var onboardingFinishedPreference = await _repository.getPreference(Preference.onboardingFinished);
    var onboardingFinished = (bool.tryParse(onboardingFinishedPreference) ?? false);

    onboardingFinished
        ? Navigator.of(context).pushReplacementNamed(AppRouter.appShell)
        : Navigator.of(context).pushReplacementNamed(AppRouter.onboardingFeature);
  }
}
