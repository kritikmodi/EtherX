import 'package:etherx/loginScreen.dart';
import 'package:etherx/registerScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class start extends StatefulWidget {
  @override
  _startState createState() => _startState();
}

class _startState extends State<start> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 70.0),
            Container(
              padding: EdgeInsets.only(left: 45),
              child : const Image(image : AssetImage("images/startimage.png"),),
            ),
            SizedBox(height: 60),
            RichText(
                text: const TextSpan(
                    text: 'ETHER',
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'X',
                          style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink))
                    ])),
            const SizedBox(height: 5.0),
            const Text(
              'Your own Xcoin Wallet',
              style: TextStyle(color: Colors.black,
                     fontStyle: FontStyle. italic,)
            ),
            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    onPressed: goToLogin,
                    child: const Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    color: Colors.pink),
                const SizedBox(width: 20.0),
                RaisedButton(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    onPressed: goToRegister,
                    child: const Text(
                      'REGISTER',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    color: Colors.pink),
              ],
            ),
            SizedBox(height: 20.0),



          ]
        )
      ),
    );
  }

  void goToLogin() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => loginScreen()));
  }

  void goToRegister() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => registerScreen()));
  }
}
