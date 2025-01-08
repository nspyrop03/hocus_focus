import 'package:flutter/material.dart';
import 'package:hocus_focus/main.dart';
import 'package:hocus_focus/styles/colors.dart';
import 'package:hocus_focus/styles/styles.dart';

class MusicDropdownWidget extends StatefulWidget {
  @override
  State<MusicDropdownWidget> createState() => _MusicDropdownWidgetState();
}

class _MusicDropdownWidgetState extends State<MusicDropdownWidget> {
  String? currentTrack;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    if (audioHandler.isPlaying()) {
      currentTrack = myPlaylist.currentName;
      isPlaying = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 310,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: MyStyles.roundBox16,
              border: MyStyles.borderAll1,
              color: MyColors.primary,
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: currentTrack,
                hint: Text('Select a track', style: MyStyles.magic14),
                items: myPlaylist.urlSources.entries.map((entry) {
                  return DropdownMenuItem<String>(
                    value: entry.key,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        entry.key,
                        style: MyStyles.magic14,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newUri) {
                  if (newUri != null) {
                    myPlaylist.currentIndex =
                        myPlaylist.urlSources.keys.toList().indexOf(newUri);
                    setState(() {
                      currentTrack = newUri;
                      isPlaying = true;
                    });
                    audioHandler.play();
                  }
                },
              ),
            ),
          ),
          SizedBox(width: 10),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [MyStyles.boxShadowBasic],
            ),
            child: IconButton(
              onPressed: () {
                if (currentTrack == null) {
                  return;
                }

                if (audioHandler.isPlaying()) {
                  audioHandler.pause();
                } else {
                  audioHandler.resume();
                }

                setState(() {
                  isPlaying = !isPlaying;
                });
              },
              style: IconButton.styleFrom(
                backgroundColor: MyColors.primary,
              ),
              icon: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                color: MyColors.details,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
