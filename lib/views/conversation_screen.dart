import 'package:flutter/material.dart';

import 'package:banreda_chat/helper/constants.dart';
import 'package:banreda_chat/services/database.dart';

import '../widgets/widget.dart';

class ConversationScreen extends StatefulWidget {
  final String chatRoomId;

  const ConversationScreen({Key? key, required this.chatRoomId})
      : super(key: key);

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {

  DataBaseMethods databaseMethods = DataBaseMethods();
  TextEditingController messageController = TextEditingController();

  Stream? chatMessageStream;

  Widget ChatMessageList(){
    return StreamBuilder(
      stream: chatMessageStream,
      builder: (context,AsyncSnapshot<dynamic> snapshot){
        return snapshot.data == null
          ? Container()
          : ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index){
                return MessageTile(
                  message: snapshot.data.docs[index]["message"],
                  isSendByMe: snapshot.data
                      .docs[index]["sendBy"] == Constants.myName
                );
              },
          );
      },
    );
  }

  sendMessage(){
    if(messageController.text.isNotEmpty){
      Map<String, dynamic> messageMap = {
        "message": messageController.text,
        "sendBy": Constants.myName,
        "time": DateTime.now().millisecondsSinceEpoch
      };
      databaseMethods.addConversationMessage(widget.chatRoomId, messageMap);
      messageController.text = "";
    }
  }

  @override
  void initState() {
    databaseMethods.getConversationMessage(widget.chatRoomId).then((value){
      setState(() {
        print("Value:");
        print(value.toString());
        chatMessageStream = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMain(),
      body: Container(
        child: Stack(
          children: [
            ChatMessageList(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Color(0xFF0D47A1),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                         controller: messageController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              hintText: "Message...",
                              hintStyle: TextStyle(color: Colors.white54),
                              border: InputBorder.none
                          ),
                        )),
                    GestureDetector(
                      onTap: (){
                        sendMessage();
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
                          padding: EdgeInsets.all(12),
                          child: Image.asset("image/send.png")),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByMe;
  const MessageTile({
    Key? key,
    required this.message,
    required this.isSendByMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isSendByMe ? const [
              Color(0xFF00509D),
              Color(0xFF003F7F)
            ] : const [
              Color(0xFF383838),
              Color(0xFF282828)
            ]
          )
        ),
        child: Text(message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.5
          )
        )
      ),
    );
  }
}
