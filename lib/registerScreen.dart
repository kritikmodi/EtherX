// ignore_for_file: file_names

import 'package:etherx/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';

class registerScreen extends StatefulWidget {
  @override
  _registerScreenState createState() => _registerScreenState();
}

class _registerScreenState extends State<registerScreen> {

  FirebaseAuth auth = FirebaseAuth.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String name="", email="", password="";

  checkAuthentication() async {
    auth.authStateChanges().listen((user) async {
      if (user != null) {
        Navigator.pushReplacementNamed(context, "/");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
  }

  signUp() async {

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      try {
        UserCredential user = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        if (user != null) {
          await auth.currentUser!.updateProfile(displayName: name);
        }
      } catch (e) {
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
            content: Text('Id doesnt exist!'),
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

  goToLogin() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => loginScreen()));
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
                    image: AssetImage("images/registerimage.png"),
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
                                if (input!.isEmpty) return 'Please enter name!';
                              },
                              decoration: InputDecoration(
                                labelText: 'Name',
                                prefixIcon: Icon(Icons.person),
                              ),
                              onSaved: (input) => name = input!),
                        ),
                        Container(
                          child: TextFormField(
                              validator: (input) {
                                if (input!.isEmpty) return 'Please enter Email!';
                              },
                              decoration: InputDecoration(
                                  labelText: 'Email',
                                  prefixIcon: Icon(Icons.email)),
                              onSaved: (input) => email = input!),
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
                              onSaved: (input) => password = input!),
                        ),
                        SizedBox(height: 40),
                        RaisedButton(
                          padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                          onPressed: signUp,
                          child: Text('REGISTER',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold)),
                          color: Colors.deepOrangeAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          child: Text('Already have an account?',
                              style: TextStyle(
                                color: Colors.blue,
                                fontStyle: FontStyle. italic,
                              )),
                          onTap: goToLogin,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

}
