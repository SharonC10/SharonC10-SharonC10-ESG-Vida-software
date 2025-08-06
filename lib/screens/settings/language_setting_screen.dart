import 'package:ESGVida/pkg/constants/common.dart';
import 'package:ESGVida/pkg/inmemory_data.dart';
import 'package:ESGVida/pkg/utils/common.dart';
import 'package:ESGVida/pkg/language.dart';

import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/widgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageSettingScreen extends StatelessWidget {
  LanguageSettingScreen({super.key});
  final currentLocale = GlobalInMemoryData.I.locale.obs;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: CommonAppbarInside(
        bgColor: const Color(0xFF5856D6),
        context,
        title:
            '${LanguageGlobalVar.Language.tr} ${LanguageGlobalVar.Setting.tr}',
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
              child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ...CommonConstant.LOCALES.entries.map((entry) {
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 0.4,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(
                        right: 10,
                        top: 10,
                        bottom: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.white, width: 0.2),
                      ),
                      width: width,
                      height: height * 0.08,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            entry.value,
                            style: CommonStyle.black18Medium,
                          ),
                          const Spacer(),
                          Obx(() => Radio(
                                visualDensity: VisualDensity.compact,
                                value: entry.key,
                                activeColor: CommonColor.blueAccent,
                                groupValue: currentLocale.value,
                                onChanged: (value) async {
                                  final selectedLocale = value.toString();
                                  currentLocale.value = selectedLocale;
                                  Get.updateLocale(
                                      LocaleUtils.fromDash(selectedLocale));
                                  GlobalInMemoryData.I
                                      .setLocale(selectedLocale);
                                },
                              )),
                        ],
                      ),
                    ),
                  );
                })
              ],
            ),
          )),
        ],
      ),
    );
  }
}
