import 'package:com_snaps/Welcome/Model/constants.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  const RoundedButton({
    Key key,
    this.text,
    this.press,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
          color: color,
          child: FlatButton(
              padding: EdgeInsets.symmetric(vertical: 18, horizontal: 40),
              onPressed: press,
              child: Text(
                text,
                style: TextStyle(color: textColor),
              )),
        ),
      ),
    );
  }
}
