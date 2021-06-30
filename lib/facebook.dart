import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'welcome.dart';

class Facebook extends StatefulWidget {
  const Facebook({Key? key}) : super(key: key);

  @override
  _FacebookState createState() => _FacebookState();
}

class _FacebookState extends State<Facebook> {
  var auth = FirebaseAuth.instance;

  void _signInWithFacebook() async {
    print('_signInWithFacebook');
    final result = await FacebookAuth.instance.login();
    final accessToken = result.accessToken;
    final credential = FacebookAuthProvider.credential(accessToken!.token);
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
        title: Text('Facebook Auth'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _signInWithFacebook(),
          child: Text(
            'SignIn With Facebook',
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
