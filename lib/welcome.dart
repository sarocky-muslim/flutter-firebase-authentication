import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  var auth = FirebaseAuth.instance;
  User? user;
  bool _isSignOut = false;

  void _signOut() async {
    await auth.signOut().then((value) {
      setState(() {
        _isSignOut = true;
      });
    });
  }

  String _result() {
    if (user!.isAnonymous) {
      return 'UID: ' + user!.uid;
    } else if (user!.providerData[0].providerId == 'password') {
      return user!.email!;
    } else if (user!.providerData[0].providerId == 'phone') {
      return user!.phoneNumber!;
    } else {
      return user!.displayName!;
    }
  }

  @override
  void initState() {
    user = auth.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_isSignOut) return MyApp();
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            user!.isAnonymous
                ? Text(
                    'Provider: Anonymous',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  )
                : Text(
                    'Provider: ' + user!.providerData[0].providerId,
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
            SizedBox(height: 10),
            user!.isAnonymous
                ? Container()
                : user!.providerData[0].photoURL == null
                    ? Container()
                    : Image.network(
                        user!.providerData[0].photoURL!,
                        width: 100,
                        height: 100,
                      ),
            user!.isAnonymous
                ? Container()
                : user!.providerData[0].photoURL == null
                    ? Container()
                    : SizedBox(height: 10),
            Text(
              _result(),
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () => _signOut(),
              child: Text('SignOut', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
