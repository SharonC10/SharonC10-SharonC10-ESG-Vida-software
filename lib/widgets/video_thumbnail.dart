import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoThumbnailWidget extends StatelessWidget {
  final String videoPath;

  Future<Uint8List?> generateThumbnail(String videoPath) async {
    try {
      final thumbnail = await VideoThumbnail.thumbnailData(
        video: videoPath,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 128, // Specify the width of the thumbnail
        quality: 25,
      );
      return thumbnail;
    } catch (e) {
      print("Error generating thumbnail: $e");
      return null;
    }
  }

  const VideoThumbnailWidget({Key? key, required this.videoPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: generateThumbnail(videoPath),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
              width: 30,
              height: 30,
              child: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.hasData && snapshot.data != null) {
          return Image.memory(snapshot.data!);
        } else {
          return const Icon(Icons
              .error); // Show an error icon if unable to generate thumbnail
        }
      },
    );
  }
}
