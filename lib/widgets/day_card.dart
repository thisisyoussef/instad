import 'package:flutter/material.dart';
import 'time_picker.dart';

class DayCard extends StatelessWidget {
  int dayIndex;
  String day;
  Function timeCallBack;
  DayCard({this.day, this.dayIndex, this.timeCallBack});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF50B184),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(day),
            trailing: Theme(
              data: Theme.of(context).copyWith(canvasColor: Colors.white),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TimePicker(
                    isOpenTime: true,
                    dayIndex: dayIndex,
                    timeCallBack: timeCallBack,
                  ),
                  Icon(Icons.arrow_right),
                  TimePicker(
                    isOpenTime: false,
                    dayIndex: dayIndex,
                    timeCallBack: timeCallBack,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
