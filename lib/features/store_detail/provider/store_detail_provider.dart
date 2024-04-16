import 'package:flutter/material.dart';
import 'package:ismart/components/lt_alert_dialog.dart';
import 'package:ismart/core/enums/preferences.dart';
import 'package:ismart/database/ismart_db_context.dart';
import 'package:ismart/repository/abstractions/preferences_repository.dart';
import 'package:ismart/resources/app_images.dart';
import 'package:ismart/router/app_router.dart';
import 'package:ismart/utils/helper_functions.dart';

enum DeleteStoreAction {
  delete,
  back,
}

class StoreDetailProvider extends ChangeNotifier {
  final PreferencesRepository _preferencesRepository = PreferencesRepository.getInstance();

  final TextEditingController _storeNameController = TextEditingController();
  TextEditingController get storeNameController => _storeNameController;

  void _initialize() async {
    var storeName = await _preferencesRepository.getPreference(Preference.shopName);
    _storeNameController.text = storeName;
  }

  StoreDetailProvider() {
    _initialize();
  }

  void editStore(BuildContext context) async {
    await _preferencesRepository.updatePreference(
      preference: Preference.shopName,
      value: _storeNameController.text,
    );

    showAlertHelper(
      context,
      title: "Success",
      description: "Updated store informations",
      image: AppImages.success,
    );
  }

  void deleteStore(BuildContext context) async {
    var result = await showAlertHelper(
      context,
      title: "Warning!",
      description: "Are you sure that you want to delete your store, this action cannot be undone.",
      actions: [
        LtAlertDialogAction(text: "Go back", primary: true, value: DeleteStoreAction.back),
        LtAlertDialogAction(text: "Delete", primary: false, value: DeleteStoreAction.delete),
      ],
    );

    if (result != DeleteStoreAction.delete) return;

    var secondResult = await showAlertHelper(
      context,
      title: "Warning!",
      description: "You chose the deletion of your store, do you want to procced? This action cannot be undone",
      actions: [
        LtAlertDialogAction(
          text: "Go back",
          primary: true,
          value: DeleteStoreAction.back,
        ),
        LtAlertDialogAction(
          text: "Proceed with the deletion",
          primary: false,
          value: DeleteStoreAction.delete,
        ),
      ],
    );

    if (secondResult != DeleteStoreAction.delete) return;

    await IsMartDatabaseContext().deleteDatabase();

    Navigator.of(context).pushNamedAndRemoveUntil(AppRouter.initialization, (route) => false);
  }
}
