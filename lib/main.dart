import 'package:banreda_chat/helper/helperfunctions.dart';
import 'package:banreda_chat/utils/utils.dart';
import 'package:banreda_chat/views/auth/auth_page.dart';
import 'package:banreda_chat/views/chatrooms_screen.dart';
import 'package:banreda_chat/widgets/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool userIsLoggedIn = false;

  @override
  void initState() {
   // getLoggedInState();
    super.initState();
  }

  getLoggedInState() async{
    await HelperFunctions.getUserLoggedInSharedPreference()
        .then((value) {
          setState(() {
            userIsLoggedIn = value!;
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        scaffoldMessengerKey: Utils.messengerKey,
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFF5BC0EB),
          primarySwatch: Colors.blue,
        ),
        home: userIsLoggedIn ? const HomePage() : const MainPage()
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) =>
      StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const Scaffold(
                  appBar: AppBarSigned(),
                  body: HomePage()
              );
            } else {
              return const Scaffold(
                  appBar: AppBarMain(),
                  body: AuthPage()
              );
            }
          }
      );
}






