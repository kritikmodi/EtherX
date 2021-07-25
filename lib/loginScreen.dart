// ignore_for_file: file_names

import 'package:etherx/registerScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:etherx/homepage.dart';

class loginScreen extends StatefulWidget {
  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {

  final FirebaseAuth auth = FirebaseAuth.instance;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _email = "", _password = "";

  checkAuthentification() async {
    auth.authStateChanges().listen((user) {
      if (user != null) {
        print(user);
        Navigator.pushReplacementNamed(context, "/");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
  }

  login() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      try {
        await auth.signInWithEmailAndPassword(
            email: _email, password: _password);
      }catch (e) {
        showError();
        print(e);
      }
    }
  }

  showError() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text('The format of your entered email is invalid!'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  goToRegister() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => registerScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 400,
                  child: Image(
                    image: AssetImage("images/loginimage.png"),
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: TextFormField(
                              validator: (input) {
                                if (input!.isEmpty) return 'Please enter Email!';
                              },
                              decoration: InputDecoration(
                                  labelText: 'Email',
                                  prefixIcon: Icon(Icons.email)),
                              onSaved: (input) => _email = input!),
                        ),
                        Container(
                          child: TextFormField(
                              validator: (input) {
                                if (input!.length < 6)
                                  return 'Password should be of minimum 6 characters!';
                              },
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: Icon(Icons.lock),
                              ),
                              obscureText: true,
                              onSaved: (input) => _password = input!),
                        ),
                        SizedBox(height: 50),
                        RaisedButton(
                          padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                          onPressed: login,
                          child: Text('LOGIN',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold)),
                          color: Colors.deepOrangeAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  child: Text('Create an Account?',
                  style: TextStyle(
                    color: Colors.blue,
                    fontStyle: FontStyle. italic,
                  )),
                  onTap: goToRegister,
                )
              ],
            ),
          ),
        ));
  }
}
