import 'package:flutter/material.dart';

import 'package:ismart/components/lt_surface_button.dart';
import 'package:ismart/components/lt_surface_input.dart';
import 'package:ismart/resources/app_icons.dart';
import 'package:ismart/resources/app_sizes.dart';

class AddGroupInput extends StatelessWidget {
  final TextEditingController controller;
  final void Function() onSubmit;
  const AddGroupInput({required this.controller, required this.onSubmit, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: LtSurfaceInput(
            controller: controller,
            hintText: "Novo grupo",
          ),
        ),
        const SizedBox(width: AppSizes.s02),
        LtSurfaceButton(icon: AppIcons.circleCheck, onTap: onSubmit),
        const SizedBox(width: AppSizes.s02)
      ],
    );
  }
}
