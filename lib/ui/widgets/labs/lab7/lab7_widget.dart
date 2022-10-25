import 'package:flutter/material.dart';
import 'package:numerical_methods/Library/Widgets/Inherited/provider.dart';
import 'package:numerical_methods/ui/widgets/labs/lab7/lab7_model.dart';

class Lab7Widget extends StatelessWidget {
  const Lab7Widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lab work №7',
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _FormulaWidget(),
          Divider(
            thickness: 2,
          ),
          _ButtonWidget(),
          SizedBox(height: 10),
          _ResultWidget(),
        ],
      ),
    );
  }
}

class _FormulaWidget extends StatelessWidget {
  const _FormulaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'f(x) = ln(x+1)',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'a = 0, b = 10;  n = 5;  h = 0.5',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

class _ButtonWidget extends StatelessWidget {
  const _ButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<Lab7Model>(context);
    if (model == null) return const SizedBox.shrink();

    return ElevatedButton(
      onPressed: () => model.interpolation(),
      child: const Text('Interpolation'),
    );
  }
}

class _ResultWidget extends StatelessWidget {
  const _ResultWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<Lab7Model>(context);
    if (model == null) return const SizedBox.shrink();
    const divider = SizedBox(
      height: 430,
      width: 1,
      child: ColoredBox(
        color: Colors.black,
      ),
    );

    final result = model.isShow
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _ColumnWithResultWidget(
                  title: 'x', content: model.getX(), count: 4),
              divider,
              _ColumnWithResultWidget(
                  title: 'yIter', content: model.getYIteration(), count: 4),
              divider,
              _ColumnWithResultWidget(
                  title: 'yReal', content: model.getYReal(), count: 4),
              divider,
              _ColumnWithResultWidget(
                  title: '∆', content: model.getDelta(), count: 4),
            ],
          )
        : const SizedBox.shrink();

    return result;
  }
}

class _ColumnWithResultWidget extends StatelessWidget {
  final String title;
  final String content;
  final int count;

  const _ColumnWithResultWidget({
    Key? key,
    required this.title,
    required this.content,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: SizedBox(
            height: 1,
            width: (MediaQuery.of(context).size.width - 36) / count,
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
