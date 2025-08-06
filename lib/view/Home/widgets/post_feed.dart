import 'package:ESGVida/model/post/feed.dart';
import 'package:ESGVida/pkg/ext.dart';

import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/widgets/cacheable_progress_image.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';

class PostFeedView extends StatelessWidget {
  final PostFeedModel data;
  const PostFeedView({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 1,
        horizontal: 1,
      ),
      width: size.width * 0.45,
      height: size.height,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: CommonColor.secondaryColor.withOpacity(0.25),
            spreadRadius: 0.5,
            blurRadius: 2,
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: size.width,
                  height: size.height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: commonCacheImage2(
                    imgHeight: 80,
                    imgWidth: 70,
                    url: data.coverUrl!,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
          3.height,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  commonCacheImage2(
                    imgHeight: 25,
                    imgWidth: 25,
                    url: data.userProfileUrl!.toString(),
                    shape: BoxShape.circle,
                  ),
                  Text(
                    "${data.username!.capitalizeFirst}",
                    style: CommonStyle.black08Bold,
                  )
                ],
              ),
              8.width,
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${data.heading.toString().capitalizeFirst}",
                      style: CommonStyle.black10Bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "${data.description.toString().capitalizeFirst}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: CommonStyle.grey10Medium,
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
