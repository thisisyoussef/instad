import 'dart:math';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:felmalaab_manager/models/timeslot_data.dart';
import 'package:felmalaab_manager/models/venue_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'file:///C:/Users/youss/AndroidStudioProjects/felmalaab_manager/lib/screens/book_slot_window.dart';
import 'package:felmalaab_manager/models/booking.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatefulWidget {
  static String id = "calendar_screen";

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  refreshCalendar() {
    setState(() {});
  }

  final _firestore = FirebaseFirestore.instance;
  DateTime selectedDateTime;
  QuerySnapshot querySnapshot;
  dynamic data;
  List<Color> _colorCollection;
  _showCalendar() {
    if (querySnapshot != null) {
      List<Booking> collection;
      var showData = querySnapshot.docs;
      List<dynamic> key = showData.toList();
      if (showData != null) {
        showData.forEach((element) {
          data = showData;
          collection ??= <Booking>[];
          final Random random = new Random();
          collection.add(Booking(
            name: element.data()['bookingName'],
            isAllDay: false,
            isRecurring: false,
            startTime:
                DateTime.parse(element.data()['startTime'].toDate().toString()),
            endTime:
                DateTime.parse(element.data()['endTime'].toDate().toString()),
          ));
        });
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      return SafeArea(
          child: Container(
        height: MediaQuery.of(context).size.height,
        child: SfCalendar(
          showNavigationArrow: true,
          backgroundColor: Colors.grey,
          view: CalendarView.week,
          timeSlotViewSettings:
              TimeSlotViewSettings(startHour: 10, endHour: 24),
          firstDayOfWeek: DateTime.now().weekday,
          monthViewSettings: MonthViewSettings(showAgenda: true),
          dataSource: _getCalendarDataSource(collection),
        ),
      ));
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  void _initializeEventColor() {
    this._colorCollection = new List<Color>();
    _colorCollection.add(const Color(0xFF0F8644));
    _colorCollection.add(const Color(0xFF8B1FA9));
    _colorCollection.add(const Color(0xFFD20100));
    _colorCollection.add(const Color(0xFFFC571D));
    _colorCollection.add(const Color(0xFF36B37B));
    _colorCollection.add(const Color(0xFF01A1EF));
    _colorCollection.add(const Color(0xFF3D4FB5));
    _colorCollection.add(const Color(0xFFE47C73));
    _colorCollection.add(const Color(0xFF636363));
    _colorCollection.add(const Color(0xFF0A8043));
  }

  BookingDataSource _getCalendarDataSource([List<Booking> collection]) {
    List<Booking> meetings = collection ?? <Booking>[];
    print(meetings);
    return BookingDataSource(meetings);
  }

  getDataFromDatabase() async {
    print((Provider.of<VenueDetails>(context, listen: false).openVenue));
    var value = await _firestore
        .collection("locations")
        .doc((Provider.of<VenueDetails>(context, listen: false).openVenue))
        .collection("bookings")
        .get();
    print(value);
    var getValue = await value;
    print(value);
    return getValue;
  }

  @override
  void initState() {
    _initializeEventColor();
    getDataFromDatabase().then((results) {
      setState(() {
        if (results != null) {
          querySnapshot = results;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TimeSlotData>(builder:
        (BuildContext context, TimeSlotData timeSlotData, Widget child) {
      return Scaffold(
        body: _showCalendar(),
        floatingActionButton: FloatingActionButton(onPressed: () async {
          await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: BookSlotWindow(),
              ),
            ),
          );
          initState();
        }),
      );
    });
  }
}

class BookingDataSource extends CalendarDataSource {
  BookingDataSource(List<Booking> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments[index].startTime;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].endTime;
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].isAllDay;
  }

  @override
  String getSubject(int index) {
    print(appointments[index].name);
    return appointments[index].name;
  }
}
