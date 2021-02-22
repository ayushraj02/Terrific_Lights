//Patient info to fill by emt.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:terrific_lights_final1/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:terrific_lights_final1/patient_info_fill.dart';
import 'package:terrific_lights_final1/patient_list.dart';
import 'package:terrific_lights_final1/registration.dart';


class patient_info_fill extends StatefulWidget {
  static const String id = 'patient_info_fill_screen';
  @override
  _patient_info_fillState createState() => _patient_info_fillState();
}

class _patient_info_fillState extends State<patient_info_fill> {
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;

  User loggedInUser;
  void ConfirmLogOut(BuildContext context) async{
    var alertDialog = AlertDialog(
      title: Text("Log Out?"),
      content: Text("Do you want to log out?"),
      actions: [
        FlatButton(
            child: Text("No"),
            onPressed: (){
              Navigator.pushNamed(context, patient_info_fill.id) ;
            }
        ),
        FlatButton(
            child: Text("Yes"),
            onPressed: () async {
              await _auth.signOut();
              Navigator.pushNamed(context, login_screen.id) ;
            }
        ),
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        }
    );
  }

  void ConfirmSubmit(BuildContext context) async{
    var alertDialog = AlertDialog(
      title: Text("Submit?"),
      content: Text("Do you want to submit?"),
      actions: [
        FlatButton(
            child: Text("No"),
            onPressed: (){
              Navigator.pushNamed(context, patient_info_fill.id) ;
            }
        ),
        FlatButton(
            child: Text("Yes"),
            onPressed: () async {
              await _firestore.collection("Patient_info").add({
                "information": Patient_Information,
              });
              ConfirmSubmit1(context);
            }
        ),
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        }
    );
  }

  void ConfirmSubmit1(BuildContext context) async{
    var alertDialog = AlertDialog(
      title: Text("Submited"),
      content: Text("The information is submitted"),
      actions: [
        FlatButton(
            child: Text("OK"),
            onPressed: (){
              Navigator.pushNamed(context, patient_info_fill.id) ;
            }
        ),
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        }
    );
  }
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
        print("congo emt nigga");
      }
    } catch (e) {
      print(e);
      print(";_;");
    }
  }

  bool checkbox1 = true;
  bool checkbox2 = false;
  String gender = 'male';
  String dropdownValue = 'A';
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  var Patient_Information = new List(15);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Patient Form'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              tooltip: 'Log Out',
              onPressed: () {
                ConfirmLogOut(context);
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(children: [
              Text(
                'Name',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 32.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(5.0))),
                onChanged: (value) {
                  Patient_Information[0] = value;
                },
              ),
              SizedBox(height: 30.0),
              Text(
                'EMT contact no.',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
              ),
              SizedBox(height: 5.0),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 32.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(5.0))),
                onChanged: (value) {
                  Patient_Information[1] = value;
                },
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                'Hospital ID',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
              ),
              SizedBox(height: 5.0),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 32.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(20.0))),
                onChanged: (value) {
                  Patient_Information[2] = value;
                },
              ),
              SizedBox(height: 30.0),
              Text(
                'Gender',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
              ),
              SizedBox(height: 5.0),
              Row(children: [
                SizedBox(
                  width: 30.0,
                ),
                SizedBox(
                  width: 10,
                  child: Radio(
                    value: 'Male',
                    groupValue: gender,
                    activeColor: Colors.orange,
                    onChanged: (value) {
                      setState(() {
                        gender = value;
                        Patient_Information[3] = value;
                      });
                    },
                  ),
                ),
                SizedBox(width: 10.0),
                Text('Male'),
                SizedBox(width: 50.0),
                SizedBox(
                  width: 10,
                  child: Radio(
                    value: 'Female',
                    groupValue: gender,
                    activeColor: Colors.orange,
                    onChanged: (value) {
                      setState(() {
                        gender = value;
                        Patient_Information[3] = value;
                      });
                    },
                  ),
                ),
                SizedBox(width: 10.0),
                Text('Female'),
                SizedBox(width: 50.0),
                SizedBox(
                  width: 10,
                  child: Radio(
                    value: 'Others',
                    groupValue: gender,
                    activeColor: Colors.orange,
                    onChanged: (value) {
                      setState(() {
                        gender = value;
                        Patient_Information[3] = value;
                      });
                    },
                  ),
                ),
                SizedBox(width: 10.0),
                Text('Others'),
              ]),
              SizedBox(
                height: 30.0,
              ),
              Text(
                'Age',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
              ),
              SizedBox(height: 5.0),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(

                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 32.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0))),
                onChanged: (value) {
                  Patient_Information[4] = value;
                },
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                'G.C',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
              ),
              SizedBox(height: 5.0),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(

                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 32.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0))),
                onChanged: (value) {
                  Patient_Information[5] = value;
                },
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                'Blood Pressure',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
              ),
              SizedBox(height: 5.0),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(

                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 32.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0))),
                onChanged: (value) {
                  Patient_Information[6] = value;
                },
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                'Pulse Rate',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
              ),
              SizedBox(height: 5.0),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(

                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 32.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0))),
                onChanged: (value) {
                  Patient_Information[7] = value;
                },
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                'Temperature',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
              ),
              SizedBox(height: 5.0),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(

                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 32.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0))),
                onChanged: (value) {
                  Patient_Information[8] = value;
                },
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                'Oxygen saturation',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
              ),
              SizedBox(height: 5.0),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(

                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 32.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0))),
                onChanged: (value) {
                  Patient_Information[9] = value;
                },
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                'Investigation',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
              ),
              SizedBox(height: 5.0),
              Text(
                'a. RBS',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15.0),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(

                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 32.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0))),
                onChanged: (value) {
                  Patient_Information[10] = value;
                },
              ),
              SizedBox(height: 10.0),
              Text(
                'b. LFT',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15.0),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(

                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 32.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0))),
                onChanged: (value) {
                  Patient_Information[11] = value;
                },
              ),
              SizedBox(height: 10.0),
              Text(
                'c. RFT',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15.0),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(

                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 32.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0))),
                onChanged: (value) {
                  Patient_Information[12] = value;
                },
              ),
              SizedBox(height: 10.0),
              Text(
                'd. CBP',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15.0),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(

                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 32.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0))),
                onChanged: (value) {
                  Patient_Information[13] = value;
                },
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                'Any H/O : ',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
              ),
              SizedBox(height: 5.0),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(

                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 32.0),
                        borderRadius: BorderRadius.circular(5.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0))),
                onChanged: (value) {
                  Patient_Information[14] = value;
                },
              ),

              SizedBox(height: 10.0),

              RaisedButton(
                color: Colors.orange,
                child: Text('Submit', style: TextStyle(color: Colors.white)),
                onPressed: () async{
                  ConfirmSubmit(context);
                },
              ),
            ]),
          ),
        ),
    );
  }
}
