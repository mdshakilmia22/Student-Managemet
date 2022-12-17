import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:student_firebase/Screen/Addstudent.dart';
import 'package:student_firebase/Screen/sing_in.dart';
import 'package:student_firebase/Screen/student_list.dart';
class SpalashScreen extends StatefulWidget {
  const SpalashScreen({Key? key}) : super(key: key);

  @override
  State<SpalashScreen> createState() => _SpalashScreenState();
}

class _SpalashScreenState extends State<SpalashScreen> {
  var currentPage=FirebaseAuth.instance.currentUser;
  void getData()async{
    await Future.delayed(const Duration(seconds: 02)).then((value) {
      if(currentPage != null){
        const StudentList().launch(context,isNewTask: true);
      }
      else{
        const SingInPage().launch(context, isNewTask: true);
      }
    });
  }
  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('images/caps.png',height: 80, width: 80,),
                const Text('ADMIT',style: TextStyle(color: Colors.blue,fontFamily: 'Lobster',fontWeight: FontWeight.w500,fontSize: 27),),
                const Text('STUDENTS',style: TextStyle(color: Colors.deepOrange,fontFamily: 'Lobster',fontWeight: FontWeight.w500,fontSize: 27),),
              ],
            ),
            Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
