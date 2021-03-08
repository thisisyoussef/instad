import 'package:flutter/material.dart';

class AmenityTile extends StatefulWidget {
  const AmenityTile({
    Key key,
    @required this.amenityIcon,
    @required this.amenities,
    @required this.amenity,
  }) : super(key: key);

  final IconData amenityIcon;
  final Map<String, bool> amenities;
  final String amenity;

  @override
  _AmenityTileState createState() => _AmenityTileState();
}

class _AmenityTileState extends State<AmenityTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 2),
      child: Container(
        width: (MediaQuery.of(context).size.width / 2) - 10,
        color: Colors.grey,
        child: CheckboxListTile(
            title: Text(widget.amenity),
            secondary: Icon(widget.amenityIcon),
            checkColor: Colors.green,
            activeColor: Colors.white70,
            value: widget.amenities[widget.amenity],
            onChanged: (bool status) {
              setState(() {
                widget.amenities[widget.amenity] = status;
              });
            }),
      ),
    );
  }
}
