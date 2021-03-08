import 'package:felmalaab_manager/data/user_details.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/youss/AndroidStudioProjects/felmalaab_manager/lib/screens/home_screen.dart';
import 'file:///C:/Users/youss/AndroidStudioProjects/felmalaab_manager/lib/widgets/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Container(
                  height: 200.0,
                  child: Image.asset('assets/images/tamaslogo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                style: TextStyle(color: Colors.black),
                cursorColor: Color(0xFF50B184),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                style: TextStyle(color: Colors.black),
                cursorColor: Color(0xFF50B184),
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                color: Color(0xFF50B184),
                title: "Log in",
                textColor: Colors.white,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final loggedInUser = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    setState(() {
                      showSpinner = false;
                    });
                    if (loggedInUser != null) {
                      UserDetails().loggedInUserID = loggedInUser.user.uid;
                      Navigator.pushNamed(context, HomeScreen.id);
                    }
                  } catch (e) {
                    setState(() {
                      showSpinner = false;
                    });
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
