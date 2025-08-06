import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberField<T extends num> extends StatelessWidget {
  final String label;
  final int maxLength;
  final T min;
  final T max;
  final TextEditingController tec;

  NumberField(
      {super.key,
      this.label = "",
      this.maxLength = 2,
      required this.min,
      required this.max,
      required this.tec});
  num? preValue;
  bool? isInt;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: TextField(
      decoration: InputDecoration(
        labelText: label,
        counterText: '',
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(maxLength),
      ],
      maxLength: maxLength,
      textAlign: TextAlign.center,
      controller: tec,
      onChanged: (text) {
        print("text=$text ${text.isEmpty}");
        if (text == "" || text.isEmpty) {
          return;
        }
        isInt ??= T.toString() == "int";
        num? newValue = isInt! ? int.parse(text) : num.tryParse(text);
        if (newValue != null && newValue >= min && newValue <= max) {
          preValue = newValue;
        } else {
          preValue ??= num.parse(tec.text);
          tec.text = preValue.toString();
        }
      },
    ));
  }
}
