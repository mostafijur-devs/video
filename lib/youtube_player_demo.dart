import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubePlayerDemo extends StatefulWidget {
  const YouTubePlayerDemo({super.key});

  @override
  _YouTubePlayerDemoState createState() => _YouTubePlayerDemoState();
}

class _YouTubePlayerDemoState extends State<YouTubePlayerDemo> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    // YouTube ভিডিওর লিঙ্ক থেকে ID বের করতে হবে
    const videoUrl = "https://www.youtube.com/watch?v=HfHfU71Crr8&ab_channel=ETechViral";
    final videoId = YoutubePlayer.convertUrlToId(videoUrl);

    _controller = YoutubePlayerController(
      initialVideoId: videoId!,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,

      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
    // _controller.updateValue(YoutubePlayerValue().);
    // YoutubePlayerValue().isPlaying ? _controller.pause() : _controller.play();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("YouTube Player Example")),
      body: Center(
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          bottomActions: [
            CurrentPosition(),
            ProgressBar(isExpanded: true),
            RemainingDuration(),
            PlaybackSpeedButton(),
          ],

          topActions: [


          ],
        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying ? _controller.pause() : _controller.play();
            
          });

        },
        child: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
      ),
    );
  }
}
