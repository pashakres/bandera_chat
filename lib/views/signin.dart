import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/widget.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarMain(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            TextField(
              decoration: textFieldInputDecoration("Email")
            ),
            TextField(
              decoration: textFieldInputDecoration("Password")
            ),
            const SizedBox(height: 8),
            Container(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: const Text("Forgot Password"),
              )
            ),
            const SizedBox(height: 8),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFFDC500),
                    const Color(0xFFFFD500),
                  ]
                )
              ),
              child: const Text("Sign In", style: TextStyle(fontSize: 17)),
            )
          ],
        ),
      )
    );
  }
}
