import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numerical_methods/Library/Widgets/Inherited/provider.dart';
import 'package:numerical_methods/ui/widgets/labs/lab1/list_operations/matrix_transpose/matrix_transpose_model.dart';

class MatrixTransposeWidget extends StatelessWidget {
  const MatrixTransposeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _BodyWidget(),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        children: const [
          SizedBox(height: 20),
          _SizeMatrixWidget(),
          Divider(thickness: 2),
          _MatrixValues(),
          Divider(thickness: 2),
          _ResultWidget(),
        ],
      ),
    );
  }
}

class _SizeMatrixWidget extends StatelessWidget {
  const _SizeMatrixWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MatrixTransposeModel>(context);
    if (model == null) return const SizedBox.shrink();
    final items = model.dimensions;
    int? currentHeight = model.height;
    int? currentWidth = model.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Height:   ',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        DropdownButton<int>(
          value: currentHeight,
          items: items.map((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text('$value'),
            );
          }).toList(),
          onChanged: (value) {
            model.changeHeight(value);
          },
        ),
        const SizedBox(width: 20),
        const Text(
          'Width:   ',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        DropdownButton<int>(
          value: currentWidth,
          items: items.map((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text('$value'),
            );
          }).toList(),
          onChanged: (value) {
            model.changeWidth(value);
          },
        ),
      ],
    );
  }
}

class _MatrixValues extends StatelessWidget {
  const _MatrixValues({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MatrixTransposeModel>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          width: double.infinity,
          child: Text(
            'Matrix values:',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 10),
        _ListFieldWidget(matrix: model?.matrix),
        const SizedBox(height: 10),
      ],
    );
  }
}

class _ListFieldWidget extends StatelessWidget {
  final List<List<int>>? matrix;

  const _ListFieldWidget({Key? key, required this.matrix}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MatrixTransposeModel>(context);
    final width = model?.width ?? 3;
    final height = model?.height ?? 3;
    if (matrix == null) return const SizedBox.shrink();

    return Row(
      children: [
        ColoredBox(
          color: Colors.black,
          child: SizedBox(
            width: 1,
            height: 30.0 * height + 5.0 * (height - 1),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 45.0 * width + 5.0 * (width - 1),
          height: 30.0 * height + 5.0 * (height - 1),
          child: ListView.separated(
            itemCount: height,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int indexH) {
              return SizedBox(
                height: 30,
                width: 45,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: width,
                  itemBuilder: (BuildContext context, int indexW) {
                    return SizedBox(
                      width: 45,
                      height: 30,
                      child: TextField(
                        onChanged: (value) => {
                          value.isEmpty
                              ? matrix![indexH][indexW] = 0
                              : matrix![indexH][indexW] = int.parse(value),
                        },
                        keyboardType:
                            const TextInputType.numberWithOptions(signed: true),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^[-+]?\d*$')),
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
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(width: 5);
                  },
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 5);
            },
          ),
        ),
        const SizedBox(width: 10),
        ColoredBox(
          color: Colors.black,
          child: SizedBox(
            width: 1,
            height: 30.0 * height + 5.0 * (height - 1),
          ),
        ),
      ],
    );
  }
}

class _ResultWidget extends StatelessWidget {
  const _ResultWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MatrixTransposeModel>(context);
    final result = model?.resultString ?? '';
    final height = model?.width ?? 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () => model?.resultCalculation(),
          child: const Text(
            'Result',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'A',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  'T',
                  style: TextStyle(
                    fontSize: 10,
                  ),
                ),
                Text(
                  ' =   ',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            ColoredBox(
              color: Colors.black,
              child: SizedBox(
                width: 1,
                height: 21.0 * height,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              result,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(width: 10),
            ColoredBox(
              color: Colors.black,
              child: SizedBox(
                width: 1,
                height: 21.0 * height,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
