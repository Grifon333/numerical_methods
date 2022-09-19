import 'package:flutter/material.dart';

class CustomPainterWidget extends StatelessWidget {
  final double start;
  final double end;
  final double Function(double) formula;
  final double functionLimit;

  const CustomPainterWidget({
    Key? key,
    required this.start,
    required this.end,
    required this.formula,
    required this.functionLimit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double heightParent = 300;
    double widthParent = MediaQuery.of(context).size.width - 32;

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
            formula: formula,
            functionLimit: functionLimit,
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
  final double Function(double x) formula;
  final double functionLimit;

  _MyPainter({
    required this.sizeScreen,
    required this.start,
    required this.end,
    required this.up,
    required this.down,
    required this.formula,
    required this.functionLimit,
  });

  @override
  void paint(Canvas canvas, Size size) {
    drawCoordinateX(size, canvas);
    drawCoordinateY(canvas, size);
    drawGrid(canvas);
    drawGraph(size, canvas);
  }

  void drawGraph(Size size, Canvas canvas) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.black
      ..strokeWidth = 1.8;

    List<Offset> list = [];
    double xMin = functionLimit;
    for (double i = start; i <= end; i += 0.01) {
      double x = i;
      double y;
      if (x <= xMin) {
        y = 0;
      } else {
        y = formula(x);
      }
      final point = Offset(x, y);
      list.add(point);
    }

    for (int i = 0; i < list.length - 1; i++) {
      final xStart = toScreenX(list[i].dx, start, end);
      var yStart = toScreenY(list[i].dy, down, up);
      final xEnd = toScreenX(list[i + 1].dx, start, end);
      final yEnd = toScreenY(list[i + 1].dy, down, up);
      if (list[i].dx <= xMin && list[i + 1].dx <= xMin) continue;
      if (list[i].dx <= xMin && list[i + 1].dx > xMin) {
        yStart = 1000;
      }
      canvas.drawLine(Offset(xStart, yStart), Offset(xEnd, yEnd), paint);
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

  double toScreenX(
    double x,
    double xMin,
    double xMax, [
    double screenXMin = 0.0,
  ]) {
    return (x - xMin) * (sizeScreen.width - screenXMin) / (xMax - xMin) +
        screenXMin;
  }

  double toScreenY(
    double y,
    double yMin,
    double yMax, [
    double screenYMin = 0.0,
  ]) {
    return (sizeScreen.height -
        (y - yMin) * (sizeScreen.height - screenYMin) / (yMax - yMin));
  }
}
