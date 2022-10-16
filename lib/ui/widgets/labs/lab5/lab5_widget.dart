import 'package:flutter/material.dart';
import 'package:numerical_methods/Library/Widgets/Inherited/provider.dart';
import 'package:numerical_methods/ui/widgets/labs/lab5/lab5_model.dart';

class Lab5Widget extends StatelessWidget {
  const Lab5Widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lab work №5',
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: _BodyWidget(),
      ),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<Lab5Model>(context);
    if (model == null) return const SizedBox.shrink();
    Widget result =
        model.isShow ? const _ResultWidget() : const SizedBox.shrink();

    return Column(
      children: [
        const _FormulaWidget(),
        const Divider(
          thickness: 2,
        ),
        const SizedBox(height: 10),
        const _SelectMethodWidget(),
        const SizedBox(height: 10),
        result,
        // _CalculateAreaWidget(),
      ],
    );
  }
}

class _FormulaWidget extends StatelessWidget {
  const _FormulaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'y = x',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '2',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              ' * lg(x)',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        const Text(
          'a = 1.4',
          style: TextStyle(fontSize: 18),
        ),
        const Text(
          'b = 3',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}

class _SelectMethodWidget extends StatelessWidget {
  const _SelectMethodWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<Lab5Model>(context);
    if (model == null) return const SizedBox.shrink();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(model.btn1),
              ),
              onPressed: () => model.leftRectanglesMethod(),
              child: const Text('Left rectangle'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(model.btn2),
              ),
              onPressed: () => model.rightRectanglesMethod(),
              child: const Text('Right rectangle'),
            ),
          ],
        ),
        Column(
          children: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(model.btn3),
              ),
              onPressed: () => model.trapezeMethod(),
              child: const Text('Trapeze'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(model.btn4),
              ),
              onPressed: () => model.simpsonsMethod(),
              child: const Text('Simpson`s'),
            ),
          ],
        ),
      ],
    );
  }
}

class _ResultWidget extends StatelessWidget {
  const _ResultWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<Lab5Model>(context);
    if (model == null) return const SizedBox.shrink();

    return SizedBox(
      width: double.infinity,
      child: Text(
        'Result: ${model.result}\nsteps: ${model.n}',
        textAlign: TextAlign.start,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}

// class _CalculateAreaWidget extends StatelessWidget {
//   const _CalculateAreaWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final model = NotifierProvider.watch<Lab5Model>(context);
//     if (model == null) return const SizedBox.shrink();
//     return ElevatedButton(
//       onPressed: () => model.selectionMethod(),
//       child: const Text('Calculate'),
//     );
//   }
// }
