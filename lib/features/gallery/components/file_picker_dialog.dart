import 'package:flutter/material.dart';
import 'package:ismart/components/lt_bottom_sheet_action.dart';
import 'package:ismart/components/lt_bottom_sheet_header.dart';
import 'package:ismart/resources/app_icons.dart';
import 'package:ismart/resources/app_sizes.dart';

enum FilePickerDialogResult {
  gallery,
  camera,
  device,
}

class FilePickerDialog extends StatelessWidget {
  const FilePickerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(AppSizes.s10)),
        color: colorScheme.surface,
      ),
      child: const Column(
        children: [
          LtBottomSheetHeader(title: "Pick an image"),
          LtBottomSheetAction(
            icon: AppIcons.gallery,
            label: "Store gallery",
            value: FilePickerDialogResult.gallery,
          ),
          Divider(height: 1),
          LtBottomSheetAction(
            icon: AppIcons.camera,
            label: "Take a picture",
            value: FilePickerDialogResult.camera,
          ),
          Divider(height: 1),
          LtBottomSheetAction(
            icon: AppIcons.phone,
            label: "Device gallery",
            value: FilePickerDialogResult.device,
          ),
        ],
      ),
    );
  }
}
