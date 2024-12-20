import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hocus_focus/styles/colors.dart';
import 'package:hocus_focus/styles/styles.dart';

class TopBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator UpbarWidget - COMPONENT
    return Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          borderRadius: MyStyles.topBox,
          boxShadow: [MyStyles.boxShadowBasic],
          color: MyColors.primary,
          border: MyStyles.borderAll1,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: LevelBarWidget(level: 42, exp: 100),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: CoinsWidget(coins: 100000000),
            ),
          ],
        ),);
  }
}

class LevelBarWidget extends StatelessWidget {
  final int level;
  final double exp;
  static const double maxWidth = 190.0;
  static const double height = 17.0;

  const LevelBarWidget({super.key, required this.level, required this.exp});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
      Text(
        'Level: $level',
        style: MyStyles.magic14,
        textAlign: TextAlign.left,
      ),
      SizedBox(width: 10),
      Stack(children: [
        Container(
          // Level bar background
          width: maxWidth,
          height: height,
          decoration: BoxDecoration(
            borderRadius: MyStyles.roundBox8,
            boxShadow: [MyStyles.boxShadowBasic],
            color: MyColors.secondary,
          ),
        ),
        Container(
          // Level bar foreground
          width: maxWidth * exp / (level * 10),
          height: height,
          decoration: BoxDecoration(
            borderRadius: MyStyles.roundBox8,
            color: MyColors.tertiary,
          ),
        ),
        Container(
          // Level bar outline
          width: maxWidth,
          height: height,
          decoration: BoxDecoration(
            borderRadius: MyStyles.roundBox8,
            border: Border.all(
              color: MyColors.details,
              width: 1,
            ),
          ),
        ),
      ]),
    ]);
  }
}

class CoinsWidget extends StatelessWidget {
  final int coins;

  const CoinsWidget({super.key, required this.coins});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$coins',
          style: MyStyles.magic14,
          textAlign: TextAlign.right,
        ),
        SizedBox(width: 5),
        SvgPicture.asset('assets/images/coin.svg', width: 21, height: 21),
      ],
    );
  }
}