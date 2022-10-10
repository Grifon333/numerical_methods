import 'package:flutter/material.dart';
import 'package:numerical_methods/Library/Widgets/Inherited/provider.dart';
import 'package:numerical_methods/elements/text_field_widget.dart';
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
              _CalculateByLUWidget(),
              _CalculateBySquareRootWidget(),
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
    return SizedBox(
      width: 400,
      height: 110,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Column(
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
          ),
        ],
      ),
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
        _FillWidget(
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
        _FillWidget(
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
        _FillWidget(
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
        _FillWidget(
          row: row,
          column: 3,
        ),
      ],
    );
  }
}

class _FillWidget extends StatelessWidget {
  final int row;
  final int column;

  const _FillWidget({
    Key? key,
    required this.row,
    required this.column,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<Lab3Model>(context);

    return TextFieldWidget(
      width: 60,
      onChanged: (value) => {
        model?.writingValueToMatrix(
          value.isEmpty || value == '-' ? 0 : double.parse(value),
          row,
          column,
        ),
      },
      hintText: '0',
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

class _CalculateByLUWidget extends StatelessWidget {
  const _CalculateByLUWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<Lab3Model>(context);

    return ElevatedButton(
      onPressed: () => model?.calculateByLU(),
      child: const Text('Calculate by LU'),
    );
  }
}

class _CalculateBySquareRootWidget extends StatelessWidget {
  const _CalculateBySquareRootWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<Lab3Model>(context);

    return ElevatedButton(
      onPressed: () => model?.calculateBySquareRoot(),
      child: const Text('Calculate by Square root'),
    );
  }
}
