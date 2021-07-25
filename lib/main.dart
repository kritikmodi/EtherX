import 'package:etherx/homepage.dart';
import 'package:etherx/registerScreen.dart';
import 'package:etherx/start.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:etherx/loginScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      debugShowCheckedModeBanner: false,
      home: homepage(),

      routes: <String,WidgetBuilder>{

        "Login" : (BuildContext context)=>loginScreen(),
        "SignUp":(BuildContext context)=>registerScreen(),
        "start":(BuildContext context)=>start(),
      },
    );
  }
}