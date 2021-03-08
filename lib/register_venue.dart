import 'file:///C:/Users/youss/AndroidStudioProjects/felmalaab_manager/lib/widgets/rounded_button.dart';
import 'package:felmalaab_manager/data/user_details.dart';
import 'file:///C:/Users/youss/AndroidStudioProjects/felmalaab_manager/lib/screens/field_details.dart';
import 'file:///C:/Users/youss/AndroidStudioProjects/felmalaab_manager/lib/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:felmalaab_manager/widgets/input_row.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'models/selected_location.dart';
import 'package:felmalaab_manager/widgets/new_search_bar.dart';
import 'widgets/amenity_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/venue_details.dart';
import 'package:firebase_auth/firebase_auth.dart';

createAlertDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
              "Your venue is under review, in the meantime you can configure your venue schedule and have it ready to go"),
          content: Row(
            children: [
              FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, HomeScreen.id);
                },
                child: Text("Go Back"),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, FieldDetails.id);
                },
                child: Text("Prepare Venue"),
              ),
            ],
          ),
        );
      });
}

final _firestore = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;

class RegisterVenue extends StatefulWidget {
  static String id = "register_venue";
  String venueName;
  @override
  _RegisterVenueState createState() => _RegisterVenueState();
}

class _RegisterVenueState extends State<RegisterVenue> {
  Location _locationTracker = Location();
  GoogleMapController mapController;
  Circle circle;
  Stream _locationSubscription;
  IconData amenity1Icon = Icons.sports_soccer_outlined;
  IconData amenity2Icon = Icons.wc;
  IconData amenity3Icon = Icons.sports_handball;
  IconData amenity4Icon = Icons.local_drink_rounded;
  String amenity1 = "Ball";
  String amenity2 = "Bathroom";
  String amenity3 = "Bibs";
  String amenity4 = "Drinks";
  var amenities = {
    "Ball": false,
    "Bathroom": false,
    "Bibs": false,
    "Drinks": false,
    "Prayer Area": false
  };
  void updateMarker(LocationData newLocalData) {
    LatLng latLng = LatLng(newLocalData.latitude, newLocalData.longitude);
    this.setState(() {
      circle = Circle(
          circleId: CircleId("yourloco"),
          radius: 500,
          zIndex: 1,
          strokeColor: Colors.green,
          center: latLng,
          fillColor: Colors.greenAccent);
    });
  }

  void getCurrentLocation(SelectedLocation selectedLocation) async {
    var location = await _locationTracker.getLocation();

    updateMarker(location);

    _locationSubscription =
        _locationTracker.onLocationChanged.listen((newLocalData) {
      if (mapController != null) {
        mapController.animateCamera(CameraUpdate.newCameraPosition(
            new CameraPosition(
                bearing: 192,
                target: selectedLocation.position,
                tilt: 0,
                zoom: 12.00)));
        updateMarker(newLocalData);
      }
    }) as Stream;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VenueDetails>(
      builder: (BuildContext context, VenueDetails venueDetails, Widget child) {
        addNewVenue(SelectedLocation selectedLocation, String venueName,
            var amenities) {
          _firestore
              .collection('locations')
              .add(
                ({
                  'name': venueName,
                  'amenities': {
                    'Ball': amenities["Ball"],
                    'Bathroom': amenities["Bathroom"],
                    'Bibs': amenities["Bibs"],
                    'Drinks': amenities["Drinks"],
                  },
                  'location': GeoPoint(selectedLocation.positionLatitude,
                      selectedLocation.positionLongitude),
                  'approved': false,
                  'managers': [auth.currentUser.uid]
                }),
              )
              .then((value) {
            venueDetails.createVenue(value.id);
            _firestore.collection('users').doc(auth.currentUser.uid).update(
                  ({
                    'venues': FieldValue.arrayUnion([value.id])
                  }),
                );
          });
        }

        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Enter Your Venue Details",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
                InputRow(
                  widget: widget,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 1.0, horizontal: 8),
                  child: Row(
                    children: [
                      AmenityTile(
                          amenityIcon: amenity1Icon,
                          amenities: amenities,
                          amenity: amenity1),
                      AmenityTile(
                          amenityIcon: amenity2Icon,
                          amenities: amenities,
                          amenity: amenity2),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 1),
                  child: Row(
                    children: [
                      AmenityTile(
                          amenityIcon: amenity3Icon,
                          amenities: amenities,
                          amenity: amenity3),
                      AmenityTile(
                          amenityIcon: amenity4Icon,
                          amenities: amenities,
                          amenity: amenity4),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Searchbar(),
                    Consumer<SelectedLocation>(builder: (BuildContext context,
                        SelectedLocation selectedLocation, Widget child) {
                      final currentPosition = selectedLocation.position;
                      return Column(
                        children: [
                          Container(
                            color: Colors.redAccent,
                            height: 300,
                            width: 500,
                            child: GoogleMap(
                              mapType: MapType.normal,
                              onMapCreated:
                                  (GoogleMapController googleMapController) {
                                print("map created");
                                getCurrentLocation(selectedLocation);
                                setState(
                                  () {
                                    mapController = googleMapController;
                                  },
                                );
                              },
                              initialCameraPosition: CameraPosition(
                                zoom: 12,
                                target: selectedLocation.position,
                              ),
                            ),
                          ),
                          RoundedButton(
                            color: Color(0xFF50B184),
                            title: "Submit Venue",
                            onPressed: () async {
                              addNewVenue(selectedLocation, widget.venueName,
                                  amenities);
                              createAlertDialog(context);
                            },
                          ),
                        ],
                      );
                    }),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
