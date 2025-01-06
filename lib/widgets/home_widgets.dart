import 'package:flutter_svg/svg.dart';
import 'package:hocus_focus/styles/colors.dart';
import 'package:hocus_focus/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:app_links/app_links.dart';


/*works if you open spotify app manually first*/
class SpotifyDropdownWidget extends StatefulWidget {
  @override
  State<SpotifyDropdownWidget> createState() => _SpotifyDropdownWidgetState();
}

class _SpotifyDropdownWidgetState extends State<SpotifyDropdownWidget> {
  String? selectedTrackUri; // Use track URI for playback
  List<Map<String, String>> tracks = []; // Store track name and URI
  String? accessToken;

  Future<String?> getAuth(
      String clientId, String redirectUri, String scopes) async {
    const callbackUrlScheme = 'yourapp';
    try {
      final result = await FlutterWebAuth.authenticate(
        url:
            'https://accounts.spotify.com/authorize?response_type=token&client_id=$clientId&redirect_uri=$redirectUri&scope=$scopes',
        callbackUrlScheme: callbackUrlScheme,
      );

      final token = Uri.parse(result)
          .fragment
          .split('&')
          .firstWhere((element) => element.startsWith('access_token'))
          .split('=')
          .last;
      return token;
    } catch (e) {
      print('Error during authentication: $e');
      return null;
    }
  }

  Future<void> fetchPlaylist() async {
    final playlistId = '0bFM9BJW82tIZvdShJo8Xv'; // Replace with your actual playlist ID
    final response = await http.get(
      Uri.parse('https://api.spotify.com/v1/playlists/$playlistId'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final playlist = json.decode(response.body);
      setState(() {
        tracks = (playlist['tracks']['items'] as List)
            .map((item) => {
                  'name': item['track']['name'] as String,
                  'uri': item['track']['uri'] as String, // Track URI
                })
            .toList();
      });
    } else {
      print('Failed to fetch playlist: ${response.body}');
    }
  }

  Future<void> playTrack(String trackUri) async {
    final response = await http.put(
      Uri.parse('https://api.spotify.com/v1/me/player/play'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'uris': [trackUri], // Use the track URI for playback
      }),
    );

    if (response.statusCode == 204) {
      print('Track is now playing!');
    } else {
      print('Failed to play track: ${response.body}');
    }
  }

  void loginToSpotify() async {
    String clientId = '86d93d4d00a444aca1320485a4dd2a6f';
    String redirectUri = 'yourapp://callback';
    String scopes =
        'user-read-private user-read-email playlist-read-private streaming user-modify-playback-state';

    accessToken = await getAuth(clientId, redirectUri, scopes);
    if (accessToken != null) {
      print('Logged in with token: $accessToken');
      await fetchPlaylist();
    } else {
      print('Failed to log in');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Add a scrollable container
      child: Padding(
        padding:
            const EdgeInsets.all(16.0), // Add padding to avoid tight spacing
        child: Column(
          children: [
            GestureDetector(
              onTap: loginToSpotify,
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/SpotifyIcon.svg',
                    width: 24,
                    height: 24,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Login to Spotify',
                      style: MyStyles.magic14,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              width: 358,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: MyStyles.roundBox16,
                border: MyStyles.borderAll1,
                color: MyColors.primary,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: selectedTrackUri,
                  hint: Text('Select a track', style: MyStyles.magic14),
                  items: tracks.map((track) {
                    return DropdownMenuItem<String>(
                      value: track['uri'],
                      child: Text(
                        track['name']!,
                        style: MyStyles.magic14,
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newUri) {
                    setState(() {
                      selectedTrackUri = newUri;
                    });
                    if (newUri != null) {
                      playTrack(newUri);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}













/*
class SpotifyDropdownWidget extends StatefulWidget {
  @override
  State<SpotifyDropdownWidget> createState() => _SpotifyDropdownWidgetState();
}

class _SpotifyDropdownWidgetState extends State<SpotifyDropdownWidget> {
  String? selectedTrack;
  final List<String> tracks = [
    'Track 1',
    'Track 2',
    'Track 3',
    'Track 4',
    'Track 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 358,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: MyStyles.roundBox16,
        border: MyStyles.borderAll1,
        color: MyColors.primary,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
            value: selectedTrack,
            hint: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: SpotifyLabelWidget(label: 'Select a track'),
            ),
            isExpanded: true,
            icon: Icon(Icons.arrow_drop_down),
            onChanged: (String? newValue) {
              setState(() {
                selectedTrack = newValue;
              });
            },
            items: tracks.map<DropdownMenuItem<String>>((String track) {
              return DropdownMenuItem<String>(
                value: track,
                child: Text(
                  track,
                  style: MyStyles.magic14,
                ),
              );
            }).toList(),
            selectedItemBuilder: (BuildContext context) {
              return tracks.map<Widget>((String track) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: SpotifyLabelWidget(label: track),
                );
              }).toList();
            },
            dropdownColor: MyColors.primary,
            menuWidth: double.infinity),
      ),
    );
  }
}

class SpotifyLabelWidget extends StatelessWidget {
  final String label;

  const SpotifyLabelWidget({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/images/SpotifyIcon.svg',
          width: 24,
          height: 24,
        ),
        SizedBox(width: 8),
        Text(
          label,
          style: MyStyles.magic14,
        ),
      ],
    );
  }
}
*/