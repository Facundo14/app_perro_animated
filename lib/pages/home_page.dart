import 'package:app_perro_animated/widgets/radial_progress.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red,
        child: Center(
          child: RadialProgress(),
        ),
      ),
    );
  }
}
