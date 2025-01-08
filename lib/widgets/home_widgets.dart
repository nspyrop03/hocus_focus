import 'package:flutter_svg/svg.dart';
import 'package:hocus_focus/styles/colors.dart';
import 'package:hocus_focus/styles/styles.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
/*
String? refreshToken;
String? accessToken;
String clientId = '86d93d4d00a444aca1320485a4dd2a6f';
String clientSecret =
    'efd4de52231548bc8d56ac15949dfee4'; // Store securely, avoid hardcoding
String redirectUri = 'yourapp://callback';

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
    if (accessToken == null) {
      print('Access token is null, cannot fetch playlist');
      return;
    }

    final playlistId =
        '73DM1FCc2XQuDev81lKbK1'; // Replace with your actual playlist ID
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
                  'uri': item['track']['uri'] as String,
                })
            .toList();
      });
      print('Playlist fetched successfully: ${tracks.length} tracks found.');
    } else {
      print('Failed to fetch playlist: ${response.body}');
    }
  }

  Future<void> playTrack(String trackUri) async {
    await _refreshToken(); // Refresh token before making the request
    final response = await http.put(
      Uri.parse('https://api.spotify.com/v1/me/player/playdevice_id= +this._device_id'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'uris': [trackUri]
      }),
    );

    if (response.statusCode == 204) {
      print('Track is now playing!');
    } else {
      print('Failed to play track: ${response.body}');
    }
  }

  Future<void> loginToSpotify() async {
    const callbackUrlScheme = 'yourapp';
    try {
      final result = await FlutterWebAuth.authenticate(
        url: 'https://accounts.spotify.com/authorize'
            '?response_type=code'
            '&client_id=$clientId'
            '&redirect_uri=$redirectUri'
            '&scope=user-read-private user-read-email '
            'playlist-read-private streaming '
            'user-modify-playback-state '
            'app-remote-control '
            'user-read-playback-state user-read-currently-playing',
        callbackUrlScheme: callbackUrlScheme,
      );

      final authCode = Uri.parse(result).queryParameters['code'];
      if (authCode != null) {
        await _exchangeCodeForToken(authCode);
        if (accessToken != null) {
          await fetchPlaylist(); //  Fetch playlist immediately after successful login
        }
      }
    } catch (e) {
      print('Error during authentication: $e');
    }
  }

  Future<void> _exchangeCodeForToken(String code) async {
    final response = await http.post(
      Uri.parse('https://accounts.spotify.com/api/token'),
      headers: {
        'Authorization':
            'Basic ${base64Encode(utf8.encode('$clientId:$clientSecret'))}',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'grant_type': 'authorization_code',
        'code': code,
        'redirect_uri': redirectUri,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      accessToken = data['access_token'];
      refreshToken = data['refresh_token'];
      if (accessToken != null) {
        print('Successfully logged in! Token obtained. ' + accessToken!);
      } else {
        print('Failed to obtain access token.');
      }
    } else {
      print('Failed to exchange code for token: ${response.body}');
    }
  }

  Future<void> _refreshToken() async {
    if (refreshToken == null) {
      print('No refresh token available.');
      return;
    }

    final response = await http.post(
      Uri.parse('https://accounts.spotify.com/api/token'),
      headers: {
        'Authorization':
            'Basic ${base64Encode(utf8.encode('$clientId:$clientSecret'))}',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'grant_type': 'refresh_token',
        'refresh_token': refreshToken!,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      accessToken = data['access_token'];
      print('Token refreshed successfully!');
    } else {
      print('Failed to refresh token: ${response.body}');
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
                      playTrack(
                          newUri); // ✅ Play track immediately after selection
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
*/