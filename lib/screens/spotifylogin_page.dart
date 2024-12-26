import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const SpotifyTestApp());
}

class SpotifyTestApp extends StatelessWidget {
  const SpotifyTestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SpotifyLoginPage(),
    );
  }
}

class SpotifyLoginPage extends StatefulWidget {
  @override
  _SpotifyLoginPageState createState() => _SpotifyLoginPageState();
}

class _SpotifyLoginPageState extends State<SpotifyLoginPage> {
  bool isLoggedIn = false;
  String? accessToken;
  Map<String, dynamic>? playlist;

  Future<String?> getAuth(String clientId, String redirectUri, String scopes) async {
    const callbackUrlScheme = 'yourapp';
    try {
      // Authenticate the user via Spotify OAuth
      final result = await FlutterWebAuth.authenticate(
        url:
            'https://accounts.spotify.com/authorize?response_type=token&client_id=$clientId&redirect_uri=$redirectUri&scope=$scopes',
        callbackUrlScheme: callbackUrlScheme,
      );

      // Extract the access token from the result URL
      final token = Uri.parse(result).fragment
          .split('&')
          .firstWhere((e) => e.startsWith('access_token='))
          .replaceFirst('access_token=', '');

      return token;
    } catch (e) {
      debugPrint("Error during authentication: $e");
      return null;
    }
  }

  Future<void> fetchPlaylist() async {
    final playlistId = '1AHqFa5s7htrcfWzHx4Bob?si=ec4ff63a79ae4d64'; // Replace with your playlist ID
    final response = await http.get(
      Uri.parse('https://api.spotify.com/v1/playlists/$playlistId'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        playlist = json.decode(response.body);
      });
    } else {
      print('Failed to fetch playlist');
    }
  }

  void loginToSpotify() async {
    // Replace with your actual clientId, redirectUri, and scopes
    String clientId = '86d93d4d00a444aca1320485a4dd2a6f';
    String redirectUri = 'yourapp://callback';
    String scopes = 'user-read-private user-read-email playlist-read-private';

    accessToken = await getAuth(clientId, redirectUri, scopes);
    if (accessToken != null) {
      setState(() {
        isLoggedIn = true;
      });
      print('Logged in with token: $accessToken');
      await fetchPlaylist();
    } else {
      print('Failed to log in');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spotify Login'),
      ),
      body: Center(
        child: isLoggedIn
            ? playlist != null
                ? ListView.builder(
                    itemCount: playlist!['tracks']['items'].length,
                    itemBuilder: (context, index) {
                      final track = playlist!['tracks']['items'][index]['track'];
                      return ListTile(
                        title: Text(track['name']),
                        subtitle: Text(track['artists'][0]['name']),
                      );
                    },
                  )
                : CircularProgressIndicator()
            : ElevatedButton(
                onPressed: loginToSpotify,
                child: Text('Login to Spotify'),
              ),
      ),
    );
  }
}





/*
void main() {
  runApp(const SpotifyTestApp());
}

class SpotifyTestApp extends StatelessWidget {
  const SpotifyTestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SpotifyLoginPage(),
    );
  }
}

class SpotifyLoginPage extends StatefulWidget {
  @override
  _SpotifyLoginPageState createState() => _SpotifyLoginPageState();
}

class _SpotifyLoginPageState extends State<SpotifyLoginPage> {
  bool isLoggedIn = false;
  String? accessToken;

  Future<String?> getAuth(String clientId, String redirectUri, String scopes) async {
    const callbackUrlScheme = 'yourapp';

    try {
      // Authenticate the user via Spotify OAuth
      final result = await FlutterWebAuth.authenticate(
        url:
            'https://accounts.spotify.com/authorize?response_type=token&client_id=$clientId&redirect_uri=$redirectUri&scope=$scopes',
        callbackUrlScheme: callbackUrlScheme,
      );

      // Extract the access token from the result URL
      final token = Uri.parse(result).fragment
          .split('&')
          .firstWhere((e) => e.startsWith('access_token='))
          .replaceFirst('access_token=', '');

      return token;
    } catch (e) {
      debugPrint("Error during authentication: $e");
      return null;
    }
  }

  Future<void> loginToSpotify() async {
    const clientId = '86d93d4d00a444aca1320485a4dd2a6f'; // Replace with your Spotify Client ID
    const redirectUri = 'yourapp://callback'; // Replace with your Redirect URI
    const scopes = 'user-modify-playback-state user-read-playback-state streaming';

    // Step 1: Use getAuth to get the access token
    final token = await getAuth(clientId, redirectUri, scopes);

    if (token != null) {
      setState(() {
        accessToken = token;
        isLoggedIn = true;
      });
    } else {
      debugPrint("Authentication failed or cancelled");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spotify Login'),
      ),
      body: Center(
        child: isLoggedIn
            ? Text('Logged in with token: $accessToken')
            : ElevatedButton(
                onPressed: loginToSpotify,
                child: Text('Login to Spotify'),
              ),
      ),
    );
  }
}
*/