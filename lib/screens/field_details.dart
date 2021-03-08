import 'file:///C:/Users/youss/AndroidStudioProjects/felmalaab_manager/lib/screens/home_screen.dart';
import 'package:felmalaab_manager/models/venue_details.dart';
import 'package:felmalaab_manager/screens/calendar_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../widgets/time_picker.dart';
import '../widgets/day_card.dart';

class FieldDetails extends StatefulWidget {
  static String id = "field_details";

  @override
  _FieldDetailsState createState() => _FieldDetailsState();
}

class _FieldDetailsState extends State<FieldDetails> {
  List numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  int initialVal = 1;

  @override
  Widget build(BuildContext context) {
    return Consumer<VenueDetails>(builder:
        (BuildContext context, VenueDetails venueDetails, Widget child) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF50B184),
            leading: Icon(Icons.arrow_back_ios),
            title: Text(
              "Venue Details",
              style: TextStyle(fontSize: 20),
            ),
          ),
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Stack(
                children: [
                  Image.network(
                    'https://www.hayahacademy.com/wp-content/uploads/2014/09/Big-Soccer-Field.jpg',
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: FlatButton(
                        child: Container(
                          width: 130,
                          child: Row(
                            children: [
                              Icon(
                                Icons.image,
                                color: Color(0xFF50B184),
                                size: 35,
                              ),
                              Text(
                                "Change Image",
                                style: TextStyle(
                                  color: Color(0xFF50B184),
                                ),
                              ),
                            ],
                          ),
                        ),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pushNamed(context, FieldDetails.id);
                        }),
                  ),
                ],
              ),
              Card(
                color: Color(0xFF50B184),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      title: Text('Number of Fields'),
                      trailing: Theme(
                        data: Theme.of(context)
                            .copyWith(canvasColor: Colors.white),
                        child: DropdownButton(
                            dropdownColor: Colors.white,
                            value: initialVal,
                            iconEnabledColor: Colors.white,
                            items: numbers.map((value) {
                              return DropdownMenuItem(
                                  value: value,
                                  child: Text(
                                    value.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ));
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                initialVal = value;
                              });
                              venueDetails.setNoOfFields(initialVal);
                            }),
                      ),
                    ),
                  ],
                ),
              ),
              DayCard(
                day: "Open Times",
                //"Sunday"
                dayIndex: 0,
                timeCallBack: () {},
              ),
              /* DayCard(
                day: "Monday",
                dayIndex: 1,
                timeCallBack: () {},
              ),
              DayCard(
                day: "Tuesday",
                dayIndex: 2,
                timeCallBack: () {},
              ),
              DayCard(
                day: "Wednesday",
                dayIndex: 3,
                timeCallBack: () {},
              ),
              DayCard(
                day: "Thursday",
                dayIndex: 4,
                timeCallBack: () {},
              ),
              DayCard(
                day: "Friday",
                dayIndex: 5,
                timeCallBack: () {},
              ),
              DayCard(
                day: "Saturday",
                dayIndex: 6,
                timeCallBack: () {},
              ),*/
              RaisedButton(
                  color: Colors.red,
                  textColor: Colors.green,
                  disabledColor: Colors.black,
                  child: Text("Submit"),
                  onPressed: () {
                    venueDetails.sendToFirebase();
                    Navigator.pushNamed(context, CalendarScreen.id);
                  })
            ],
          ),
        ),
      );
    });
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double height = size.height;
    double width = size.width;
    path.lineTo(0, height - 25);
    path.quadraticBezierTo(width / 2, height, width, height - 25);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
