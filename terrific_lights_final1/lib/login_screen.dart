import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:terrific_lights_final1/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:terrific_lights_final1/patient_info_fill.dart';
import 'package:terrific_lights_final1/patient_list.dart';
import 'package:terrific_lights_final1/registration.dart';
//import 'package:terrific_lights_final1/driver_map.dart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class login_screen extends StatefulWidget {
  static const String id = 'logic_screen' ;
  @override
  _login_screenState createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  String email_for_login, password_for_login ;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(// <-- STACK AS THE SCAFFOLD PARENT
        children: [
          // Container(
          //   decoration: BoxDecoration(
          //     image: DecorationImage(
          //       image: AssetImage(
          //         'images/pexels-artem-saranin-1853537.jpg',
          //       ),
          //       fit: BoxFit.cover, // <-- BACKGROUND IMAGE fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
          Scaffold(
            body: Container(
              height: height,
              width: width,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: width,
                      height: height * 0.45,
                      //child: Image.asset('images/pexels-artem-saranin-1853537.jpg',fit: BoxFit.fill,),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 25.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Email',
                        suffixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                        onChanged: (value) {
                          email_for_login = value;
                        }
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIcon: Icon(Icons.visibility_off),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                        onChanged: (value) {
                          password_for_login = value;
                        }
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Forgot password?',
                            style: TextStyle(fontSize: 12.0),
                          ),
                          RaisedButton(
                            child: Text('Login'),
                            color: Color(0xffEE7B23),
                            onPressed: () async {
                              try {
                                  print(email_for_login);print(password_for_login);
                                  await Firebase.initializeApp();
                                  final _firestore = await Firestore.instance;
                                  final _auth1 = await FirebaseAuth.instance;
                                  final user = await _auth1.signInWithEmailAndPassword(email: email_for_login, password: password_for_login);
                                  if(user != null)  {
                                    await for( var snapshot in _firestore.collection("Authentication").snapshots()) {
                                      for (var message in snapshot.documents) {
                                        if (message.data()["email"] ==
                                            email_for_login) {
                                          if (message.data()["profession"] ==
                                              "doctor") {
                                            Navigator.pushNamed(context, patient_list.id);
                                          }
                                          else if (message.data()["profession"] ==
                                              "emt") {
                                            Navigator.pushNamed(
                                                context, patient_info_fill.id);
                                          }
                                          else {
                                            //Navigator.pushNamed(context, driver_map.id);
                                          }
                                          break;
                                        }
                                      }
                                    }
                                  }
                              } catch (e) {
                                print(e);
                                print(";_;");
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, registration.id);
                      },
                      child: Text.rich(
                        TextSpan(text: 'Don\'t have an account', children: [
                          TextSpan(
                            text: ' Sign Up',
                            style: TextStyle(color: Color(0xffEE7B23)),
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]);
  }
}
