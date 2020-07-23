import 'package:com_snaps/Chats/msgTile.dart';
import 'package:com_snaps/Model/Msg.dart';
import 'package:com_snaps/Welcome/Model/constants.dart';
import 'package:com_snaps/helper/constants.dart';
import 'package:com_snaps/services/database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Chat extends StatefulWidget {
  static String mutualId;
  final String recieverName;

  const Chat({this.recieverName});
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  getChatRoomId(String a, String b) {
    if ((a.compareTo(b) > 0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  Map<String, dynamic> retrievedData;
  QuerySnapshot b;
  final searchEditingController = TextEditingController();
  identity(mp) {
    databaseMethods.setIdentity(mp);
  }

  addData(String mutualId) {
    Msg msg1 = new Msg(
      msg: searchEditingController.text,
      name: Constants.myName,
      time: DateTime.now().millisecondsSinceEpoch,
    );
    databaseMethods.addChat(msg1, mutualId);
    searchEditingController.clear();
  }

  // String a = getChatRoomId('Faizan', 'Usama');
  @override
  void initState() {
    Chat.mutualId = getChatRoomId(Constants.myName, widget.recieverName);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    databaseMethods.readChat(Chat.mutualId);
    //  String a = getChatRoomId('Faizan', 'Usama');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recieverName),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(child: chatContents(context)),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchEditingController.text;
                      });
                    },
                    controller: searchEditingController,
                    decoration: InputDecoration(
                        labelText: 'Enter a message ...',
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        )),
                  ),
                ),
                IconButton(
                    icon: Icon(
                      Icons.send,
                      color: searchEditingController.text.isNotEmpty
                          ? kPrimaryColor
                          : null,
                    ),
                    onPressed: () {
                      print('pppppppppppppppp');
                      print(Constants.myName);
                      Chat.mutualId =
                          getChatRoomId(Constants.myName, widget.recieverName);

                      print(Chat.mutualId);
                      identity({
                        'arr': [Constants.myName, widget.recieverName],
                        'chatRoomId': Chat.mutualId
                      });
                      return addData(Chat.mutualId);
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget chatContents(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      child: StreamBuilder<List<Msg>>(
        stream: databaseMethods.readChat(Chat.mutualId),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            print('data shta msgs ki');
            final msgsData = snapshot.data;
            print(snapshot.data);
            final msgs =
                msgsData.map((msgClass) => Text(msgClass.msg)).toList();
            final users =
                msgsData.map((msgClass) => Text(msgClass.name)).toList();
            // print(msgs[0].data);
            return ListView.builder(
                itemCount: msgs.length,
                itemBuilder: (ctx, i) {
                  print(msgs[i].data.toString());
                  //return msgs[i];
                  return MessageTile(
                      message: msgs[i].data,
                      sendByMe:
                          users[i].data == Constants.myName ? true : false);
                });
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Some error occurred'),
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
