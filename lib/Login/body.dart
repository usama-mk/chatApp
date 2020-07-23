import 'package:com_snaps/Chats/RecentChats_home.dart';
import 'package:com_snaps/Welcome/Model/constants.dart';
import 'package:com_snaps/helper/constants.dart';
import 'package:com_snaps/helper/helperfunctions.dart';
import 'package:com_snaps/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'background.dart';
import 'loginsignupformwidget.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // AuthService authService = new AuthService();
  DatabaseMethods databaseMethods = new DatabaseMethods(); //remove
  final auth = FirebaseAuth.instance;
  var _isLoading = false;
  void _onSubmit(
      {String username,
      String email,
      String password,
      bool islogin,
      BuildContext ctx}) async {
    AuthResult authResult;

    try {
      setState(() {
        _isLoading = true;
      });
      if (islogin) {
        authResult = await auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((result) async {
          if (result != null) {
            QuerySnapshot userInfoSnapshot =
                await DatabaseMethods().getUserInfo(email);

            HelperFunctions.saveUserLoggedInSharedPreference(true);
            HelperFunctions.saveUserNameSharedPreference(
                userInfoSnapshot.documents[0].data["userName"]);
            Constants.myName = userInfoSnapshot.documents[0].data["userName"];
            print('aaaaaaaaaaaaa');
            print(Constants.myName);
            HelperFunctions.saveUserEmailSharedPreference(
                userInfoSnapshot.documents[0].data["userEmail"]);

            Navigator.pushReplacement(
                ctx, MaterialPageRoute(builder: (context) => RecentChats()));
          }
          return result;
        });
      } else {
        authResult = await auth.createUserWithEmailAndPassword(
            email: email, password: password);

        if (authResult != null) {
          Map<String, String> userDataMap = {
            "userName": username,
            "userEmail": email
          };
          print(username);
          print(email);
          print('zzzzzzzzzzz');
          print(userDataMap);
          databaseMethods.addUserInfo(userDataMap);

          HelperFunctions.saveUserLoggedInSharedPreference(true);
          HelperFunctions.saveUserNameSharedPreference(username); //hardcode now
          HelperFunctions.saveUserEmailSharedPreference(email);

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => RecentChats()));
        }
      }
    } on PlatformException catch (err) {
      var message = 'An error occurred please check your credentials';
      if (err.message != null) {
        print('zzzzzzzzzzz PF Err');
        message = err.message;
      }
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print('zzzzzzzzzzz catched Err');
      print(err);

      // setState(() {
      //   _isLoading = false;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SvgPicture.asset(
              'lib/Assets/Icons/login.svg',
              height: size.height * 0.3,
            ),
            Container(
              width: size.width * 0.81,
              child: LoginSignupForm(_onSubmit, _isLoading),
            ),
          ],
        ),
      ),
    );
  }
}
