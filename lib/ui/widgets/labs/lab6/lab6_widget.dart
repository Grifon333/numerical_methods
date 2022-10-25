import 'package:flutter/material.dart';
import 'package:numerical_methods/Library/Widgets/Inherited/provider.dart';
import 'package:numerical_methods/ui/widgets/labs/lab6/graph_by_points_widget.dart';
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
    final model = NotifierProvider.watch<Lab6Model>(context);
    if (model == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          const _FormulaWidget(),
          const SizedBox(height: 10),
          const _SelectMethodWidget(),
          const SizedBox(height: 10),
          const _ResultsWidget(),
          const SizedBox(height: 10),
          model.isShow
              ? Center(
                child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.red,
                        width: 2,
                      ),
                    ),
                    child: GraphByPointsWidget(
                        start: -6, end: 11, points: model.points),
                  ),
              )
              : const SizedBox.shrink(),
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
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: () => model.calculateByEulerMethod(),
          child: const Text('Euler'),
        ),
        ElevatedButton(
          onPressed: () => model.calculateByRungeKuttaMethod(),
          child: const Text('Runge Kutta'),
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
    final matrix = model.transpMatrix;

    final result = model.isShow
        ? SizedBox(
            height: 30 + matrix[0].length * 19,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return _ColumnWithResultWidget(
                  content:
                      matrix[index].map((e) => e == 0 ? ' ' : e).join('\n'),
                  title: model.titles[index],
                  count: matrix.length,
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Padding(
                  padding: EdgeInsets.all(0),
                  child: SizedBox(
                    width: 1,
                    child: ColoredBox(color: Colors.black),
                  ),
                );
              },
              itemCount: matrix.length,
            ),
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
