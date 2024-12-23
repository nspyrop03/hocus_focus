import 'package:flutter/material.dart';
import 'package:hocus_focus/widgets/welcome_widgets.dart';

class WelcomePage extends StatefulWidget {
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final _wizardIconKey = GlobalKey<WizardIconWidgetState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SafeArea(child: PageTitleWidget(title: "Welcome to HocusFocus")),
          SizedBox(height: 20),
          NameInputFullBoxWidget(),
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
                type:"wand",
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
          CreateButtonWidget(text: 'Finish'),
        ],
      ),
    ));
  }
}
