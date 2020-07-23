import 'package:com_snaps/Welcome/Model/constants.dart';
import 'package:flutter/material.dart';

class LoginSignupForm extends StatefulWidget {
  LoginSignupForm(this._onSubmit, this.isLoading);
  final bool isLoading;
  final void Function(
      {String username,
      String email,
      String password,
      bool islogin,
      BuildContext ctx}) _onSubmit;

  @override
  _LoginSignupFormState createState() => _LoginSignupFormState();
}

class _LoginSignupFormState extends State<LoginSignupForm> {
  var _islogin = true;
  var _userEmail = '';
  var _userPassword = '';
  var _userName = '';
  final _formKey = GlobalKey<FormState>();

  void _trySubmit() {
    FocusScope.of(context).unfocus();
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      _formKey.currentState.save();
      // print(_userEmail);
      // print(_userPassword);
      // print(_userName);
      widget._onSubmit(
        username: _userName.trim(),
        email: _userEmail.trim(),
        password: _userPassword.trim(),
        islogin: _islogin,
        ctx: context,
      );
      _userEmail = '';
      _userName = '';
      _userPassword = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              key: ValueKey('email'),
              onSaved: (value) {
                _userEmail = value;
              },
              validator: (value) {
                if (value.isEmpty || !value.contains('@comsats.edu.pk')) {
                  return 'Enter a valid Email';
                }
                return null;
              },
              decoration: InputDecoration(
                icon: Icon(
                  Icons.email,
                  color: kPrimaryColor,
                ),
                labelText: 'Email',
              ),
            ),
            if (!_islogin)
              TextFormField(
                key: ValueKey('username'),
                onSaved: (value) {
                  _userName = value;
                },
                validator: (value) {
                  if (value.isEmpty || value.length < 4) {
                    return 'Enter a username of more than 3 characters';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.account_circle,
                    color: kPrimaryColor,
                  ),
                  labelText: 'Username',
                ),
              ),
            TextFormField(
              key: ValueKey('password'),
              onSaved: (value) {
                _userPassword = value;
              },
              validator: (value) {
                if (value.isEmpty || value.length < 7) {
                  return 'Password must be atleast 7 Characters';
                }
                return null;
              },
              decoration: InputDecoration(
                icon: Icon(
                  Icons.lock,
                  color: kPrimaryColor,
                ),
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(
              height: 10,
            ),
            if (widget.isLoading) CircularProgressIndicator(),
            if (!widget.isLoading)
              RaisedButton(
                color: kPrimaryColor,
                textColor: kPrimaryLightColor,
                onPressed: _trySubmit,
                child: _islogin ? Text('Login') : Text('Signup'),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
            SizedBox(
              height: 10,
            ),
            if (!widget.isLoading)
              FlatButton(
                  onPressed: () {
                    setState(() {
                      _islogin = !_islogin;
                    });
                  },
                  child: _islogin
                      ? Text('Don\'t have account? SIGNUP')
                      : Text('Already have account? LOGIN'))
          ],
        ));
  }
}
