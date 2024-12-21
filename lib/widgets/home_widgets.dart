import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hocus_focus/styles/colors.dart';
import 'package:hocus_focus/styles/styles.dart';

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

