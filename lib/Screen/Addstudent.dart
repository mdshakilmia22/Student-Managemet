import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:student_firebase/Model/model.dart';
import 'package:student_firebase/porvider/studentprovider.dart';

class AddStudentPage extends StatefulWidget {
  const AddStudentPage({Key? key}) : super(key: key);

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  List<String> languages = ['English', 'Bangla'];
  String initialLanguage = 'English';

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

  final ImagePicker _picker = ImagePicker();
  XFile? image;
  String? _imageUrl;
  Future<void> getImage() async {
    image = await _picker.pickImage(source: ImageSource.gallery);
    var snapshot = await FirebaseStorage.instance.ref('Student Image').child(DateTime.now().microsecondsSinceEpoch.toString()).putFile(File(image!.path));
    _imageUrl = await snapshot.ref.getDownloadURL();
    setState(() {});
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController fathersNameController = TextEditingController();
  TextEditingController motherNameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController studentIdController = TextEditingController();
  TextEditingController inistituteController = TextEditingController();
  TextEditingController studentGrupController = TextEditingController();
  TextEditingController bloodGrupController = TextEditingController();
  TextEditingController classNameController = TextEditingController();
  TextEditingController studentcontactController = TextEditingController();
  TextEditingController pictureUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lime,
        title: const Text(
          'Add student',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Consumer(
              builder: (_, ref, watch) {
                return Column(children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.red,
                            image: image == null
                                ? const DecorationImage(
                                image: AssetImage('images/student.png'),
                                fit: BoxFit.cover)
                                : DecorationImage(
                                image: FileImage(File(image!.path)),
                                fit: BoxFit.cover)),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.camera_alt,
                            size: 30,
                            color: Colors.black,
                          ),
                        ),
                      ).onTap(() => getImage()),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  AppTextField(
                    textFieldType: TextFieldType.NAME,
                    controller: nameController,
                    decoration: InputDecoration(
                        hintText: 'Student\'s Name',
                        hintStyle: TextStyle(fontSize: 18),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AppTextField(
                    textFieldType: TextFieldType.NAME,
                    controller: fathersNameController,
                    decoration: InputDecoration(
                        hintText: 'Father\'s Name',
                        hintStyle: const TextStyle(fontSize: 18),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AppTextField(
                    textFieldType: TextFieldType.NAME,
                    controller: motherNameController,
                    decoration: InputDecoration(
                        hintText: 'Mother\'s Name',
                        hintStyle: const TextStyle(fontSize: 18),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AppTextField(
                    textFieldType: TextFieldType.NUMBER,
                    controller: studentIdController,
                    decoration: InputDecoration(
                        hintText: 'Student\'s Id',
                        hintStyle: const TextStyle(fontSize: 18),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AppTextField(
                    textFieldType: TextFieldType.NUMBER,
                    controller: birthDateController,
                    readOnly: true,
                    decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: DateTime.now().toString().substring(0, 10),
                        suffixIcon:
                        const Icon(Icons.calendar_month).onTap(() async {
                          var date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime.now(),
                          );
                          setState(() {
                            birthDateController.text =
                                date.toString().substring(0, 10);
                          });
                        }),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AppTextField(
                    textFieldType: TextFieldType.NAME,
                    controller: inistituteController,
                    decoration: InputDecoration(
                        hintText: 'Inistitute Name',
                        hintStyle: const TextStyle(fontSize: 18),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AppTextField(
                    textFieldType: TextFieldType.NAME,
                    controller: bloodGrupController,
                    decoration: InputDecoration(
                        hintText: 'Blood Group',
                        hintStyle: const TextStyle(fontSize: 18),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: context.width(),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: SizedBox(
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child:
                        DropdownButtonHideUnderline(child: getLanguages()),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AppTextField(
                    textFieldType: TextFieldType.NAME,
                    controller: studentGrupController,
                    decoration: InputDecoration(
                        hintText: 'Student\'s Group',
                        hintStyle: const TextStyle(fontSize: 18),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AppTextField(
                    textFieldType: TextFieldType.NAME,
                    controller: classNameController,
                    decoration: InputDecoration(
                        hintText: 'Class Name',
                        hintStyle: const TextStyle(fontSize: 18),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AppTextField(
                    textFieldType: TextFieldType.NUMBER,
                    controller: studentcontactController,
                    decoration: InputDecoration(
                        hintText: 'Emergency Contact Number',
                        hintStyle: const TextStyle(fontSize: 18),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.deepOrange),
                        onPressed: () async {
                          StudentModel model = StudentModel(
                              studentName: nameController.text,
                              fathersName: fathersNameController.text,
                              mothersName: motherNameController.text,
                              birthDate: birthDateController.text,
                              roll: studentIdController.text,
                              studentInistitute: inistituteController.text,
                              studentGrup: studentGrupController.text,
                              bloodGrup: bloodGrupController.text,
                              className: classNameController.text,
                              studentsContact: studentcontactController.text,
                              studentLanguase: initialLanguage,
                              pictureUrl: _imageUrl);
                          await FirebaseDatabase.instance.ref('Student Information').push().set(model.toJson()).then((value) {
                            EasyLoading.showSuccess('Done');
                            ref.refresh(studentProvider);
                          });
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Registration',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        )),
                  )
                ]);
              },
            ),
          ),
        ),
      ),
    );
  }
}