import 'dart:ui';

import 'package:flutter/material.dart';

class Graph extends StatelessWidget {
  final double start;
  final double end;
  final List<Offset> points;
  final List<double Function(double)> formula;

  const Graph({
    Key? key,
    required this.start,
    required this.end,
    required this.points,
    required this.formula,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double heightParent = 400;
    double widthParent = MediaQuery
        .of(context)
        .size
        .width - 32;

    final width = end - start;
    final height = heightParent * width / widthParent;
    final up = height / 2;
    final down = -up;

    return ClipRect(
      child: SizedBox(
        height: heightParent,
        width: widthParent,
        child: CustomPaint(
          painter: _MyPainter(
            sizeScreen: Size(widthParent, heightParent),
            start: start,
            end: end,
            up: up,
            down: down,
            points: points,
            formula: formula,
          ),
        ),
      ),
    );
  }
}

class _MyPainter extends CustomPainter {
  final Size sizeScreen;
  final double start;
  final double end;
  final double up;
  final double down;
  final List<Offset> points;
  final List<double Function(double)> formula;

  _MyPainter({
    required this.sizeScreen,
    required this.start,
    required this.end,
    required this.up,
    required this.down,
    required this.points,
    required this.formula,
  });

  @override
  void paint(Canvas canvas, Size size) {
    drawCoordinateX(size, canvas);
    drawCoordinateY(canvas, size);
    drawGrid(canvas);
    drawGraph(size, canvas);
  }

  void drawGraph(Size size, Canvas canvas) {
    final paintPoints = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.red
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;
    final paintGraph = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.black
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    final colorsList = [Colors.green, Colors.blue, Colors.purple];

    for (int i = 0; i < formula.length; i++) {
      paintGraph.color = colorsList[i];
      drawListLines(formula[i], canvas, paintGraph);
    }

    // points
    List<Offset> pointsList = [];
    for (int i = 0; i < points.length; i++) {
      final x = toScreenX(points[i].dx, start, end);
      final y = toScreenY(points[i].dy, down, up);
      pointsList.add(Offset(x, y));
    }
    canvas.drawPoints(PointMode.points, pointsList, paintPoints);
  }

  void drawListLines(double Function(double) formula, Canvas canvas,
      Paint paintGraph) {
    List<Offset> list = [];
    for (double i = 1; i <= 10; i += 0.01) {
      double x = i;
      double y;
      y = formula(x);
      final point = Offset(x, y);
      list.add(point);
    }

    for (int i = 0; i < list.length - 1; i++) {
      final xStart = toScreenX(list[i].dx, start, end);
      var yStart = toScreenY(list[i].dy, down, up);
      final xEnd = toScreenX(list[i + 1].dx, start, end);
      final yEnd = toScreenY(list[i + 1].dy, down, up);
      canvas.drawLine(Offset(xStart, yStart), Offset(xEnd, yEnd), paintGraph);
    }
  }

  void drawCoordinateX(Size size, Canvas canvas) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.black
      ..strokeWidth = 1;

    final xStart = toScreenX(start, start, end);
    final xEnd = toScreenX(end, start, end);
    final y = toScreenY(0, down, up);
    canvas.drawLine(
      Offset(xStart, y),
      Offset(xEnd, y),
      paint,
    );
  }

  void drawCoordinateY(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.black
      ..strokeWidth = 1;

    final yStart = toScreenY(up, down, up);
    final yEnd = toScreenY(down, down, up);
    final x = toScreenX(0, start, end);
    canvas.drawLine(
      Offset(x, yStart),
      Offset(x, yEnd),
      paint,
    );
  }

  void drawGrid(Canvas canvas) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.grey;
    final yStart = toScreenY(up, down, up);
    final yEnd = toScreenY(down, down, up);
    double x;
    for (int i = start.toInt(); i <= end; i++) {
      x = toScreenX(i.toDouble(), start, end);
      canvas.drawLine(
        Offset(x, yStart),
        Offset(x, yEnd),
        paint,
      );
    }
    final xStart = toScreenX(start, start, end);
    final xEnd = toScreenX(end, start, end);
    double y;
    for (int i = down.toInt(); i <= end; i++) {
      y = toScreenY(i.toDouble(), down, up);
      canvas.drawLine(
        Offset(xStart, y),
        Offset(xEnd, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  double toScreenX(double x,
      double xMin,
      double xMax, [
        double screenXMin = 0.0,
      ]) {
    return (x - xMin) * (sizeScreen.width - screenXMin) / (xMax - xMin) +
        screenXMin;
  }

  double toScreenY(double y,
      double yMin,
      double yMax, [
        double screenYMin = 0.0,
      ]) {
    return (sizeScreen.height -
        (y - yMin) * (sizeScreen.height - screenYMin) / (yMax - yMin));
  }
}
