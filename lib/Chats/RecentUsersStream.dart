import 'package:com_snaps/Chats/Chat.dart';
import 'package:com_snaps/Welcome/Model/constants.dart';
import 'package:com_snaps/helper/constants.dart';
import 'package:com_snaps/services/T.dart';
import 'package:com_snaps/services/database.dart';
import 'package:flutter/material.dart';

class RecentUsersStream extends StatefulWidget {
  @override
  _RecentUsersStreamState createState() => _RecentUsersStreamState();
}

class _RecentUsersStreamState extends State<RecentUsersStream> {
  Stream chatRooms;
  getUserInfogetChats() async {}

  DatabaseMethods databaseMethods = new DatabaseMethods();
  @override
  void initState() {
    // TODO: implement initState
    getUserInfogetChats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<T>>(
      stream: DatabaseMethods().getUserChats(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print('DATA of List T');
          // print(snapshot.data[0].t);
          final child = snapshot.data.map((T) => Text(T.t)).toList();
          // if (child.isEmpty) {
          //   print('length of child list');
          //   print(child.length);
          // }
          return ListView.builder(
              itemCount: child.length,
              itemBuilder: (ctx, i) {
                return ChatRoomsTile(
                  chatRoomId: child[i].data,
                  userName: child[i]
                      .data
                      .toString()
                      .replaceAll("_", "")
                      .replaceAll(Constants.myName, ""),
                );
              });
        }
        return Container();
        //   print('length======== ${snapshot.data.documents.length}');
        // return snapshot.hasData
        //     ? ListView.builder(
        //         itemCount: snapshot.data.documents.length,
        //         shrinkWrap: true,
        //         itemBuilder: (context, index) {
        //           return Text('Usama');
        //         })
        //     : Container();
      },
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;

  ChatRoomsTile({this.userName, @required this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Chat(
                      recieverName: userName,
                    )));
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              padding: EdgeInsets.all(5),
              color: kPrimaryColor,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  userName.substring(0, 1),
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          title: Text(
            userName,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text('message..'),
          trailing: Icon(
            Icons.input,
            color: kPrimaryLightColor,
          ),
        ),
      ),
    );
  }
}
