import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolistapp/view/HomePage.dart';
import 'package:todolistapp/view/profile.dart';
import 'package:todolistapp/view/onboarding.dart';
import 'package:todolistapp/view/todo_list.dart';
import 'package:todolistapp/model/user.dart';
import 'SharedPref.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class landingPage extends StatefulWidget {
  // late String param;
  // landingPage({Key? key, required this.param}) : super(key: key);
  Function setTheme;
  final String user;

  landingPage({Key? key, required this.setTheme, required this.user})
      : super(key: key);
  State<landingPage> createState() => _landingPageState();
}

class _landingPageState extends State<landingPage> {
  // final String ;
  // _landingPageState({required this.param});
  bool isDarkmode = SharedPref.pref?.getBool('isDarkmode') ?? false;
  ThemeData themeData = ThemeData.light();
  /* fungsi mengubah tema sesuai inputan parameter */
  void setTheme(bool isDarkmode) {
    setState(() {
      /* jika isDarkmode true maka ThemeData adalah dark dan sebaliknya */
      themeData = (isDarkmode) ? ThemeData.dark() : ThemeData.light();
      /* simpan nilai boolean pada shared preferences */
      SharedPref.pref?.setBool('isDarkmode', isDarkmode);
      print(isDarkmode);
    });
  }

  int _bottomNavCurrentIndex = 0;

  @override
  void initState() {
    // print(param.toString());
    // super.initState();
    bool isDarkmode = SharedPref.pref?.getBool('isDarkmode') ?? false;
    setTheme(isDarkmode);

    super.initState();
  }

  late List<Widget> container = [
    homePage(setTheme: setTheme),
    todoApp(),
    ProfilePage(setTheme: setTheme, user: widget.user)
    // Catalog(),
    // Catalog(param: param),
    // Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        automaticallyImplyLeading: false,
        title: const Text(
          "ToDoListApp",
          style: TextStyle(color: Colors.white),
        ),
        // automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.brightness_4_rounded,
                color: const Color.fromARGB(255, 253, 251, 251)),
            padding: EdgeInsets.only(right: 25),
            onPressed: () {
              isDarkmode = !isDarkmode;
              widget.setTheme(isDarkmode);
            },
          )
        ],
      ),
      body: container[_bottomNavCurrentIndex],
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _bottomNavCurrentIndex,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        backgroundColor: Colors.blue[400],
        onItemSelected: (index) =>
            setState(() => _bottomNavCurrentIndex = index),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text('Beranda'),
            activeColor: Colors.white,
            inactiveColor: Colors.white,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.assignment),
            title: Text('Catalog'),
            activeColor: Colors.white,
            inactiveColor: Colors.white,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.person),
            title: Text('Account'),
            activeColor: Colors.white,
            inactiveColor: Colors.white,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
