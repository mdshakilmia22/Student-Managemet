import 'dart:io';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:student_firebase/Model/model.dart';
import 'package:student_firebase/Screen/student_list.dart';
import 'package:student_firebase/porvider/studentprovider.dart';
class AddStudent extends StatefulWidget {
  const AddStudent({Key? key}) : super(key: key);

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  List<String> languages = ['English', 'Bangla'];
  String initialLanguage = 'English';
  String? datePicker;

  DropdownButton<String> getLanguages() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String des in languages) {
      var item = DropdownMenuItem(
        value: des,
        child: Text(des),
      );
      dropDownItems.add(item);
    }
    return DropdownButton(
      items: dropDownItems,
      value: initialLanguage,
      onChanged: (value) {
        setState(() {
          initialLanguage = value!;
        });
      },
    );
  }
  TextEditingController studentNameController = TextEditingController();
  TextEditingController rollController = TextEditingController();
  TextEditingController fathersNameController= TextEditingController();
  TextEditingController mothersNameController=TextEditingController();
  TextEditingController studentinistitutecontroller=TextEditingController();
  TextEditingController grupcontroller=TextEditingController();
  TextEditingController bloodgrupcontroller=TextEditingController();
  TextEditingController classNamecontroller=TextEditingController();
  TextEditingController contactcontroller=TextEditingController();
  TextEditingController pictururlcontroller=TextEditingController();


  final ImagePicker _picker = ImagePicker();
  XFile ? image;
  String ? _imageUrl;
  Future<void> getImage()async{
    image= await _picker.pickImage(source: ImageSource.gallery);
    var snapshot= await FirebaseStorage.instance.ref('Student Image').child(DateTime.now().microsecondsSinceEpoch.toString()).putFile(File(image!.path));
    _imageUrl= await snapshot.ref.getDownloadURL();
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Consumer(builder: (_,ref,watch){
                return Column(
                  children: [
                    const Text('Student Information',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: Colors.green),),
                    const SizedBox(height: 30,),
                    InkWell(
                      onTap: (){
                        getImage();
                      },
                      child: Container(
                         height: 150,
                         width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.red,
                          image: image==null ? const DecorationImage(image: NetworkImage('https://cdn.iconscout.com/icon/free/png-256/avatar-370-456322.png'),fit: BoxFit.fill):
                          DecorationImage(image: FileImage(File(image!.path)),fit: BoxFit.fill),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    AppTextField(
                      textFieldType: TextFieldType.NAME,
                      controller: studentNameController,
                      decoration: InputDecoration(
                        hintText: 'Student\'s Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),

                      ),
                    ),
                    SizedBox(height: 15,),
                    AppTextField(
                      textFieldType: TextFieldType.NAME,
                      controller: fathersNameController,
                      decoration: InputDecoration(
                        hintText: 'Father\'s Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),

                      ),
                    ),
                    SizedBox(height: 15,),
                    AppTextField(
                      textFieldType: TextFieldType.NAME,
                      controller: mothersNameController,
                      decoration: InputDecoration(
                        hintText: 'Mother\'s Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),

                      ),
                    ),
                    SizedBox(height: 15,),
                    AppTextField(
                      textFieldType: TextFieldType.NUMBER,
                      controller: rollController,
                      decoration: InputDecoration(
                        hintText: 'Roll Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),

                      ),
                    ),
                    SizedBox(height: 15,),
                    DateTimePicker(
                      firstDate: DateTime(1950),
                      lastDate: DateTime.now(),
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.calendar_month,size: 30,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: 'Date Time',

                      ),
                      onChanged: (value){
                        setState(() {
                          datePicker=value;
                        });
                      },
                    ),
                    // AppTextField(
                    //   textFieldType: TextFieldType.NAME,
                    //   readOnly: true,
                    //   controller: dateofbirthcontroller,
                    //   decoration: InputDecoration(
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(15)
                    //     ),
                    //     hintText: DateTime.now().toString().substring(0,10),
                    //     floatingLabelBehavior: FloatingLabelBehavior.always,
                    //     suffixIcon: const Icon(Icons.calendar_month).onTap(()=>showDatePicker(
                    //         context: context,
                    //         initialDate: DateTime.now(),
                    //         firstDate: DateTime(1950),
                    //         lastDate: DateTime.now()))
                    //   )
                    // ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: context.width(),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: SizedBox(
                        height: 58,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: DropdownButtonHideUnderline(child: getLanguages()),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    AppTextField(
                      textFieldType: TextFieldType.NAME,
                      controller: grupcontroller,
                      decoration: InputDecoration(
                        hintText: 'Student Grup',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),

                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    AppTextField(
                      textFieldType: TextFieldType.NAME,
                      controller: bloodgrupcontroller,
                      decoration: InputDecoration(
                        hintText: 'Blood Grup',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),

                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    AppTextField(
                      textFieldType: TextFieldType.NAME,
                      controller: classNamecontroller,
                      decoration: InputDecoration(
                        hintText: 'Class Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),

                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    AppTextField(
                      textFieldType: TextFieldType.NUMBER,
                      controller: contactcontroller,
                      decoration: InputDecoration(
                        hintText: 'Contact Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),

                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    AppTextField(
                      textFieldType: TextFieldType.NAME,
                      controller: studentinistitutecontroller,
                      decoration: InputDecoration(
                        hintText: 'Inistiture Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),

                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 55,
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(

                          ),
                          onPressed: () async{
                            StudentModel model= StudentModel(studentName: studentNameController.text, fathersName: fathersNameController.text, mothersName: mothersNameController.text, birthDate: datePicker, roll: rollController.text, studentLanguase: initialLanguage, studentInistitute: studentinistitutecontroller.text, studentGrup: grupcontroller.text, bloodGrup: bloodgrupcontroller.text, className: classNamecontroller.text, studentsContact: contactcontroller.text, pictureUrl: _imageUrl,);
                            await FirebaseDatabase.instance.ref('Student Information').push().set(model.toJson()).then((value) {
                              EasyLoading.showSuccess('Done');
                              ref.refresh(studentProvider);

                            });
                          },
                          child: const Text('Registration',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),)),
                    )
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
// Column(
// children: [
// Text('Student Information',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: Colors.green),),
// SizedBox(height: 30,),
// InkWell(
// onTap: (){
// getImage();
// },
// child: Container(
// height: 150,
// width: 150,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(100),
// color: Colors.red,
// image: image==null ? DecorationImage(image: NetworkImage('https://cdn.iconscout.com/icon/free/png-256/avatar-370-456322.png'),fit: BoxFit.fill):
// DecorationImage(image: FileImage(File(image!.path)),fit: BoxFit.fill),
// ),
// ),
// ),
// SizedBox(
// height: 20,
// ),
//
// AppTextField(
// textFieldType: TextFieldType.NAME,
// controller: studentNameController,
// decoration: InputDecoration(
// hintText: 'Student\'s Name',
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(15),
// ),
//
// ),
// ),
// SizedBox(height: 15,),
// AppTextField(
// textFieldType: TextFieldType.NAME,
// controller: fathersNameController,
// decoration: InputDecoration(
// hintText: 'Father\'s Name',
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(15),
// ),
//
// ),
// ),
// SizedBox(height: 15,),
// AppTextField(
// textFieldType: TextFieldType.NAME,
// controller: mothersNameController,
// decoration: InputDecoration(
// hintText: 'Mother\'s Name',
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(15),
// ),
//
// ),
// ),
// SizedBox(height: 15,),
// AppTextField(
// textFieldType: TextFieldType.NUMBER,
// controller: rollController,
// decoration: InputDecoration(
// hintText: 'Roll Number',
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(15),
// ),
//
// ),
// ),
// SizedBox(height: 15,),
// DateTimePicker(
// firstDate: DateTime(1950),
// lastDate: DateTime.now(),
// decoration: InputDecoration(
// suffixIcon: Icon(Icons.calendar_month,size: 30,),
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(15),
// ),
// hintText: 'Date Time',
//
// ),
// onChanged: (value){
// setState(() {
// datePicker=value;
// });
// },
// ),
// // AppTextField(
// //   textFieldType: TextFieldType.NAME,
// //   readOnly: true,
// //   controller: dateofbirthcontroller,
// //   decoration: InputDecoration(
// //     border: OutlineInputBorder(
// //       borderRadius: BorderRadius.circular(15)
// //     ),
// //     hintText: DateTime.now().toString().substring(0,10),
// //     floatingLabelBehavior: FloatingLabelBehavior.always,
// //     suffixIcon: const Icon(Icons.calendar_month).onTap(()=>showDatePicker(
// //         context: context,
// //         initialDate: DateTime.now(),
// //         firstDate: DateTime(1950),
// //         lastDate: DateTime.now()))
// //   )
// // ),
// SizedBox(
// height: 15,
// ),
// Container(
// width: context.width(),
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(15.0),
// border: Border.all(color: Colors.grey),
// ),
// child: SizedBox(
// height: 58,
// child: Padding(
// padding: const EdgeInsets.only(left: 15.0),
// child: DropdownButtonHideUnderline(child: getLanguages()),
// ),
// ),
// ),
// SizedBox(
// height: 15,
// ),
// AppTextField(
// textFieldType: TextFieldType.NAME,
// controller: grupcontroller,
// decoration: InputDecoration(
// hintText: 'Student Grup',
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(15),
// ),
//
// ),
// ),
// SizedBox(
// height: 15,
// ),
// AppTextField(
// textFieldType: TextFieldType.NAME,
// controller: bloodgrupcontroller,
// decoration: InputDecoration(
// hintText: 'Blood Grup',
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(15),
// ),
//
// ),
// ),
// SizedBox(
// height: 15,
// ),
// AppTextField(
// textFieldType: TextFieldType.NAME,
// controller: classNamecontroller,
// decoration: InputDecoration(
// hintText: 'Class Name',
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(15),
// ),
//
// ),
// ),
// SizedBox(
// height: 15,
// ),
// AppTextField(
// textFieldType: TextFieldType.NUMBER,
// controller: contactcontroller,
// decoration: InputDecoration(
// hintText: 'Contact Number',
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(15),
// ),
//
// ),
// ),
// SizedBox(
// height: 15,
// ),
// AppTextField(
// textFieldType: TextFieldType.NAME,
// controller: studentinistitutecontroller,
// decoration: InputDecoration(
// hintText: 'Inistiture Name',
// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(15),
// ),
//
// ),
// ),
// SizedBox(
// height: 30,
// ),
// Container(
// height: 55,
// width: double.infinity,
// child: ElevatedButton(
// style: ElevatedButton.styleFrom(
//
// ),
// onPressed: () async{
// StudentModel model= StudentModel(studentName: studentNameController.text, fathersName: fathersNameController.text, mothersName: mothersNameController.text, birthDate: datePicker, roll: rollController.text, studentLanguase: initialLanguage, studentInistitute: studentinistitutecontroller.text, studentGrup: grupcontroller.text, bloodGrup: bloodgrupcontroller.text, className: classNamecontroller.text, studentsContact: contactcontroller.text, pictureUrl: _imageUrl);
// await FirebaseDatabase.instance.ref('Student Information').push().set(model.toJson()).then((value) {
// EasyLoading.showSuccess('Done');
// StudentList().launch(context);
//
// });
// },
// child: const Text('Registration',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),)),
// )
// ],
