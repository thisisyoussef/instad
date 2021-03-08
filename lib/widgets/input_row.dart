import 'package:flutter/material.dart';
import 'package:felmalaab_manager/register_venue.dart';

class InputRow extends StatelessWidget {
  InputRow({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final RegisterVenue widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Venue Name",
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              width: MediaQuery.of(context).size.width / 1.5,
              color: Colors.grey.shade100,
              child: TextField(
                style: TextStyle(color: Colors.black, fontSize: 15),
                onChanged: (String input) {
                  widget.venueName = input;
                },
                decoration: InputDecoration(
                    //hintText: "Venue Name",
                    hintStyle: TextStyle(
                        color: Colors.green, fontStyle: FontStyle.italic),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                      borderRadius: BorderRadius.circular(15),
                    )),
              )),
        )
      ],
    );
  }
}
