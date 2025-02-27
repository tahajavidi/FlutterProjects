import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:javidcoffee_android_app/app/app_controller.dart';
import 'package:javidcoffee_android_app/features/admin/pages/admin_panel_page.dart';
import 'package:javidcoffee_android_app/features/admin/pages/edit_product_page.dart';
import 'package:javidcoffee_android_app/features/admin/pages/new_product_page.dart';
import 'package:javidcoffee_android_app/features/auth/pages/forgot_page.dart';
import 'package:javidcoffee_android_app/features/auth/pages/login_page.dart';
import 'package:javidcoffee_android_app/features/auth/pages/register_page.dart';
import 'package:javidcoffee_android_app/features/auth/pages/reset_page.dart';
import 'package:javidcoffee_android_app/features/auth/pages/welcome_page.dart';
import 'package:javidcoffee_android_app/features/chat/pages/chat_page.dart';
import 'package:javidcoffee_android_app/features/connection/pages/no_internet_page.dart';
import 'package:javidcoffee_android_app/features/details/pages/details_page.dart';
import 'package:javidcoffee_android_app/features/home/pages/home_page.dart';
import 'package:javidcoffee_android_app/features/policy/pages/policy_page.dart';
import 'package:javidcoffee_android_app/features/products/pages/products_page.dart';
import 'package:javidcoffee_android_app/features/profile/pages/edit_profile_page.dart';
import 'package:javidcoffee_android_app/features/profile/pages/profile_page.dart';
import 'package:javidcoffee_android_app/features/search/pages/search_page.dart';
import 'package:javidcoffee_android_app/features/splash/pages/splash_screen.dart';
import 'package:javidcoffee_android_app/theme/app_theme.dart';
import 'package:javidcoffee_android_app/view/view_page.dart';

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
                        ConnectivityResult.wifi ||
                    appController.results.first.obs.value ==
                        ConnectivityResult.vpn ||
                    appController.results.first.obs.value !=
                        ConnectivityResult.vpn
                ? appController.user.value == null
                    ? const WelcomePage()
                    : const ViewPage()
                : const NoInternetPage();
          } else {
            return const SplashScreen();
          }
        },
      ),
      getPages: [
        GetPage(
          name: HomePage.routeName,
          page: () => const HomePage(),
          curve: Curves.ease,
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: WelcomePage.routeName,
          page: () => const WelcomePage(),
          curve: Curves.ease,
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RegisterPage.routeName,
          page: () => const RegisterPage(),
          curve: Curves.ease,
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: LoginPage.routeName,
          page: () => const LoginPage(),
          curve: Curves.ease,
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: PolicyPage.routeName,
          page: () => const PolicyPage(),
          curve: Curves.ease,
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: ForgotPage.routeName,
          page: () => const ForgotPage(),
          curve: Curves.ease,
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: ResetPage.routeName,
          page: () => const ResetPage(),
          curve: Curves.ease,
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: SearchPage.routeName,
          page: () => const SearchPage(),
          curve: Curves.ease,
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: ProductsPage.routeName,
          page: () => const ProductsPage(),
          curve: Curves.ease,
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: ChatPage.routeName,
          page: () => const ChatPage(),
          curve: Curves.ease,
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: ProfilePage.routeName,
          page: () => const ProfilePage(),
          curve: Curves.ease,
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: EditProfilePage.routeName,
          page: () => const EditProfilePage(),
          curve: Curves.ease,
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: AdminPanelPage.routeName,
          page: () => const AdminPanelPage(),
          curve: Curves.ease,
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: DetailsPage.routeName,
          page: () => const DetailsPage(),
          curve: Curves.ease,
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: EditProductPage.routeName,
          page: () => const EditProductPage(),
          curve: Curves.ease,
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: NewProductPage.routeName,
          page: () => const NewProductPage(),
          curve: Curves.ease,
          transition: Transition.leftToRightWithFade,
        ),
      ],
    );
  }
}
