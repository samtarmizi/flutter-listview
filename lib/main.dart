import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() => runApp(MyApp());
 
class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String url = 'https://ams-api.astro.com.my/ams/v3/getChannelList';

  List data;

  Future<String> getData() async{
     var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    setState(() {
      var extractdata = json.decode(response.body);
      data = extractdata["channels"];
      print(data);
    });
    return null;
  }

  Future init() async {
    this.getData();
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  // final List<String> items = ['Apple','Banana', 'Coconut', 'Durian'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: ListView.builder(
          itemCount: data.length == null ? 0 : data.length,
          itemBuilder: (context, index){
            return ListTile(
              title: Text('${data[index]['channelTitle']} '),
              subtitle: Text('${data[index]['channelStbNumber']} - ${data[index]['channelId']}'),
            );
          },
        )
        ),
    );
  }
}