import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numerical_methods/Library/Widgets/Inherited/provider.dart';
import 'package:numerical_methods/ui/widgets/labs/lab1/list_operations/vector_module/vector_module_model.dart';

class VectorModuleWidget extends StatelessWidget {
  const VectorModuleWidget({Key? key}) : super(key: key);

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
          _VectorDimensionWidget(),
          Divider(thickness: 2),
          _VectorFormWidget(),
          Divider(thickness: 2),
          _VectorValues(),
          Divider(thickness: 2),
          _ResultWidget(),
        ],
      ),
    );
  }
}

class _VectorDimensionWidget extends StatelessWidget {
  const _VectorDimensionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<VectorModuleModel>(context);
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
  const _VectorFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<VectorModuleModel>(context);
    if (model == null) return const SizedBox.shrink();
    final items = model.vectorForms;
    String? currentValue = model.currentVectorForm;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Vector representation form:   ',
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
            model.changeVectorForm(value);
          },
        ),
      ],
    );
  }
}

class _VectorValues extends StatelessWidget {
  const _VectorValues({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<VectorModuleModel>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          width: double.infinity,
          child: Text(
            'Vector values:',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 10),
        model?.currentVectorForm == 'points'
            ? const _PointsVectorValuesWidget()
            : const _CoordinatesVectorValuesWidget(),
        const SizedBox(height: 10),
      ],
    );
  }
}

class _PointsVectorValuesWidget extends StatelessWidget {
  const _PointsVectorValuesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<VectorModuleModel>(context);

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
            _ListFieldWidget(array: model?.pointA),
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
            _ListFieldWidget(array: model?.pointB),
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
  const _CoordinatesVectorValuesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<VectorModuleModel>(context);

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
        _ListFieldWidget(array: model?.vector),
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
    final model = NotifierProvider.watch<VectorModuleModel>(context);
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
    final model = NotifierProvider.watch<VectorModuleModel>(context);
    final result = model?.result;

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
          '$result',
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}