import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'Screen/home.dart';
import 'Screen/splash.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'IRANSans',
        primaryColor: Colors.transparent,
        useMaterial3: false,
      ),
      //
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fa', 'IR'),
        Locale('en', 'US'),
      ],
      locale: const Locale('fa', 'IR'),
      //
      initialRoute: "/splash",
      routes: {
        "/splash": (context) => const SplashScreen(),
        "/home": (context) => const HomeScreen(),
      },
    );
  }
}
