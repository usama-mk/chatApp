import 'package:com_snaps/Login/loginScreen.dart';
import 'package:com_snaps/Welcome/Components/rounded_button.dart';
import 'package:com_snaps/Welcome/Model/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'background.dart';

class WelcomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'lib/Assets/Images/ComsatsCompressed1.png',
              height: size.height * 0.17,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Text(
              "Welcome to ComSnaps!",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Container(
              // padding: EdgeInsets.symmetric(horizontal: 35),
              child: Image.asset(
                'lib/Assets/Icons/chat.png',
                width: size.width * 0.81,
                height: size.height * 0.45,
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            RoundedButton(
              text: 'LOGIN',
              press: () {
                Navigator.of(context).pushNamed(LoginScreen.routeName);
              },
            ),
            RoundedButton(
              text: 'SIGNUP',
              press: () {},
              color: kPrimaryLightColor,
              textColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
