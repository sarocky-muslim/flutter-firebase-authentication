import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'welcome.dart';

class Google extends StatefulWidget {
  const Google({Key? key}) : super(key: key);

  @override
  _GoogleState createState() => _GoogleState();
}

class _GoogleState extends State<Google> {
  var auth = FirebaseAuth.instance;

  void _signInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

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
        title: Text('Google Auth'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _signInWithGoogle(),
          child: Text(
            'SignIn With Google',
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
