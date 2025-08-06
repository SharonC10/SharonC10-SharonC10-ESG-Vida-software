import 'package:ESGVida/pkg/ext.dart';
import 'package:ESGVida/view/Chat/chatting/utils.dart';
import 'package:ESGVida/view/Chat/widgets/image_from_file.dart';

import 'package:ESGVida/screens/gallery/model.dart';
import 'package:ESGVida/screens/gallery/screen.dart';
import 'package:ESGVida/view/Chat/widgets/local_image_view.dart';
import 'package:ESGVida/widgets/cacheable_progress_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';

class TextMessageWidget extends StatelessWidget {
  final types.TextMessage message;
  final String receiverId;

  const TextMessageWidget(
      {super.key, required this.message, required this.receiverId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      color: message.author.id.toString() == receiverId
          ? Colors.grey.shade200
          : Colors.blue.shade50,
      child: Column(
        crossAxisAlignment: message.author.id.toString() == receiverId
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(message.text,
              style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                  fontSize: 13)),
          Text(
            message.createdAt!.toFriendlyDatetimeStr(),
            style: TextStyle(
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w400,
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }
}

class ImageMessageWidget extends StatelessWidget {
  final types.ImageMessage message;

  const ImageMessageWidget({super.key, required this.message});
  @override
  Widget build(BuildContext context) {
    double fileSizeKB = message.size / 1024;
    double fileSizeMB = fileSizeKB / 1024;
    final size = MediaQuery.sizeOf(context);
    final width =
        message.width! > message.height! ? size.width * 0.7 : size.width * 0.5;
    return SizedBox(
      width: width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              onClickImage();
            },
            child: Stack(
              children: [
                SizedBox(
                  width: width,
                  child: AspectRatio(
                    aspectRatio: message.width! / message.height!,
                    child: _buildImage(),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    width: width,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          message.name.filename(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          fileSizeKB > 1024
                              ? "${fileSizeMB.toStringAsFixed(2)} MB"
                              : "${fileSizeKB.toStringAsFixed(2)} KB",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              alignment: Alignment.centerRight,
              child: Text(
                message.createdAt!.toFriendlyDatetimeStr(),
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w400,
                  fontSize: 9,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildImage() {
    if (message.uri.startsWith("http")) {
      return commonCacheImage2(
        imgHeight: message.height!,
        imgWidth: message.width!,
        url: message.uri,
      );
    }
    return imageFromFile(
      imgHeight: message.height!,
      imgWidth: message.width!,
      uri: message.uri,
    );
  }

  void onClickImage() {
    String extension = message.uri.toString().split(".").last;
    bool isHttp = message.uri.toString().startsWith("http");
    String extLower = extension.toLowerCase();
    if (SUPPORT_IMAGES.contains(extLower)) {
      if (isHttp) {
        Get.to(() => GalleryImageViewWrapper(
              titleGallery: "Image View",
              galleryItems: [
                GalleryItemModel(id: "0", imageUrl: message.uri.toString())
              ],
              backgroundDecoration: const BoxDecoration(
                color: Colors.black,
              ),
              initialIndex: 0,
              scrollDirection: Axis.horizontal,
            ));
      } else {
        Get.to(() => LocalImageView(
              url: message.uri.toString(),
            ));
      }
    }
  }
}

class FileMessageWidget extends StatelessWidget {
  final types.FileMessage message;
  final Size? size;
  final bool isReceiver;

  const FileMessageWidget(
      {super.key, required this.message, this.size, required this.isReceiver});

  @override
  Widget build(BuildContext context) {
    double fileSizeKB = message.size / 1024;
    double fileSizeMB = fileSizeKB / 1024;
    return Container(
      width: 220,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 7,
      ),
      color: isReceiver ? Colors.grey.shade200 : Colors.blue.shade50,
      child: Row(
        children: [
          CircleAvatar(
            radius: 15,
            backgroundColor:
                isReceiver ? Colors.grey.shade400 : Colors.blue.shade100,
            child: Icon(
              Icons.video_file,
              size: isReceiver ? 15 : 15,
              color: isReceiver ? Colors.white : Colors.blue.shade300,
            ),
          ),
          10.width,
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width: 150,
                  child: Text(
                    message.name.filename(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  )),
              Text(
                fileSizeKB > 1024
                    ? "${fileSizeMB.toStringAsFixed(2)} MB"
                    : "${fileSizeKB.toStringAsFixed(2)} KB",
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
