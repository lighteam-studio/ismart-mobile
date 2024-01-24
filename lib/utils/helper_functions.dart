import 'package:flutter/material.dart';
import 'package:ismart/components/lt_future_dialog.dart';

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
