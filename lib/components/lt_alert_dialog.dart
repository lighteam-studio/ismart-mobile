import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ismart/resources/app_images.dart';
import 'package:ismart/resources/app_sizes.dart';

class LtAlertDialogAction<T> {
  final String text;
  final T? value;
  final bool primary;

  LtAlertDialogAction({required this.text, this.value, this.primary = false});
}

class LtAlertDialog extends StatelessWidget {
  final Animation<double> animation;
  final String? title;
  final String description;
  final String image;
  final List<LtAlertDialogAction>? actions;

  const LtAlertDialog({
    this.title,
    this.image = AppImages.alert,
    this.actions,
    required this.animation,
    required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Widget renderAction({required String text, required bool primary, required dynamic value}) {
      return Padding(
        padding: const EdgeInsets.only(bottom: AppSizes.s03),
        child: Material(
          borderRadius: BorderRadius.circular(AppSizes.s03),
          color: primary ? Colors.white.withOpacity(.2) : Colors.transparent,
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            onTap: () => Navigator.of(context).pop(value),
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.s03),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      );
    }

    List<Widget> actionButtons() {
      if (actions != null) {
        return actions!
            .map((action) => renderAction(text: action.text, primary: action.primary, value: action.value))
            .toList();
      }

      return [
        renderAction(text: "Ok", primary: true, value: null),
      ];
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Center(
          child: ScaleTransition(
            scale: Tween<double>(begin: .8, end: 1).animate(
              CurvedAnimation(parent: animation, curve: Curves.ease),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.s08),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(image, height: AppSizes.s30),

                  // Título
                  Text(
                    title ?? 'Opss...',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: AppSizes.s07,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSizes.s02),

                  // Subtitulo
                  Text(
                    description,
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSizes.s20),

                  // Content
                  ...actionButtons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
