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
            NameInputFullBoxWidget(),
            SizedBox(height: 20),
            ChangeAppearanceWidget(name: 'Wand:', maxSelections: 3,),
          ],
        ),
      )
    );
  }
}
