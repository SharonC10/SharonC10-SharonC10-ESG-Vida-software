import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/view/Chat/widgets/custom_video_player_chat.dart';
import 'package:ESGVida/view/Chat/widgets/local_video_player_chat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VideoPlay extends StatefulWidget {
  String VideoUrl;
  String type;

  VideoPlay({super.key, required this.VideoUrl, required this.type});

  @override
  State<VideoPlay> createState() => _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlay> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: CommonColor.blackColor,
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
              "Video player",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              height: height * 0.3,
              width: width,
              child: widget.type == "http"
                  ? CustomVideoPlayerChat(
                      thumbnailLink: "",
                      videoLink: widget.VideoUrl,
                    )
                  : LocalCustomVideoPlayerChat(
                      thumbnailLink: "",
                      videoLink: widget.VideoUrl,
                    )),
        ],
      ),
    );
  }
}
