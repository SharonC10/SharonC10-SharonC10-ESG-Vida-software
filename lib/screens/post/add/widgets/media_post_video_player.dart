import 'dart:io';

import 'package:ESGVida/widgets/loadings.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MediaPostVideoPlayer extends StatefulWidget {
  final String path;
  final void Function(FlickManager flickManager) onInit;
  final void Function() onDispose;
  final double? Function(Size size, double aspectRatio) maxHightGetter;
  final double? Function(Size size, double aspectRatio) maxWidthGetter;
  const MediaPostVideoPlayer({
    super.key,
    required this.path,
    required this.onInit,
    required this.onDispose,
    required this.maxHightGetter,
    required this.maxWidthGetter,
  });

  @override
  State<MediaPostVideoPlayer> createState() => _MediaPostVideoPlayerState();
}

class _MediaPostVideoPlayerState extends State<MediaPostVideoPlayer> {
  bool isVideoLoading = true;
  FlickManager? flickManager;
  @override
  void initState() {
    initializeVideoController(widget.path);
    super.initState();
  }

  @override
  void didUpdateWidget(MediaPostVideoPlayer oldWidget) {
    if (oldWidget.path != widget.path) {
      initializeVideoController(widget.path);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    flickManager?.dispose();
    widget.onDispose();
    super.dispose();
  }

  void initializeVideoController(String videoPath) async {
    isVideoLoading = true;
    flickManager?.dispose();
    final videoPlayerController = VideoPlayerController.file(
      File(videoPath),
    );
    await videoPlayerController.initialize();
    if (!mounted) {
      return;
    }
    setState(() {
      flickManager = FlickManager(
        videoPlayerController: videoPlayerController,
        autoInitialize: false,
        autoPlay: false,
      );
      widget.onInit(flickManager!);
      isVideoLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isVideoLoading) {
      return loadingWidget();
    }
    final size = MediaQuery.sizeOf(context);
    final aspectRatio =
        flickManager!.flickVideoManager!.videoPlayerValue!.aspectRatio;
    final mustSmallIcon =
        aspectRatio < 1 && !flickManager!.flickControlManager!.isFullscreen;
    return Center(
      child: SizedBox(
        height: widget.maxHightGetter(size, aspectRatio),
        width: widget.maxWidthGetter(size, aspectRatio),
        child: AspectRatio(
          aspectRatio: aspectRatio,
          child: FlickVideoPlayer(
            flickManager: flickManager!,
            flickVideoWithControls: FlickVideoWithControls(
              controls: FlickPortraitControls(
                iconSize: mustSmallIcon ? 12 : 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
