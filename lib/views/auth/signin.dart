import 'package:banreda_chat/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../helper/helperfunctions.dart';
import '../../main.dart';
import '../../utils/utils.dart';
import '../../widgets/widget.dart';

class SignIn extends StatefulWidget {
  final VoidCallback onClickedSignUp;


  const SignIn({Key? key, required this.onClickedSignUp})
    : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final formKey = GlobalKey<FormState>();
  DataBaseMethods dataBaseMethods = new DataBaseMethods();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  QuerySnapshot? snapshotUserInfo;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
           Form(
             key:formKey,
             child: Column(children: [
               TextField(
                   controller: emailController,
                   textInputAction: TextInputAction.next,
                   decoration: textFieldInputDecoration("Email")
               ),
               TextField(
                 controller: passwordController,
                 textInputAction: TextInputAction.done,
                 decoration: textFieldInputDecoration("Password"),
                 obscureText: true,
               ),
             ],),
           ),
            const SizedBox(height: 8),
            Container(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: const Text("Forgot Password"),
              )
            ),
            const SizedBox(height: 22),
            ElevatedButton(
              onPressed: signIn,
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFFFDC500),
                shape: const StadiumBorder()
              ),
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: const Text("Sign In", style: TextStyle(fontSize: 18)),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: signIn,
              style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF00509D),
                  shape: const StadiumBorder()
              ),
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: const Text("Sign In with Google", style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                )),
              ),
            ),
            const SizedBox(height: 18),
            RichText(
              text: TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = widget.onClickedSignUp,
                style: TextStyle(color: Colors.black),
                text: "Don't have account? Register now!"
              ),
            ),
            const SizedBox(height: 35)
          ],
        ),
      )
    );
  }
  Future signIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator())
    );

    HelperFunctions.saveUserEmailSharedPreference(emailController.text);

    dataBaseMethods.getUserByUserEmail(emailController.text).then((val){
        snapshotUserInfo = val;
        HelperFunctions.saveUserNameSharedPreference(snapshotUserInfo!.docs.isNotEmpty ? snapshotUserInfo!.docs[0]["name"] : '');
        print("${HelperFunctions.saveUserNameSharedPreference(snapshotUserInfo!.docs.isNotEmpty ? snapshotUserInfo!.docs[0]["name"] : '')}");
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch(e) {
      print(e);

      Utils.showSnackBar(e.message);
    }
    HelperFunctions.saveUserLoggedInSharedPreference(true);
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
