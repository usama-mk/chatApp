import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:com_snaps/Welcome/Model/constants.dart';
import 'package:com_snaps/helper/constants.dart';
import 'package:com_snaps/services/database.dart';
import 'package:flutter/material.dart';

import 'Chat.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/searchScreen';
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  QuerySnapshot searchResultSnapshot;
  DatabaseMethods databaseMethods = new DatabaseMethods(); //REMOVE
  final searchEditingController = TextEditingController();
  bool isLoading; //implement later
  bool haveUserSearched = false; //removeeeee
  initiateSearch() async {
    if (searchEditingController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await databaseMethods
          .searchByName(searchEditingController.text)
          .then((snapshot) {
        searchResultSnapshot = snapshot;
        print("$searchResultSnapshot");
        setState(() {
          haveUserSearched = true;
          isLoading = false;
        });
      });
    }
  }

  Widget userList() {
    return haveUserSearched
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchResultSnapshot.documents.length,
            itemBuilder: (context, index) {
              return userTile(
                searchResultSnapshot.documents[index].data["userName"],
                searchResultSnapshot.documents[index].data["userEmail"],
              );
            })
        : Container();
  }

  sendMessage(String userName) {
    // print('hi');
    // List<String> users = [Constants.myName, userName];

    // String chatRoomId = getChatRoomId(Constants.myName, userName);

    // Map<String, dynamic> chatRoom = {
    //   "users": users,
    //   "chatRoomId": chatRoomId,
    // };

    // databaseMethods.addChatRoom(chatRoom, chatRoomId);
    // print('after adding to db');

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Chat(
                  recieverName: userName,
                )));
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  @override
  void initState() {
    super.initState();
  }

  Widget userTile(String userName, String userEmail) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                userEmail,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              sendMessage(userName);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(24)),
              child: Text(
                "Message",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: searchEditingController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      hintText: "search username ...",
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 16,
                      ),
                      border: InputBorder.none),
                ),
              ),
              GestureDetector(
                onTap: () {
                  initiateSearch();
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            const Color(0x36FFFFFF),
                            const Color(0x0FFFFFFF)
                          ],
                          begin: FractionalOffset.topLeft,
                          end: FractionalOffset.bottomRight),
                      borderRadius: BorderRadius.circular(40)),
                  padding: EdgeInsets.all(12),
                  child: Icon(Icons.search),
                ),
              )
            ],
          ),
          userList()
        ],
      )),
    );
  }
}
