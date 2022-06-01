import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:banreda_chat/services/database.dart';
import 'package:banreda_chat/views/conversation_screen.dart';
import 'package:banreda_chat/widgets/widget.dart';
import 'package:banreda_chat/helper/constants.dart';


class SearchScreen extends StatefulWidget{
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  DataBaseMethods dataBaseMethods = DataBaseMethods();
  TextEditingController searchTextEditingController = TextEditingController();

  QuerySnapshot? searchSnapshot;

  initiateSearch(){
    dataBaseMethods.getUserByUserName(searchTextEditingController.text).then((val){
      setState(() {
        searchSnapshot = val;
      });
    });
  }

  Widget searchList(){
    if (searchSnapshot != null) {
      return ListView.builder(
        itemCount: searchSnapshot!.docs.length,
        shrinkWrap: true,
        itemBuilder: (context, index){
          return searchTitle(
            userName: searchSnapshot!.docs[index]["name"],
            userEmail: searchSnapshot!.docs[index]["email"],
          );
        });
    } else {
      return Container();
    }
  }
  /// create chatroom, send user to conversation room, pushreplacement

  createChatroomAndStartConversation( String userName){
    if(userName != Constants.myName) {
      if(Constants.myName.isEmpty){
        print("Name not found");
      }
      String chatRoomId = getChatRoomId(userName, Constants.myName);
      List<String> users = [userName, Constants.myName];
      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatroomid": chatRoomId
      };
      DataBaseMethods().createChatRoom(chatRoomId, chatRoomMap);
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ConversationScreen(
            chatRoomId: chatRoomId
          )));
    } else {
      print("You cannot send message to yourself");
    }
  }


  Widget searchTitle( {String? userName, String? userEmail}){
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userName!, style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),),
                Text(userEmail!, style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),)
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: (){
                createChatroomAndStartConversation(userName);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(30)
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16,  vertical: 8),
                child: const Text("Message", style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),),
              ),
            )
          ],
        )
    );
  }

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMain(),
      body: Container(
        child: Column(
          children: [
            Container(
              color: const Color(0xFF0D47A1),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child:  TextField(
                        controller: searchTextEditingController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: "search username...",
                        hintStyle: TextStyle(color: Colors.white54),
                        border: InputBorder.none
                      ),
                    )),
                  GestureDetector(
                    onTap: (){
                      initiateSearch();
                    },
                    child: Container(
                      height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFB71C1C),
                              Color(0xFF000000)
                            ]
                          ),
                          borderRadius: BorderRadius.circular(40)
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Image.asset("image/search_white.png")),
                  )
                ],
              ),
            ),
          searchList()
          ],
        ),
      )
      );
  }
  
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}


