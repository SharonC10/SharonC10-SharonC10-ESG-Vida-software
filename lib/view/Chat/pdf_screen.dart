import 'dart:io';

import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/widgets/loadings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:printing/printing.dart';

class PDFViewerPage extends StatefulWidget {
  String pdfUrl;
  String name;
  String type;

  PDFViewerPage(
      {super.key,
      required this.pdfUrl,
      required this.name,
      required this.type});

  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  String pdfUrl = ""; //
  bool isDownloading = false; // Replace with your PDF URL

  final webViewKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      pdfUrl = widget.pdfUrl;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        shadowColor: Colors.grey,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        toolbarHeight: 40,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 20,
            ),
            GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 21,
                )),
            const SizedBox(
              width: 5,
            ),
            const Text(
              "Pdf view",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
      body: PdfPreview(
        pdfPreviewPageDecoration:
            const BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.white,
          )
        ]),

        maxPageWidth: MediaQuery.of(context).size.width,
        build: widget.type == "http"
            ? (format) => networkImageToBase64(pdfUrl)
            : (format) => loadFileBytes(pdfUrl),
        // onPrinted: _showPrintedToast,
        // onShared: _showSharedToast,
        allowPrinting: false,
        canChangeOrientation: false,
        padding: EdgeInsets.zero,
        previewPageMargin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        canChangePageFormat: false,
        loadingWidget: loadingIndigator(
            width: 40, height: 40, color: CommonColor.secondaryColor),
        canDebug: false,
        pdfFileName: "${widget.name}.pdf",
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     //    print(widget.DownloadUrl);
      //     //   print("Comapare ================");
      //     //   print(Url.fees+"${widget.title}");
      //     setState(() {
      //       isDownloading = true;
      //     });
      //     file_download().download("${pdfUrl}","MyTurf Brochure.pdf").whenComplete((){
      //       setState(() {
      //         isDownloading = false;
      //       });
      //     });
      //   },
      //   backgroundColor: Colors.white,
      //   child:const Icon(Icons.download_for_offline,color: Constants.newPrimaryColor,size: 40,),
      // ),
    );
  }
}

Future<Uint8List> networkImageToBase64(String imageUrl) async {
  http.Response response = await http.get(Uri.parse(imageUrl.toString()));
  final bytes = response.bodyBytes;
  return bytes;
}

Future<Uint8List> loadFileBytes(String filePath) async {
  File file = File(filePath);
  Uint8List bytes = await file.readAsBytes();
  final fileBytes = bytes;
  return fileBytes;
}
