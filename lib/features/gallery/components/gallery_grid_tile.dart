import 'package:flutter/material.dart';
import 'package:ismart/core/entities/media_entity.dart';
import 'package:ismart/resources/app_icons.dart';
import 'package:ismart/resources/app_sizes.dart';
import 'package:transparent_image/transparent_image.dart';

class GalleryGridTile extends StatelessWidget {
  final MediaEntity media;
  final bool selected;
  final bool hasMediaSelected;
  final void Function() onClick;

  const GalleryGridTile({
    required this.media,
    required this.selected,
    required this.onClick,
    required this.hasMediaSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Material(
      borderRadius: BorderRadius.circular(AppSizes.s03),
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned.fill(
            child: AnimatedScale(
              duration: const Duration(milliseconds: 150),
              scale: hasMediaSelected && !selected ? .98 : 1,
              child: AnimatedOpacity(
                opacity: hasMediaSelected && !selected ? .3 : 1,
                duration: const Duration(milliseconds: 150),
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  foregroundDecoration: BoxDecoration(
                    border: Border.all(
                      color: colorScheme.surface,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(AppSizes.s03),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSizes.s03),
                    color: Colors.white,
                  ),
                  child: FadeInImage(
                    fadeInDuration: const Duration(milliseconds: 100),
                    fit: BoxFit.cover,
                    image: MemoryImage(media.data),
                    placeholder: MemoryImage(kTransparentImage),
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: InkWell(
              onTap: onClick,
            ),
          ),

          // Tick
          Align(
            alignment: Alignment.bottomRight,
            child: AnimatedSwitcher(
              switchOutCurve: Curves.ease,
              switchInCurve: Curves.ease,
              transitionBuilder: (child, animation) {
                return ScaleTransition(
                  scale: animation,
                  child: child,
                );
              },
              duration: const Duration(milliseconds: 100),
              child: selected
                  ? Container(
                      margin: const EdgeInsets.all(AppSizes.s01),
                      width: AppSizes.s06,
                      height: AppSizes.s06,
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: BorderRadius.circular(999),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            offset: Offset.zero,
                            color: colorScheme.onSurface.withOpacity(.3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Image.asset(
                          AppIcons.check,
                          color: Colors.white,
                          width: AppSizes.s04,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          )
        ],
      ),
    );
  }
}
