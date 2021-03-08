import 'package:flutter/material.dart';
import 'package:felmalaab_manager/widgets/list_card.dart';
import '../register_venue.dart';

class ListScreen extends StatefulWidget {
  List<ListCard> listCards = [];
  ListScreen(this.listCards);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, RegisterVenue.id);
        },
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white70,
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                reverse: false,
                children: widget.listCards,
                //padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
