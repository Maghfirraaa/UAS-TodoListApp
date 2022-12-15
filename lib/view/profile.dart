import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:todolistapp/view/login.dart';
import 'package:todolistapp/view/onboarding.dart';

class ProfilePage extends StatefulWidget {
  Function setTheme;
  final String user;

  ProfilePage({Key? key, required this.setTheme, required this.user})
      : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  double coverHeight = 280;
  double profileHeight = 144;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
              margin: EdgeInsets.only(
                bottom: 80,
              ),
              child: buildTop()),
          buildContent(),
        ],
      ),
    );
  }

  Widget buildTop() {
    final top = coverHeight - profileHeight / 2;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        coverImage(),
        Positioned(
          top: top,
          child: profileImage(),
        ),
      ],
    );
  }

  Widget buildContent() => Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Text(
            widget.user,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Mahasiswa',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 140,
          ),
          Builder(
            builder: (context) => RaisedButton(
              onPressed: () {
                setState(() {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => onboarding()));
                });
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(130, 15, 130, 15),
                child: Text(
                  "Logout",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      );

  Widget coverImage() => Container(
        color: Colors.grey,
        child: Image(
          image: AssetImage('image/image.png'),
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover,
        ),
      );

  Widget profileImage() => CircleAvatar(
        radius: profileHeight / 2,
        backgroundColor: Colors.grey.shade800,
        backgroundImage: AssetImage('image/image4.png'),
      );
}
