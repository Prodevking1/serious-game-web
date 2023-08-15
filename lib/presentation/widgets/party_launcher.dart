import 'package:flutter/material.dart';

class PartyLauncher extends StatelessWidget {
  final Widget game;
  const PartyLauncher({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(),
      ),
    );
  }
}
