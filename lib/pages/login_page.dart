import 'package:chatapp/pages/chat_page.dart';
import 'package:chatapp/widgets/custom_button.dart';
import 'package:chatapp/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants.dart';
import '../helper/show_snack_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading=false;
  String? emailAddress;
  String? password;
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
                        padding: EdgeInsets.all(mediaQuery.size.width * 0.02),
                        child: const Text('Login',style: TextStyle(color: kPrimaryColor,fontSize: 22.0,fontWeight: FontWeight.bold),),),
                            const SizedBox(height: 10,),
                            CustomFormTextField(hint: 'Email Address',prefix: Icons.email,onChanged: (data)
                              {
                                emailAddress=data;
                              },),
                            CustomFormTextField(hint: 'Password',suffix: Icons.visibility_off,prefix: Icons.lock,isObscureText: true,onChanged: (data)
                              {
                                password=data;
                              },),

                            CustomButton(text: 'Login', onPress: ()
                            async{
                              isLoading=true;
                              setState(() {
                              });
                              if(formkey.currentState!.validate())
                              {
                                try{
                                  await loginUser();
                                  // ignore: use_build_context_synchronously
                                  Navigator.pushNamed(context, ChatPage.id,arguments: emailAddress);
                                } on FirebaseAuthException catch (e)
                                {
                                  if (e.code == 'user-not-found') {
                                    ShowSnackBar(context,'No user found for that email.');
                                  } else if (e.code == 'wrong-password') {
                                    ShowSnackBar(context, 'Wrong password provided for that user.');
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
                                const Text("Don\'t have an account? " ,style: TextStyle(color:kPrimaryColor ),),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, 'Signup');
                                    },
                                    child: Text('Sign Up',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: mediaQuery.size.width * 0.04,
                                            color: kPrimaryColor,
                                            decoration: TextDecoration.underline)))
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
  Future<void> loginUser() async {
    var auth=FirebaseAuth.instance;
    UserCredential user= await auth.signInWithEmailAndPassword(email: emailAddress!, password: password!);
  }
}
