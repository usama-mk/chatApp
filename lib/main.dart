import 'package:com_snaps/Chats/RecentChats_home.dart';
import 'package:com_snaps/Chats/SearchScreen.dart';
import 'package:com_snaps/Login/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Chats/Chat.dart';
import 'Welcome/Model/constants.dart';
import 'Welcome/View/welcome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (ctx, userSnapshot) {
          if (userSnapshot.hasData) {
            //return IndividualMessages();
            return RecentChats();
          }
          return LoginScreen();
        },
      ),
      routes: {
        LoginScreen.routeName: (ctx) => LoginScreen(),
        SearchScreen.routeName: (ctx) => SearchScreen(),
      },
    );
  }
}
