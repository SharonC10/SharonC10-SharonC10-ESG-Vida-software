import 'package:ESGVida/model/news_model.dart';

import 'package:ESGVida/pkg/style_color.dart';
import 'package:ESGVida/widgets/cacheable_progress_image.dart';
import 'package:flutter/material.dart';

class NewsFeedPreview extends StatelessWidget {
  final NewsModel data;
  const NewsFeedPreview({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      width: size.width,
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        color: const Color(0xE6ECFBFF),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        border: Border.all(
          color: Colors.grey.shade100,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: commonCacheImage2(
              imgHeight: 100,
              imgWidth: 100,
              url: data.images.toString(),
              borderRadius: 8,
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${data.title}",
                  style: CommonStyle.black15Medium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Flexible(
                  child: Text(
                    "${data.description}",
                    style: CommonStyle.grey12Medium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
