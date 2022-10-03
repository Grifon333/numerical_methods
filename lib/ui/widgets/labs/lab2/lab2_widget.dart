import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:numerical_methods/Library/Widgets/Inherited/provider.dart';
import 'package:numerical_methods/elements/text_field_widget.dart';
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
    final focusNodeB = FocusNode();

    return Row(
      children: [
        const Text(
          'a =  ',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        TextFieldWidget(
          width: 70,
          autoFocus: true,
          controller: TextEditingController(text: '${model.a}'),
          onSubmited: (value) => {
            value.isEmpty || value == '-'
                ? model.setA(0.1)
                : model.setA(double.parse(value)),
            focusNodeB.requestFocus(),
          },
          hintText: '0',
        ),
        const SizedBox(width: 30),
        const Text(
          'b =  ',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        TextFieldWidget(
          width: 70,
          focusNode: focusNodeB,
          controller: TextEditingController(text: '${model.b}'),
          onSubmited: (value) => {
            value.isEmpty || value == '-'
                ? model.setB(0.9)
                : model.setB(double.parse(value))
          },
          hintText: '0',
        ),
      ],
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
    final listMethods = [
      model.calculateByHalfDivide,
      model.calculateByIteration,
      model.calculateByChords,
      model.calculateByNewton,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              try {
                model.check();
                listMethods[model.currentMethodNumber()].call();
              } on ExceptionRange catch (e) {
                String msg;
                switch (e.type) {
                  case ExceptionRangeType.pointIsNotInZone:
                    msg = 'f(a) * f(b) > 0 \n'
                        'The root isolation interval is set incorrectly';
                    break;
                  case ExceptionRangeType.exceedingTheBoundaries:
                    msg = 'x є (0, ∞)';
                    break;
                  case ExceptionRangeType.bLessA:
                    msg = 'b < a \n'
                        'Points of the root isolation interval are given in the wrong order';
                }
                showDialog(
                  context: context,
                  builder: (context) => _AlertDialogWidget(
                    textError: msg,
                  ),
                );
              }
            },
            child: Text(
              'Calculate by method ${model.methods[model.currentMethodNumber()]}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
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

class _AlertDialogWidget extends StatelessWidget {
  final String textError;

  const _AlertDialogWidget({
    Key? key,
    required this.textError,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Error'),
      content: Text(textError),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
