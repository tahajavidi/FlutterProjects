class Responsive {
  static late bool isMobile;
  static late bool isTablet;

  void init(double width) {
    if (width < 600) {
      isMobile = true;
      isTablet = false;
    } else {
      isMobile = false;
      isTablet = true;
    }
  }
}
