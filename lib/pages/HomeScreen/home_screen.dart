import 'package:flutter/material.dart';
import 'package:q_ours_mobile/extensions/hex_color.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String text = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text(text),),
    );
  }
}
