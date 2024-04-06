import 'package:flutter/material.dart';
import 'package:ismart/resources/app_sizes.dart';

class MarketingSection extends StatelessWidget {
  final String label;
  const MarketingSection({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.s05,
        vertical: AppSizes.s03,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const Text(
            "View all",
            style: TextStyle(
              fontSize: AppSizes.s03_5,
            ),
          )
        ],
      ),
    );
  }
}
