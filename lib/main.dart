import 'package:flutter/material.dart';
import 'package:project/screens/wrapper.dart';
import 'package:project/services/auth_service.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider.value(
          value: AuthService().user,
        ),
      ],
      child: MaterialApp(
        home: Wrapper(),
        routes: {},
      ),
    );
  }
}
