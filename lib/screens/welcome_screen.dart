import 'package:flutter/material.dart';
import 'package:phone_auth/provider/auth_provider.dart';
import 'package:phone_auth/screens/home_screen.dart';
import 'package:phone_auth/screens/registration_screen.dart';
import 'package:phone_auth/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
          child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 55),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              "assets/image1.png",
              height: 300,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Let's get Started",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Never a better time to start than now!",
              style: TextStyle(
                color: Colors.black38,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: CustomButton(
                  text: "Get started",
                  onPressed: () {
                    ap.isSignedIn == true
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()))
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (e) => const RegistrationScreen()));
                  }),
            )
          ]),
        ),
      )),
    );
  }
}
