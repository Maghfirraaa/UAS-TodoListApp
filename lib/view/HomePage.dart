import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolistapp/view/HomePage.dart';
import 'package:todolistapp/view/profile.dart';
import 'package:todolistapp/view/onboarding.dart';
import 'package:todolistapp/Service/Service.dart';
import 'SharedPref.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'detailscreen.dart';
import 'package:todolistapp/model/model.dart';

class homePage extends StatefulWidget {
  // late String param;
  // landingPage({Key? key, required this.param}) : super(key: key);
  Function setTheme;
  homePage({Key? key, required this.setTheme}) : super(key: key);
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  void setTheme() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  Widget card() {
    return Card(
      color: Colors.blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        height: 144,
        width: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("image/image2.png"), fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "ToDoList App",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              "Get Solution for" + " Managing Time",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  // Widget card_blog(String nama, String gambar, String detail,
  //     AsyncSnapshot<List<Data>> snapshot, int index)
  Widget card_blog(String nama, String gambar, String detail,
      AsyncSnapshot<List<Data>> snapshot, int index) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.network(
              snapshot.data![index].gambar,
              height: 280,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              nama,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              detail,
              maxLines: 2,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: EdgeInsets.only(top: 16, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          card(),
          SizedBox(
            height: 24,
          ),
          Text(
            "Popular Articles",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 16,
          ),
          Expanded(
            child: FutureBuilder<List<Data>>(
              future: Service.getDataHome(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.hasError) {
                    return const Text('Woops something wrong');
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailArtikel(
                                              nama: snapshot.data![index].nama,
                                              gambar:
                                                  snapshot.data![index].gambar,
                                              detail:
                                                  snapshot.data![index].detail,
                                            )));
                              },
                              child: card_blog(
                                  snapshot.data![index].nama,
                                  snapshot.data![index].gambar,
                                  snapshot.data![index].detail,
                                  snapshot,
                                  index),
                            ),
                          ],
                        );
                      },
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    ));
  }

//   card_blog(nama, gambar, detail, AsyncSnapshot<Map<String, dynamic>> snapshot, int index) {}
}

//             Padding(padding: EdgeInsets.only(bottom: 5)),
//             FutureBuilder<Map<String, dynamic>>(
//               future: Service.getDataHome(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: Text('Please wait its loading...'));
//                 } else {
//                   if (snapshot.hasError) {
//                     return Center(child: Text('Error: ${snapshot.error}'));
//                     // return Text(snapshot.data.toString());
//                   } else {
//                     return Padding(
//                       padding: const EdgeInsets.all(12.0),
//                       child: GridView.builder(
//                           itemCount: snapshot.data!.length,
//                           gridDelegate:
//                               const SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 2,
//                             crossAxisSpacing: 16,
//                             mainAxisSpacing: 16,
//                           ),
//                           itemBuilder: (context, index) {
//                             return Stack(
//                               children: [
//                                 Container(
//                                   // color: Colors.orange,
//                                   width: double.infinity,
//                                   height: double.infinity,

//                                   child: Image.network(
//                                     "${snapshot.data![index].gambar}",
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                                 Column(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Container(
//                                         width: double.infinity,
//                                         color: Colors.black26,
//                                         child: Text(
//                                           "${snapshot.data![index].tittle}",
//                                           textAlign: TextAlign.center,
//                                           style: TextStyle(color: Colors.white),
//                                         )),
//                                     Container(
//                                         width: double.infinity,
//                                         color: Colors.black26,
//                                         child: Text(
//                                           "${snapshot.data![index].price}",
//                                           textAlign: TextAlign.center,
//                                           style: TextStyle(color: Colors.white),
//                                         )),
//                                   ],
//                                 )
//                               ],
//                             );
//                           }),
//                     );
//                   }
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
