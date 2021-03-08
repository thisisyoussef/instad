import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:search_map_place/search_map_place.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:felmalaab_manager/models/selected_location.dart';

class Searchbar extends StatefulWidget {
  final String name;
  const Searchbar({Key key, this.name});
  @override
  _SearchbarState createState() => _SearchbarState(name);
}

class _SearchbarState extends State<Searchbar> {
  String name;
  _SearchbarState(this.name);
  SearchMapPlaceWidget searchbar;

  LatLng location;

  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position>(context);
    return Consumer<SelectedLocation>(
      builder: (BuildContext context, SelectedLocation selectedLocation,
          Widget child) {
        return Container(
          child: SearchMapPlaceWidget(
            apiKey: 'AIzaSyAFiqtR8aU69FaHCCVuOYvic0A9DB8yyXU',
            location:
                LatLng(currentPosition.latitude, currentPosition.longitude),
            radius: 50000,
            onSearch: (Place place) {
              print("searching");
            },
            onSelected: (Place place) {
              setState(() {
                print("onSelected used");
                selectedLocation.changeName(place.name);
                place.geolocation.then((location) {
                  selectedLocation.changePosition(location.coordinates);
                });
              });
            },
          ),
        );
      },
    );
  }
}
