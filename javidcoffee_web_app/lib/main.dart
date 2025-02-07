import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:javidcoffee_web_app/screens/landing.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  String supabaseKey = dotenv.env["SUPABASE_KEY"] ?? "";
  String supabaseUrl = dotenv.env["SUPABASE_URL"] ?? "";

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
  );

  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "JavidCoffee",
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fa'),
        Locale("en"),
      ],
      locale: const Locale("fa"),
      theme: ThemeData(
        fontFamily: "Yekan",
      ),
      home: Landing(),
      routes: {
        Landing.routeName: (context) => const Landing(),
      },
    );
  }
}
