import 'package:flutter/material.dart';
import 'package:try_work/multiManager/flickMultiManager.dart';
import 'package:try_work/multiManager/flickMultiPlayer.dart';
import 'package:try_work/utils/mockData.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'downloadFIle.dart';

class FeedPlayer extends StatefulWidget {
  FeedPlayer({Key? key}) : super(key: key);

  @override
  _FeedPlayerState createState() => _FeedPlayerState();
}

class _FeedPlayerState extends State<FeedPlayer> {
  List items = mockData['items'];

  late FlickMultiManager flickMultiManager;

  @override
  void initState() {
    super.initState();
    flickMultiManager = FlickMultiManager();
    cacheFile();
  }

  Future<void> cacheFile() async {
    for (int x = 0; x < items.length; ++x) {
      await _downloadFile(items[x]['trailer_url'], x);
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ObjectKey(flickMultiManager),
      onVisibilityChanged: (visibility) {
        if (visibility.visibleFraction == 0 && this.mounted) {
          flickMultiManager.pause();
        }
      },
      child: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return StreamBuilder<Object>(
            stream: null,
            builder: (context, snapshot) {
              return FlickMultiPlayer(
                url: items[index]['trailer_url'],
                cachePath: items[index]["cache"],
                flickMultiManager: flickMultiManager,
                image: items[index]['image'],
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _downloadFile(String url, int index) async {
    String fileName = url.substring(url.lastIndexOf("/") + 1);
    String filePath = await getFilePath(fileName);
    await downloadFile(
      url,
      filePath: "$filePath",
      onDownloadComplete: (String? savePath) async {
        print(savePath);
        mockData['items'][index]["cache"] = savePath;
        items = mockData["items"];
        setState(() {});
      },
      onProgress: (
        int rec,
        int total,
        String precentCompletedText,
        double percentCompleteValue,
      ) {
        debugPrint("$rec $total");
      },
    );
  }
}
