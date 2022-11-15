import 'package:flutter/material.dart';
import 'package:numerical_methods/Library/Widgets/Inherited/provider.dart';
import 'package:numerical_methods/ui/widgets/labs/lab8/graph.dart';
import 'package:numerical_methods/ui/widgets/labs/lab8/lab8_model.dart';

class Lab8Widget extends StatelessWidget {
  const Lab8Widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lab work №8',
        ),
      ),
      body: const _BodyWidget(),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<Lab8Model>(context);
    if (model == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const _Formula1Widget(),
          const _Formula2Widget(),
          const _Formula3Widget(),
          const _ButtonWidget(),
          model.isShow
              ? Column(
                  children: const [
                    SizedBox(height: 20),
                    _GraphWidget(),
                    SizedBox(height: 20),
                    _ResultFormula1Widget(),
                    SizedBox(height: 6),
                    _ResultFormula2Widget(),
                    SizedBox(height: 6),
                    _ResultFormula3Widget(),
                  ],
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

class _Formula1Widget extends StatelessWidget {
  const _Formula1Widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const color = Colors.green;
    const style = TextStyle(fontSize: 20, color: color);
    const styleIndex = TextStyle(fontSize: 11, color: color);

    return Row(
      children: [
        const Text('y = ', style: style),
        Column(
          children: [
            const Text('1', style: style),
            const SizedBox(
              height: 1.2,
              width: 70,
              child: ColoredBox(color: color),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Text('a', style: style),
                Text('1', style: styleIndex),
                Text(' + a', style: style),
                Text('2', style: styleIndex),
                Text('x', style: style),
              ],
            )
          ],
        ),
      ],
    );
  }
}

class _Formula2Widget extends StatelessWidget {
  const _Formula2Widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const color = Colors.blue;
    const style = TextStyle(fontSize: 20, color: color);
    const styleIndex = TextStyle(fontSize: 11, color: color);
    const styleSmallIndex = TextStyle(fontSize: 7, color: color);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text('y = a', style: style),
        const Text('1', style: styleIndex),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('e', style: style),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Text('a', style: styleIndex),
                Text('2', style: styleSmallIndex),
                Text('x', style: styleIndex),
              ],
            )
          ],
        )
      ],
    );
  }
}

class _Formula3Widget extends StatelessWidget {
  const _Formula3Widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const color = Colors.purple;
    const style = TextStyle(fontSize: 20, color: color);
    const styleIndex = TextStyle(fontSize: 11, color: color);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: const [
        Text('y = a', style: style),
        Text('1', style: styleIndex),
        Text(' + a', style: style),
        Text('2', style: styleIndex),
        Text('x', style: style),
      ],
    );
  }
}

class _ButtonWidget extends StatelessWidget {
  const _ButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<Lab8Model>(context);
    if (model == null) return const SizedBox.shrink();

    return ElevatedButton(
      onPressed: () => model.methodSquareRoot(),
      child: const Text('Calculate'),
    );
  }
}

class _GraphWidget extends StatelessWidget {
  const _GraphWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<Lab8Model>(context);
    if (model == null) return const SizedBox.shrink();

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red, width: 2),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Graph(
        start: -2,
        end: 13,
        points: model.points,
        formula: [model.formula1, model.formula2, model.formula3],
      ),
    );
  }
}

class _ResultFormula1Widget extends StatelessWidget {
  const _ResultFormula1Widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const color = Colors.green;
    const style = TextStyle(fontSize: 18, color: color);
    final model = NotifierProvider.watch<Lab8Model>(context);
    if (model == null) return const SizedBox.shrink();

    return Row(
      children: [
        const Text('y = ', style: style),
        Column(
          children: [
            const Text('1', style: style),
            const SizedBox(
              height: 1.2,
              width: 110,
              child: ColoredBox(color: color),
            ),
            Text(
              '${model.getA1_1()}${model.getA2_1()}x',
              style: style,
            ),
          ],
        ),
        Text(';  ∆ = ${model.getUncertainty1()}', style: style),
      ],
    );
  }
}

class _ResultFormula2Widget extends StatelessWidget {
  const _ResultFormula2Widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const color = Colors.blue;
    const style = TextStyle(fontSize: 20, color: color);
    const styleIndex = TextStyle(fontSize: 11, color: color);
    final model = NotifierProvider.watch<Lab8Model>(context);
    if (model == null) return const SizedBox.shrink();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('y = ${model.getA1_2()}e', style: style),
        Text('${model.getA2_2()}x', style: styleIndex),
        Text(';  ∆ = ${model.getUncertainty2()}', style: style),
      ],
    );
  }
}

class _ResultFormula3Widget extends StatelessWidget {
  const _ResultFormula3Widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const color = Colors.purple;
    const style = TextStyle(fontSize: 20, color: color);
    final model = NotifierProvider.watch<Lab8Model>(context);
    if (model == null) return const SizedBox.shrink();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
            'y = ${model.getA1_3()} + ${model.getA2_3()}x;  ∆ = ${model.getUncertainty3()}',
            style: style),
      ],
    );
  }
}
