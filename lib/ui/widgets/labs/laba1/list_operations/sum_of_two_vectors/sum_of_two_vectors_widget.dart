import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numerical_methods/Library/Widgets/Inherited/provider.dart';
import 'package:numerical_methods/ui/widgets/labs/laba1/list_operations/sum_of_two_vectors/sum_of_two_vectors_model.dart';

class SumOfTwoVectorsWidget extends StatelessWidget {
  const SumOfTwoVectorsWidget({Key? key}) : super(key: key);

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
    final model = NotifierProvider.watch<SumOfTwoVectorsModel>(context);
    if (model == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        children: [
          const SizedBox(height: 20),
          const _VectorDimensionWidget(),
          const Divider(thickness: 2),
          _VectorFormWidget(
            text: 'First vector representation form:   ',
            currentValue: model.currentVectorFormFirst,
            onChange: model.changeVectorFormFirst,
          ),
          _VectorFormWidget(
            text: 'Second vector representation form:   ',
            currentValue: model.currentVectorFormSecond,
            onChange: model.changeVectorFormSecond,
          ),
          const Divider(thickness: 2),
          _VectorFirstValues(
            text: 'First vector values:',
            currentVectorForm: model.currentVectorFormFirst,
            pointA: model.firstPointA,
            pointB: model.firstPointB,
            vector: model.firstVector,
          ),
          _VectorFirstValues(
            text: 'Second vector values:',
            currentVectorForm: model.currentVectorFormSecond,
            pointA: model.secondPointA,
            pointB: model.secondPointB,
            vector: model.secondVector,
          ),
          const Divider(thickness: 2),
          const _ResultWidget(),
        ],
      ),
    );
  }
}

class _VectorDimensionWidget extends StatelessWidget {
  const _VectorDimensionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<SumOfTwoVectorsModel>(context);
    if (model == null) return const SizedBox.shrink();
    final items = model.dimensions;
    int? currentValue = model.currentDimension;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Vector dimension:   ',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        DropdownButton<int>(
          value: currentValue,
          items: items.map((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text('$value'),
            );
          }).toList(),
          onChanged: (value) {
            model.changeDimension(value);
          },
        ),
      ],
    );
  }
}

class _VectorFormWidget extends StatelessWidget {
  final String text;
  final String? currentValue;
  final Function(String? value) onChange;

  const _VectorFormWidget({
    Key? key,
    required this.text,
    required this.currentValue,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<SumOfTwoVectorsModel>(context);
    if (model == null) return const SizedBox.shrink();
    final items = model.vectorForms;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            DropdownButton<String>(
              value: currentValue,
              items: items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(fontSize: 14),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                onChange(value);
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _VectorFirstValues extends StatelessWidget {
  final String text;
  final String currentVectorForm;
  final List<int>? pointA;
  final List<int>? pointB;
  final List<int>? vector;

  const _VectorFirstValues({
    Key? key,
    required this.text,
    required this.currentVectorForm,
    this.pointA,
    this.pointB,
    this.vector,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 10),
        currentVectorForm == 'points' && pointA != null && pointB != null
            ? _PointsVectorValuesWidget(
                pointA: pointA,
                pointB: pointB,
              )
            : _CoordinatesVectorValuesWidget(
                vector: vector,
              ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class _PointsVectorValuesWidget extends StatelessWidget {
  final List<int>? pointA;
  final List<int>? pointB;

  const _PointsVectorValuesWidget({
    Key? key,
    required this.pointA,
    required this.pointB,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (pointA == null || pointB == null) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Start point',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'A',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: ' = {',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  )
                ],
              ),
            ),
            _ListFieldWidget(array: pointA),
            const Text(
              '}',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ],
        ),
        const SizedBox(height: 15),
        const Text(
          'End point',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'B',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: ' = {',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  )
                ],
              ),
            ),
            _ListFieldWidget(array: pointB),
            const Text(
              '}',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ],
        ),
      ],
    );
  }
}

class _CoordinatesVectorValuesWidget extends StatelessWidget {
  final List<int>? vector;

  const _CoordinatesVectorValuesWidget({
    Key? key,
    required this.vector,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (vector == null) return const SizedBox.shrink();

    return Row(
      children: [
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'a',
                style: TextStyle(
                  decoration: TextDecoration.overline,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: ' = {',
                style: TextStyle(color: Colors.black, fontSize: 18),
              )
            ],
          ),
        ),
        _ListFieldWidget(array: vector),
        const Text(
          '}',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ],
    );
  }
}

class _ListFieldWidget extends StatelessWidget {
  final List<int>? array;

  const _ListFieldWidget({Key? key, required this.array}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<SumOfTwoVectorsModel>(context);
    final count = model?.currentDimension ?? 2;

    return SizedBox(
      width: 45.0 * count + 6.0 * (count - 1),
      height: 30,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 45,
            child: TextField(
              onChanged: (value) => {
                value.isEmpty && array != null
                    ? array![index] = 0
                    : array![index] = int.parse(value),
              },
              keyboardType: const TextInputType.numberWithOptions(signed: true),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^[-+]?\d*$')),
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
          return const Text(
            ',',
            style: TextStyle(color: Colors.black, fontSize: 18),
          );
        },
        itemCount: count,
      ),
    );
  }
}

class _ResultWidget extends StatelessWidget {
  const _ResultWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<SumOfTwoVectorsModel>(context);
    final resultVector = model?.resultVector.join(', ');

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
        Text(
          '{$resultVector}',
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
