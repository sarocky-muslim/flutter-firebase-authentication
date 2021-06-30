import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'email_password.dart';
import 'phone.dart';
import 'google.dart';
import 'facebook.dart';
import 'twitter.dart';
// import 'github.dart';
import 'anonymous.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Authentication',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Select Provider'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        color: Colors.black87,
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            SignInButtonBuilder(
              text: 'Anonymous',
              icon: Icons.ac_unit,
              padding: EdgeInsets.all(15),
              onPressed: () {
                var widget = (context) => Anonymous();
                var route = MaterialPageRoute(builder: widget);
                Navigator.push(context, route);
              },
              backgroundColor: Colors.blueGrey,
            ),
            SizedBox(height: 20),
            SignInButtonBuilder(
              text: 'Sign in with Phone',
              icon: Icons.phone,
              padding: EdgeInsets.all(15),
              onPressed: () {
                var widget = (context) => Phone();
                var route = MaterialPageRoute(builder: widget);
                Navigator.push(context, route);
              },
              backgroundColor: Colors.cyan,
            ),
            SizedBox(height: 20),
            SignInButton(
              Buttons.Email,
              padding: EdgeInsets.all(15),
              onPressed: () {
                var widget = (context) => EmailPassword();
                var route = MaterialPageRoute(builder: widget);
                Navigator.push(context, route);
              },
            ),
            SizedBox(height: 20),
            SignInButton(
              Buttons.Google,
              padding: EdgeInsets.all(8),
              onPressed: () {
                var widget = (context) => Google();
                var route = MaterialPageRoute(builder: widget);
                Navigator.push(context, route);
              },
            ),
            SizedBox(height: 20),
            SignInButton(
              Buttons.Facebook,
              padding: EdgeInsets.all(15),
              onPressed: () {
                var widget = (context) => Facebook();
                var route = MaterialPageRoute(builder: widget);
                Navigator.push(context, route);
              },
            ),
            SizedBox(height: 20),
            SignInButton(
              Buttons.Twitter,
              padding: EdgeInsets.all(15),
              onPressed: () {
                var widget = (context) => Twitter();
                var route = MaterialPageRoute(builder: widget);
                Navigator.push(context, route);
              },
            ),
            // SizedBox(height: 20),
            // SignInButton(
            //   Buttons.GitHub,
            //   padding: EdgeInsets.all(15),
            //   onPressed: () {
            //     var widget = (context) => Github();
            //     var route = MaterialPageRoute(builder: widget);
            //     Navigator.push(context, route);
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
