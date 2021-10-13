import 'package:flutter/material.dart';
import 'package:layout/pages/add.dart';
import 'package:layout/pages/home.dart';
import 'package:layout/pages/todolist.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Computer Knowledge',
      home: Todolist(),
    );
  }

 
}
