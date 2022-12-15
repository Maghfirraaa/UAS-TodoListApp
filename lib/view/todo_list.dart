import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:todolistapp/Service/Service.dart';
import 'package:todolistapp/model/todo.dart';

class todoApp extends StatefulWidget {
  @override
  _todoAppState createState() => _todoAppState();
}

// ignore: camel_case_types
class _todoAppState extends State<todoApp> {
  var output = '';
  List<dynamic> mylist = [];
  bool firstVal = false;

  TextEditingController todox = TextEditingController();

  void addTodo(String todo) async {
    try {
      var response =
          await Dio().post('http://10.0.2.2:3000/Todo', data: {"todo": todo});
      if (response.statusCode == 201) {
      } else {
        print("Failed");
      }
    } catch (e) {
      print(e);
    }
  }

  void Deltodo(String id) async {
    try {
      var response = await Dio().delete('http://10.0.2.2:3000/Todo/' + id);
      if (response.data.length > 0) {
      } else {
        print("Failed");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void update(String id, String todo) async {
    try {
      var response = await Dio()
          .put('http://10.0.2.2:3000/Todo/' + id, data: {"todo": todo});
      if (response.data.length > 0) {
        print("Edit successfully");
      } else {
        print("Failed");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10.0),
        height: double.infinity,
        child: FutureBuilder<List<Todo>>(
            future: Service.getDataTodo(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.hasError) {
                  return const Text('Woops something wrong');
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(5.0),
                          height: 60,
                          color: Colors.grey[200],
                          child: ListTile(
                            title: Text(
                              '${snapshot.data![index].todo}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                            trailing: Container(
                              width: 50,
                              child: Row(children: [
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text('Edit Your Todo'),
                                                content: TextField(
                                                  onChanged: (value) {
                                                    output = value;
                                                  },
                                                ),
                                                actions: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        update(
                                                            snapshot
                                                                .data![index].id
                                                                .toString(),
                                                            output);
                                                      });

                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Center(
                                                        child: Center(
                                                            child:
                                                                Text('Edit'))),
                                                  )
                                                ],
                                              );
                                            });
                                      });
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.green,
                                    )),
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        // mylist.removeAt(index);
                                        Deltodo("${snapshot.data?[index].id}");
                                      });
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    )),
                              ]),
                            ),
                          ),
                        );
                      });
                }
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Add Your Todo'),
                  content: TextField(
                    // onChanged: (value) {
                    //   output = value;
                    // },
                    controller: todox,
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          addTodo(todox.text);
                          todox.clear();
                        });

                        Navigator.of(context).pop();
                      },
                      child: Center(child: Text('Add to List')),
                    )
                  ],
                );
              });
        },
        child: Icon(
          Icons.add,
          color: Colors.cyan[900],
        ),
      ),
    );
  }
}
