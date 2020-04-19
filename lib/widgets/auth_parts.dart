import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:q_ours_mobile/extensions/hex_color.dart';
import 'package:q_ours_mobile/services/auth_service.dart';

class LoginField extends StatefulWidget {
  String buttonText;
  RichText helpText;
  bool isAccount;

  Function(String, String) action;

  LoginField(this.buttonText, this.helpText, this.action);
  @override
  LoginFieldState createState() => LoginFieldState();
}

class LoginFieldState extends State<LoginField> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController userControl = TextEditingController();
    TextEditingController passControl = TextEditingController();

    final emailField =
        UserTextField("Email Address", false, userControl, Icons.person);
    final passwordField =
        UserTextField("Password", true, passControl, Icons.lock);

    final loginButton = Container(
      width: 120.0,
      child: RaisedButton(
        color: HexColor.fromHex('9965F4'),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onPressed: () => widget.action(userControl.text, passControl.text),
        child: Text(
          widget.buttonText.toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
            letterSpacing: 1.25,
          ),
        ),
      ),
    );
    return Container(
      width: 300.0,
      height: 300.0,
      child: Card(
        elevation: 6,
        color: Colors.white.withOpacity(0.4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                emailField,
                passwordField,
                loginButton,
                widget.helpText,
              ]
                  .map((input) => Container(
                        padding: EdgeInsets.only(bottom: 20),
                        child: input,
                      ))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class UserTextField extends StatefulWidget {
  String hintText;
  bool obscureText, isPassword;
  IconData icon;

  TextEditingController textController;

  UserTextField(
      this.hintText, this.isPassword, this.textController, this.icon) {
    obscureText = isPassword;
  }
  @override
  _UserTextField createState() => _UserTextField();
}

class _UserTextField extends State<UserTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        obscureText: widget.obscureText,
        controller: widget.textController,
        style: TextStyle(
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(widget.icon, color: HexColor.fromHex('D4BFF9')),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    widget.obscureText
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.black87,
                  ),
                  onPressed: () =>
                      setState(() => widget.obscureText = !widget.obscureText),
                )
              : null,
          filled: true,
          fillColor: Colors.white,
          hintText: widget.hintText,
          hintStyle: TextStyle(fontSize: 14),
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
      ),
    );
  }
}

class LoggedIn extends StatelessWidget {
  FirebaseUser user;
  Function() callback;
  LoggedIn(this.user, this.callback);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(children: <Widget>[
        Container(
          width: 300,
          height: 300,
          child: Card(
            elevation: 6,
            color: Colors.white.withOpacity(0.4),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Welcome, ${user.email}'),
                Container(
                  child: RaisedButton(
                    color: HexColor.fromHex('9965F4'),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    onPressed: () {
                      AuthService().signOut();
                      callback();
                    },
                    child: Text(
                      'Sign Out'.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        letterSpacing: 1.25,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
