import 'package:flutter/material.dart';
import 'package:q_ours_mobile/routing/router.dart';
import 'package:q_ours_mobile/pages/HomeScreen/home_screen.dart';
import 'package:q_ours_mobile/pages/HomeScreen/scaffold.dart';
import 'package:q_ours_mobile/routing/locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AppScaffold(),
    );
  }
}
