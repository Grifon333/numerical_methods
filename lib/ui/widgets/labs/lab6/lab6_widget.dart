import 'package:flutter/material.dart';
import 'package:numerical_methods/Library/Widgets/Inherited/provider.dart';
import 'package:numerical_methods/ui/widgets/labs/lab6/lab6_model.dart';

class Lab6Widget extends StatelessWidget {
  const Lab6Widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lab work №6',
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
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: const [
          _FormulaWidget(),
          SizedBox(height: 10),
          _SelectMethodWidget(),
          SizedBox(height: 10),
          _ResultsWidget(),
        ],
      ),
    );
  }
}

class _SelectMethodWidget extends StatelessWidget {
  const _SelectMethodWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<Lab6Model>(context);
    if (model == null) return const SizedBox.shrink();

    return Row(
      children: [
        ElevatedButton(
          onPressed: () => model.calculateByEulerMethod(),
          child: const Text('Euler'),
        ),
      ],
    );
  }
}

class _FormulaWidget extends StatelessWidget {
  const _FormulaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontSize: 18,
    );
    return Row(
      children: [
        const Text('y\' = ', style: style),
        Column(
          children: const [
            Text('2xy', style: style),
            SizedBox(
              height: 1.2,
              width: 32,
              child: ColoredBox(color: Colors.black),
            ),
            Text('x+4', style: style),
          ],
        ),
        const Text(' - 0.4', style: style),
      ],
    );
  }
}

class _ResultsWidget extends StatelessWidget {
  const _ResultsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<Lab6Model>(context);
    if (model == null) return const SizedBox.shrink();
    final indexes = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10].join('\n');
    const divider = Padding(
      padding: EdgeInsets.all(0),
      child: SizedBox(
        height: 240,
        width: 1,
        child: ColoredBox(color: Colors.black),
      ),
    );

    final result = model.isShow
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _ColumnWithResultWidget(
                title: 'i',
                content: indexes,
              ),
              divider,
              _ColumnWithResultWidget(
                title: 'x',
                content: model.getX(),
              ),
              divider,
              _ColumnWithResultWidget(
                title: 'y',
                content: model.getY(),
              ),
              divider,
              _ColumnWithResultWidget(
                title: 'f',
                content: model.getF(),
              ),
              divider,
              _ColumnWithResultWidget(
                title: 'hf',
                content: model.getStep(),
              ),
            ],
          )
        : const SizedBox.shrink();
    return result;
  }
}

class _ColumnWithResultWidget extends StatelessWidget {
  final String content;
  final String title;

  const _ColumnWithResultWidget({
    Key? key,
    required this.content,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: SizedBox(
            height: 1,
            width: (MediaQuery.of(context).size.width - 36) / 5,
            child: const ColoredBox(color: Colors.black),
          ),
        ),
        Text(
          content,
          textAlign: TextAlign.start,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
