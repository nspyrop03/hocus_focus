import 'package:flutter/material.dart';
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
        ));
  }
}
