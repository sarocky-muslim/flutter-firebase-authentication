import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:twitter_login/twitter_login.dart';
import 'welcome.dart';

class Twitter extends StatefulWidget {
  const Twitter({Key? key}) : super(key: key);

  @override
  _TwitterState createState() => _TwitterState();
}

class _TwitterState extends State<Twitter> {
  var auth = FirebaseAuth.instance;

  void _signInWithTwitter() async {
    print('_signInWithTwitter');

    final twitterLogin = TwitterLogin(
      apiKey: 'InVWIpjoJ4FRVDlD0JkTMsQEs',
      apiSecretKey: 'yuRM3o6t9aHD7PyffrGP59J2ncAU323LmhfWf2xttbwh2QXYYC',
      redirectURI: 'twitterkit-InVWIpjoJ4FRVDlD0JkTMsQEs://',
    );
    final result = await twitterLogin.login();
    final token = result.authToken;
    final secret = result.authTokenSecret;
    final credential =
        TwitterAuthProvider.credential(accessToken: token!, secret: secret!);

    final userCredential = await auth.signInWithCredential(credential);
    var user = userCredential.user;

    print(user);
    setState(() {
      // reload build for login check
    });
  }

  @override
  Widget build(BuildContext context) {
    if (auth.currentUser != null) return Welcome();
    return Scaffold(
      appBar: AppBar(
        title: Text('Twitter Auth'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _signInWithTwitter(),
          child: Text(
            'SignIn With Twitter',
            style: TextStyle(fontSize: 20),
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.teal),
              padding:
                  MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15))),
        ),
      ),
    );
  }
}
