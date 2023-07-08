import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late SharedPreferences _sharedPreferences;

  AuthProvider() {
    checkSignIn();
  }

  void checkSignIn() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _isSignedIn = _sharedPreferences.getBool("isSignedIn") ?? false;
    notifyListeners();
  }
}
