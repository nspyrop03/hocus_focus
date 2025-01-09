import 'package:flutter/material.dart';
import 'package:hocus_focus/widgets/bar_widgets.dart';
import 'package:hocus_focus/widgets/shop_widgets.dart';
import 'package:hocus_focus/widgets/welcome_widgets.dart';


class ShopPageLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
            child: PageTitleWidget(title: "Shop"),
          ),
          Expanded(
            child: ShopWidgets(),
          ),
        
      ],
    );
  }
}


class ShopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopBarWidget(),
          SafeArea(
            child: PageTitleWidget(title: "Shop"),
          ),
          Expanded(
            child: ShopWidgets(),
          ),
        ],
      ),
    );
  }
}

      

