import 'package:flutter/material.dart';

class AppBarMain extends StatelessWidget implements PreferredSizeWidget {
  const AppBarMain({Key? key}) : super(key: key);

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

InputDecoration textFieldInputDecoration(String hintText){
  return InputDecoration(
      hintText: hintText,
      focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFFDC500))
      )
  );
}
