import 'package:felmalaab_manager/models/venue_details.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  final Function dayCallBack;
  const DatePicker({Key key, this.dayCallBack}) : super(key: key);
  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  double _height;
  double _width;
  int initialDay;
  String _setTime, _setDate;
  final f = new DateFormat('dd-MM-yyyy');

  String dateTime;
  DateTime selectedDate = DateTime.now();
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
      Future<Null> _selectDate(BuildContext context) async {
        final DateTime picked = await showDatePicker(
            context: context,
            initialDate: selectedDate,
            initialDatePickerMode: DatePickerMode.day,
            firstDate: DateTime(2015),
            lastDate: DateTime(2101));
        if (picked != null) {
          setState(() {
            selectedDate = picked;
            _dateController.text = f.format(selectedDate);
          });
          widget.dayCallBack(selectedDate);
          print(selectedDate);
        }
      }

      return Container(
        child: InkWell(
          onTap: () {
            _selectDate(context);
          },
          child: Container(
            color: Color(0xFF50B184),
            margin: EdgeInsets.only(top: 10),
            //width: _width / 4,
            height: _height / 20,
            //alignment: Alignment.center,
            child: TextFormField(
              style: TextStyle(fontSize: 18, color: Colors.white),
              textAlign: TextAlign.center,
              onSaved: (String val) {
                _setDate = val;
              },
              enabled: false,
              keyboardType: TextInputType.text,
              controller: _dateController,
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
