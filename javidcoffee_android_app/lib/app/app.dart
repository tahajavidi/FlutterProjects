import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:javidcoffee_android_app/app/app_controller.dart';
import 'package:javidcoffee_android_app/features/auth/pages/forgot_page.dart';
import 'package:javidcoffee_android_app/features/auth/pages/login_page.dart';
import 'package:javidcoffee_android_app/features/auth/pages/register_page.dart';
import 'package:javidcoffee_android_app/features/auth/pages/welcome_page.dart';
import 'package:javidcoffee_android_app/features/connection/pages/no_internet_page.dart';
import 'package:javidcoffee_android_app/features/home/pages/home_page.dart';
import 'package:javidcoffee_android_app/features/policy/pages/policy_page.dart';
import 'package:javidcoffee_android_app/features/splash/pages/splash_screen.dart';
import 'package:javidcoffee_android_app/theme/app_theme.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppController appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "JavidCoffee",
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('fa'), Locale("en")],
      locale: const Locale("fa"),
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: Obx(
        () {
          if (appController.results.isNotEmpty) {
            return appController.results.first.obs.value ==
                        ConnectivityResult.mobile ||
                    appController.results.first.obs.value ==
                        ConnectivityResult.wifi
                ? appController.user.value == null
                    ? const WelcomePage()
                    : const HomePage()
                : const NoInternetPage();
          } else {
            return const SplashScreen();
          }
        },
      ),
      getPages: [
        GetPage(
          name: WelcomePage.routeName,
          page: () => const WelcomePage(),
          curve: Curves.ease,
          transition: Transition.cupertino,
        ),
        GetPage(
          name: RegisterPage.routeName,
          page: () => const RegisterPage(),
          curve: Curves.ease,
          transition: Transition.cupertino,
        ),
        GetPage(
          name: LoginPage.routeName,
          page: () => const LoginPage(),
          curve: Curves.ease,
          transition: Transition.cupertino,
        ),
        GetPage(
          name: PolicyPage.routeName,
          page: () => const PolicyPage(),
          curve: Curves.ease,
          transition: Transition.cupertino,
        ),
        GetPage(
          name: ForgotPage.routeName,
          page: () => const ForgotPage(),
          curve: Curves.ease,
          transition: Transition.cupertino,
        ),
      ],
    );
  }
}
