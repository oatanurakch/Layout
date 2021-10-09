import 'package:flutter/material.dart';
import 'package:layout/pages/detail.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Homepage extends StatefulWidget {
  // const Homepage({ Key? key }) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Computer Knowledge'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
          builder: (context, AsyncSnapshot snapshot) {
            // var _data = json.decode(snapshot.data.toString());
            // Listview.builder คล้าย ๆ การวนหลูบ index จะวนอัตโนมัติ
            return ListView.builder(
              // itemBuilder: (BuildContext context, int index) {
              //   return Mybox(_data[index]["title"], _data[index]["subtitle"],
              //       _data[index]["image_url"], _data[index]["detail"],);
              // },
              itemBuilder: (BuildContext context, int index) {
                return Mybox(snapshot.data[index]["title"], snapshot.data[index]["subtitle"],
                    snapshot.data[index]["image_url"], snapshot.data[index]["detail"],);
              },
              itemCount: snapshot.data.length,
            );
          },

          // future: DefaultAssetBundle.of(context).loadString('assets/data.json'),
          future: getData(),

        ),
      ),
    );
  }

  Widget Mybox(String title, String subTitle, String url, String _detail) {
    var v1, v2, v3, v4;
    v1 = title;
    v2 = subTitle;
    v3 = url;
    v4 = _detail;
    return Container(
      margin: EdgeInsets.only(
        top: 20,
      ),
      padding: EdgeInsets.all(20),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        // color: Colors.green[200],
        image: DecorationImage(
          image: NetworkImage(url),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            subTitle,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(v1, v2, v3, v4),
                ),
              );
            },
            child: Text('อ่านต่อ'),
          ),
        ],
      ),
    );
  }

  Future getData() async {
    var url = Uri.https('raw.githubusercontent.com', 'oatanurakch/BasicFlutterAPI/main/data.json');
    var response = await http.get(url);
    var result = json.decode(response.body);
    return result;
  }

}
