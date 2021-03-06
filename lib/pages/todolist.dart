import 'package:flutter/material.dart';
import 'package:layout/pages/add.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:layout/pages/update_todolist.dart';

class Todolist extends StatefulWidget {
  // const Todolist({ Key? key }) : super(key: key);

  @override
  _TodolistState createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {
  List todolistitems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTodolist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPage(),
            ),
          ).then((value) {
            setState(() {
              getTodolist();
            });
          });
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('All Todolist'),
        actions: [
          IconButton(
            onPressed: () {
              getTodolist();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: todolistCreate(),
    );
  }

  Widget todolistCreate() {
    return ListView.builder(
      itemCount: todolistitems.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text('${todolistitems[index]['title']}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdatePage(
                    todolistitems[index]['id'],
                    todolistitems[index]['title'],
                    todolistitems[index]['detail'],
                  ),
                ),
              ).then((value) {
                setState(() {
                  print(value);
                  if (value == 'delete') {
                    final snackBar = SnackBar(
                      content: const Text('Delete Complete'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  getTodolist();
                });
              });
            },
          ),
        );
      },
    );
  }

  Future<void> getTodolist() async {
    List alltodo = [];
    var url = Uri.http('192.168.1.67:8000', 'api/get-all-todolist');
    var response = await http.get(url);
    // var result = json.decode(response.body);
    var result = utf8.decode(response.bodyBytes);
    setState(() {
      todolistitems = jsonDecode(result);
    });
  }
}
