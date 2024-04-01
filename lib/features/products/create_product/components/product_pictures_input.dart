import 'package:collection/collection.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:ismart/components/lt_icon_button.dart';
import 'package:ismart/core/entities/media_entity.dart';
import 'package:ismart/resources/app_icons.dart';
import 'package:ismart/resources/app_images.dart';
import 'package:ismart/resources/app_sizes.dart';
import 'package:ismart/router/app_router.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductPicturesInput extends StatelessWidget {
  final List<MediaEntity> pictures;
  final void Function(List<MediaEntity> pictures) onChange;

  const ProductPicturesInput({
    required this.pictures,
    required this.onChange,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    void selectPicture() async {
      var images = await Navigator.of(context).pushNamed(AppRouter.gallery);
      if (images is List<MediaEntity>) {
        onChange([...pictures, ...images]);
      }
    }

    void onRemovePicture(int i) {
      onChange(pictures.whereIndexed((index, element) => index != i).toList());
    }

    Widget renderSelectImageButton() {
      return Material(
        color: colorScheme.surface,
        clipBehavior: Clip.hardEdge,
        borderRadius: BorderRadius.circular(AppSizes.s03),
        child: InkWell(
          onTap: selectPicture,
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
                    width: AppSizes.s12,
                    color: colorScheme.onBackground,
                  ),
                  Text(
                    "Select images",
                    style: TextStyle(color: Colors.grey.shade700, fontSize: AppSizes.s03),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget renderImagePreview(MediaEntity picture, int index) {
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
                      image: MemoryImage(picture.data),
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
