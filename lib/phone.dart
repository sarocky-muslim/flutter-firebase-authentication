import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'welcome.dart';

class Phone extends StatefulWidget {
  const Phone({Key? key}) : super(key: key);

  @override
  _PhoneState createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  var auth = FirebaseAuth.instance;
  String _number = '', _verificationId = '', _smsCode = '';
  String? _error;

  void _phoneAuth() async {
    print('_phoneAuth');
    await auth.verifyPhoneNumber(
      timeout: Duration(minutes: 1),
      phoneNumber: _number,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // ANDROID ONLY!
        // var userCredential = await auth.signInWithCredential(credential);
        // print(userCredential.user);
      },
      verificationFailed: (FirebaseAuthException e) {
        setState(() {
          _error = e.code;
        });
      },
      codeSent: (String verificationId, int? resendToken) async {
        setState(() {
          _verificationId = verificationId;
        });
        _verificationDialogue();
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // this is called when verificationCompleted() not complete within timout duration
      },
    );
  }

  void _verificationDialogue() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('SMS Code Verification'),
          content: Column(
            children: [
              TextFormField(
                onChanged: (value) => _smsCode = value,
                decoration: InputDecoration(
                  hintText: 'Enter the verification code',
                  labelText: 'Verification',
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _verifySMScode(),
                  child: Text(
                    'Verify',
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(15))),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _verifySMScode() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: _smsCode);
    var userCredential = await auth.signInWithCredential(credential);
    var user = userCredential.user;
    print(user);
    // Navigator.pop(context);
    setState(() {});
  }

  Widget _errorWidget() {
    if (_error == null) return Container();
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    if (auth.currentUser != null) return Welcome();
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _errorWidget(),
            TextFormField(
              onChanged: (value) => _number = value,
              decoration: InputDecoration(
                hintText: 'Enter the number',
                labelText: 'Number',
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _phoneAuth(),
                child: Text(
                  'Send SMS Code',
                  style: TextStyle(fontSize: 20),
                ),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(15))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
