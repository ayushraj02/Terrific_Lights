import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:terrific_lights_final1/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:terrific_lights_final1/patient_info_fill.dart';
import 'package:terrific_lights_final1/patient_list.dart';
import 'package:terrific_lights_final1/registration.dart';
//import 'package:terrific_lights_final1/driver_map.dart.dart';

class patient_list extends StatefulWidget {
  static const String id = 'patient_list';
  @override
  _patient_listState createState() => _patient_listState();
}

class _patient_listState extends State<patient_list> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  String hospitalid;
  User loggedInUser;
  int no_of_patients = 0;
  Future _future;
  var patient_information = <List>[];
  @override
  void initState() {
    super.initState();
    _future = getCurrentUser();
  }

  Future getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print("loggedInUser.email = ${loggedInUser.email}");
        get_patients1();

        await for (var snapshot
            in _firestore.collection("Patient_info").snapshots()) {
          for (var message in snapshot.docs) {
            if (message.data()["information"][2] == hospitalid) {
              patient_information.add([
                message.data()["information"][0],
                message.data()["information"][4]
              ]);
              print("hospital id matched!");
            }
          }
          print("patient_information1(final) = $patient_information");
          print("length of the fkn list =  ${patient_information.length}");
        }
        print("yay");
      }
    } catch (e) {
      print(e);
      print(";_;");
    }
  }

  void get_patients1() async {
    await for (var snapshot
        in _firestore.collection("Authentication").snapshots()) {
      for (var message in snapshot.docs) {
        if (message.data()["email"] == loggedInUser.email) {
          hospitalid = message.data()["hospital_id"];
          print("hospitalid = ${hospitalid}");
          break;
        }
      }
    }
  }

  Future<int> get_patients2() async {
    //List patient_information_temp = [];
    await for (var snapshot
        in _firestore.collection("Patient_info").snapshots()) {
      for (var message in snapshot.docs) {
        if (message.data()["information"][2] == hospitalid) {
          patient_information.add([
            message.data()["information"][0],
            message.data()["information"][4]
          ]);
          print("hospital id matched!");
          //patient_information_temp.add([message.data()["information"][0], message.data()["information"][4]]);
        }
      }
      //print("patient_information2 = ${patient_information_temp}");
      //get_patients3(patient_information_temp);
    }
    print("yay");
  }

  void get_patients3(List<List<dynamic>> patient_information_temp) {
    patient_information = patient_information_temp;
    print("patient_information1(final) = ${patient_information}");
  }
  // patient_information = [
  //   ['Ayush' , '25'],
  //   ['Piyush' , '52']
  //   ....
  // ]

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Patient_list',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Patient List'),
          // to give signout option and self details
        ),
        body: FutureBuilder(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return loadingWidget;
            }
            return Container(
              child: ListView.builder(
                //padding: const EdgeInsets.all(8),
                itemCount: patient_information.length,
                itemBuilder: (context, index) => Container(
                  child: Card(
                    margin: EdgeInsets.all(10),
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        print(
                            'patient_information.length = ${patient_information.length}');
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20, 40, 10, 40),
                        child: Text(
                            '${patient_information[index][0]} , ${patient_information[index][1]}'),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget loadingWidget = Center(
    child: CircularProgressIndicator(),
  );
}
