// ignore_for_file: non_constant_identifier_names

import 'package:chatapp/widgets/custom_button.dart';
import 'package:chatapp/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants.dart';
import '../helper/show_snack_bar.dart';
import 'chat_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? emailAddress;

  String? password;

  bool isLoading=false;

  GlobalKey<FormState> formkey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/chat1.png'),
                  Padding(
                    padding:  EdgeInsets.all(mediaQuery.size.width * 0.02),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Sign up',style: TextStyle(color: kPrimaryColor,fontSize: 22.0,fontWeight: FontWeight.bold),),
                        const SizedBox(height: 10,),
                        CustomFormTextField(hint: 'Email Address',prefix: Icons.email,onChanged: (data)
                          {
                            emailAddress=data;
                          },),
                        CustomFormTextField(hint: 'Password',suffix: Icons.visibility_off,prefix: Icons.lock,isObscureText: true,onChanged: (data)
                          {
                            password=data;
                          },),

                        CustomButton(text: 'Sign up', onPress: () async{
                          isLoading=true;
                          setState(() {
                          });
                          if(formkey.currentState!.validate())
                            {
                              try{
                                await RegisterUser();
                                // ignore: use_build_context_synchronously
                                Navigator.pushNamed(context, ChatPage.id,arguments: emailAddress);
                              } on FirebaseAuthException catch (e)
                              {
                                if (e.code == 'weak-password') {
                                  ShowSnackBar(context,'The password provided is too weak.');
                                } else if (e.code == 'email-already-in-use') {
                                  ShowSnackBar(context, 'The account already exists for that email.');
                                }
                              }catch(ex)
                              {
                                ShowSnackBar(context, ex.toString());
                              }
                              isLoading=false;
                              setState(() {
                              });
                            }
                          else
                            {
                              ShowSnackBar(context, 'There was an error');

                            }


                        }, backColor: kPrimaryColor, textColor: Colors.white),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an account? " ,style: TextStyle(color:kPrimaryColor ),),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Login',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: mediaQuery.size.width * 0.04,
                                        color: kPrimaryColor,
                                        decoration: TextDecoration.underline)))
                          ],
                        )

                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),

    );
  }
  Future<void> RegisterUser() async {
     var auth=FirebaseAuth.instance;
    UserCredential user= await auth.createUserWithEmailAndPassword(email: emailAddress!, password: password!);
  }
}
