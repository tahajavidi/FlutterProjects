import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:javidcoffee_web_app/config/responsive.dart';
import 'package:javidcoffee_web_app/config/size_config.dart';
import 'package:javidcoffee_web_app/utils/app_colors.dart';
import 'package:javidcoffee_web_app/widgets/navbar.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  static const routeName = "/landing";

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  final ScrollController scrollController = ScrollController();
  final List<String> navLinks = [
    "خانه",
    "محصولات",
    "درباره ما",
    "ارتباط با ما",
  ];
  final List<GlobalKey> navbarKey = List.generate(4, (index) => GlobalKey());

  void scrollSection(int navIndex) {
    final key = navbarKey[navIndex];
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: Responsive.isDesktop(context)
                ? SizeConfig.screenHeight * 0.89
                : SizeConfig.screenHeight * 0.92,
            child: Navbar(
              navLinks: navLinks,
              navbarKey: navbarKey,
              onNavItemTap: (p0) {
                scrollSection(p0);
              },
            ),
          ),
          Positioned(
            bottom: 0,
            top: Responsive.isDesktop(context)
                ? SizeConfig.screenHeight * 0.11
                : SizeConfig.screenHeight * 0.08,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              controller: scrollController,
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(key: navbarKey.first),
                  Container(
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.screenHeight,
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 0.1,
                      vertical: SizeConfig.screenHeight * 0.1,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "قهوه جاوید",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize:
                                      Responsive.isMobile(context) ? 28 : 32,
                                  fontWeight: FontWeight.w800,
                                  foreground: Paint()
                                    ..shader = const LinearGradient(
                                      colors: [
                                        AppColors.bgColor1,
                                        AppColors.bgColor2,
                                      ],
                                    ).createShader(
                                        Rect.fromLTRB(0, 50, 100, 10)),
                                ),
                              ).animate().fade().slideY(duration: 1.seconds),
                              Text(
                                "تعمیر دستگاه‌های قهوه‌ساز و فروش دانه‌های قهوه خاص",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize:
                                      Responsive.isMobile(context) ? 22 : 25,
                                  fontWeight: FontWeight.w800,
                                ),
                              ).animate().fade().slideY(duration: 1.seconds),
                              SizedBox(height: 20),
                              Text(
                                "قهوه جاوید، مکانی برای عاشقان قهوه است. ما در تعمیر برندهای معتبر دستگاه‌های قهوه‌ساز تخصص داریم و بهترین دانه‌های قهوه را برای شما فراهم می‌کنیم.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize:
                                      Responsive.isMobile(context) ? 19 : 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              ).animate().fade().slideY(duration: 1.seconds),
                              SizedBox(height: 30),
                              if (Responsive.isMobile(context))
                                FadeIn(
                                  animate: true,
                                  delay: const Duration(milliseconds: 500),
                                  duration: const Duration(seconds: 1),
                                  child: InkWell(
                                    onTap: () {},
                                    borderRadius: BorderRadius.circular(50),
                                    child: Container(
                                      height: 50,
                                      width: SizeConfig.screenWidth * 0.5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        gradient: LinearGradient(
                                          colors: [
                                            AppColors.bgColor1,
                                            AppColors.bgColor2,
                                          ],
                                        ),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "شروع کنید",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              else
                                FadeIn(
                                  animate: true,
                                  delay: const Duration(milliseconds: 500),
                                  duration: const Duration(seconds: 1),
                                  child: InkWell(
                                    onTap: () {},
                                    borderRadius: BorderRadius.circular(50),
                                    child: Container(
                                      height: 55,
                                      width: SizeConfig.screenWidth * 0.18,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        gradient: LinearGradient(
                                          colors: [
                                            AppColors.bgColor1,
                                            AppColors.bgColor2,
                                          ],
                                        ),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "شروع کنید",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              if (Responsive.isMobile(context))
                                Expanded(
                                  child: Image.asset(
                                    "assets/images/coffee_maker_3d.png",
                                    height: SizeConfig.screenHeight * 0.8,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        if (Responsive.isDesktop(context) ||
                            Responsive.isTablet(context))
                          Expanded(
                            child: Image.asset(
                              "assets/images/coffee_maker_3d.png",
                              height: SizeConfig.screenHeight * 0.8,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Container(
                    key: navbarKey[1],
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.screenHeight,
                    color: Color(0xFFBB6789),
                    child: Center(
                      child: Text(
                        "محصولات",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    key: navbarKey[2],
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.screenHeight,
                    color: Color(0xFFFB8A61),
                    child: Center(
                      child: Text(
                        "درباره ما",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    key: navbarKey[3],
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.screenHeight,
                    color: Color(0xFF469DFA),
                    child: Center(
                      child: Text(
                        "ارتباط با ما",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
