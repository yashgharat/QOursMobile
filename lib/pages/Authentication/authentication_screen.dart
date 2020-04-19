import 'package:firebase_auth/firebase_auth.dart';
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
  FirebaseUser user;

  authenticate(String email, String password) async {
    if (isAccount) {
      await AuthService().signIn(email, password);
      FirebaseAuth.instance.onAuthStateChanged.listen((user) {
        if (user != null)
          this.setState(() {
            this.user = user;
            AuthService.isLoggedIn = true;
          });
        else {
          this.setState(() {
            AuthService.isLoggedIn = false;
          });
        }
      });
    } else {
      AuthService().register(email, password);
    }
  }

  switchType() {
    cardKey.currentState.toggleCard();
  }

  _AuthenticationScreenState() {
    isAccount = true;
    buttonText = 'Login';
    leadIn = 'Need an Account? ';
    link = 'Sign up';
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    changeBack() => this.setState(() => AuthService.isLoggedIn = false);
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
        child: AuthService.isLoggedIn
            ? LoggedIn(AuthService().user, changeBack)
            : FlipCard(
                key: cardKey,
                flipOnTouch: false,
                onFlipDone: (status) => isAccount = status,
                direction: FlipDirection.HORIZONTAL,
                speed: 1000,
                front:
                    Center(child: LoginField('Login', loginText, authenticate)),
                back: Center(
                    child: LoginField('Register', registerText, authenticate)),
              ));
  }
}
