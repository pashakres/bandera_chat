import 'package:banreda_chat/helper/constants.dart';
import 'package:banreda_chat/helper/helperfunctions.dart';
import 'package:banreda_chat/widgets/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:banreda_chat/views/search.dart';
import 'package:banreda_chat/views/auth/auth_page.dart';


import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async{
     Constants.myName = (await HelperFunctions.getUserNameSharedPreference())!;
     setState(() {

     });
  }


  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return  Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context)=> SearchScreen()
          ));
        },
      ),
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

