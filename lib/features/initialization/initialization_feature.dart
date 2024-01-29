import 'package:flutter/material.dart';
import 'package:ismart/components/lt_pulse_animation.dart';
import 'package:ismart/features/initialization/provider/initialization_provider.dart';
import 'package:ismart/resources/app_images.dart';
import 'package:provider/provider.dart';

class InitializationFeature extends StatefulWidget {
  const InitializationFeature({super.key});

  @override
  State<InitializationFeature> createState() => _InitializationFeatureState();
}

class _InitializationFeatureState extends State<InitializationFeature> {
  void initialize() async {
    await Future.microtask(() => context.read<InitializationProvider>().initialize(context));
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colorScheme.background,
              colorScheme.surface,
            ],
          ),
        ),
        child: LtPulseAnimation(
          child: Image.asset(
            AppImages.logo,
            color: colorScheme.onSurface,
            width: 180,
          ),
        ),
      ),
    );
  }
}
