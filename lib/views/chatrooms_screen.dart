import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Container(
      child: Column(
        children: [
          Text(user!.email.toString()),
          ElevatedButton(onPressed: signOut, child: Text('Уйти'))
        ],
      )
    );
  }
  Future signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch(e) {
      print(e);
    }
  }
}
