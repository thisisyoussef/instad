import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:felmalaab_manager/models/venue_details.dart';
import 'package:felmalaab_manager/screens/calendar_screen.dart';
import 'package:felmalaab_manager/screens/field_details.dart';
import 'package:felmalaab_manager/screens/venue_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListCard extends StatefulWidget {
  ListCard({
    this.venueId,
    this.approved,
    this.name,
  });
  final String name;
  final bool approved;
  final String venueId;
  @override
  _ListCardState createState() => _ListCardState();
}

class _ListCardState extends State<ListCard> {
  String easeOfAccess;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 6,
          child: InkWell(
            onTap: () {
              Provider.of<VenueDetails>(context, listen: false)
                  .setOpenVenue(widget.venueId);
              Navigator.pushNamed(context, VenuePage.id);
            },
            child: Card(
              color: easeOfAccess == "easy" ? Colors.green : Colors.white,
              // elevation: 7,
              //  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Container(
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height / 15,
                            child: Image.network(
                              'https://www.foreverlawn.com/wp-content/uploads/2019/01/DSC_0018.jpg',
                            ),
                          ),
                        ],
                      ),
                    ),
                    title: widget.name != null
                        ? Text(
                            widget.name,
                            style: TextStyle(color: Colors.black),
                          )
                        : Text(
                            "name is null",
                            style: TextStyle(color: Colors.black),
                          ),
                    trailing: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 8,
                        ),
                        RaisedButton(
                          textColor: Colors.redAccent,
                          disabledColor: Colors.grey,
                          shape: CircleBorder(),
                          color: Colors.green,
                          onPressed: () {
                            Provider.of<VenueDetails>(context, listen: false)
                                .setOpenVenue(widget.venueId);
                            Navigator.pushNamed(context, FieldDetails.id);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Text(
                              "GO",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.amberAccent,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 30,
                    child: ListView(
                      reverse: true,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
