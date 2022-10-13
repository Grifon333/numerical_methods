import 'package:flutter/material.dart';
import 'package:numerical_methods/Library/Widgets/Inherited/provider.dart';
import 'package:numerical_methods/elements/text_field_widget.dart';
import 'package:numerical_methods/ui/widgets/labs/lab3/lab3_model.dart';

class Lab3Widget extends StatelessWidget {
  const Lab3Widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<Lab3Model>(context);
    if (model == null) return const SizedBox.shrink();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Solution SLAE',
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              const _SystemOfEquationsWidget(),
              const Divider(
                thickness: 2,
                height: 40,
              ),
              const _SelectMethodWidget(),
              const SizedBox(height: 20),
              model.isShow == true
                  ? const _ShowResultWidget()
                  : const SizedBox.shrink(),
            ],
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
    final model = NotifierProvider.watch<Lab3Model>(context);
    if (model == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select method:',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _ButtonForSelectMethodWidget(
              onPressed: () => model.calculateByGauss(),
              title: 'Gauses',
            ),
            _ButtonForSelectMethodWidget(
              onPressed: () => model.calculateByLU(),
              title: 'LU',
            ),
            _ButtonForSelectMethodWidget(
              onPressed: () => model.calculateBySquareRoot(),
              title: 'Square root',
            ),
          ],
        ),
      ],
    );
  }
}

class _ButtonForSelectMethodWidget extends StatelessWidget {
  final void Function() onPressed;
  final String title;

  const _ButtonForSelectMethodWidget({
    Key? key,
    required this.onPressed,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size(100, 36)),
      ),
      child: Text(title),
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

class _ShowResultWidget extends StatelessWidget {
  const _ShowResultWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<Lab3Model>(context);
    if (model == null) return const SizedBox.shrink();
    List<Widget> interimResult = [];
    for (int i = 0; i < model.interimResult.length; i++) {
      interimResult.add(_ShowMatrixWidget(
        title: '${model.interimResult[i][0]}',
        content: '${model.interimResult[i][1]}',
        isBold: false,
      ));
      interimResult.add(const SizedBox(height: 20));
    }

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _ShowMatrixWidget(
              title: 'A',
              content: model.getMatrixCoefficient(),
              isBold: false,
            ),
            const SizedBox(width: 50),
            _ShowMatrixWidget(
              title: 'B',
              content: model.getMatrixB(),
              isBold: false,
            ),
          ],
        ),
        const SizedBox(height: 20),
        interimResult.isNotEmpty
            ? Column(
                children: interimResult,
              )
            : const SizedBox.shrink(),
        _ShowMatrixWidget(
          title: 'ε',
          content: model.getUncertainty(),
          isBold: false,
        ),
        const SizedBox(height: 20),
        _ShowMatrixWidget(
          title: 'X',
          content: model.getMatrixX(),
          isBold: true,
        ),
      ],
    );
  }
}

class _ShowMatrixWidget extends StatelessWidget {
  final String title;
  final String content;
  final bool isBold;

  const _ShowMatrixWidget({
    Key? key,
    required this.title,
    required this.content,
    required this.isBold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$title = ',
          style: TextStyle(
              fontSize: 16,
              fontWeight: isBold == true ? FontWeight.w600 : FontWeight.normal),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Container(
            color: Colors.black,
            width: isBold ? 1.5 : 1,
            height: 60,
          ),
        ),
        Text(
          content,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isBold == true ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Container(
            color: Colors.black,
            width: isBold ? 1.5 : 1,
            height: 60,
          ),
        )
      ],
    );
  }
}
