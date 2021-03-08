import 'package:flutter/material.dart';

class CheckboxTIle extends StatefulWidget {
  final String taskTitle;
  final Function checkboxCallback;
  final Function removeTaskCallback;

  CheckboxTIle(
      {this.taskTitle, this.checkboxCallback, this.removeTaskCallback});

  @override
  _CheckboxTIleState createState() => _CheckboxTIleState();
}

bool isChecked = false;

class _CheckboxTIleState extends State<CheckboxTIle> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          unselectedWidgetColor: Color(0xFF50B184),
          primaryColor: Color(0xFF50B184)),
      child: ListTile(
          onLongPress: widget.removeTaskCallback,
          title: Text(
            widget.taskTitle,
            style: TextStyle(
              color: Color(0xFF50B184),
            ),
          ),
          trailing: Checkbox(
            autofocus: true,
            focusColor: Color(0xFF50B184),
            hoverColor: Color(0xFF50B184),
            activeColor: Colors.white,
            value: isChecked,
            checkColor: Color(0xFF50B184),
            onChanged: (condition) {
              setState(() {
                isChecked = !isChecked;
              });
              widget.checkboxCallback();
            },
          )),
    );
  }
}
