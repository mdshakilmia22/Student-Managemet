import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:student_firebase/Model/model.dart';

class StudentRepo{
  Future<List<StudentModel>> getAllData()async{
    List<StudentModel> studentlist = [];
    await FirebaseDatabase.instance.ref('Student Information').orderByKey().get().then((value) => {
      for(var elements in value.children){
        studentlist.add(StudentModel.fromJson(jsonDecode(jsonEncode(elements.value))))
      }
    });
    return studentlist;
  }
}