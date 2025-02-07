import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;
  const Responsive({
    super.key,
    required this.desktop,
    required this.tablet,
    required this.mobile,
  });

  //* mobile
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  //* tablet
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1026 &&
      MediaQuery.of(context).size.width >= 650;

  //* desktop
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1026;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    if (size.width >= 1026) {
      return desktop;
    } else if (size.width >= 650 && tablet != null) {
      return tablet!;
    } else {
      return mobile;
    }
  }
}
