import 'dart:ffi';
import 'package:chat_app/constants.dart';
import 'package:chat_app/login_screen.dart';
import 'package:chat_app/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
FirebaseFirestore _firestore=FirebaseFirestore.instance;
class ChatScreen extends StatefulWidget {
  static const String id='chatscreen';
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController chatcontrollor=TextEditingController();

  String? textMessage;
  final _auth=FirebaseAuth.instance;
  User? loggedInUser;
  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser()async
  {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    }
    catch (e) {

    }
  }
    void messageStream()async
    {
      await for(var snapshots in _firestore.collection('messages').snapshots()){
        for(var messages in snapshots.docs)
          {

          }
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Ranchat',style: title.copyWith(color: Colors.white,fontSize: 30),),
        actions: [
          IconButton(
              onPressed:(){
                Navigator.pushNamed(context, Login.id);
              } ,
              icon: const Icon(Icons.logout_outlined),),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream:  _firestore
                  .collection('messages')
                  .orderBy('time', descending: false)//add this
                  .snapshots(),
              builder: (context,snapshot){
                List<MessageBubble> messageWidget=[];
                if(!snapshot.hasData)
                  {
                    // return Center(
                    //   child: CircularProgressIndicator(
                    //     backgroundColor: Colors.blueAccent,
                    //   ),
                    // );
                  }
                    final messages=snapshot.data!.docs.reversed;
                    for(var message in messages)
                      {
                        final messageText=message['text'];
                        final messageSender=message['sender'];
                        final messageTime = message['time'] as Timestamp;
                        final curretUserEmail=loggedInUser!.email;
                        final messageWidge=MessageBubble(messageText,messageSender,curretUserEmail==messageSender,messageTime);
                        messageWidget.add(messageWidge);
                      }

                return Expanded(
                  child: ListView(
                    reverse: true,
                    children: messageWidget,
                  ),
                );
              },
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: chatcontrollor,

                    onChanged: (value){
                      textMessage=value;
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      hintText: 'Type a message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Colors.lightBlueAccent,width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Colors.lightBlueAccent,width: 2),
                      ),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  child: MaterialButton(
                    child: Icon(Icons.send,color: Colors.green,),
                    onPressed: ()async{
                     await _firestore.collection('messages').add({
                        'text':textMessage,
                        'sender':loggedInUser!.email,
                       'time': FieldValue.serverTimestamp(),
                      });
                     setState((){
                       chatcontrollor.clear();
                     });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
class MessageBubble extends StatelessWidget {
  MessageBubble(this.messageText,this.messageSender,this.isMe,this.time);
  bool isMe;
  final String messageText;
  final String messageSender;
  final Timestamp time;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isMe?CrossAxisAlignment.end:CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10,right: 10,bottom: 5,left: 10),
          child: Text('$messageSender'),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Material(
            elevation: 7,
            borderRadius: BorderRadius.circular(20),
            color: isMe?Colors.lightBlueAccent:Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('$messageText',maxLines: 80,overflow:TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize:16,
                  color: isMe?Colors.white:Colors.black,),),
            ),
          ),
        ),
      ],
    );
  }
}



