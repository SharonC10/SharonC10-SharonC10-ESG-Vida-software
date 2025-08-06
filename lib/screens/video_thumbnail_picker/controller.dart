import 'dart:io';
import 'dart:math';
import 'package:ESGVida/pkg/utils/file.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';

class VideoThumbnailController extends GetxController {
  final isVideoPlayerLoading = true.obs;
  late FlickManager flickManager;
  final String videoPath;
  final currentPositionMills = 0.obs;
  final generateAt = 0.obs;
  final thumbnailPath = RxnString();
  final durationSecs = 0.obs;
  final aspectRatio = (16 / 9.0).obs;
  final isGeneratingThumbnail = false.obs;
  final count = 0.obs;

// 小时有点夸张，应该不需要，但是不管啦。。
  final maxLoading = true.obs;
  late int maxHours;
  late int maxMinutes;
  late int maxSeconds;
  final hoursTC = TextEditingController(text: "0");
  final minutesTC = TextEditingController(text: "0");
  final secondsTC = TextEditingController(text: "0");

  @override
  void onInit() {
    initializeVideoController();
    super.onInit();
  }

  VideoThumbnailController(this.videoPath);

  void initializeVideoController() async {
    try {
      isVideoPlayerLoading.value = true;
      final videoPlayerController = VideoPlayerController.file(File(videoPath));
      await videoPlayerController.initialize();
      flickManager = FlickManager(
        videoPlayerController: videoPlayerController,
        autoInitialize: false,
        autoPlay: false,
      );
      durationSecs.value = videoPlayerController.value.duration.inSeconds;

      final durationObj = videoPlayerController.value.duration;
      maxHours = durationObj.inHours;
      maxMinutes = maxHours != 0 ? 59 : durationObj.inMinutes.remainder(60);
      maxSeconds = maxMinutes != 0 ? 59 : durationObj.inSeconds.remainder(60);
      maxLoading.value = false;

      aspectRatio.value = videoPlayerController.value.aspectRatio;
      videoPlayerController.addListener(listenPlay);
    } finally {
      isVideoPlayerLoading.value = false;
    }
  }

  void listenPlay() async {
    final videoPlayerController =
        flickManager.flickVideoManager?.videoPlayerController;
    if (videoPlayerController == null) {
      return;
    }
    final curPosition = await videoPlayerController.position;
    currentPositionMills.value = curPosition?.inMilliseconds ?? 0;
  }

  Future<void> seekToTime() async {
    final newPosition = Duration(
      hours:
          maxHours == 0 || hoursTC.text.isEmpty ? 0 : int.parse(hoursTC.text),
      minutes: maxMinutes == 0 || minutesTC.text.isEmpty
          ? 0
          : int.parse(minutesTC.text),
      seconds: maxSeconds == 0 || secondsTC.text.isEmpty
          ? 0
          : int.parse(secondsTC.text),
    );
    final ms = newPosition.inMilliseconds;
    if (ms >= 0 && ms <= durationSecs.value * 1000) {
      await seekTo(newPosition.inMilliseconds);
    }
  }

  Future<void> seekTo(int positionMills) async {
    if (flickManager.flickVideoManager!.isPlaying) {
      await flickManager.flickVideoManager!.videoPlayerController!.pause();
    }
    await flickManager.flickVideoManager!.videoPlayerController!
        .seekTo(Duration(milliseconds: positionMills));
    currentPositionMills.value = positionMills;
  }

  void generateThumbnail() async {
    try {
      final tempDir = await getTemporaryDirectory();
      if (flickManager.flickVideoManager!.isPlaying) {
        await flickManager.flickVideoManager!.videoPlayerController!.pause();
      }
      final positionMills = currentPositionMills.value;
      isGeneratingThumbnail.value = true;
      final dir = Directory(FileUtils.join([
        tempDir.path,
        "media",
      ]));
      if (!dir.existsSync()) {
        dir.createSync(recursive: true);
      }
      final thumbnailPathV = FileUtils.join([
        dir.path,
        "${FileUtils.basenameWithoutExt(videoPath)}.png",
      ]);
      final path = await VideoThumbnail.thumbnailFile(
        video: videoPath,
        thumbnailPath: thumbnailPathV,
        imageFormat: ImageFormat.PNG,
        timeMs: positionMills,
      );
      if (thumbnailPath.value != null) {
        imageCache.evict(FileImage(
          File(thumbnailPath.value!),
        ));
      }
      thumbnailPath.value = path;
      generateAt.value = DateTime.now().microsecondsSinceEpoch;
    } finally {
      isGeneratingThumbnail.value = false;
    }
  }

  Future<void> randomThumbnail() async {
    await seekTo(Random().nextInt(durationSecs.value + 1) * 1000);
    generateThumbnail();
  }

  @override
  void onClose() {
    flickManager.dispose();
    super.onClose();
  }
}
