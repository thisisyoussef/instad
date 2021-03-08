import 'package:felmalaab_manager/models/venue_details.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class TimePicker extends StatefulWidget {
  final bool isOpenTime;
  final int dayIndex;
  final Function timeCallBack;
  TimePicker({Key key, this.isOpenTime, this.dayIndex, this.timeCallBack})
      : super(key: key);
  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  double _height;
  double _width;
  int initialHour;
  String _setTime, _setDate;

  String _hour, _minute, _time;

  String dateTime;
  TimeOfDay selectedTime = TimeOfDay(hour: 11, minute: 00);
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  @override
  void initState() {
    _dateController.text = formatDate(DateTime.now(), [yy, '-', M, '-', d]);

    _timeController.text =
        formatDate(DateTime(2019, 08, 1, 10, 0), [hh, ':', nn, " ", am])
            .toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    // dateTime = formatDate(DateTime.now(), [yy, '-', M, '-', d]);
    return Consumer<VenueDetails>(builder:
        (BuildContext context, VenueDetails venueDetails, Widget child) {
      Future<Null> _selectTime(BuildContext context) async {
        final TimeOfDay picked = await showTimePicker(
          context: context,
          initialTime: TimeOfDay(hour: 11, minute: 0),
        );
        if (picked != null) {
          setState(() {
            selectedTime = picked;
            _hour = selectedTime.hour.toString();
            _minute = selectedTime.minute.toString();
            _time = _hour + ' : ' + _minute;
            _timeController.text = _time;
            _timeController.text = formatDate(
                DateTime(2021, 1, 1, selectedTime.hour, selectedTime.minute),
                [hh, ':', nn, " ", am]).toString();
            venueDetails.setBusinessHours(
                widget.dayIndex, widget.isOpenTime, selectedTime.toString());
            widget.timeCallBack(widget.isOpenTime,
                DateTime(2021, 1, 1, selectedTime.hour, selectedTime.minute));
          });
        }
      }

      return Container(
        child: InkWell(
          onTap: () {
            _selectTime(context);
          },
          child: Container(
            margin: EdgeInsets.only(top: 10),
            width: _width / 4,
            height: _height / 30,
            //alignment: Alignment.center,
            child: TextFormField(
              style: TextStyle(fontSize: 18, color: Colors.white),
              textAlign: TextAlign.center,
              onSaved: (String val) {
                _setTime = val;
              },
              enabled: false,
              keyboardType: TextInputType.text,
              controller: _timeController,
              decoration: InputDecoration(
                disabledBorder:
                    UnderlineInputBorder(borderSide: BorderSide.none),
                // labelText: 'Time',
                // contentPadding: EdgeInsets.all(5)
              ),
            ),
          ),
        ),
      );
    });
  }
}
