import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LtFutureDialog extends StatefulWidget {
  final Future Function() callback;
  const LtFutureDialog({required this.callback, super.key});

  @override
  State<LtFutureDialog> createState() => _LtFutureDialogState();
}

class _LtFutureDialogState extends State<LtFutureDialog> {
  late Future _loadingRequest;

  Future makeRequest() async {
    try {
      var response = await widget.callback();
      Navigator.of(context).pop(response);
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  void initState() {
    _loadingRequest = makeRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        //
        // Future builder
        child: FutureBuilder(
          future: _loadingRequest,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("ERROR"),
              );
            }
            // Content
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: Lottie.asset('lib/assets/lottie/loading.json', height: 200)),
                const Text(
                  "Finalizando alguns ajustes...",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
