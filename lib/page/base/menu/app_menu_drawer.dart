import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/blocs/auth/authentication_bloc.dart';
import 'package:flutter_app/util/routes_paths.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class AppMenu extends StatefulWidget {
  @override
  AppMenuState createState() => AppMenuState();
}

class AppMenuState extends State<AppMenu> with RouteAware {
  String? _activeRoute;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPush() {
    var modalRoute = ModalRoute.of(context);
    if(modalRoute != null) {
      _activeRoute = modalRoute.settings.name.toString();
    }
  }

  Future _navigate(String route) async {
    await Navigator.pushReplacementNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    _activeRoute??='/';

    var user = BlocProvider.of<AuthenticationBloc>(context).state.user;
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: Text(user.id),
            accountName: Text(user.nickname??'')
          ),
          // ListTile(
          //   leading: Icon(Icons.person),
          //   title: Text("회원목록"),
          //   selected: _activeRoute == RoutesPaths.homePage,
          //   onTap: () => _navigate(RoutesPaths.homePage),
          // ),
          ListTile(
            leading: Icon(Icons.fact_check),
            title: Text("할일목록"),
            selected: _activeRoute == RoutesPaths.todoListPage,
            onTap: () => _navigate(RoutesPaths.todoListPage),
          ),
          ListTile(
            leading: Icon(Icons.fact_check),
            title: Text("root"),
            selected: _activeRoute == RoutesPaths.rootPage,
            onTap: () => _navigate(RoutesPaths.rootPage),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("logOut"),
            onTap: () => {
              BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationLogOutRequested()),
              _navigate(RoutesPaths.loginPage)
            },
          ),
          // AboutListTile(
          //   icon: Icon(Icons.info),
          //   applicationName: "Produce Store",
          //   aboutBoxChildren: <Widget>[
          //     Text("Thanks for reading Flutter in Action!"),
          //   ],
          // ),
        ],
      ),
    );
  }
}
