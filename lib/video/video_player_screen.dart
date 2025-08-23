import 'package:flutter/material.dart';
import 'package:flutter_volume_controller/flutter_volume_controller.dart';
import 'package:video_player/video_player.dart';

class VideoPlayers extends StatefulWidget {
  const VideoPlayers({super.key});

  @override
  State<VideoPlayers> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayers> {
  late VideoPlayerController _controller;
  double _volume = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _controller = VideoPlayerController.networkUrl(
    //         Uri.parse(
    //           'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    //         ),
    //       )
    _controller = VideoPlayerController.asset('assets/video/cartoon.mp4')
      ..initialize().then((value) {
        setState(() {
          _controller.play();
        });
      });
    FlutterVolumeController.getVolume().then((value) {
      setState(() {
        _volume = value!;
      });
    });

    FlutterVolumeController.addListener((value) {
      FlutterVolumeController.getVolume().then((value) {
        setState(() {
          _volume = value!;
        });
      });
    });
  }

  getFroward() async {
    final position = _controller.value.position;
    final maxVolume = _controller.value.duration;
    Duration newPosition = position + Duration(seconds: 10);
    if(newPosition >maxVolume){
      newPosition = maxVolume;
    }
    _controller.seekTo(newPosition);
  }
  getBackward() async {
    final position = _controller.value.position;
    Duration newPosition = position - Duration(seconds: 10);
    if(newPosition < Duration.zero) newPosition = Duration.zero;
    _controller.seekTo(newPosition);
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _controller.dispose();
    FlutterVolumeController.removeListener();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Video Player')),
      body: _controller.value.isInitialized
          ? Column(
        mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Center(
                  child: Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(
                                _controller.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                              ),
                              onPressed: () {
                                setState(() {
                                  _controller.value.isPlaying
                                      ? _controller.pause()
                                      : _controller.play();
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                _volume > 0
                                    ? Icons.volume_up
                                    : Icons.volume_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _controller.value.volume > 0
                                      ? FlutterVolumeController.setVolume(0)
                                      : _controller.setVolume(_volume);
                                });
                              },
                            ),
                            Slider(
                              value: _volume,
                              onChanged: (value) {
                                setState(() {
                                  _volume = value;
                                  FlutterVolumeController.setVolume(value);
                                });
                              },
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      getBackward();
                                    },
                                    // child:Icon(Icons.delivery_dining),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      getFroward();
                                    },
                                    // child: Container(color: Colors.red,),
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),

            ],

          )
          : const Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
