import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

Widget cachedImage({
  @required BuildContext? context,
  @required String? image,
  @required double? height,
  @required double? width,
  // String placeholder = IMAGELOADINGERROROFFLINE,
  BoxFit fit = BoxFit.cover,
  // int? diskCache = 170,
}) {
  return CachedNetworkImage(
    height: height,
    width: width,
    fit: fit,
    // maxHeightDiskCache: diskCache,
    // maxWidthDiskCache: diskCache,
    // errorWidget: (widget, text, error) {
    //   return Image.asset(
    //     placeholder,
    //     height: height,
    //     width: width,
    //     fit: fit,
    //   );
    // },
    progressIndicatorBuilder: (context, url, progress) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (progress.progress != null && progress.progress! > 0)
          SizedBox(
            width: 30,
            height: 30,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: LinearPercentIndicator(
                lineHeight: 5.0,
                percent: progress.progress!,
                backgroundColor: Colors.grey,
                progressColor: Colors.blue,
              ),
            ),
            // CircularProgressIndicator(
            //   valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
            //   value: progress.progress,
            // ),
          ),
        if (progress.progress == null || progress.progress! == 0)
          Container(
            width: width! - 6,
            height: height! - 6,
            color: Colors.grey,
          )
      ],
    ),
    imageUrl: "$image",
  );
}
