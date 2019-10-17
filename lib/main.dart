import 'package:flutter/material.dart';
import 'package:flutter_app/home.dart';
import 'package:flutter_app/login.dart';
import 'package:flutter_app/services/userservice.dart';

void main() async{
  UserService userService = UserService();
  Widget page = Login();
  final route = <String, WidgetBuilder>{
    'login': (context) => Login(),
    'home': (context) => Home(),
  };

  WidgetsFlutterBinding.ensureInitialized();
  if(await userService.isLogin()){
    page = Home();
  }

  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Coin Demo",
        home: page,
        routes: route,
      )
  );
}

