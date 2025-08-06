import 'dart:io';


import 'package:ESGVida/widgets/loadings.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AdaptiveVideoPlayer extends StatefulWidget {
  final String uri;
  final void Function(FlickManager flickManager) onInit;
  final void Function() onDispose;
  final double? Function(Size size, double aspectRatio) maxHightGetter;
  final double? Function(Size size, double aspectRatio) maxWidthGetter;
  const AdaptiveVideoPlayer({
    super.key,
    required this.uri,
    this.onInit = _defaultOnInit,
    this.onDispose = _defaultOnDispose,
    this.maxHightGetter = _defaultMaxHightGetter,
    this.maxWidthGetter = _defaultMaxWidthGetter,
  });

  @override
  State<AdaptiveVideoPlayer> createState() => _AdaptiveVideoPlayerState();

  static void _defaultOnInit(FlickManager flickManager) {}
  static void _defaultOnDispose() {}
  static double? _defaultMaxHightGetter(Size size, double aspectRatio) {
    return aspectRatio > 1 ? null : size.height * 0.5;
  }

  static double? _defaultMaxWidthGetter(Size size, double aspectRatio) {
    return aspectRatio > 1 ? size.width : null;
  }
}

class _AdaptiveVideoPlayerState extends State<AdaptiveVideoPlayer> {
  bool isVideoLoading = true;
  FlickManager? flickManager;
  @override
  void initState() {
    initializeVideoController(widget.uri);
    super.initState();
  }

  @override
  void didUpdateWidget(AdaptiveVideoPlayer oldWidget) {
    if (oldWidget.uri != widget.uri) {
      initializeVideoController(widget.uri);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    flickManager?.dispose();
    widget.onDispose();
    super.dispose();
  }

  void initializeVideoController(String videoUri) async {
    isVideoLoading = true;
    flickManager?.dispose();
    final videoPlayerController = videoUri.startsWith("http")
        ? VideoPlayerController.networkUrl(
            Uri.parse(videoUri),
          )
        : VideoPlayerController.file(
            File(videoUri),
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
