import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


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
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
              value: progress.progress,
            ),
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
