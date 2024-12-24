import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hocus_focus/sqflite_helper.dart';
import 'package:hocus_focus/styles/colors.dart';
import 'package:hocus_focus/styles/styles.dart';
import '../cache.dart' as cache;

class TopBarWidget extends StatelessWidget {
  Future waitForData() async {
    var dbh = DatabaseHelper();
    var exp = await dbh.getProfileExp();
    var coins = await dbh.getProfileCoins();
    print("$exp, $coins");
    return {"exp": exp, "coins": coins};
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: waitForData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Container(
              height: 55,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: MyStyles.topBox,
                boxShadow: [MyStyles.boxShadowBasic],
                color: MyColors.primary,
                border: MyStyles.borderAll1,
              ),
            );
          } else {
            return Container(
              width: MediaQuery.of(context).size.width,
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
                    child: LevelBarWidget(
                        level: (snapshot.data['exp'] ~/ 10) + 1,
                        exp: snapshot.data['exp']),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: CoinsWidget(coins: snapshot.data['coins']),
                  ),
                ],
              ),
            );
          }
        });
  }
}

class BottomBarWidget extends StatelessWidget {
  final Function(int) onPressed;

  const BottomBarWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: MyStyles.bottomBox,
        boxShadow: [MyStyles.boxShadowBasic],
        color: MyColors.primary,
        border: MyStyles.borderAll1,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          NavBarButton(
            iconPath: 'assets/images/nav_icons/ShopIcon.svg',
            width: 24,
            height: 22,
            index: 0,
            onPressed: onPressed,
          ),
          NavBarButton(
            iconPath: 'assets/images/nav_icons/BookVector.svg',
            width: 27,
            height: 23,
            index: 1,
            onPressed: onPressed,
          ),
          NavBarButton(
            iconPath: 'assets/images/nav_icons/HomeVector.svg',
            width: 29,
            height: 30,
            index: 2,
            onPressed: onPressed,
          ),
          NavBarButton(
            iconPath: 'assets/images/nav_icons/CalendarVector.svg',
            width: 21,
            height: 22,
            index: 3,
            onPressed: onPressed,
          ),
          NavBarButton(
            iconPath: 'assets/images/nav_icons/ToDoListVector.svg',
            width: 23,
            height: 18,
            index: 4,
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}

class NavBarButton extends StatelessWidget {
  final String iconPath;
  final double width;
  final double height;
  final Function(int) onPressed;
  final int index;

  NavBarButton(
      {super.key,
      required this.iconPath,
      required this.width,
      required this.height,
      required this.index,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 43,
      height: 43,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [MyStyles.boxShadowBasic],
          color: MyColors.tertiary,
          border: MyStyles.borderAll1),
      child: IconButton(
        onPressed: () {
          print("Pressed NavBarButton");
          onPressed(index);
          cache.currentClock.value?.updateClock();
        },
        icon: SvgPicture.asset(iconPath, width: width, height: height),
      ),
    );
  }
}

class LevelBarWidget extends StatelessWidget {
  final int level;
  final int exp;
  static const double maxWidth = 190.0;
  static const double height = 17.0;

  const LevelBarWidget({super.key, required this.level, required this.exp});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
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
