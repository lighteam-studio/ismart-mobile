import 'package:flutter/material.dart';
import 'package:ismart/components/lt_surface.dart';

class SocialMediaListTile extends StatelessWidget {
  const SocialMediaListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return const AspectRatio(
      aspectRatio: .8,
      child: LtSurface(),
    );
  }
}
