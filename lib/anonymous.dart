import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'welcome.dart';

class Anonymous extends StatefulWidget {
  const Anonymous({Key? key}) : super(key: key);

  @override
  _AnonymousState createState() => _AnonymousState();
}

class _AnonymousState extends State<Anonymous> {
  var auth = FirebaseAuth.instance;

  void _signInWithAnonymous() async {
    final userCredential = await auth.signInAnonymously();
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
        title: Text('Anonymous Auth'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _signInWithAnonymous(),
          child: Text(
            'SignIn With Anonymous',
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
