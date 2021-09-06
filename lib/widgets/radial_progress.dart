import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RadialProgress extends StatefulWidget {
  //final porcentaje;
  final Color colorPrimario;
  final Color colorSecundario;
  final double grosorPrimario;
  final double grosorSecundario;

  const RadialProgress({
    //required this.porcentaje,
    this.colorPrimario = Colors.white,
    this.colorSecundario = Colors.black,
    this.grosorPrimario = 10.0,
    this.grosorSecundario = 4.0,
  });
  @override
  _RadialProgressState createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late double porcentajeAnterior;
  late IconData cambioIcono;
  late Color colorPrimario;
  late Color colorSecundario;

  @override
  void initState() {
    //porcentajeAnterior = widget.porcentaje;
    cambioIcono = FontAwesomeIcons.dog;
    colorPrimario = widget.colorSecundario;
    colorSecundario = widget.colorPrimario;
    controller = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );
    controller.forward();
    controller.addListener(() {
      if (controller.status == AnimationStatus.completed) {
        controller.forward(from: 0.0);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final diferenciaAnimar = widget.porcentaje - porcentajeAnterior;
    //porcentajeAnterior = widget.porcentaje;
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        final size = MediaQuery.of(context).size;
        print(size);
        return Stack(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  cambioIcono = FontAwesomeIcons.dog;
                  colorPrimario = colorPrimario;
                  colorSecundario = colorSecundario;
                  controller.forward(from: 0.0);
                });
              },
              child: Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                height: double.infinity,
                child: CustomPaint(
                  painter: _MiRadialProgress(
                    controller.value * 100,
                    colorPrimario,
                    colorSecundario,
                    widget.grosorPrimario,
                    widget.grosorSecundario,
                    controller.value,
                  ),
                ),
              ),
            ),
            Center(
              child: FaIcon(
                (controller.value < 0.9) ? cambioIcono : FontAwesomeIcons.check,
                size: 200,
                color: (controller.value < 0.9) ? colorPrimario : colorSecundario,
              ),
            )
          ],
        );
      },
    );
  }
}

class _MiRadialProgress extends CustomPainter {
  final double controller;
  final porcentaje;
  final Color colorPrimario;
  final Color colorSecundario;
  final double grosorPrimario;
  final double grosorSecundario;

  _MiRadialProgress(
    this.porcentaje,
    this.colorPrimario,
    this.colorSecundario,
    this.grosorPrimario,
    this.grosorSecundario,
    this.controller,
  );
  @override
  void paint(Canvas canvas, Size size) {
    // final Rect rect = new Rect.fromCircle(
    //   center: Offset(0, 0),
    //   radius: 180,
    // );
    // final Gradient gradient = new LinearGradient(
    //   colors: <Color>[
    //     Color(0xffC012FF),
    //     Color(0xff6D05E8),
    //     Colors.red,
    //   ],
    // );
    //Ciruclo Completado
    final paint = new Paint()
      ..strokeWidth = grosorSecundario
      ..color = (controller < 0.9) ? colorSecundario : colorPrimario
      ..style = PaintingStyle.fill;

    final center = new Offset(size.width * 0.5, size.height * 0.5);
    final radius = min(size.width * 0.5, size.height * 0.5);

    canvas.drawCircle(center, radius, paint);

    //Arco
    final paintArco = new Paint()
      ..strokeWidth = grosorPrimario
      ..color = (controller < 0.9) ? colorPrimario : colorSecundario
      // ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    //Parte que se debera ir llenando
    double arcAngule = 2 * pi * (porcentaje / 100);
    canvas.drawArc(
        Rect.fromCircle(
          center: center,
          radius: radius,
        ),
        -pi / 2,
        arcAngule,
        false,
        paintArco);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
