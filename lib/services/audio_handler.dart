import 'package:audio_service/audio_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class MyAudioHandler extends BaseAudioHandler {
  final _player = AudioPlayer();
  final MyPlaylist playlist;

  MyAudioHandler({required this.playlist});

  @override
  Future<void> play() => _player.play(playlist.currentUrlSource);

  bool isPlaying() {
    return _player.state == PlayerState.playing;
  }

  Future<void> next() {
    playlist.next();
    return play();
  }

  Future<void> previous() {
    playlist.previous();
    return play();
  }

  Future<void> resume() => _player.resume();

  @override
  Future<void> pause() => _player.pause();
  
  @override
  Future<void> stop() => _player.stop();
}

class MyPlaylist {
  final Map<String, String> _playlist = {
    'Rivendell Ambience': 'https://www.youtube.com/watch?v=62j1xAdYKAQ',
    'Winterfell Ambience': 'https://www.youtube.com/watch?v=_N-IREy7C9s',
    'Hogwarts Ambience': 'https://www.youtube.com/watch?v=BQrxsyGTztM',
  };
  Map<String, UrlSource> _urlSource = {};
  int currentIndex = 0;

  Future<void> initUrlSources() async {
    final yt = YoutubeExplode();
    for (final entry in _playlist.entries) {
      final video = await yt.videos.get(entry.value);
      final manifest = await yt.videos.streamsClient.getManifest(video.id);
      final audioUrl = manifest.audioOnly.last.url;
      _urlSource[entry.key] = UrlSource(audioUrl.toString());
    }
    yt.close();
  }
  void next() => currentIndex = (currentIndex + 1) % _playlist.length;
  void previous() => currentIndex = (currentIndex - 1) % _playlist.length;
  UrlSource get currentUrlSource => _urlSource.values.elementAt(currentIndex);
  String get currentName => _urlSource.keys.elementAt(currentIndex);
  Map<String, UrlSource> get urlSources => _urlSource;
}