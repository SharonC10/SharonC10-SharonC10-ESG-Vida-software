import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberInputer extends StatelessWidget {
  final TextEditingController controller;
  final Color color;
  final double height;
  final double width;
  final bool editable;
  final Future<void> Function()? onClickText;
  final void Function(int value)? onChange;
  const NumberInputer({
    super.key,
    required this.controller,
    this.color = const Color.fromARGB(255, 224, 224, 224),
    this.height = 25,
    this.width = 60,
    this.onChange,
    this.editable = true,
    this.onClickText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            if (controller.text.isEmpty) {
              return;
            }
            final count = int.tryParse(controller.text);
            if (count != null && count > 0) {
              controller.text = (count - 1).toString();
              onChange?.call(count - 1);
            }
          },
          icon: const Icon(
            Icons.remove,
            color: Colors.black,
          ),
        ),
        Container(
            color: color,
            height: height,
            width: width,
            child: editable
                ? TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    textAlign: TextAlign.center,
                    scrollPadding: EdgeInsets.zero,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.zero,
                        gapPadding: 0,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.zero,
                        gapPadding: 0,
                      ),
                    ),
                  )
                : InkWell(
                    onTap: () {
                      onClickText?.call();
                    },
                    child: ValueListenableBuilder(
                      valueListenable: controller,
                      builder: (context, value, child) {
                        return Text(
                          value.text,
                          textAlign: TextAlign.center,
                        );
                      },
                    ),
                  )),
        IconButton(
          onPressed: () {
            if (controller.text.isEmpty) {
              return;
            }
            final count = int.tryParse(controller.text);
            if (count != null) {
              controller.text = (count + 1).toString();
              onChange?.call(count + 1);
            }
          },
          icon: const Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
