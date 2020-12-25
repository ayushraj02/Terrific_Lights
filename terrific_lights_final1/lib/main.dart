import 'package:flutter/material.dart';
import 'package:terrific_lights_final1/login_screen.dart';
import 'package:terrific_lights_final1/patient_info_fill.dart';
import 'package:terrific_lights_final1/registration.dart';
import 'package:terrific_lights_final1/single_patient_info_doc.dart';
import 'package:terrific_lights_final1/patient_list.dart';
void main() => runApp(Terrific_Lights());

class Terrific_Lights extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme : ThemeData.dark().copyWith(
        textTheme: TextTheme(
          body1 : TextStyle(color : Colors.black54),
        ),
      ),
      initialRoute: login_screen.id,
      routes : {
        login_screen.id : (context) => login_screen(),
        registration.id : (context) => registration(),
        single_patient_info_doc.id : (context) => single_patient_info_doc(),
        patient_info_fill.id : (context) => patient_info_fill(),
        patient_list.id : (context) => patient_list(),
        //Doctorspage.id : (context) => patient_list(),
      }
    );
  }
}

// password of the trial account is  : abhinav for abhinav@email.com
