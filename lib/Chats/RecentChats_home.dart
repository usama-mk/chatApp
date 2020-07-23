import 'package:com_snaps/Chats/RecentUsersStream.dart';
import 'package:com_snaps/Chats/SearchScreen.dart';
import 'package:com_snaps/Login/loginScreen.dart';
import 'package:com_snaps/Welcome/Model/constants.dart';
import 'package:com_snaps/helper/constants.dart';
import 'package:com_snaps/helper/helperfunctions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecentChats extends StatefulWidget {
  static const routeName = '/recentChats';
  @override
  _RecentChatsState createState() => _RecentChatsState();
}

class _RecentChatsState extends State<RecentChats> {
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      getMyName();
    });

    super.initState();
  }

  getMyName() async {
    await HelperFunctions.getUserNameSharedPreference()
        .then((value) => Constants.myName = value);
    print(Constants.myName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chats'),
          actions: <Widget>[
            DropdownButton(
              items: [
                DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.exit_to_app),
                        SizedBox(
                          width: 8,
                        ),
                        Text('Logout'),
                      ],
                    ),
                  ),
                  value: 'logout',
                )
              ],
              onChanged: (itemIdentifier) async {
                if (itemIdentifier == 'logout') {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  await preferences.clear();
                  Navigator.of(context).pop();

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                  FirebaseAuth.instance.signOut();
                }
              },
              icon: Icon(
                Icons.more_vert,
                color: kPrimaryColor,
              ),
            ),
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: RecentUsersStream(),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: kPrimaryColor,
          onPressed: () {
            print(Constants.myName);
            Navigator.of(context).pushNamed(SearchScreen.routeName);
          },
          child: Icon(
            Icons.message,
          ),
        ));
  }
}
