// ignore: file_names
import 'package:flutter/material.dart';
import 'package:sultan_farm_mobile/Theme.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class VideoPlayerRtmp extends StatefulWidget {
  const VideoPlayerRtmp({super.key});

  @override
  State<VideoPlayerRtmp> createState() => _VideoPlayerRtmpState();
}

class _VideoPlayerRtmpState extends State<VideoPlayerRtmp> {
  late VlcPlayerController _videoPlayer;
  bool isDataLoading = true;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  void _initializePlayer() {
    _videoPlayer = VlcPlayerController.network(
      'rtmp://103.210.69.14/live/abcd',
      hwAcc: HwAcc.full,
      autoPlay: true,
      options: VlcPlayerOptions(),
    );

    // Listen to the player events to track when data loading is complete
    _videoPlayer.addListener(() {
      Future.delayed(const Duration(seconds: 5), () {
        if (_videoPlayer.value.isInitialized && isDataLoading) {
          // Data loading is complete
          setState(() {
            isDataLoading = false;
          });
        }
      });
    });
  }

  // final VlcPlayerController _videoPlayer = VlcPlayerController.network(
  //   'rtmp://103.210.69.14/live/abcd',
  //   hwAcc: HwAcc.full,
  //   autoPlay: true,
  //   options: VlcPlayerOptions(),
  // );

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   color: whiteColor,
    //   child: isDataLoading
    //       ? Center(
    //           child: CircularProgressIndicator(
    //             color: bluetogreenColor,
    //           ),
    //         )
    //       : VlcPlayer(
    //           controller: _videoPlayer,
    //           aspectRatio: 16 / 9,
    //           placeholder: isDataLoading
    //               ? Center(
    //                   child: CircularProgressIndicator(
    //                     color: bluetogreenColor,
    //                   ),
    //                 )
    //               : Center(
    //                   child: Text(
    //                     "Streaming Sedang Mati",
    //                     style: blackTextStyle.copyWith(
    //                         fontSize: 14,
    //                         fontWeight: semiBold,
    //                         letterSpacing:
    //                             1), // Customize the text style as needed
    //                   ),
    //                 ),
    //         ),
    // );
    return Stack(
      children: [
        VlcPlayer(
          controller: _videoPlayer,
          aspectRatio: 16 / 9,
          placeholder: isDataLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: bluetogreenColor,
                  ),
                )
              : Center(
                  child: Text(
                    "Streaming Sedang Mati",
                    style: blackTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: semiBold,
                        letterSpacing: 1), // Customize the text style as needed
                  ),
                ),
        ),
        if (isDataLoading)
          Positioned.fill(
            child: Center(
              child: CircularProgressIndicator(
                color: bluetogreenColor,
              ),
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _videoPlayer.dispose();
    super.dispose();
  }
}
