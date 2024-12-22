import 'package:flutter/material.dart';
import 'package:hocus_focus/styles/colors.dart';
import 'package:hocus_focus/styles/styles.dart';
import 'package:hocus_focus/widgets/bar_widgets.dart';
import 'package:hocus_focus/widgets/shop_widgets.dart';
import 'package:hocus_focus/widgets/welcome_widgets.dart';



class ShopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold( 
      body: Column(
        children: [
          TopBarWidget(), 
          SafeArea(
            child: PageTitleWidget(title: "Shop"),
          ),
          Component2Widget()
        ]
      )
    );
  }
}

      

