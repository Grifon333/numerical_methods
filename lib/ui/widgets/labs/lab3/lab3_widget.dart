import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numerical_methods/Library/Widgets/Inherited/provider.dart';
import 'package:numerical_methods/ui/widgets/labs/lab3/lab3_model.dart';

class Lab3Widget extends StatelessWidget {
  const Lab3Widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final model = NotifierProvider.watch<Lab3Model>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Solution SLAE',
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: const [
              _SystemOfEquationsWidget(),
              Divider(
                thickness: 2,
                height: 40,
              ),
              _CalculateByGaussWidget(),
              _ShowWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _SystemOfEquationsWidget extends StatelessWidget {
  const _SystemOfEquationsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _RowMatrixWidget(
          row: 0,
        ),
        SizedBox(height: 5),
        _RowMatrixWidget(
          row: 1,
        ),
        SizedBox(height: 5),
        _RowMatrixWidget(
          row: 2,
        ),
      ],
    );
  }
}

class _RowMatrixWidget extends StatelessWidget {
  final int row;

  const _RowMatrixWidget({
    Key? key,
    required this.row,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _TextFieldWidget(
          row: row,
          column: 0,
        ),
        const _VariableWithIndexWidget(
          variable: 'x',
          index: 1,
        ),
        const Text(
          ' + ',
          style: TextStyle(fontSize: 18),
        ),
        _TextFieldWidget(
          row: row,
          column: 1,
        ),
        const _VariableWithIndexWidget(
          variable: 'x',
          index: 2,
        ),
        const Text(
          ' + ',
          style: TextStyle(fontSize: 18),
        ),
        _TextFieldWidget(
          row: row,
          column: 2,
        ),
        const _VariableWithIndexWidget(
          variable: 'x',
          index: 3,
        ),
        const Text(
          ' = ',
          style: TextStyle(fontSize: 18),
        ),
        _TextFieldWidget(
          row: row,
          column: 3,
        ),
      ],
    );
  }
}

class _TextFieldWidget extends StatelessWidget {
  final int row;
  final int column;

  const _TextFieldWidget({
    Key? key,
    required this.row,
    required this.column,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<Lab3Model>(context);

    return SizedBox(
      width: 60,
      height: 30,
      child: TextField(
        onChanged: (value) => {
          value.isEmpty || value == '-'
              ? model?.writingValueToMatrix(
                  0,
                  row,
                  column,
                )
              : model?.writingValueToMatrix(
                  double.parse(value),
                  row,
                  column,
                ),
        },
        keyboardType: const TextInputType.numberWithOptions(signed: true),
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
    );
  }
}

class _VariableWithIndexWidget extends StatelessWidget {
  final String variable;
  final int index;

  const _VariableWithIndexWidget({
    Key? key,
    required this.variable,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          ' $variable',
          style: const TextStyle(
            fontSize: 26,
          ),
        ),
        Text(
          index.toString(),
          style: const TextStyle(
            fontSize: 10,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class _CalculateByGaussWidget extends StatelessWidget {
  const _CalculateByGaussWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<Lab3Model>(context);

    return ElevatedButton(
      onPressed: () => model?.calculateByGauss(),
      child: const Text('Calculate by Gauss'),
    );
  }
}

class _ShowWidget extends StatelessWidget {
  const _ShowWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<Lab3Model>(context);

    return ElevatedButton(
      onPressed: () => model?.show(),
      child: const Text('Show'),
    );
  }
}
