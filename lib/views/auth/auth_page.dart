import 'package:banreda_chat/views/auth/signin.dart';
import 'package:banreda_chat/views/auth/signup.dart';
import 'package:flutter/cupertino.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  bool getState() => isLogin;

  @override
  Widget build(BuildContext context) => isLogin
      ? SignIn(onClickedSignUp: toggle)
      : SignUp(onClickedSignIn: toggle);

  void toggle() => setState(() => isLogin = !isLogin);
}