import 'package:flutter/material.dart';
import 'package:ismart/components/lt_page.dart';
import 'package:ismart/features/marketing/components/marketing_section.dart';
import 'package:ismart/features/marketing/components/social_media_list_tile.dart';
import 'package:ismart/resources/app_sizes.dart';

class MarketingFeature extends StatelessWidget {
  const MarketingFeature({super.key});

  @override
  Widget build(BuildContext context) {
    return LtPage(
      title: "Marketing and desgin",
      child: ListView(
        children: [
          const MarketingSection(label: "Social media post"),
          SizedBox(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.only(bottom: AppSizes.s03),
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.s05),
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                separatorBuilder: (context, index) => const SizedBox(width: AppSizes.s03),
                itemBuilder: (context, index) {
                  return const SocialMediaListTile();
                },
              ),
            ),
          ),
          const MarketingSection(label: "Flyers"),
          SizedBox(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.only(bottom: AppSizes.s03),
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.s05),
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                separatorBuilder: (context, index) => const SizedBox(width: AppSizes.s03),
                itemBuilder: (context, index) {
                  return const SocialMediaListTile();
                },
              ),
            ),
          ),
          const MarketingSection(label: "Short video"),
          SizedBox(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.only(bottom: AppSizes.s03),
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.s05),
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                separatorBuilder: (context, index) => const SizedBox(width: AppSizes.s03),
                itemBuilder: (context, index) {
                  return const SocialMediaListTile();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
