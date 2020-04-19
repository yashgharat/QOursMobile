import 'package:flutter/material.dart';
import 'package:q_ours_mobile/pages/Authentication/authentication_screen.dart';
import 'package:q_ours_mobile/pages/CodeScreen/code_screen.dart';
import 'package:q_ours_mobile/pages/HomeScreen/home_screen.dart';

const String HomeRoute = 'home';
const String CodeRoute = 'favorite';
const String AuthRoute = 'authentication';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AuthRoute:
        return MaterialPageRoute(builder: (_) => AuthenticationScreen());
    case CodeRoute:
        return MaterialPageRoute(builder: (_) => Codes());
    default:
        return MaterialPageRoute(builder: (_) => HomeScreen());
  }
}