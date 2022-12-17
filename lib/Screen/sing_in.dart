import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:student_firebase/Screen/singup.dart';
import 'package:student_firebase/Screen/student_list.dart';

import 'Addstudent.dart';

class SingInPage extends StatefulWidget {

  const SingInPage({Key? key}) : super(key: key);
  @override
  State<SingInPage> createState() => _SingInPageState();
}

class _SingInPageState extends State<SingInPage> {

  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('images/caps.png',height: 80, width: 80,),
                      const Text('ADMIT',style: TextStyle(color: Colors.blue,fontFamily: 'Lobster',fontWeight: FontWeight.w500,fontSize: 25),),
                      const Text('STUDENTS',style: TextStyle(color: Colors.deepOrange,fontFamily: 'Lobster',fontWeight: FontWeight.w500,fontSize: 25),),
                    ],
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    height: 50,
                    child: AppTextField(
                      controller: emailController,
                      textAlignVertical: TextAlignVertical.bottom,
                      textFieldType: TextFieldType.EMAIL,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.email),
                          hintText: 'Emal',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          )
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  SizedBox(
                    height: 50,
                    child: AppTextField(
                      controller: passwordController,
                      textAlignVertical: TextAlignVertical.bottom,
                      textFieldType: TextFieldType.PASSWORD,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          hintText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          )
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 45,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.deepOrange,
                            ),
                            onPressed: () async{
                              try {
                                EasyLoading.show(status: 'Singing In');
                                final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                                EasyLoading.showSuccess('SingIn Successful');
                                StudentList().launch(context);
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  EasyLoading.showError('No user found');
                                  print('No user found for that email.');
                                } else if (e.code == 'wrong-password') {
                                  EasyLoading.showError('wrong password');
                                  print('Wrong password provided for that user.');
                                }
                              }
                            },
                            child: Text('Sign In',style: TextStyle(color: Colors.white,fontFamily: 'Merriweather',fontSize: 20),)),
                      ),
                      TextButton(
                          onPressed: (){},
                          child: Text('Forgot Password',style: TextStyle(color: Colors.deepOrange,fontSize: 16),))
                    ],
                  ),
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Do you have any Accounts?'),
                      TextButton(
                          onPressed: (){
                            SingUpPage().launch(context);
                          },
                          child: const Text('Sign Up',style: TextStyle(color: Colors.deepOrange,fontFamily: 'Merriweather',fontSize: 16),))
                    ],
                  ),
                ],
              ),
            ),
          ),
        )),
    );
  }
}
