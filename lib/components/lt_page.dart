import 'package:flutter/material.dart';
import 'package:ismart/components/lt_bottom_sheet_header.dart';

class LtPage extends StatelessWidget {
  final String title;
  final Widget child;
  final List<Widget>? actions;

  const LtPage({
    required this.title,
    required this.child,
    super.key,
    this.actions,
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
                actions: actions,
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
