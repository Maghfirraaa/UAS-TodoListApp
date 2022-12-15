import 'package:flutter/material.dart';
import 'package:todolistapp/view/login.dart';
import 'package:todolistapp/view/register.dart';
import 'package:todolistapp/view/splashscreen.dart';
import 'SharedPref.dart';

Future<void> main() async {
  // runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.init();

  // runApp(const onboarding());
}

class onboarding extends StatefulWidget {
  const onboarding({Key? key}) : super(key: key);

  @override
  State<onboarding> createState() => _onboardingState();
}

class _onboardingState extends State<onboarding> {
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
  void initState() {
    bool isDarkmode = SharedPref.pref?.getBool('isDarkmode') ?? false;
    setTheme(isDarkmode);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              Image.asset(
                'image/image.png',
                width: 261.11,
                height: 262,
              ),
              SizedBox(
                height: 60,
              ),
              Text(
                "Do Your Plan \n Do Everything On Schedule",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                "whatever is done according to the schedule\nwill definitely run smoothly",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black45,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 100,
              ),
              Builder(
                builder: (context) => RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                LoginPage(setTheme: setTheme)));
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.blue[400],
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(130, 16, 130, 16),
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Builder(
                  builder: (context) => OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RegisterPage(setTheme: setTheme)));
                        },
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    side: BorderSide(color: Colors.black54)))),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(130, 16, 130, 16),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54),
                          ),
                        ),
                      )),
            ],
          ),
        ),
      ),
    );
  }
}
