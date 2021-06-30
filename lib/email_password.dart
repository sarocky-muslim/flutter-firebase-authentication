import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'welcome.dart';

class EmailPassword extends StatefulWidget {
  const EmailPassword({Key? key}) : super(key: key);

  @override
  _EmailPasswordState createState() => _EmailPasswordState();
}

class _EmailPasswordState extends State<EmailPassword> {
  var auth = FirebaseAuth.instance;
  String _email = '', _password = '';
  String? _error;

  void _create() async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
      Route route = MaterialPageRoute(builder: (context) => Welcome());
      Navigator.push(context, route);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        setState(() {
          _error = 'The password provided is too weak.';
        });
      } else if (e.code == 'email-already-in-use') {
        setState(() {
          _error = 'The account already exists for that email.';
        });
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    }
  }

  void _signIn() async {
    try {
      await auth
          .signInWithEmailAndPassword(email: _email, password: _password)
          .then((user) {
        setState(() {});
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          _error = 'No user found for that email.';
        });
      } else if (e.code == 'wrong-password') {
        setState(() {
          _error = 'Wrong password provided for that user.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (auth.currentUser != null) return Welcome();
    return Scaffold(
      appBar: AppBar(
        title: Text('Email and Password'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _error == null
                ? Container()
                : Row(
                    children: [
                      Expanded(
                        flex: 9,
                        child: Text(
                          _error ?? '',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.red, fontSize: 18),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            setState(() {
                              _error = null;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
            _error == null ? Container() : SizedBox(height: 15),
            TextFormField(
              onChanged: (value) => _email = value,
              decoration: InputDecoration(
                hintText: 'Enter the email',
                labelText: 'Email',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 10),
            TextFormField(
              onChanged: (value) => _password = value,
              decoration: InputDecoration(
                hintText: 'Enter the password',
                labelText: 'Password',
              ),
              keyboardType: TextInputType.text,
              obscureText: true,
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: ElevatedButton(
                    onPressed: () => _signIn(),
                    child: Text(
                      'SignIn',
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(15))),
                  ),
                ),
                Expanded(flex: 2, child: Container()),
                Expanded(
                  flex: 4,
                  child: ElevatedButton(
                    onPressed: () => _create(),
                    child: Text(
                      'Create',
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.teal),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(15))),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
