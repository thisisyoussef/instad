import 'dart:ui';

class OnboardPageModel {
  final Color primeColor;
  final Color accentColor;
  final Color nextAccentColor;
  final int pageNumber;
  final String imagePath;
  final String caption;
  final String subhead;
  final String description;
  bool login;

  OnboardPageModel(
      this.primeColor,
      this.accentColor,
      this.nextAccentColor,
      this.pageNumber,
      this.imagePath,
      this.caption,
      this.description,
      this.subhead,
      this.login);
}
