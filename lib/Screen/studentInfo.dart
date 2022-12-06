import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:student_firebase/Model/model.dart';
import 'package:student_firebase/Screen/edit.dart';
class StudentInfo extends StatefulWidget {
  const StudentInfo({super.key, required this.studentInformation});
  final StudentModel studentInformation;

  @override
  State<StudentInfo> createState() => _StudentInfoState();
}

class _StudentInfoState extends State<StudentInfo> {

  String netImage='https://cdn.iconscout.com/icon/free/png-256/avatar-370-456322.png';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lime,
        title: Text(widget.studentInformation.studentName.toString(),style: TextStyle(fontSize: 22),),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.edit,size: 29).onTap(()=>EditPage(edit: widget.studentInformation).launch(context)),
                SizedBox(width: 8,),
                Icon(Icons.delete_forever,size: 29,)
              ],
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 50,),
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.blueGrey,
                  backgroundImage: NetworkImage(widget.studentInformation.pictureUrl ?? netImage),
                )
              ],
            ),
          ),
          SizedBox(height: 7,),
          Text(widget.studentInformation.studentName.toString(),style: TextStyle(fontFamily: 'Pacifico',fontWeight: FontWeight.w500,fontSize: 25),),
         SizedBox(height: 30,),
         Container(
           color: Colors.grey[200],

           child: Padding(
             padding: const EdgeInsets.all(20.0),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 SizedBox(height: 20,),
                 Text('Student Name : ${widget.studentInformation.studentName}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                 SizedBox(height: 7,),
                 Text('Fathers Name : ${widget.studentInformation.fathersName}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                 SizedBox(height: 7,),
                 Text('Date of Birth : ${widget.studentInformation.birthDate}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                 SizedBox(height: 7,),
                 Text('Roll Number  : ${widget.studentInformation.roll}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                 SizedBox(height: 7,),
                 Text('Student Grup : ${widget.studentInformation.studentGrup}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                 SizedBox(height: 7,),
                 Text('Blood Grup : ${widget.studentInformation.bloodGrup}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                 SizedBox(height: 7,),
                 Text('Class Name : ${widget.studentInformation.className}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                 SizedBox(height: 7,),
                 Text('Contact Number : ${widget.studentInformation.studentsContact}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                 SizedBox(height: 7,),
                 Text('Inistiture Name : ${widget.studentInformation.studentInistitute}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                 SizedBox(height: 7,),
               ],
             ),
           ),
         )
        ],
      ),

    );
  }
}
