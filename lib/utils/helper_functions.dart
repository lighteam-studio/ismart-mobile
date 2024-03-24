import 'package:flutter/material.dart';
import 'package:ismart/components/lt_alert_dialog.dart';
import 'package:ismart/components/lt_future_dialog.dart';
import 'package:ismart/resources/app_images.dart';

Future<T?> showLoadingDialog<T>(BuildContext context, Future<T> Function() callback) {
  return showGeneralDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(.4),
    pageBuilder: (context, animation, secondaryAnimation) {
      return LtFutureDialog(
        callback: callback,
      );
    },
  );
}

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

Future<T?> showBottomSheetHelper<T>(BuildContext context, {required Widget child}) async {
  return await showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    builder: (context) => child,
  );
}

List<List<String>> createCartesianMatrix<T>(List<List<String>> properties) {
  return properties.fold<List<List<String>>>([[]], (acc, curr) {
    final temp = <List<String>>[];

    for (var accItem in acc) {
      for (var currItem in curr) {
        temp.add([...accItem, currItem]);
      }
    }

    return temp;
  });
}

Future<T?> showAlertHelper<T>(
  BuildContext context, {
  String? title,
  String? image,
  required String description,
  List<LtAlertDialogAction<T>>? actions,
}) {
  return showGeneralDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(.8),
    pageBuilder: (context, animation, secondaryAnimation) {
      return LtAlertDialog(
        animation: animation,
        title: title,
        image: image ?? AppImages.alert,
        description: description,
        actions: actions,
      );
    },
  );
}
