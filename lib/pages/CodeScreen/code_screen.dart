import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:q_ours_mobile/services/auth_service.dart';

class Codes extends StatefulWidget {
  @override
  _CodesState createState() => _CodesState();
}

class _CodesState extends State<Codes> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.linear,
      duration: Duration(seconds: 1),
      child: AuthService.isLoggedIn
          ? Center(
              child: Container(
              child: Text(
                'Authenticated',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
              ),
            ))
          : Center(
              child: Container(
              alignment: Alignment.center,
              child: Text(
                'There is nothing here, Please log in to see your active codes',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
              ),
            )),
    );
  }
}
