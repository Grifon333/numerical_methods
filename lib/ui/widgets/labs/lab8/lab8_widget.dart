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
          const _FormulaWidget(),
          const _ButtonWidget(),
          model.isShow
              ? Column(
                  children: const [
                    SizedBox(height: 20),
                    _GraphWidget(),
                    SizedBox(height: 20),
                    _ResultFormulaWidget(),
                  ],
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

class _FormulaWidget extends StatelessWidget {
  const _FormulaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(fontSize: 20);
    const styleIndex = TextStyle(fontSize: 10);

    return Row(
      children: [
        const Text('y = ', style: style),
        Column(
          children: [
            const Text('1', style: style),
            const SizedBox(
              height: 1.2,
              width: 70,
              child: ColoredBox(color: Colors.black),
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
        end: 15,
        points: model.points,
        formula: model.formula,
      ),
    );
  }
}

class _ResultFormulaWidget extends StatelessWidget {
  const _ResultFormulaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(fontSize: 18);
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
              child: ColoredBox(color: Colors.black),
            ),
            Text(
              '${model.getA1()}${model.getA2()}x',
              style: style,
            ),
          ],
        ),
      ],
    );
  }
}
