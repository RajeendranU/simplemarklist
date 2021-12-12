import 'package:flutter/material.dart';
import 'package:marklist/loginscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatelessWidget {
  final signupusernamecontrlr = TextEditingController();
  final signuppasswordcontrlr = TextEditingController();
  final _formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {


      return Scaffold(
        backgroundColor: Colors.greenAccent,
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                TextFormField(
                  validator: (value){
                    if(value==null||value.isEmpty){
                      return 'Enter Username';
                    }

                  },
                  controller: signupusernamecontrlr,
                  decoration: const InputDecoration(
                    hintText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value){
                    if(value==null||value.isEmpty){
                      return 'Enter Password';
                    }

                  },
                  controller: signuppasswordcontrlr,
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
                      style:ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.green) ),
                      onPressed: () {
                        if(_formKey.currentState!.validate()){
                          savesignupdetails(context);

                        }
                      },
                      child: const Text('Create Account'),
                    ),
                    ElevatedButton(
                      style:ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.green) ),

                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (ctx)=>LoginScreen()));
                      },
                      child: const Text('Goto Login page'),
                    ),
                  ],
                ),
                ],
            ),
          ),
        ),
      );

    }

  Future<void> savesignupdetails(BuildContext context) async {
    final username=signupusernamecontrlr.text;
    final password=signuppasswordcontrlr.text;
    final sharedpref=await SharedPreferences.getInstance();
    sharedpref.setString('uname', username);
    sharedpref.setString('pword', password);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Account Created Succesfully!! Goto Login page')));
  }
  }

