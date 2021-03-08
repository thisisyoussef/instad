import 'package:felmalaab_manager/screens/calendar_screen.dart';
import 'package:felmalaab_manager/screens/field_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_indicator/flutter_slider_indicator.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:felmalaab_manager/widgets/slider_widget.dart';

class VenuePage extends StatefulWidget {
  static String id = "venue_page";

  @override
  _VenuePageState createState() => _VenuePageState();
}

class _VenuePageState extends State<VenuePage> {
  bool isFavorite = true;
  var _pageController = PageController();
  var _currentImageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            _buildImageSlider(context),
            FieldPriceIndicator(),
            BackButton(),
            _buildImageIndicator(context),
            DraggableScrollableSheet(
                initialChildSize: 0.6,
                maxChildSize: 0.8,
                minChildSize: 0.6,
                builder: (context, controller) {
                  return SingleChildScrollView(
                    controller: controller,
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 25),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Icon(
                                  Icons.drag_handle,
                                  size: 30,
                                  color: Color(0xFF50B184),
                                ),
                              ),
                              Center(
                                child: Text(
                                  "Hayah Academy",
                                  style: TextStyle(
                                      color: Color(0xFF50B184),
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 26, right: 26, left: 26),
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF50B184),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.assistant_navigation,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 4.0),
                                          child: Text(
                                            "5 KM",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Color(0xFF50B184),
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "South of Police Academy \n 5th District \n New Cairo",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          color: Color(0xFF50B184),
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      AmenityBox(
                                        buttonIcon: MdiIcons.soccerField,
                                        iconString: "5 v 5",
                                      ),
                                      AmenityBox(
                                        buttonIcon: MdiIcons.soccer,
                                        iconString: "Ball",
                                      ),
                                      AmenityBox(
                                        buttonIcon: Icons.local_drink_sharp,
                                        iconString: "Drinks",
                                      ),
                                      AmenityBox(
                                        buttonIcon: Icons.wc,
                                        iconString: "WC",
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        /* Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(right: 24.0, bottom: 10),
                            child: FloatingActionButton(
                                child: Icon(
                                  isFavorite
                                      ? Icons.star_outlined
                                      : Icons.star_outline,
                                  color: Color(0xFF50B184),
                                  size: 35,
                                ),
                                backgroundColor: Colors.white,
                                onPressed: () {
                                  setState(() {
                                    isFavorite = !isFavorite;
                                  });
                                }),
                          ),
                        ),*/
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(right: 24.0, bottom: 10),
                            child: FloatingActionButton(
                                heroTag: null,
                                child: Icon(
                                  Icons.edit,
                                  color: Color(0xFF50B184),
                                  size: 35,
                                ),
                                backgroundColor: Colors.white,
                                onPressed: () {
                                  Navigator.pushNamed(context, FieldDetails.id);
                                }),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(right: 90.0, bottom: 10),
                            child: FloatingActionButton(
                                heroTag: null,
                                child: Icon(
                                  Icons.calendar_today_sharp,
                                  color: Color(0xFF50B184),
                                  size: 35,
                                ),
                                backgroundColor: Colors.white,
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, CalendarScreen.id);
                                }),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ],
        ),
        bottomNavigationBar: Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.15,
                right: MediaQuery.of(context).size.width * 0.15,
                bottom: 15),
            child: SliderWidget()),
      ),
    );
  }

  Widget _buildImageIndicator(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding:
            EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.32),
        child: SliderIndicator(
          length: 3,
          activeIndex: 0,
          indicator: Icon(
            Icons.radio_button_unchecked,
            size: 20,
            color: Color(0xFF50B184),
          ),
          activeIndicator: Icon(
            Icons.radio_button_checked,
            size: 20,
            color: Color(0xFF50B184),
          ),
        ),
      ),
    );
  }

  Widget _buildImageSlider(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      child: PageView.builder(
        controller: _pageController,
        itemBuilder: (context, index) {
          return Image.network(
            'https://www.hayahacademy.com/wp-content/uploads/2014/09/Big-Soccer-Field.jpg',
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}

class AmenityBox extends StatelessWidget {
  const AmenityBox({Key key, @required this.buttonIcon, this.iconString})
      : super(key: key);

  final IconData buttonIcon;
  final String iconString;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        //Color(0xFF50B184),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
        border: Border.all(
          width: 1,
          color: Color(0xFF50B184),
        ),
        // color: Color(0xFF50B184),
      ),
      child: Column(
        children: [
          Icon(
            buttonIcon,
            color: Color(0xFF50B184),
            //Colors.white,
            size: 70,
          ),
          Text(
            iconString,
            style: TextStyle(
                color: Color(0xFF50B184),
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF50B184),
          ),
          onPressed: () {
            Navigator.pop(context);
          }),
    );
  }
}

class FieldPriceIndicator extends StatelessWidget {
  const FieldPriceIndicator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 24, top: 50),
      decoration: BoxDecoration(
        color: Color(0xFF50B184).withOpacity(0.8),
        // Colors.grey.withOpacity(0.8),
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "100 EGP/hour",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
