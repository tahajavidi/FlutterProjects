import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:javidcoffee_android_app/app/app.dart';
import 'package:javidcoffee_android_app/features/home/controllers/home_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();
  String supabaseKey = dotenv.env["SUPABASE_KEY"] ?? "";
  String supabaseUrl = dotenv.env["SUPABASE_URL"] ?? "";

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
    authOptions: const FlutterAuthClientOptions(
      authFlowType: AuthFlowType.implicit,
    ),
  );

  AppLinks().uriLinkStream.listen((uri) {
    if (kDebugMode) {
      print(uri.toString());
    }
  });

  Get.create(() => HomeController());

  runApp(const MyApp());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}
