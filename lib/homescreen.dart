//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        child: ListView(
          shrinkWrap: true,
         scrollDirection: Axis.vertical,
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
            ElevatedButton(onPressed: (){
             if( _formKey.currentState!.validate()){
               savemarkstodb();

             }
            }, child: Text('Add')),
            ValueListenableBuilder(
              valueListenable: studentlist,
              builder: (BuildContext context,List<StudentModel> values, Widget? child) {
                return ListView.separated(
                  shrinkWrap: true,
                    itemBuilder: (BuildContext context,index){
                      final name=values[index].studentname;
                       final mark=values[index].mark;


                        return ListTile(
                          title: Text(name),
                          subtitle: Text(mark),
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
    studentlist.value.add(studentmodel);
  }
}
