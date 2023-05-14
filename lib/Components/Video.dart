import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Video extends StatefulWidget {
  const Video({super.key});

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  YoutubePlayerController? _controller;
  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: '8U6rdI_uG2c',
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        isLive: false,
        forceHD: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller!,
        showVideoProgressIndicator: true,
      ),
      builder: (context, player) {
        return Scaffold(
            body: Container(
          height: double.infinity,
          width: double.infinity,
          child: player,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
        ));
      },
    );
  }
}
