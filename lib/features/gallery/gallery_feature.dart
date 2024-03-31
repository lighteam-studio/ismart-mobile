import 'package:flutter/material.dart';
import 'package:ismart/components/lt_page.dart';
import 'package:ismart/components/lt_search_sliver.dart';
import 'package:ismart/features/gallery/components/gallery_grid_tile.dart';
import 'package:ismart/features/gallery/provider/gallery_list_provider.dart';
import 'package:ismart/resources/app_sizes.dart';
import 'package:provider/provider.dart';

class GalleryFeature extends StatelessWidget {
  const GalleryFeature({super.key});

  @override
  Widget build(BuildContext context) {
    GalleryListProvider provider = Provider.of(context);

    return LtPage(
      title: "Gallery",
      child: StreamBuilder(
        stream: provider.mediaStream,
        builder: (context, snapshot) {
          return CustomScrollView(
            slivers: [
              // Search sliver
              const SliverPadding(
                padding: EdgeInsets.only(top: AppSizes.s02),
                sliver: LtSearchSliver(),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.s05),
                sliver: SliverGrid.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    crossAxisSpacing: AppSizes.s01,
                    mainAxisSpacing: AppSizes.s01,
                  ),
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
          );
        },
      ),
    );
  }
}
