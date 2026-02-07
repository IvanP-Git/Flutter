import 'package:flutter/material.dart';
import 'package:supersearch/screens/search/splash.dart';
//import 'screens/search/search.dart';
import 'style.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Super Search',
      home: const SplashScreen(),
      //home: const Search(),
      theme: appTheme,
    );
  }
}
