import 'dart:async';

import 'file:///C:/Users/youss/AndroidStudioProjects/felmalaab_manager/lib/screens/login_screen.dart';
import 'file:///C:/Users/youss/AndroidStudioProjects/felmalaab_manager/lib/screens/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:felmalaab_manager/data/onboard_page_details.dart';
import 'file:///C:/Users/youss/AndroidStudioProjects/felmalaab_manager/lib/widgets/rounded_button.dart';

class IntroScreen extends StatefulWidget {
  static String id = "intro_screen";
  int selectedPage = 0;

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Tamas Manager \n",
                  style: Theme.of(context).textTheme.headline3,
                  children: <TextSpan>[
                    TextSpan(
                        text: "simple venue management",
                        style: Theme.of(context).textTheme.caption),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 1.8,
              ),
              RoundedButton(
                color: Colors.white,
                title: "Get Started",
                onPressed: () {
                  Navigator.pushNamed(context, RegisterScreen.id);
                },
              ),
              RoundedButton(
                color: Colors.white,
                title: "Log in",
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
              ),
            ],
          ),
        ),
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "assets/images/SoccerBackground.png",
          ),
        ),
      ),
    );
  }
}
