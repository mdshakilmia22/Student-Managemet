import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:student_firebase/Screen/Addstudent.dart';
import 'package:student_firebase/Screen/singup.dart';

class SingInPage extends StatefulWidget {

  const SingInPage({Key? key}) : super(key: key);
  @override
  State<SingInPage> createState() => _SingInPageState();
}

class _SingInPageState extends State<SingInPage> {
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children:  [
                  const Text('SIGN IN',style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold,fontSize: 35,fontFamily: 'Lobster'),),
                  const SizedBox(height: 30,),
                  AppTextField(
                      textFieldType: TextFieldType.EMAIL,
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Email Address',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                  ),
                  const SizedBox(height: 15,),
                  AppTextField(
                    textFieldType: TextFieldType.PASSWORD,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: 'Enter Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30,),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepOrange,
                      ),
                        onPressed: () async{
                          try {
                            EasyLoading.show(status: 'Singing In');
                            final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text,
                            );
                            EasyLoading.showSuccess('SingIn Successful');
                            AddStudent().launch(context);
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
                        child: const Text('Sign In',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold,),)),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Do you have any Accounts?'),
                      TextButton(onPressed: (){
                        SingUpPage().launch(context);

                      }, child: Text('Sign Up'))
                    ],
                  )

                ],
              ),
            ),
          ),
        )),
    );
  }
}
