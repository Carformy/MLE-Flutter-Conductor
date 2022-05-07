import 'package:fire_uber_driver/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fire_uber_driver/screens/register.dart';
import 'package:fire_uber_driver/screens/tabs.dart';

class SignScreen extends StatefulWidget {
  SignScreen({Key? key}) : super(key: key);

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  String email = '';
  String password = '';
  String error = '';

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              backgroundColor: Colors.lightBlue.shade100,
              body: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: ListView(
                    children: [
                      Column(
                        //scrollDirection: Axis.vertical,

                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 100,
                          ),

                          Text('Uber Driver',
                              style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'DancingScript',
                                  color: Colors.lightBlue)),
                          Padding(
                            padding: const EdgeInsets.only(left: 120.0),
                            child: Text(
                              'Taxi Driver Application',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Form(
                              key: _formKey,
                              child: Text(
                                'Email',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.lightBlue,
                                ),
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                color: Color(0xffEFF3F6),
                                borderRadius: BorderRadius.circular(100),
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Color.fromRGBO(0, 0, 0, 0.1),
                                //     offset: Offset(6, 2),
                                //     blurRadius: 6.0,
                                //     spreadRadius: 3.0,
                                //   ),
                                //   BoxShadow(
                                //     color: Color.fromRGBO(255, 255, 255, 0.9),
                                //     offset: Offset(-6, -2),
                                //     blurRadius: 6.0,
                                //     spreadRadius: 3.0,
                                //   ),
                                // ],
                              ),
                              child: TextField(
                                onChanged: (val) {
                                  setState(() => email = val);
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 20),
                                  border: InputBorder.none,
                                  hintText: 'customer@gmail.com',
                                ),
                              )),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.lightBlue,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xffFFEFF3F6),
                              borderRadius: BorderRadius.circular(100),
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: Color.fromRGBO(0, 0, 0, 0.1),
                              //     offset: Offset(6, 2),
                              //     blurRadius: 6.0,
                              //     spreadRadius: 3.0,
                              //   ),
                              //   BoxShadow(
                              //     color: Color.fromRGBO(255, 255, 255, 0.9),
                              //     offset: Offset(-6, -2),
                              //     blurRadius: 6.0,
                              //     spreadRadius: 3.0,
                              //   ),
                              // ],
                            ),
                            child: TextField(
                              obscureText: true,
                              onChanged: (val) {
                                setState(() => password = val);
                              }, //
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 20),
                                  border: InputBorder.none,
                                  hintText: '123456789'),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: Text('Forgot Password ?',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                )),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Column(
                            children: <Widget>[
                              ButtonTheme(
                                minWidth: 320.0,
                                height: 45.0,
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7.0)),
                                  color: Colors.lightBlue,
                                  onPressed: () async {
                                    try {
                                      UserCredential userCredential =
                                          await FirebaseAuth.instance
                                              .signInWithEmailAndPassword(
                                                  email: email,
                                                  password: password);
                                    } on FirebaseAuthException catch (e) {
                                      if (e.code == 'user-not-found') {
                                        print('No user found for that email.');
                                      } else if (e.code == 'wrong-password') {
                                        print(
                                            'Wrong password provided for that user.');
                                      }
                                    }
                                  },
                                  child: Text('Login',
                                      style: TextStyle(color: Colors.white)),
                                ), //rec
                              ), //flat
                            ], //widget
                          ), //column
                          Column(
                            children: <Widget>[
                              ButtonTheme(
                                minWidth: 320.0,
                                height: 45.0,
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7.0)),
                                  onPressed: () async {
                                    //widget.toggleView();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Register()));
                                  },
                                  child: Text('Register',
                                      style:
                                          TextStyle(color: Colors.lightBlue)),
                                ), //rec
                              ), //flat
                            ], //widget
                          ), //column
                        ],
                      ),
                    ],
                  )
                  //form
                  ),
            );
            //end
          }

          return MySplashScreen();
        });
  }
}