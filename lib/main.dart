import 'package:flutter/material.dart';
import 'package:todolistapp/view/HomePage.dart';
import 'package:todolistapp/view/landing.dart';
import 'package:todolistapp/view/splashscreen.dart';
import 'package:todolistapp/view/SharedPref.dart';

Future<void> main() async {
  // runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData themeData = ThemeData.light();
  //mengubah fungsi sesuai parameter
  void setTheme(bool isDarkmode) {
    setState(() {
      themeData = (isDarkmode) ? ThemeData.dark() : ThemeData.light();

      //simpan nilai bolean pada shared preferences
      SharedPref.pref?.setBool('isDarkmode', isDarkmode);
      print(isDarkmode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(setTheme: setTheme),
      // home: landingPage(setTheme: setTheme),
    );
  }
}
