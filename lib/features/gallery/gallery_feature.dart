import 'package:flutter/material.dart';
import 'package:ismart/components/lt_icon_button.dart';
import 'package:ismart/components/lt_page.dart';
import 'package:ismart/components/lt_popup_action_button.dart';
import 'package:ismart/components/lt_search_sliver.dart';
import 'package:ismart/components/lt_surface_button.dart';
import 'package:ismart/core/interfaces/lt_popup_option.dart';
import 'package:ismart/features/gallery/components/gallery_grid_tile.dart';
import 'package:ismart/features/gallery/provider/gallery_provider.dart';
import 'package:ismart/resources/app_icons.dart';
import 'package:ismart/resources/app_sizes.dart';
import 'package:provider/provider.dart';

class GalleryFeature extends StatelessWidget {
  const GalleryFeature({super.key});

  @override
  Widget build(BuildContext context) {
    GalleryProvider provider = Provider.of(context);
    var colorScheme = Theme.of(context).colorScheme;

    return StreamBuilder(
      stream: provider.mediaStream,
      builder: (context, snapshot) {
        return LtPage(
          title: "Gallery",

          // Page actions
          actions: provider.selectedMedias.isNotEmpty
              ? [
                  LtPopupActionButton(
                    icon: AppIcons.circleEllipsis,
                    options: [
                      LtPopupOption(label: "Delete", onTap: () {}),
                    ],
                  ),
                  LtIconButton(
                    onPressed: () => provider.confirmSelection(context),
                    icon: AppIcons.check,
                  ),
                ]
              : [
                  LtPopupActionButton(
                    icon: AppIcons.import,
                    options: [
                      LtPopupOption(label: "From camera", onTap: () => provider.importFromCamera()),
                      LtPopupOption(label: "From gallery", onTap: () => provider.importFromGallery()),
                    ],
                  ),
                ],
          child: CustomScrollView(
            slivers: [
              //
              // Search sliver
              SliverPadding(
                padding: const EdgeInsets.only(top: AppSizes.s02),
                sliver: LtSearchSliver(
                  action: LtSurfaceButton(
                    icon: AppIcons.queue,
                    size: AppSizes.s12,
                    backgroundColor: colorScheme.onPrimary,
                    hasShadow: true,
                    onTap: () {},
                  ),
                ),
              ),

              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.s05),

                // Content
                sliver: SliverGrid.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    crossAxisSpacing: AppSizes.s01,
                    mainAxisSpacing: AppSizes.s01,
                  ),

                  // Grid tile item
                  itemBuilder: (context, index) {
                    var media = snapshot.data![index];
                    return GalleryGridTile(
                      media: media,
                      onClick: () => provider.toogleSelection(media.mediaId),
                      hasMediaSelected: provider.selectedMedias.isNotEmpty,
                      selected: provider.selectedMedias.contains(media.mediaId),
                    );
                  },
                  itemCount: snapshot.data?.length ?? 0,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
