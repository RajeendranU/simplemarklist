import 'package:hive/hive.dart';

part 'studentmodel.g.dart';

@HiveType(typeId: 1)

class StudentModel{

  @HiveField(0)
  late final String studentname;

  @HiveField(1)
  late final String mark;

  @HiveField(2)
  int  id=0;
  StudentModel({required this.studentname,required this.mark,});
}