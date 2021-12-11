import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'loginscreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () async {
            final sharedpref=await SharedPreferences.getInstance();
            sharedpref.remove('logingrant');
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (ctx)=>LoginScreen()));

          }, icon: Icon(Icons.logout)),
        ],
      ),
      body:  Text('home'),
    );
  }
}
