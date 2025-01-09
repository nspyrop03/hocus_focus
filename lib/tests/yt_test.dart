import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

void main() {
  runApp(YoutubeMusicApp());
}

class YoutubeMusicApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: YoutubeMusicPage(),
    );
  }
}

class YoutubeMusicPage extends StatefulWidget {
  @override
  _YoutubeMusicPageState createState() => _YoutubeMusicPageState();
}

class _YoutubeMusicPageState extends State<YoutubeMusicPage> {
  late YoutubeExplode yt;
  late AudioPlayer player;
  

  @override
  void initState() {
    super.initState();
    yt = YoutubeExplode();
    player = AudioPlayer();
  }

  Future<void> playTestTrack() async {
    // Initialize the Youtube Music API
    final video = await yt.videos.get('https://www.youtube.com/watch?v=62j1xAdYKAQ');
    final manifest = await yt.videos.streamsClient.getManifest(video.id);
    final audioUrl = manifest.audioOnly.last.url;
    yt.close();
    player.play(UrlSource(audioUrl.toString()));
    //Playlist pl = await yt.playlists.get('https://www.youtube.com/playlist?list=PLFgquLnL59alCl_2TQvOiD5Vgm1hCaGSI');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Youtube Music'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text('Welcome to Youtube Music'),
            ElevatedButton(
              onPressed: playTestTrack,
              child: const Text('Play Test Track'),
            ),
            ElevatedButton(onPressed: () {
              if (player.state == PlayerState.playing) {
                player.pause();
              } else {
                player.resume();
              }
            }, child: Text("Pause/Resume")),
          ],
        ),
      ),
    );
  }
}