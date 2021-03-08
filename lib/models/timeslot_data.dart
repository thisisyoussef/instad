import 'package:felmalaab_manager/models/venue_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'booking.dart';
import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;

class TimeSlotData extends ChangeNotifier {
  List<Booking> _timeslots = [];
  String openVenueId;
  bool reBuildCalendar = false;
  int get taskCount {
    return _timeslots.length;
  }

  getDataFromDatabase() async {
    var value = await _firestore
        .collection("locations")
        .doc(openVenueId)
        .collection("bookings")
        .snapshots()
        .map(
          (snapShot) => snapShot.docs.map(
            (document) => Booking(
                name: document.data()['name'],
                startTime: document.data()['startTime'],
                endTime: document.data()['endTime'],
                phoneNumber: document.data()['phoneNumber'],
                isAllDay: false,
                isRecurring: false),
          ),
        );
    return value;
  }

  UnmodifiableListView<Booking> get tasks {
    return UnmodifiableListView(_timeslots);
  }

  Future<Stream<List<Booking>>> getBookings() async {
    return await _firestore
        .collection("locations")
        .doc(openVenueId)
        .collection("bookings")
        .snapshots()
        .map(
          (snapShot) => snapShot.docs.map(
            (document) => Booking(
                name: document.data()['name'],
                startTime: document.data()['startTime'],
                endTime: document.data()['endTime'],
                phoneNumber: document.data()['phoneNumber'],
                isAllDay: false,
                isRecurring: false),
          ),
        );
  }

  StreamBuilder<QuerySnapshot> buildStreamBuilder() {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection("locations")
            .doc(openVenueId)
            .collection("bookings")
            .snapshots(),
        // ignore: missing_return/, missing_return
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
          List<Timestamp> timeSlots;
          final timeslots = snapshot.data.docs;
          print("cleared listcards");
          for (var timeslot in timeslots) {
            print("in loop");
            final Booking _timeSlot = Booking(
                name: timeslot.data()['name'],
                startTime: timeslot.data()['startTime'],
                endTime: timeslot.data()['endTime'],
                phoneNumber: timeslot.data()['phoneNumber'],
                isAllDay: false,
                isRecurring: false);
            _timeslots.add(_timeSlot);
          }
          notifyListeners();
        });
  }

  List<Booking> getTimeSlots() {
    buildStreamBuilder();
    getBookings();
    return _timeslots;
  }

  void bookSlot(String bookingName, String phoneNumber, DateTime startTime,
      DateTime endTime, DateTime bookingDay) {
    print(startTime.toString());
    startTime = DateTime(bookingDay.year, bookingDay.month, bookingDay.day,
        startTime.hour, startTime.minute);
    endTime = DateTime(bookingDay.year, bookingDay.month, bookingDay.day,
        endTime.hour, endTime.minute);
    print("booking slot..");
    print(openVenueId);
    _firestore
        .collection("locations")
        .doc(openVenueId)
        .collection("bookings")
        .add({
      'bookingName': bookingName,
      'phoneNumber': phoneNumber,
      'startTime': startTime,
      'endTime': endTime,
    });
    buildStreamBuilder();
    /* final timeslot = Booking(
      name: bookingName,
      phoneNumber: phoneNumber,
      startTime: startTime,
      endTime: endTime,
      isRecurring: false,
      isAllDay: false,
    );*/
    //_timeslots.add(timeslot);
    reBuildCalendar = true;
    notifyListeners();
    reBuildCalendar = false;
    notifyListeners();
  }

  void updateBooking(Booking booking) {
    notifyListeners();
  }

  void setVenueId(String venueId) {
    openVenueId = venueId;
    print("venue ID: " + openVenueId);
  }

  void removeTask(Booking booking) {
    _timeslots.removeAt(_timeslots.indexOf(booking));
    notifyListeners();
  }
}
