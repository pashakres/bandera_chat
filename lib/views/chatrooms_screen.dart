import 'dart:math';

import 'package:banreda_chat/services/database.dart';
import 'package:banreda_chat/views/conversation_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:banreda_chat/helper/constants.dart';
import 'package:banreda_chat/helper/helperfunctions.dart';
import 'package:banreda_chat/views/search.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  DataBaseMethods databaseMethods = DataBaseMethods();

  Stream? chatRoomsStream;

  Widget chatRoomList(){
    return StreamBuilder(
      stream: chatRoomsStream,
      builder: (context, AsyncSnapshot<dynamic> snapshot){
        return snapshot.data == null
            ? Container()
            : ListView.builder(
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index){
            return ChatRoomTile(
              userName: snapshot.data.docs[index]["chatroomid"]
                .toString().replaceAll("_", "")
                .replaceAll(Constants.myName, ""),
              chatRoom: snapshot.data.docs[index]["chatroomid"],
            );
          },
        );
      },
    );
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async{
     Constants.myName = (await HelperFunctions.getUserNameSharedPreference())!;
     databaseMethods.getChatRooms(Constants.myName).then((value){
       setState(() {
         chatRoomsStream = value;
       });
     });
     setState(() {
     });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: chatRoomList(),
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

class ChatRoomTile extends StatelessWidget {
  final String userName;
  final String chatRoom;

  const ChatRoomTile({
    Key? key,
    required this.userName,
    required this.chatRoom
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ConversationScreen(
                chatRoomId: chatRoom
            )
        ));
      },
      child: Column(
        children: [
          Container(
            color: Colors.black12,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
                    borderRadius: BorderRadius.circular(40)
                  ),
                  child: Text(userName.substring(0,1).toUpperCase()),
                ),
                const SizedBox(width: 8,),
                Text(userName),
              ],
            )
          ),
          const SizedBox(
            height: 1,
          ),
        ],
      ),
    );
  }
}

