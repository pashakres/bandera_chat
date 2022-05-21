import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';

import '../../main.dart';
import '../../utils/utils.dart';
import '../../widgets/widget.dart';

class SignUp extends StatefulWidget {
  final Function() onClickedSignIn;

  const SignUp({Key? key, required this.onClickedSignIn})
    : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
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
              TextField(
                  controller: usernameController,
                  textInputAction: TextInputAction.next,
                  decoration: textFieldInputDecoration("Username")
              ),
              TextFormField(
                controller: emailController,
                textInputAction: TextInputAction.next,
                decoration: textFieldInputDecoration("Email"),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                  email != null && !EmailValidator.validate(email)
                    ? "Enter a valid email"
                    : null,
              ),
              TextFormField(
                controller: passwordController,
                textInputAction: TextInputAction.done,
                decoration: textFieldInputDecoration("Password"),
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => value != null && value.length < 6
                  ? 'Min. 6 characters'
                  : null,
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
                onPressed: signUp,
                style: ElevatedButton.styleFrom(
                    primary: const Color(0xFFFDC500),
                    shape: const StadiumBorder()
                ),
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: const Text("Sign Up", style: TextStyle(fontSize: 18)),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: signUp,
                style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF00509D),
                    shape: const StadiumBorder()
                ),
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: const Text("Sign Up with Google", style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  )),
                ),
              ),
              const SizedBox(height: 18),
              RichText(
                text: TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = widget.onClickedSignIn,
                    style: TextStyle(color: Colors.black),
                    text: "Already have account? Log In!"
                ),
              ),
              const SizedBox(height: 35)
            ],
          ),
        )
    );
  }
  Future signUp() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator())
    );

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch(e) {
      print(e);

      Utils.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
