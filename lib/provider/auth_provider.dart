import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_auth/screens/otp_screen.dart';
import 'package:phone_auth/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String? _userId;
  String get userId => _userId!;

  AuthProvider() {
    checkSignIn();
  }

  void checkSignIn() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    _isSignedIn = sharedPreferences.getBool("is_signedin") ?? false;
    notifyListeners();
  }

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            await _auth.signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (error) => throw Exception(error.message),
          codeSent: (verificationId, forceResendingToken) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        OtpScreen(verificationId: verificationId)));
          },
          codeAutoRetrievalTimeout: ((verificationId) {}));
    } on FirebaseAuthException catch (error) {
      showSnackBar(context, error.message.toString());
    } catch (error) {
      showSnackBar(context, error.toString());
    }
    setIsLoading(false);
  }

  void verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String otpCode,
    required Function onSuccess,
  }) async {
    setIsLoading(true);
    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otpCode);
      User? user = (await _auth.signInWithCredential(creds)).user!;
     _userId = user.uid;
    } on FirebaseAuthException catch (error) {
      showSnackBar(context, error.message.toString());
    } catch (error) {
      showSnackBar(context, error.toString());
    }
    setIsLoading(false);
  }
}
