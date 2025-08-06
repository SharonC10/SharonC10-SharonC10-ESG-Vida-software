import 'package:ESGVida/pkg/style_color.dart';
import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';

class CustomVideoPlayerChat extends StatefulWidget {
  final String videoLink;
  final String thumbnailLink;

  const CustomVideoPlayerChat(
      {super.key, required this.videoLink, required this.thumbnailLink});

  @override
  State<CustomVideoPlayerChat> createState() => _CustomVideoPlayerChatState();
}

class _CustomVideoPlayerChatState extends State<CustomVideoPlayerChat> {
  late VideoPlayerController videoPlayerController;
  bool isInitialized = false;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      setState(() {});
    }
    //  videoPlayerController = VideoPlayerController.network(widget.videoLink, videoPlayerOptions: VideoPlayerOptions(),);
    videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoLink.toString()));
    setState(() {});
    videoPlayerController.addListener(() {});
    videoPlayerController.play();
    videoPlayerController.setLooping(true);
    videoPlayerController.initialize().then((value) {
      isInitialized = true;
      setState(() {});
    });
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isInitialized,
      // }),
      replacement: GestureDetector(
        onTap: () {},
        child: SizedBox(
          child: Stack(
            children: [
              Center(
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).height,
                  width: MediaQuery.sizeOf(context).width,
                  child: widget.thumbnailLink == null
                      ? Image.network(
                          "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png")
                      : widget.thumbnailLink == ""
                          ? Image.asset(
                              "assets/loading.gif",
                              height: MediaQuery.sizeOf(context).height,
                              width: MediaQuery.sizeOf(context).width,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              widget.thumbnailLink,
                              fit: BoxFit.fill,
                            ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 30, left: 10, right: 10),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: LinearProgressIndicator(
                    color: CommonColor.primaryColor,
                    backgroundColor: Colors.black,
                    minHeight: 2,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      child: InkWell(
          onTap: () {
            if (videoPlayerController.value.isPlaying) {
              videoPlayerController.pause();
              isPlaying = false;
              setState(() {});
            } else {
              videoPlayerController.play();
              isPlaying = true;
              setState(() {});
            }
          },
          child: SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: Stack(
                children: [
                  SizedBox(
                      width: videoPlayerController.value.size.width ?? 0,
                      height: videoPlayerController.value.size.height ?? 0,
                      child: VideoPlayer(videoPlayerController)),
                  Positioned(
                      left: 0,
                      top: 0,
                      right: 0,
                      bottom: 0,
                      child: videoPlayerController.value.isPlaying
                          ? const SizedBox()
                          : const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 70,
                            )),
                ],
              ),
            ),
          )),
    );
  }
}
