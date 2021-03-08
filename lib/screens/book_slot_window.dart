import 'file:///C:/Users/youss/AndroidStudioProjects/felmalaab_manager/lib/widgets/amenity_tile.dart';
import 'package:felmalaab_manager/models/timeslot_data.dart';
import 'package:felmalaab_manager/models/venue_details.dart';
import 'package:felmalaab_manager/widgets/checkbox_tile.dart';
import 'package:felmalaab_manager/widgets/date_picker.dart';
import 'package:felmalaab_manager/widgets/time_picker.dart';
import 'package:felmalaab_manager/widgets/day_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'calendar_screen.dart';

var buttonEnabled = false;
bool isRecurring = false;
String bookingName;
String bookingNumber;
DateTime startTime;
DateTime endTime;
DateTime bookingDay;
CalendarScreen calendarScreen;

class BookSlotWindow extends StatefulWidget {
  StatefulWidget calendarWidget;
  BookSlotWindow({Key key, this.calendarWidget}) : super(key: key);
  @override
  _BookSlotWindowState createState() => _BookSlotWindowState();
}

class _BookSlotWindowState extends State<BookSlotWindow> {
  @override
  Widget build(BuildContext context) {
    return Consumer<VenueDetails>(builder:
        (BuildContext context, VenueDetails venueDetails, Widget child) {
      return Container(
        color: Color(0xFF50B184),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Book Venue',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xFF50B184),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: (MediaQuery.of(context).size.width / 2) - 20,
                      child: TextField(
                        style: TextStyle(
                          color: Color(0xFF50B184),
                        ),
                        decoration: InputDecoration(
                            labelText: "Booking Name",
                            labelStyle: TextStyle(
                              color: Color(0xFF50B184),
                            )),
                        textAlign: TextAlign.left,
                        //autofocus: true,
                        onChanged: (newText) {
                          bookingName = newText;
                        },
                      ),
                    ),
                    Container(
                      width: (MediaQuery.of(context).size.width / 2) - 20,
                      child: TextField(
                        style: TextStyle(
                          color: Color(0xFF50B184),
                        ),
                        decoration: InputDecoration(
                            labelText: "Phone Number",
                            labelStyle: TextStyle(
                              color: Color(0xFF50B184),
                            )),
                        textAlign: TextAlign.left,
                        //  autofocus: true,
                        onChanged: (newText) {
                          bookingNumber = newText;
                        },
                      ),
                    ),
                  ],
                ),
                CheckboxTIle(
                  taskTitle: "Is Recurring:",
                  checkboxCallback: () {
                    isRecurring = !isRecurring;
                    print(isRecurring);
                  },
                  //isChecked: false,
                ),
                DatePicker(
                  dayCallBack: (DateTime day) {
                    bookingDay = day;
                    print(bookingDay);
                  },
                ),
                DayCard(
                    day: "From",
                    dayIndex: 0,
                    timeCallBack: (bool isStartTime, DateTime time) {
                      if (isStartTime) {
                        startTime = time;
                      } else {
                        endTime = time;
                      }
                      print(startTime);
                    }),
                FlatButton(
                  onPressed: () {
                    buttonEnabled = true;
                    print(bookingName);
                    if (bookingName != null) {
                      setState(() {
                        Provider.of<TimeSlotData>(context, listen: false)
                            .setVenueId(venueDetails.openVenue);
                        Provider.of<TimeSlotData>(context, listen: false)
                            .bookSlot(bookingName, bookingNumber, startTime,
                                endTime, bookingDay);
                      });
                    }
                    Navigator.pop(context);
                  },
                  color: Color(0xFF50B184),
                  child: Text(
                    'Book',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
