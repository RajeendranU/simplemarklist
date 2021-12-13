//import 'package:flutter/cupertino.dart';
//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:marklist/main.dart';
import 'package:marklist/model/studentmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'loginscreen.dart';
final namecontrlr = TextEditingController();
final markcontrlr = TextEditingController();
final _formKey=GlobalKey<FormState>();
ValueNotifier<List<StudentModel>> studentlist=ValueNotifier([]);


class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {
             signout(context);
          }, icon: Icon(Icons.logout)),
        ],
      ),
      body:  Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            //shrinkWrap: true,
          // scrollDirection: Axis.vertical,
            children: [
              SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value){
                  if(value==null||value.isEmpty){
                    return 'Enter Name';
                  }

                },
                controller: namecontrlr,
                decoration: const InputDecoration(
                  hintText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value){
                  if(value==null||value.isEmpty){
                    return 'Enter Mark';
                  }
                },
                controller: markcontrlr,
                decoration: const InputDecoration(
                  hintText: 'Mark',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 150.0,right: 150),
                child: ElevatedButton(onPressed: (){
                 if( _formKey.currentState!.validate()){
                   savemarkstodb();

                 }
                }, child: Text('Add')),
              ),
              ValueListenableBuilder(
                valueListenable: studentDB.listenable(),
                builder: (BuildContext context,Box<StudentModel> values, Widget? child) {
                  final keys=values.keys.toList();
                  return ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                      itemBuilder: (BuildContext context,index){
                       final name=values.get(keys[index])!.studentname;
                         final mark=values.get(keys[index])!.mark;



                          return ListTile(
                            //onTap: (){},
                            title: Text(name),
                            subtitle: Text(mark),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [IconButton(onPressed: () {
                                editdata(context,keys[index]);
                              }, icon: Icon(Icons.edit),),

                                IconButton(onPressed: () {
                                  values.delete(keys[index]);
                                }, icon: Icon(Icons.delete),),
                              ],
                            ),
                          );
                      },
                      separatorBuilder: (BuildContext context,index){
                        return const Divider(thickness: 5,);

                      },
                      itemCount: values.length);
                },

              )
            ],
          ),
        ),
      ),
    );
  }
  Future<void> signout(BuildContext context) async {
    final sharedpref=await SharedPreferences.getInstance();
    sharedpref.remove('logingrant');
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx)=>LoginScreen()));
  }
  Future<void> savemarkstodb()async {
    final name=namecontrlr.text;
    final mark=markcontrlr.text;
    final studentmodel=StudentModel(studentname: name, mark: mark);
   // studentlist.value.add(studentmodel);
    await studentDB.add(studentmodel);

  }

  Future<void> editdata(context,key) async {
    showDialog(context: context, builder: (ctx){
      final editnamecontrlr=TextEditingController();
      final editpasswordcontrlr=TextEditingController();
      return AlertDialog(
        content: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value){
                if(value==null||value.isEmpty){
                  return 'Enter Username';
                }

              },
              controller: editnamecontrlr,
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
              controller: editpasswordcontrlr,
              decoration: const InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style:ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.green) ),

              onPressed: () {
                final editedname=editnamecontrlr.text;
                final editedmark=editpasswordcontrlr.text;
                final editeddata=StudentModel(studentname: editedname, mark: editedmark);
                studentDB.put(key, editeddata);
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      );});
  }
}
