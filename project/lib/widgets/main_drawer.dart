import 'package:flutter/material.dart';
import 'package:project/services/auth_service.dart';

class MainDrawer extends StatelessWidget {
  final AuthService authService;
  MainDrawer(this.authService);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            backgroundColor: Colors.green[400],
            title: Text('Hello Friend!'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () async {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              await authService.signOut();
            },
          ),
        ],
      ),
    );
  }
}
