import 'dart:math';

import 'package:felmalaab_manager/register_venue.dart';
import 'package:felmalaab_manager/screens/list_screen.dart';
import 'package:felmalaab_manager/widgets/list_card.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

final _firestore = FirebaseFirestore.instance;
auth.User loggedInUser;
String name = " ";
List<ListCard> listCards = [];

class HomeScreen extends StatefulWidget {
  static String id = "home_screen";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

StreamBuilder<QuerySnapshot> buildStreamBuilder() {
  return StreamBuilder<QuerySnapshot>(
    stream: _firestore.collection('locations').snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.lightBlueAccent,
          ),
        );
      }
      final fields = snapshot.data.docs;
      listCards.clear();
      for (var field in fields) {
        final bool approved = field.data()['approved'];
        final String Id = field.id;
        final String name = field.data()['name'];
        double latitude;
        double longitude;
        final listCard = ListCard(
          venueId: Id,
          name: name,
          approved: approved,
        );
        listCards.add(listCard);
      }
      return ListScreen(listCards);
    },
  );
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = auth.FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        setState(() {
          loggedInUser = user;
          _firestore
              .collection("users")
              .doc(loggedInUser.uid)
              .get()
              .then((value) {
            print(value.data());
            name = value.data()["First Name"];
            print(name);
          });
        });
        print(loggedInUser.email);
        setState(() {});
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "Hello " + name,
        ),
      ),
      body: buildStreamBuilder(),
    );
  }
}
