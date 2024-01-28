import 'package:flutter/material.dart';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:provider/provider.dart';

import 'multiManager/flickMultiManager.dart';

class FeedPlayerPortraitControls extends StatelessWidget {
  const FeedPlayerPortraitControls(
      {Key? key, this.flickMultiManager, this.flickManager})
      : super(key: key);

  final FlickMultiManager? flickMultiManager;
  final FlickManager? flickManager;

  @override
  Widget build(BuildContext context) {
    FlickDisplayManager displayManager =
        Provider.of<FlickDisplayManager>(context);
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          FlickAutoHideChild(
            showIfVideoNotInitialized: false,
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: FlickLeftDuration(),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              flickManager!.flickVideoManager!.isPlaying
                  ? flickMultiManager?.pause()
                  : flickMultiManager?.play();
              displayManager.handleShowPlayerControls();
            },
            child: Container(
              padding: EdgeInsets.all(10),
              color: Colors.transparent,
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * .8,
              child: FlickAutoHideChild(
                showIfVideoNotInitialized: false,
                child: FlickTogglePlayAction(
                  togglePlay: () {
                    flickManager!.flickVideoManager!.isPlaying
                        ? flickMultiManager?.pause()
                        : flickMultiManager?.play();
                    displayManager.handleShowPlayerControls();
                  },
                  child: flickManager!.flickVideoManager!.isPlaying
                      ? Icon(Icons.pause)
                      : Icon(Icons.play_arrow_rounded),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FlickAutoHideChild(
              autoHide: true,
              showIfVideoNotInitialized: false,
              child: FlickSoundToggle(
                toggleMute: () => flickMultiManager?.toggleMute(),
                color: Colors.white,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              color: Colors.transparent,
              padding: EdgeInsets.all(10),
              child: FlickAutoHideChild(
                autoHide: true,
                showIfVideoNotInitialized: false,
                child: FlickFullScreenToggle(
                  toggleFullscreen: () => flickMultiManager?.toggleFullscreen(),
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
