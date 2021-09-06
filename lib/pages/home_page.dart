import 'package:app_perro_animated/widgets/radial_progress.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.red,
            child: Center(
              child: RadialProgress(),
            ),
          ),
          Positioned(
            bottom: 90,
            left: 35,
            child: Text('WALK THE DOG', style: TextStyle(fontSize: 50, color: Colors.white, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}
