import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatelessWidget {
  final double width;
  final bool autoFocus;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final Function(String value)? onSubmited;
  final Function(String value)? onChanged;
  final String? hintText;

  const TextFieldWidget({
    Key? key,
    required this.width,
    this.autoFocus = false,
    this.focusNode,
    this.controller,
    this.onSubmited,
    this.onChanged,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 30,
      child: TextField(
        autofocus: autoFocus,
        focusNode: focusNode,
        controller: controller,
        onSubmitted: onSubmited,
        onChanged: onChanged,
        keyboardType: const TextInputType.numberWithOptions(
          signed: true,
          decimal: true,
        ),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'^[-]?\d*\.?\d*')),
        ],
        style: const TextStyle(fontSize: 16),
        textAlign: TextAlign.end,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 6),
          hintText: hintText,
        ),
      ),
    );
  }
}
