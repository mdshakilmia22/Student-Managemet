import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:student_firebase/Screen/Addstudent.dart';
import 'package:student_firebase/Screen/sing_in.dart';
class SingUpPage extends StatefulWidget {
  const SingUpPage({Key? key}) : super(key: key);

  @override
  State<SingUpPage> createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {

  TextEditingController fnameController=TextEditingController();
  TextEditingController lnameController=TextEditingController();
  TextEditingController numberController=TextEditingController();
  TextEditingController mailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                          textAlignVertical: TextAlignVertical.bottom,
                          controller: fnameController,
                          textFieldType: TextFieldType.NAME,
                          decoration: InputDecoration(
                              hintText: 'Enter FirstName',
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
                          controller: lnameController,
                          textAlignVertical: TextAlignVertical.bottom,
                          textFieldType: TextFieldType.NAME,
                          decoration: InputDecoration(
                              hintText: 'Enter LastName',
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
                          controller: numberController,
                          textAlignVertical: TextAlignVertical.bottom,
                          textFieldType: TextFieldType.PHONE,
                          decoration: InputDecoration(
                              hintText: 'Moblile Number',
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
                          controller: mailController,
                          textAlignVertical: TextAlignVertical.bottom,
                          textFieldType: TextFieldType.EMAIL,
                          decoration: InputDecoration(
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
                              hintText: 'Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              )
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        height: 45,
                        width: double.infinity,

                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.deepOrange,
                            ),
                            onPressed: () async {
                              try {
                                EasyLoading.show(status: 'Siging Up...');
                                final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                  email: mailController.text,
                                  password: passwordController.text,
                                );
                                EasyLoading.showSuccess('SingUp Succesful');
                                SingInPage().launch(context);
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'weak-password') {
                                  EasyLoading.showError('weak password');
                                  print('The password provided is too weak.');
                                } else if (e.code == 'email-already-in-use') {
                                  EasyLoading.showError('Email Already in use');
                                  print('The account already exists for that email.');
                                }
                              } catch (e) {
                                print(e);
                              }
                            },
                            child: Text('Sign Up',style: TextStyle(color: Colors.white,fontFamily: 'Merriweather',fontSize: 20),)),
                      ),
                      SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have an Accounts?'),
                          TextButton(
                              onPressed: (){
                                SingInPage().launch(context);
                              },
                              child: const Text('Sign In',style: TextStyle(color: Colors.deepOrange,fontFamily: 'Merriweather',fontSize: 16),))
                        ],
                      ),
                    ],
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
