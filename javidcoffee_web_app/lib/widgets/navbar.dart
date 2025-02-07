import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:javidcoffee_web_app/config/responsive.dart';
import 'package:javidcoffee_web_app/utils/app_colors.dart';

class Navbar extends StatefulWidget {
  final List<GlobalKey> navbarKey;
  final Function(int) onNavItemTap;
  final List<String> navLinks;

  const Navbar({
    super.key,
    required this.navbarKey,
    required this.onNavItemTap,
    required this.navLinks,
  });

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 45,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20),
                  width: 120,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.bgColor1,
                        AppColors.bgColor2,
                      ],
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF6078ea).withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(20),
                    child: Material(
                      color: Colors.transparent,
                      child: Center(
                        child: Text(
                          "ورود/ثبت نام",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 18),
                  child: TextButton(
                    onPressed: () {
                      widget.onNavItemTap(0);
                    },
                    child: Text(
                      widget.navLinks.first,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 18),
                  child: TextButton(
                    onPressed: () {
                      widget.onNavItemTap(1);
                    },
                    child: Text(
                      widget.navLinks[1],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 18),
                  child: TextButton(
                    onPressed: () {
                      widget.onNavItemTap(2);
                    },
                    child: Text(
                      widget.navLinks[2],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 18),
                  child: TextButton(
                    onPressed: () {
                      widget.onNavItemTap(3);
                    },
                    child: Text(
                      widget.navLinks[3],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ).animate().fade().slideX(duration: 1.seconds, begin: -0.5),
            Spacer(),
            Row(
              children: [
                Text(
                  "JAVID\nCOFFEE",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 16),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    gradient: LinearGradient(
                      colors: [
                        AppColors.bgColor1,
                        AppColors.bgColor2,
                      ],
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "JC",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                      ),
                    ),
                  ),
                ),
              ],
            ).animate().fade().slideX(duration: 1.seconds, begin: 2),
          ],
        ),
      );
    } else {
      if (Responsive.isTablet(context)) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 45,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PopupMenuButton(
                icon: Icon(
                  Icons.menu,
                  size: 35,
                ),
                position: PopupMenuPosition.over,
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      height: 70,
                      onTap: () {
                        widget.onNavItemTap(0);
                      },
                      child: ListTile(
                        title: Text(
                          widget.navLinks.first,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        leading: Icon(FontAwesomeIcons.house),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                    PopupMenuItem(
                      height: 70,
                      onTap: () {
                        widget.onNavItemTap(1);
                      },
                      child: ListTile(
                        title: Text(
                          widget.navLinks[1],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        leading: Icon(FontAwesomeIcons.bagShopping),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                    PopupMenuItem(
                      height: 70,
                      onTap: () {
                        widget.onNavItemTap(2);
                      },
                      child: ListTile(
                        title: Text(
                          widget.navLinks[2],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        leading: Icon(FontAwesomeIcons.circleInfo),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                    PopupMenuItem(
                      height: 70,
                      onTap: () {
                        widget.onNavItemTap(3);
                      },
                      child: ListTile(
                        title: Text(
                          widget.navLinks[3],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        leading: Icon(FontAwesomeIcons.phone),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                  ];
                },
              ).animate().fade().slideX(duration: 1.seconds, begin: -2),
              SizedBox(width: 15),
              Container(
                margin: EdgeInsets.only(right: 10),
                width: 120,
                height: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.bgColor1,
                      AppColors.bgColor2,
                    ],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF6078ea).withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(20),
                  child: Material(
                    color: Colors.transparent,
                    child: Center(
                      child: Text(
                        "ورود/ثبت نام",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ).animate().fade().slideX(duration: 1.seconds, begin: -1.3),
              Spacer(),
              Row(
                children: [
                  Text(
                    "JAVID\nCOFFEE",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 14),
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      gradient: LinearGradient(
                        colors: [
                          AppColors.bgColor1,
                          AppColors.bgColor2,
                        ],
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "JC",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ).animate().fade().slideX(duration: 1.seconds, begin: 2),
            ],
          ),
        );
      } else {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PopupMenuButton(
                icon: Icon(
                  Icons.menu,
                  size: 30,
                ),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      height: 70,
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        width: 120,
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.bgColor1,
                              AppColors.bgColor2,
                            ],
                            begin: Alignment.bottomRight,
                            end: Alignment.topLeft,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF6078ea).withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: Offset(0, 8),
                            ),
                          ],
                        ),
                        child: InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(20),
                          child: Material(
                            color: Colors.transparent,
                            child: Center(
                              child: Text(
                                "ورود/ثبت نام",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      height: 60,
                      onTap: () {
                        widget.onNavItemTap(0);
                      },
                      child: ListTile(
                        title: Text(
                          widget.navLinks.first,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        leading: Icon(FontAwesomeIcons.house),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                    PopupMenuItem(
                      height: 60,
                      onTap: () {
                        widget.onNavItemTap(1);
                      },
                      child: ListTile(
                        title: Text(
                          widget.navLinks[1],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        leading: Icon(FontAwesomeIcons.bagShopping),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                    PopupMenuItem(
                      height: 60,
                      onTap: () {
                        widget.onNavItemTap(2);
                      },
                      child: ListTile(
                        title: Text(
                          widget.navLinks[2],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        leading: Icon(FontAwesomeIcons.circleInfo),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                    PopupMenuItem(
                      height: 60,
                      onTap: () {
                        widget.onNavItemTap(3);
                      },
                      child: ListTile(
                        title: Text(
                          widget.navLinks[3],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        leading: Icon(FontAwesomeIcons.phone),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                  ];
                },
              ).animate().fade().slideX(duration: 1.seconds, begin: -2),
              Spacer(),
              Row(
                children: [
                  Text(
                    "JAVID\nCOFFEE",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 14),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        colors: [
                          AppColors.bgColor1,
                          AppColors.bgColor2,
                        ],
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "JC",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                        ),
                      ),
                    ),
                  ),
                ],
              ).animate().fade().slideX(duration: 1.seconds, begin: 1),
            ],
          ),
        );
      }
    }
  }
}
