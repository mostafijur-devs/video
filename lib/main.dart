import 'package:flutter/material.dart';
import 'package:quran/quran_model.dart';
import 'package:quran/video/video_player_screen.dart';
import 'package:quran/youtube_player_demo.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
// import 'package:quran/youtube_player_demo.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: VideoPlayers(),
  ));
}
class OpenYoutubeScreen extends StatelessWidget {

  // final String videoUrl;

  const OpenYoutubeScreen({Key? key}) : super(key: key);

  Future<void> _launchUrl(Uri url) async {
    await launchUrlString(url.toString());


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Open YouTube'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            final Uri url = Uri.parse('https://www.youtube.com/results?search_query=4k+video');
            _launchUrl(url);
          },
          child: const Text('Open YouTube Video'),
        ),
      ),
    );
  }
}
