import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;

class VenueDetails extends ChangeNotifier {
  bool firstAdjustment = true;
  int _noOfFields = 1;
  var venueIds = [];
  String openVenue;
  //List<List<String>> businessHours = [[], [], [], [], [], [], []];
  Map businessHours = {};

  void setNoOfFields(int noOfFields) {
    _noOfFields = noOfFields;
  }

  void setOpenVenue(String id) {
    openVenue = id;
  }

  void createVenue(String id) {
    openVenue = id;
    venueIds.add(openVenue);
  }

  void setBusinessHours(int dayIndex, bool isOpenTime, String time) {
    //businessHours[dayIndex][isOpenTime ? 0 : 1] = time;
    if (firstAdjustment) {
      for (int i = 0; i < 14; i++) {
        businessHours[i.toString()] = "10:00 AM";
      }
      firstAdjustment = false;
    }
    print(time);
    if (isOpenTime) {
      businessHours[(dayIndex * 2).toString()] = time;
      print(businessHours[dayIndex.toString()]);
    } else {
      businessHours[((dayIndex * 2) + 1).toString()] = time;
      print(businessHours[((dayIndex * 2) + 1).toString()]);
    }
  }

  void sendToFirebase() {
    _firestore.collection('locations').doc(openVenue).update({
      "number of fields": _noOfFields,
      "Business Hours": {
        "Sunday": [businessHours[0.toString()], businessHours[1.toString()]],
        "Monday": [businessHours[2.toString()], businessHours[3.toString()]],
        "Tuesday": [businessHours[4.toString()], businessHours[5.toString()]],
        "Wednesday": [businessHours[6.toString()], businessHours[7.toString()]],
        "Thursday": [businessHours[8.toString()], businessHours[9.toString()]],
        "Friday": [businessHours[10.toString()], businessHours[11.toString()]],
        "Saturday": [
          businessHours[12.toString()],
          businessHours[13.toString()]
        ],
      }

      /* for (int i = 0; i < 14; i += 2)
    {
    days[(i / 2).toInt()]: [businessHours[i], businessHours[i + 1]].toList()
    }*/
      //Map.fromIterable(businessHours, key: (e) => e.name, value: (e) => e)
    });
  }
}
