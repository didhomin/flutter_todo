import 'package:flutter/material.dart';
import 'menu/app_menu_drawer.dart';

class PageContainer extends StatelessWidget {

  final String pageTitle;
  final Widget body;
  final bool isMenu;

  const PageContainer({
    Key? key,
    required this.pageTitle,
    required this.body,
    this.isMenu = true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Container(
        //   height: MediaQuery.of(context).size.height,
        //   width: MediaQuery.of(context).size.width,
        //   color: Theme.of(context).backgroundColor,
        // ),
        Scaffold(
          appBar: AppBar(
            // brightness: Brightness.light,
            // backgroundColor: Colors.transparent,
            // elevation: 0.0,
            title: Text(pageTitle),
            // textTheme: Theme.of(context).primaryTextTheme,
            // actions: <Widget>[
            //   AppBarCartIcon(),
            // ],
          ),
          drawer: isMenu ? AppMenu() : null,
          body: body,
        ),
      ],
    );
  }
}
