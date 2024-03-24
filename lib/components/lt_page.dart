import 'package:flutter/material.dart';
import 'package:ismart/components/lt_bottom_sheet_header.dart';

class LtPage extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? action;

  const LtPage({
    required this.title,
    required this.child,
    super.key,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Container(
        //
        // Container Background
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colorScheme.onPrimary,
              colorScheme.background,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //
              // Page title
              LtBottomSheetHeader(
                title: title,
                action: action,
              ),

              Expanded(
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
