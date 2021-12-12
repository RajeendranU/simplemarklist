import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homescreen.dart';
import 'loginscreen.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.orange[150],
      home:splashScreen(),
    );
  }
}
class splashScreen extends StatefulWidget {

  @override
  _splashScreenState createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {

  @override
  void initState() {
Timer(Duration(seconds: 3), (){
   checksharedpref();
 });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(child: Image.asset('assets/rjtech.png')),
      ),
    );
  }
  Future<void> checksharedpref()async {
     final sharedpref=await SharedPreferences.getInstance();
     final logingrnt=sharedpref.getBool('logingrant');
     if(logingrnt==true)
       {
       Navigator.of(context).pushReplacement(MaterialPageRoute(
           builder: (ctx)=>HomeScreen()));
     }
     else{
       Navigator.of(context).pushReplacement(MaterialPageRoute(
           builder: (ctx)=>LoginScreen()));
     }

  }
}

