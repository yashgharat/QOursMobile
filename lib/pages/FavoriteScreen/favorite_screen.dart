import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AnimationController animationController;
    return Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text(
                'do something'.toUpperCase(),
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => animationController.forward(),
              color: Colors.deepPurpleAccent,
            ),

          ],
        ));
  }
}
