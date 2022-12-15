import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:todolistapp/view/login.dart';
import 'package:todolistapp/model/todo.dart';

import '../model/model.dart';

class Service {
  static Future<List<Data>> getDataHome() async {
    Dio dio = Dio();
    var response = await dio.get('http://10.0.2.2:3000/data');

    print('status code : ${response.statusCode}');
    var dataResponse = response.data;
    //print(dataResponse);

    List<Data> datas =
        (response.data as List).map((e) => Data.fromJson(e)).toList();
    return datas;
  }

  static Future<List<Todo>> getDataTodo() async {
    Dio dio = Dio();
    var response = await dio.get('http://10.0.2.2:3000/Todo');

    print('status code : ${response.statusCode}');
    var dataResponse = response.data;
    //print(dataResponse);

    List<Todo> datatodo =
        (response.data as List).map((e) => Todo.fromJson(e)).toList();
    return datatodo;
  }

  static Future<List<Todo>> getDataid(String id) async {
    Dio dio = Dio();
    var response = await dio.get('http://10.0.2.2:3000/Todo?id=' + id);

    print('status code : ${response.statusCode}');
    var dataResponse = response.data;
    //print(dataResponse);

    List<Todo> datatodo =
        (response.data as List).map((e) => Todo.fromJson(e)).toList();
    return datatodo;
  }
}
