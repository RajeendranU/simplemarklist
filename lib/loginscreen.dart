import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marklist/signuppage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homescreen.dart';

class LoginScreen extends StatelessWidget {
  final usernamecontrlr = TextEditingController();
  final passwordcontrlr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.orange[300],
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              TextField(
                controller: usernamecontrlr,
                decoration: const InputDecoration(
                  hintText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: passwordcontrlr,
                decoration: const InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (ctx)=>SignUp()));
                    },
                    child: Text('Sign Up'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                         checklogin(context);
                    },
                    child: Text('Login'),
                  ),
                ],
              ),
              Text('New User? Sign up first!!')
            ],
          ),
        ),
      ),
    );
  }
  Future<void> checklogin(BuildContext context) async {
    final username=usernamecontrlr.text;
    final password=passwordcontrlr.text;
    final sharedpref=await SharedPreferences.getInstance();
    final shareduname=sharedpref.getString('uname');
    final sharedpword=sharedpref.getString('pword');
    if(username==shareduname && password==sharedpword){
      sharedpref.setBool('logingrant', true);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (ctx)=>HomeScreen()));
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Enter Correct Username and Password')));
    }

  }
}
