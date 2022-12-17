import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:student_firebase/Model/model.dart';
import 'package:student_firebase/Screen/Addstudent.dart';
import 'package:student_firebase/Screen/studentInfo.dart';
import 'package:student_firebase/porvider/studentprovider.dart';

class StudentList extends StatefulWidget {
  const StudentList({Key? key}) : super(key: key);
  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  String netImage='https://cdn.iconscout.com/icon/free/png-256/avatar-370-456322.png';
  @override
  Widget build(BuildContext context) {
    return
    Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            const AddStudentPage().launch(context);
          },
          child: const Icon(Icons.add,color: Colors.white,),
        ),
        appBar: AppBar(
          title: const Text('Students Model',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
          centerTitle: true,
          backgroundColor: Colors.amber,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Consumer(builder: (_,ref,watch){
                AsyncValue<List<StudentModel>> studentlist= ref.watch(studentProvider);
                return studentlist.when(
                    data: (students){
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: students.length,
                          itemBuilder: (_,index){
                            return StudentTemple(
                                student: students[index],
                                pictureUrl: netImage);
                          });
                    },
                    error: (e,stack){
                      return Text(e.toString());
                    }, loading: ((){
                      return const Center(child: CircularProgressIndicator(),);
                }));

              })
            ],
          ),
        ),
    );
  }
}

class StudentTemple extends StatelessWidget {
  const StudentTemple({super.key,
    required this.student,required this.pictureUrl
  });
  final StudentModel student;
  final String pictureUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black,width: 0.5)
      ),
      child: Center(
        child: ListTile(
          onTap: ()=>StudentInfo(studentInformation: student).launch(context),
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(student.pictureUrl ?? pictureUrl),
          ),
          title: Text(student.studentName ?? '',style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 17),),
          subtitle: Row(
            children: [
              Text('Class :${student.className},',style: TextStyle(),),

              Text('Roll : ${student.roll}'),

            ],
          ),
          trailing: const Icon(Icons.arrow_forward_ios,size: 28,),
        ),
      ),
    );
  }
}
