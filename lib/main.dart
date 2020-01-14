import 'package:flutter/material.dart';
import 'package:flutter_sqlite/pages/login/home_page.dart';
import 'package:flutter_sqlite/pages/login/login_page.dart';

void main() => runApp(MyApp());

final routes = {
  '/login' :(BuildContext context)=> new LoginPage(),
  '/home' : (BuildContext context)=> new HomePage(),
  '/' : (BuildContext context) => LoginPage()
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:'SQlite App',
      theme: ThemeData(
        primarySwatch: Colors.teal
      ),
      routes: routes,
    );
  }
}
