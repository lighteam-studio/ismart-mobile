import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ismart/components/lt_icon_button.dart';
import 'package:ismart/resources/app_icons.dart';
import 'package:ismart/resources/app_images.dart';
import 'package:ismart/resources/app_sizes.dart';
import 'package:transparent_image/transparent_image.dart';

class LtFilePicker extends StatelessWidget {
  final void Function(List<String> pictures) onChange;
  final void Function(int index) onRemovePicture;
  final List<String> pictures;

  const LtFilePicker({
    required this.onChange,
    required this.pictures,
    required this.onRemovePicture,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    var textTheme = Theme.of(context).textTheme;

    void pickFiles() async {
      var picker = ImagePicker();
      var files = await picker.pickMultiImage();

      if (files.isNotEmpty) {
        var filteredFiles = files.where((element) => !pictures.contains(element.path));
        onChange(filteredFiles.map((file) => file.path).toList());
      }
    }

    void takePicture() async {
      var picker = ImagePicker();
      var file = await picker.pickImage(source: ImageSource.camera);
      if (file is XFile) {
        onChange([file.path]);
      }
    }

    void openPickFileOptions() async {
      var response = await showModalBottomSheet(
        context: context,
        backgroundColor: colorScheme.background,
        builder: (context) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.s02),
                height: AppSizes.s16,
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: colorScheme.surface)),
                ),
                child: Stack(
                  children: [
                    // Back button
                    Align(
                      alignment: Alignment.centerLeft,
                      child: LtIconButton(
                        icon: AppIcons.chevronDown,
                        iconSize: AppSizes.s06,
                        color: colorScheme.onSurface,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),

                    // Title
                    Center(
                      child: Text(
                        "Pick an image",
                        style: textTheme.displaySmall,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: AppSizes.s14,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(1),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSizes.s04),
                      child: Row(
                        children: [
                          Image.asset(AppIcons.camera, width: AppSizes.s06),
                          const SizedBox(width: AppSizes.s02),
                          const Expanded(
                            child: Text("Take a picture"),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(height: 1),
              SizedBox(
                height: AppSizes.s14,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(2),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSizes.s04),
                      child: Row(
                        children: [
                          Image.asset(AppIcons.gallery, width: AppSizes.s06),
                          const SizedBox(width: AppSizes.s02),
                          const Expanded(
                            child: Text("Pick from gallery"),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );

      if (response is! int) return;

      if (response == 1) {
        takePicture();
        return;
      }

      if (response == 2) {
        pickFiles();
        return;
      }
    }

    Widget renderSelectImageButton() {
      return Material(
        color: colorScheme.surface,
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(AppSizes.s03),
        child: InkWell(
          onTap: openPickFileOptions,
          child: DottedBorder(
            dashPattern: const [8, 4],
            borderType: BorderType.RRect,
            radius: const Radius.circular(AppSizes.s03),
            borderPadding: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            color: Colors.grey.shade400,
            strokeWidth: 3,
            child: SizedBox(
              height: AppSizes.s32,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImages.camera,
                    width: AppSizes.s14,
                    color: colorScheme.onBackground,
                  ),
                  Text(
                    "Select images",
                    style: TextStyle(color: Colors.grey.shade700),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget renderImagePreview(String picture, int index) {
      return Padding(
        padding: const EdgeInsets.only(right: AppSizes.s02),
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            width: AppSizes.s32,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(AppSizes.s03),
              border: Border.all(color: colorScheme.onBackground),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.s03),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: FadeInImage(
                      fadeInDuration: const Duration(milliseconds: 150),
                      image: FileImage(File(picture)),
                      placeholder: MemoryImage(kTransparentImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(AppSizes.s01),
                      child: LtIconButton(
                        icon: AppIcons.trash,
                        iconSize: AppSizes.s06,
                        size: AppSizes.s08,
                        onPressed: () => onRemovePicture(index),
                        color: colorScheme.error,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }

    if (pictures.isEmpty) {
      return renderSelectImageButton();
    }

    return SizedBox(
      height: AppSizes.s32,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ...pictures.mapIndexed((index, picture) {
            return renderImagePreview(picture, index);
          }),
          AspectRatio(
            aspectRatio: 1,
            child: renderSelectImageButton(),
          )
        ],
      ),
    );
  }
}
