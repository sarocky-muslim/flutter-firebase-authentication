import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:github_sign_in/github_sign_in.dart';
import 'welcome.dart';

class Github extends StatefulWidget {
  const Github({Key? key}) : super(key: key);

  @override
  _GithubState createState() => _GithubState();
}

class _GithubState extends State<Github> {
  var auth = FirebaseAuth.instance;

  // void _signInWithGithub() async {
  //   var clientId = '6808b40b52c8af54f3b0';
  //   var clientSecret = 'b989fe16fa6a9e89d76352d9e4dac7a8d9def43b';
  //   var redirectUrl = 'https://my-project.firebaseapp.com/__/auth/handler';
  //   final gitHubSignIn = GitHubSignIn(
  //       clientId: clientId,
  //       clientSecret: clientSecret,
  //       redirectUrl: redirectUrl);

  //   final result = await gitHubSignIn.signIn(context);
  //   final token = result.token;
  //   final credential = GithubAuthProvider.credential(token);

  //   final userCredential = await auth.signInWithCredential(credential);
  //   var user = userCredential.user;

  //   print(user);
  //   setState(() {
  //     // reload build for login check
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    if (auth.currentUser != null) return Welcome();
    return Scaffold(
      appBar: AppBar(
        title: Text('Github Auth'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => null,
          child: Text(
            'SignIn With Github',
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
