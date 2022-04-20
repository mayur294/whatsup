import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsup_v1/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsup_v1/components.dart';
var loggedInUser;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  var messageText;
  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () async {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️whatsup!'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(firestore: _firestore),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      try {
                        _firestore.collection("messages").add({
                          'text': messageText,
                          'sender': loggedInUser.email,
                          'date' : DateTime.now(),
                        });
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  const MessageStream({
    Key? key,
    required FirebaseFirestore firestore,
  })  : _firestore = firestore,
        super(key: key);

  final FirebaseFirestore _firestore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection("messages").orderBy('date').snapshots(),
        builder: (context, snapshot) {
          List<BubbleMessage> messageswidget = [];
          if (snapshot.hasData) {
            final messages = snapshot.data!.docs.reversed;
            for (var message in messages) {
              final messageText = message.get('text');
              final messageSender = message.get('sender');
              final messageWidget =
                  BubbleMessage(
                    message: messageText,
                    sender: messageSender,
                    isMe: loggedInUser.email.toString() == messageSender,
                  );
              messageswidget.add(messageWidget);
            }
          }
          return Expanded(
            child: ListView(
              reverse: true,
              children: messageswidget,
            ),
          );
        });
  }
}


