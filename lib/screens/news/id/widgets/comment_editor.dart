import 'package:ESGVida/pkg/toast.dart';

import 'package:ESGVida/pkg/style_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentEditor extends StatelessWidget {
  CommentEditor({super.key, required this.onUpload, String? text}) {
    contentTec = TextEditingController(text: text);
  }

  final Future<void> Function(String content) onUpload;
  late final TextEditingController contentTec;
  final isUploading = false.obs;

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              autofocus: false,
              controller: contentTec,
              decoration: InputDecoration(
                filled: true,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none),
                fillColor: CommonColor.whiteColor,
                hintText: "Enter comment",
                hintStyle: CommonStyle.grey14Medium,
              ),
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              if (contentTec.value.text.isEmpty) {
                showToast("can' t post empty comment");
              } else {
                isUploading.value = true;
                onUpload(contentTec.value.text).then((_) {
                  isUploading.value = false;
                  contentTec.value = const TextEditingValue();
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Obx(
                () => isUploading.value
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: Colors.blue,
                          strokeWidth: 2.2,
                        ),
                      )
                    : const Icon(
                        Icons.send,
                        color: Colors.blue,
                        size: 24,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
