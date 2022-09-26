import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:numerical_methods/Library/Widgets/Inherited/provider.dart';
import 'package:numerical_methods/ui/widgets/labs/lab2/graph_widget.dart';
import 'package:numerical_methods/ui/widgets/labs/lab2/lab2_model.dart';

class Lab2Widget extends StatelessWidget {
  const Lab2Widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lab work №2',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: const [
            _GraphWidget(),
            SizedBox(height: 20),
            _EnterRangeWidget(),
            _SelectMethodWidget(),
            _ShowCurrentMethodWidget(),
            _ShowStepsWidget(),
          ],
        ),
      ),
    );
  }
}

class _GraphWidget extends StatelessWidget {
  const _GraphWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<Lab2Model>(context);
    if (model == null) return const SizedBox.shrink();

    return Center(
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.red,
            width: 2,
          ),
        ),
        child: CustomPainterWidget(
          start: model.start,
          end: model.end,
          formula: model.formula,
          functionLimit: model.functionLimit,
        ),
      ),
    );
  }
}

class _EnterRangeWidget extends StatelessWidget {
  const _EnterRangeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<Lab2Model>(context);
    if (model == null) return const SizedBox.shrink();

    return Row(
      children: [
        const Text(
          'a =  ',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        SizedBox(
          width: 70,
          height: 30,
          child: TextField(
            controller: TextEditingController(text: '${model.a}'),
            onSubmitted: (value) => {
              value.isEmpty || value == '-'
                  ? model.setA(0.1)
                  : model.setA(double.parse(value))
            },
            keyboardType: const TextInputType.numberWithOptions(
              signed: true,
              decimal: true,
            ),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'^[-]?\d*\.?\d*')),
            ],
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.end,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 6),
              hintText: '0',
            ),
          ),
        ),
        const SizedBox(width: 30),
        const Text(
          'b =  ',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        SizedBox(
          width: 70,
          height: 30,
          child: TextField(
            controller: TextEditingController(text: '${model.b}'),
            onSubmitted: (value) => {
              value.isEmpty || value == '-'
                  ? model.setB(0.1)
                  : model.setB(double.parse(value))
            },
            keyboardType: const TextInputType.numberWithOptions(
              signed: true,
              decimal: true,
            ),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'^[-]?\d*\.?\d*')),
            ],
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.end,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 6),
              hintText: '0',
            ),
          ),
        )
      ],
    );
  }
}

class _MethodHalfDivide extends StatelessWidget {
  const _MethodHalfDivide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<Lab2Model>(context);
    if (model == null) return const SizedBox.shrink();

    return ElevatedButton(
      onPressed: () => model.calculateByHalfDivide(),
      child: const Text(
        'Calculate by method Half Divider',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _MethodIteration extends StatelessWidget {
  const _MethodIteration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<Lab2Model>(context);
    if (model == null) return const SizedBox.shrink();

    return ElevatedButton(
      onPressed: () => model.calculateByIteration(),
      child: const Text(
        'Calculate by method Iteration',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _MethodChords extends StatelessWidget {
  const _MethodChords({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<Lab2Model>(context);
    if (model == null) return const SizedBox.shrink();

    return ElevatedButton(
      onPressed: () => model.calculateByChords(),
      child: const Text(
        'Calculate by method Chords',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _MethodNewton extends StatelessWidget {
  const _MethodNewton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<Lab2Model>(context);
    if (model == null) return const SizedBox.shrink();

    return SizedBox(
      child: ElevatedButton(
        onPressed: () => model.calculateByNewton(),
        child: const Text(
          'Calculate by method Newton',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _SelectMethodWidget extends StatelessWidget {
  const _SelectMethodWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<Lab2Model>(context);
    if (model == null) return const SizedBox.shrink();
    final items = model.methods;
    String? currentValue = model.currentMethod;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Method:   ',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        DropdownButton<String>(
          value: currentValue,
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            model.changeMethod(value);
          },
        ),
      ],
    );
  }
}

class _ShowCurrentMethodWidget extends StatelessWidget {
  const _ShowCurrentMethodWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<Lab2Model>(context);
    if (model == null) return const SizedBox.shrink();
    const methodWidgets = [
      _MethodHalfDivide(),
      _MethodIteration(),
      _MethodChords(),
      _MethodNewton()
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: methodWidgets[model.currentMethodNumber()],
        ),
        const SizedBox(height: 10),
        Text(
          'Result: \n${model.result}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const Divider(
          thickness: 2,
        ),
        const SizedBox(
          width: double.infinity,
          child: Text(
            'Performance',
            style: TextStyle(
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Text(
          'Count iterations: ${model.countIterations}',
        ),
        Text('Duration proses (in microseconds): ${model.duration}'),
        const Divider(
          thickness: 2,
        )
      ],
    );
  }
}

class _ShowStepsWidget extends StatelessWidget {
  const _ShowStepsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<Lab2Model>(context);
    if (model == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          width: double.infinity,
          child: Text(
            'Steps',
            style: TextStyle(
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                model.resultBySteps ?? '',
              ),
            ),
            Expanded(
              child: Text(
                model.resultFunctionBySteps ?? '',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
