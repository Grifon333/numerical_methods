import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numerical_methods/Library/Widgets/Inherited/provider.dart';
import 'package:numerical_methods/ui/widgets/labs/lab1/list_operations/sum_and_product_matrices/sum_and_product_matrices_model.dart';

class SumAndProductsMatricesWidget extends StatelessWidget {
  const SumAndProductsMatricesWidget({Key? key}) : super(key: key);

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
          _TitleWidget(),
          _SizeMatrixWidget(typeMatrix: 'First'),
          _SizeMatrixWidget(typeMatrix: 'Second'),
          Divider(thickness: 2),
          _MatrixValues(typeMatrix: 'first'),
          _MatrixValues(typeMatrix: 'second'),
          Divider(thickness: 2),
          _ResultSumWidget(),
          SizedBox(height: 10),
          Divider(thickness: 2),
          _ResultDifferenceWidget(),
          SizedBox(height: 10),
          Divider(thickness: 2),
          _ResultProductWidget(),
        ],
      ),
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        'Sum & product of two matrices',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _SizeMatrixWidget extends StatelessWidget {
  final String typeMatrix;

  const _SizeMatrixWidget({
    Key? key,
    required this.typeMatrix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<SumAndProductsMatricesModel>(context);
    if (model == null) return const SizedBox.shrink();
    final items = model.dimensions;
    int? currentHeight =
        typeMatrix == 'First' ? model.heightFirst : model.heightSecond;
    int? currentWidth =
        typeMatrix == 'First' ? model.widthFirst : model.widthSecond;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          typeMatrix,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 20),
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
            typeMatrix == 'First'
                ? model.changeHeightFirst(value)
                : model.changeHeightSecond(value);
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
            typeMatrix == 'First'
                ? model.changeWidthFirst(value)
                : model.changeWidthSecond(value);
          },
        ),
      ],
    );
  }
}

class _MatrixValues extends StatelessWidget {
  final String typeMatrix;

  const _MatrixValues({
    Key? key,
    required this.typeMatrix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<SumAndProductsMatricesModel>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            'Matrix $typeMatrix values:',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 10),
        _ListFieldWidget(
            typeMatrix: typeMatrix,
            matrix: typeMatrix == 'first'
                ? model?.matrixFirst
                : model?.matrixSecond),
        const SizedBox(height: 10),
      ],
    );
  }
}

class _ListFieldWidget extends StatelessWidget {
  final String typeMatrix;
  final List<List<int>>? matrix;

  const _ListFieldWidget({
    Key? key,
    required this.typeMatrix,
    required this.matrix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<SumAndProductsMatricesModel>(context);
    final width = typeMatrix == 'first'
        ? (model?.widthFirst ?? 3)
        : (model?.widthSecond ?? 3);
    final height = typeMatrix == 'first'
        ? (model?.heightFirst ?? 3)
        : (model?.heightSecond ?? 3);
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

class _ResultSumWidget extends StatelessWidget {
  const _ResultSumWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<SumAndProductsMatricesModel>(context);
    final result = model?.resultSumString ?? '';
    final height = model?.heightFirst ?? 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () {
            if (model?.heightFirst != model?.heightSecond ||
                model?.widthFirst != model?.widthSecond) {
              model?.setResultSumString = '';
              showDialog(
                context: context,
                builder: (context) => const _AlertDialogWidget(
                  textError:
                  'Matrix sizes are not equal',
                ),
              );
            } else {
              model?.sumCalculate();
            }
          },
          child: const Text(
            'Sum',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Text(
              'A + B = ',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
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

class _ResultDifferenceWidget extends StatelessWidget {
  const _ResultDifferenceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<SumAndProductsMatricesModel>(context);
    final result = model?.resultDifferenceString ?? '';
    final height = model?.heightFirst ?? 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () {
            if (model?.heightFirst != model?.heightSecond ||
                model?.widthFirst != model?.widthSecond) {
              model?.setResultDifferenceString = '';
              showDialog(
                context: context,
                builder: (context) => const _AlertDialogWidget(
                  textError:
                  'Matrix sizes are not equal',
                ),
              );
            } else {
              model?.differenceCalculate();
            }
          },
          child: const Text(
            'Difference',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Text(
              'A - B = ',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
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

class _ResultProductWidget extends StatelessWidget {
  const _ResultProductWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<SumAndProductsMatricesModel>(context);
    final result = model?.resultProductString ?? '';
    final height = model?.heightFirst ?? 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () {
            if (model?.widthFirst != model?.heightSecond) {
              model?.setResultProductString = '';
              showDialog(
                context: context,
                builder: (context) => const _AlertDialogWidget(
                  textError:
                      'The number of columns of the first matrix does not '
                      'equal the number of rows of the second matrix',
                ),
              );
            } else {
              model?.productCalculate();
            }
          },
          child: const Text(
            'Product',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Text(
              'A * B = ',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
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
