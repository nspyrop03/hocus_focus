import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hocus_focus/sqflite_helper.dart';
import 'package:hocus_focus/styles/styles.dart';

const double _offsetX = 12.0;
const double _offsetY = 0.0;

class WizardIconWidget extends StatefulWidget {
  final Key? key;

  WizardIconWidget({this.key}) : super(key: key);

  @override
  State<WizardIconWidget> createState() => WizardIconWidgetState();
}

class WizardIconWidgetState extends State<WizardIconWidget> {
  //final double _offsetX = 12.0;
  //final double _offsetY = 0.0;

  int currentCloakIndex = 0;
  int currentHatIndex = 0;
  int currentWandIndex = 0;

  void nextCloak() {
    setState(() {
      currentCloakIndex += 1;
    });
  }

  void previousCloak() {
    setState(() {
      currentCloakIndex -= 1;
    });
  }

  void nextHat() {
    setState(() {
      currentHatIndex += 1;
    });
  }

  void previousHat() {
    setState(() {
      currentHatIndex -= 1;
    });
  }

  void nextWand() {
    print("Next wand");
    setState(() {
      currentWandIndex += 1;
    });
  }

  void previousWand() {
    setState(() {
      currentWandIndex -= 1;
    });
  }

  Future waitForData() async {
    var myCloaks = await DatabaseHelper().getWizardAssetsOfType('cloak');
    var myHats = await DatabaseHelper().getWizardAssetsOfType('hat');
    var myWands = await DatabaseHelper().getWizardAssetsOfType('wand');
    //print('Cloaks: $myCloaks');
    return {"cloaks": myCloaks, "hats": myHats, "wands": myWands};
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:
            waitForData(), // I think it works now... ARE YOU FCKING KIDDING ME!!?
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Container(
                width: 148,
                height: 168,
                decoration: BoxDecoration(
                  //border: MyStyles.borderAll1, // debug
                ),
                child: Center(child: CircularProgressIndicator()));
          } else {
            if (snapshot.hasError) {
              print(snapshot.error);
              return Container(
                width: 148,
                height: 168,
                decoration: BoxDecoration(
                  //border: MyStyles.borderAll1,
                ),
              );
            } else {
              return Container(
                width: 148,
                height: 168,
                decoration: BoxDecoration(
                  //border: MyStyles.borderAll1, //debug
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: _offsetY + 40,
                      left: _offsetX,
                      child: SvgPicture.asset(
                        snapshot.data['cloaks'][currentCloakIndex],
                        width: 148,
                        height: 168,
                      ),
                    ),
                    Positioned(
                      top: _offsetY,
                      left: _offsetX + 2.5,
                      child: SvgPicture.asset(
                        snapshot.data['hats'][currentHatIndex],
                        width: 148,
                        height: 168,
                      ),
                    ),
                    Positioned(
                      top: _offsetY + 18,
                      left: _offsetX + 48,
                      child: SvgPicture.asset(
                        snapshot.data['wands'][currentWandIndex],
                        width: 148,
                        height: 168,
                      ),
                    ),
                  ],
                ),
              );
            }
          }
        });
  }
}

class WizardHomeWidget extends StatelessWidget {
  Future waitForData() async {
    var dbh = DatabaseHelper();
    var cloak = await dbh.getSelectedCloakPath();
    var hat = await dbh.getSelectedHatPath();
    var wand = await dbh.getSelectedWandPath();
    print("Got paths!\n$cloak\n$hat\n$wand");
    var pr = await dbh.getProfiles();
    print("$pr");
    return {"cloak": cloak, "hat": hat, "wand": wand};
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: waitForData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Container(
                width: 148,
                height: 168,
                decoration: BoxDecoration(
                  //border: MyStyles.borderAll1,
                ),
                child: Center(child: CircularProgressIndicator()));
          } else {
            if (snapshot.hasError) {
              print(snapshot.error);
              return Container(
                width: 148,
                height: 168,
                decoration: BoxDecoration(
                  //border: MyStyles.borderAll1,
                ),
              );
            } else {
              return Container(
                width: 148,
                height: 168,
                decoration: BoxDecoration(
                  //border: MyStyles.borderAll1, //debug
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: _offsetY + 40,
                      left: _offsetX,
                      child: SvgPicture.asset(
                        snapshot.data['cloak'],
                        width: 148,
                        height: 168,
                      ),
                    ),
                    Positioned(
                      top: _offsetY,
                      left: _offsetX + 2.5,
                      child: SvgPicture.asset(
                        snapshot.data['hat'],
                        width: 148,
                        height: 168,
                      ),
                    ),
                    Positioned(
                      top: _offsetY + 18,
                      left: _offsetX + 48,
                      child: SvgPicture.asset(
                        snapshot.data['wand'],
                        width: 148,
                        height: 168,
                      ),
                    ),
                  ],
                ),
              );
            }
          }
        });
  }
}
