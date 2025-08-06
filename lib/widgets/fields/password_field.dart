import 'package:ESGVida/pkg/style_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PasswordField extends StatelessWidget {
  Rx<bool> obscureText;
  TextEditingController textEditingController;

  String hintText;

  PasswordField(
      {super.key,
      required this.obscureText,
      required this.textEditingController,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      //  height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      // color: Colors.grey.shade300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(width: 0.4, color: CommonColor.blueAccent),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Obx(() => TextFormField(
                  obscureText: obscureText.value,
                  autofocus: false,
                  controller: textEditingController,
                  style: CommonStyle.black14Regular,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r'\s')),
                  ],
                  decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: InkWell(
                            onTap: () {
                              obscureText.value = !obscureText.value;
                            },
                            child: Icon(
                              obscureText.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: CommonColor.blueAccent,
                              size: 20,
                            )),
                      ),
                      suffixIconConstraints: const BoxConstraints(
                          maxHeight: 30,
                          minHeight: 20,
                          maxWidth: 40,
                          minWidth: 20),
                      border: InputBorder.none,
                      filled: true,
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
                      fillColor: Colors.transparent,
                      hintText: hintText,
                      hintStyle: CommonStyle.grey14Light),
                )),
          ),
        ],
      ),
    );
  }
}
