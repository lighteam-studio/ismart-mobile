import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Validators {
  BuildContext context;
  Validators._(this.context);

  factory Validators.of(BuildContext context) {
    return Validators._(context);
  }

  String? required(Object? value) {
    var message = S.of(context).requiredValidation;
    if (value == null) return message;
    if (value is String && value.isEmpty) return message;

    return null;
  }
}
