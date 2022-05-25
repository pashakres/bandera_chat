import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AppBarMain extends StatelessWidget implements PreferredSizeWidget {
  const AppBarMain(  {Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'BanderaChat',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      backgroundColor: const Color(0xFFFDC500),
      centerTitle: true,
      elevation: 0,
    );
  }
}
class AppBarSigned extends StatelessWidget implements PreferredSizeWidget {
  const AppBarSigned({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'BanderaChat',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      actions:  [
        GestureDetector(
          onTap: () {
            signOut();
          },
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Icon(Icons.exit_to_app)),
        )],
      backgroundColor: const Color(0xFFFDC500),
      centerTitle: true,
      elevation: 0,


    );
  }
}

Future signOut() async {
  try {
    await FirebaseAuth.instance.signOut();
  } on FirebaseAuthException catch(e) {
    print(e);
  }
}

InputDecoration textFieldInputDecoration(String hintText){
  return InputDecoration(
      hintText: hintText,
      focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFFDC500))
      )
  );
}
