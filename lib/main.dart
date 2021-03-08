import 'package:felmalaab_manager/models/timeslot_data.dart';
import 'package:felmalaab_manager/models/venue_details.dart';
import 'package:felmalaab_manager/screens/calendar_screen.dart';
import 'package:felmalaab_manager/screens/field_details.dart';
import 'package:felmalaab_manager/screens/intro_screen.dart';
import 'package:felmalaab_manager/screens/login_screen.dart';
import 'package:felmalaab_manager/screens/venue_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:felmalaab_manager/register_venue.dart';
import 'package:provider/provider.dart';
import 'models/selected_location.dart';
import 'package:geolocator/geolocator.dart';
import 'services/geolocator_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseFirestore.instance.clearPersistence();
  FirebaseFirestore.instance.settings = Settings(persistenceEnabled: false);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final locatorService = GeoLocatorService();
    //TODO: adjust theme
    //TODO: refactor theme
    return MultiProvider(
      providers: [
        FutureProvider(
          create: (context) => locatorService.getLocation(),
        ),
        ChangeNotifierProvider<SelectedLocation>(
          create: (_) => SelectedLocation(),
        ),
        ChangeNotifierProvider<TimeSlotData>(
          create: (_) => TimeSlotData(),
        ),
        ChangeNotifierProvider<VenueDetails>(
          create: (_) => VenueDetails(),
          builder: (context, widget) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                // Define the default brightness and colors.
                brightness: Brightness.dark,
                primaryColor: Colors.lightBlue[800],
                accentColor: Colors.cyan[600],

                // Define the default font family.
                fontFamily: 'Georgia',

                // Define the default TextTheme. Use this to specify the default
                // text styling for headlines, titles, bodies of text, and more.
                textTheme: TextTheme(
                  headline1:
                      TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
                  headline3: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(5.0, 2.0),
                        blurRadius: 3.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ],
                  ),
                  headline6:
                      TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
                  bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
                ),
              ),
              initialRoute: LoginScreen.id,
              routes: {
                IntroScreen.id: (context) => IntroScreen(),
                RegisterScreen.id: (context) => RegisterScreen(),
                RegisterVenue.id: (context) => RegisterVenue(),
                HomeScreen.id: (context) => HomeScreen(),
                LoginScreen.id: (context) => LoginScreen(),
                FieldDetails.id: (context) => FieldDetails(),
                CalendarScreen.id: (context) => CalendarScreen(),
                VenuePage.id: (context) => VenuePage(),
              },
            );
          },
        )
      ],
      //  child:
    );
  }
}
