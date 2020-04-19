import 'package:flip_card/flip_card.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:q_ours_mobile/extensions/hex_color.dart';
import 'package:q_ours_mobile/services/auth_service.dart';
import 'package:q_ours_mobile/widgets/auth_parts.dart';

class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  String buttonText;
  String leadIn, link;
  bool isAccount;

  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  authenticate(String email, String password) {
    if (isAccount) {
      AuthService().signIn(email, password);
    } else {
      AuthService().register(email, password);
    }
  }

  _AuthenticationScreenState() {
    isAccount = true;
    buttonText = 'Login';
    leadIn = 'Need an Account? ';
    link = 'Sign up';
  }

  switchType() {
    cardKey.currentState.toggleCard();
  }

  @override
  Widget build(BuildContext context) {
    RichText loginText = RichText(
        text: TextSpan(children: <TextSpan>[
      TextSpan(
          text: 'Need an Account? ', style: TextStyle(color: Colors.black)),
      TextSpan(
          text: 'Sign up',
          style: TextStyle(color: HexColor.fromHex('EB3505')),
          recognizer: TapGestureRecognizer()..onTap = switchType)
    ]));

    RichText registerText = RichText(
        text: TextSpan(children: <TextSpan>[
      TextSpan(
          text: 'Already have an account? ',
          style: TextStyle(color: Colors.black)),
      TextSpan(
          text: 'Login',
          style: TextStyle(color: HexColor.fromHex('EB3505')),
          recognizer: TapGestureRecognizer()..onTap = switchType)
    ]));
    return Container(
        child: FlipCard(
      key: cardKey,
      flipOnTouch: false,
      onFlipDone: (status) => isAccount = status,
      direction: FlipDirection.HORIZONTAL,
      speed: 1000,
      front: Center(child: LoginField('Login', loginText, authenticate)),
      back: Center(child: LoginField('Register', registerText, authenticate)),
    ));
  }
}
