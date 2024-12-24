import 'package:flutter/material.dart';
import 'package:hocus_focus/sqflite_helper.dart';
import 'package:hocus_focus/widgets/welcome_widgets.dart';

class WelcomePage extends StatefulWidget {
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final _wizardIconKey = GlobalKey<WizardIconWidgetState>();
  final NameInputFullBoxWidget inputField = NameInputFullBoxWidget();

  String _formatPath(String path) {
    return path.replaceAll("assets/images/wizard/", "").replaceAll(".svg", "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false, // fixes bug when keyboard appears
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SafeArea(child: PageTitleWidget(title: "Welcome to HocusFocus")),
              SizedBox(height: 20),
              inputField,
              SizedBox(height: 50),
              ChangeAppearanceWidget(
                name: "Hat: ",
                type: "hat",
                onNext: () {
                  _wizardIconKey.currentState?.nextHat();
                },
                onPrevious: () {
                  _wizardIconKey.currentState?.previousHat();
                },
              ),
              SizedBox(height: 10),
              WizardIconWidget(key: _wizardIconKey),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ChangeAppearanceWidget(
                    name: 'Wand:',
                    type: "wand",
                    onNext: () {
                      _wizardIconKey.currentState?.nextWand();
                    },
                    onPrevious: () {
                      _wizardIconKey.currentState?.previousWand();
                    },
                  ),
                  SizedBox(width: 20),
                  ChangeAppearanceWidget(
                    name: 'Cloak: ',
                    type: "cloak",
                    onNext: () {
                      _wizardIconKey.currentState?.nextCloak();
                    },
                    onPrevious: () {
                      _wizardIconKey.currentState?.previousCloak();
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              CreateButtonWidget(
                text: 'Finish',
                inputField:
                    inputField.inputField.nameController,
                extraOnClick: () async {
                  var dbh = DatabaseHelper();
                  await dbh.createNewProfile(inputField.inputField.nameController.text);
                  var cloak = _formatPath((await dbh.getItemAssetsOfType('cloak'))[_wizardIconKey.currentState?.currentCloakIndex ?? 0]);
                  var hat = _formatPath((await dbh.getItemAssetsOfType('hat'))[_wizardIconKey.currentState?.currentHatIndex ?? 0]);
                  var wand = _formatPath((await dbh.getItemAssetsOfType('wand'))[_wizardIconKey.currentState?.currentWandIndex ?? 0]);

                  await dbh.updateItemBought(cloak);
                  await dbh.updateItemBought(hat);
                  await dbh.updateItemBought(wand);
                  
                  print("Created new profile with items!");
                },
              ),
            ],
          ),
        ));
  }
}
