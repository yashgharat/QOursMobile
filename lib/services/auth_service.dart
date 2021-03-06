import 'package:firebase_auth/firebase_auth.dart';
import 'package:q_ours_mobile/routing/locator.dart';
import 'package:q_ours_mobile/routing/router.dart';
import 'package:q_ours_mobile/services/navigation_service.dart';

FirebaseUser _currentUser;

class AuthService {
  static bool isLoggedIn = false;

  handleAuth() {

  }

  signOut() => FirebaseAuth.instance.signOut();

  signIn(email, password) async {
    _currentUser = (await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .catchError((e) => print(e)))
        .user;
  }

  register(email, password) async {
    _currentUser = (await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password))
        .user;

    if (!_currentUser.isEmailVerified)
      await _currentUser.sendEmailVerification();
  }

  signInAnon() async {
        await FirebaseAuth.instance.signInAnonymously();
  }
  
  get user => _currentUser;
}
