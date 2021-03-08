import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:search_map_place/search_map_place.dart';
import 'package:felmalaab_manager/services/geolocator_screen.dart';
//import 'package:geopoint/geopoint.dart';

class SelectedLocation extends ChangeNotifier {
  LatLng position = LatLng(31.2357, 30.0444);
  //GeoPoint positionGeoPoint;
  double positionLatitude;
  double positionLongitude;
  String name = "null";
  Image image;
  void changeName(String newName) {
    name = newName;
    notifyListeners();
  }

  void changeImage() {}

  void changePosition(LatLng newPosition) {
    position = newPosition;
    try {
      positionLatitude = position.latitude;
      positionLongitude = position.longitude;
      position = LatLng(positionLatitude, positionLongitude);
      notifyListeners();
    } catch (e) {
      print("cant change position");
    }
  }

  LatLng getLocation() {
    return LatLng(positionLatitude, positionLongitude);
  }
}
