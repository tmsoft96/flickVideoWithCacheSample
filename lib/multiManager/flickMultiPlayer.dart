import 'dart:io';

import 'package:flick_video_player/flick_video_player.dart';

import 'package:flutter/material.dart';
import 'package:try_work/cachedImage.dart';
import 'package:try_work/multiManager/flickMultiManager.dart';
import 'package:try_work/portraitControls.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:video_player/video_player.dart';

class FlickMultiPlayer extends StatefulWidget {
  const FlickMultiPlayer(
      {Key? key,
      required this.url,
      required this.cachePath,
      this.image,
      required this.flickMultiManager})
      : super(key: key);

  final String url;
  final String? cachePath;
  final String? image;
  final FlickMultiManager flickMultiManager;

  @override
  _FlickMultiPlayerState createState() => _FlickMultiPlayerState();
}

class _FlickMultiPlayerState extends State<FlickMultiPlayer> {
  FlickManager? flickManager;

  Future<void> _initFlickManager() async {
    if (widget.cachePath != null) {
      bool isExit = await File(widget.cachePath!).exists();
      if (isExit) {
        flickManager = FlickManager(
          videoPlayerController:
              VideoPlayerController.file(File(widget.cachePath!))
                ..setLooping(true),
          autoPlay: true,
        );
        setState(() {});
        widget.flickMultiManager.init(flickManager!);
        return;
      }
    }

    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(widget.url)
        ..setLooping(true),
      autoPlay: true,
    );
    widget.flickMultiManager.init(flickManager!);
  }

  @override
  void initState() {
    _initFlickManager();
    super.initState();
  }

  @override
  void dispose() {
    widget.flickMultiManager.remove(flickManager!);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return flickManager == null
        ? Positioned.fill(
            child: cachedImage(
              image: widget.image!,
              fit: BoxFit.cover,
              context: context,
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
            ),
          )
        : VisibilityDetector(
            key: ObjectKey(flickManager),
            onVisibilityChanged: (visiblityInfo) {
              if (visiblityInfo.visibleFraction > 0.9) {
                widget.flickMultiManager.play(flickManager);
              }
            },
            child: FlickVideoPlayer(
              flickManager: flickManager!,
              flickVideoWithControls: FlickVideoWithControls(
                playerLoadingFallback: Positioned.fill(
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: cachedImage(
                          image: widget.image!,
                          fit: BoxFit.cover,
                          context: context,
                          height: MediaQuery.of(context).size.width,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                      Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          strokeWidth: 4,
                        ),
                      ),
                    ],
                  ),
                ),
                playerErrorFallback: Stack(
                  children: [
                    Center(
                      child: Text(
                        "No internet scroll down to view offline data",
                      ),
                    ),
                  ],
                ),
                controls: FeedPlayerPortraitControls(
                  flickMultiManager: widget.flickMultiManager,
                  flickManager: flickManager,
                ),
              ),
              flickVideoWithControlsFullscreen: FlickVideoWithControls(
                playerLoadingFallback: Center(
                  child: cachedImage(
                    image: widget.image!,
                    fit: BoxFit.cover,
                    context: context,
                    height: MediaQuery.of(context).size.width,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                controls: FlickLandscapeControls(),
                iconThemeData: IconThemeData(
                  size: 40,
                  color: Colors.white,
                ),
                textStyle: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          );
  }
}
