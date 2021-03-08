import 'dart:ui';
import 'package:felmalaab_manager/models/onboard_page_model.dart';

List<OnboardPageModel> onboardData = [
  OnboardPageModel(
      Color(0xFFFFFFFF),
      Color(0xFF50B184),
      Color(0xFF8DA8FF),
      0,
      "assets/images/soccerstadium.png",
      "Welcome to Tamas Manager!",
      "to make the most out of your sports venue!",
      "TAMAS PROVIDES EVERYTHING YOU NEED",
      false),
  OnboardPageModel(
      Color(0xFFFFFFFF),
      Color(0xFF50B184),
      Color(0xFF376F92),
      1,
      "assets/images/findplayers.png",
      "Set up",
      "Organize all your bookings at the press of a button",
      "Your Schedule",
      false),
  OnboardPageModel(Color(0xFFFFFFFF), Color(0xFF50B184), Color(0xFFFFFFFF), 2,
      "assets/images/playerkickingball.png", "Play", "", "Your Game", true),
];
