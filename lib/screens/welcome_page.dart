import 'package:flutter/material.dart';
import 'package:hocus_focus/widgets/welcome_widgets.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SafeArea(
              child: PageTitleWidget(title: "Welcome to HocusFocus")
            ),
            SizedBox(height: 20),
            NameInputFullBoxWidget(),
            SizedBox(height: 50),
            ChangeAppearanceWidget(name: "Hat: ", maxSelections: 2),
            SizedBox(height: 10),
            WizardIconWidget(),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChangeAppearanceWidget(name: 'Wand:', maxSelections: 3,),
                SizedBox(width: 20),
                ChangeAppearanceWidget(name: 'Cloak: ', maxSelections: 3),
              ],
            ),
            SizedBox(height: 50,),
            CreateButtonWidget(text: 'Finish'),
          ],
        ),
      )
    );
  }
}
