import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: Starships(),
  ));
}

class Starships extends StatefulWidget {
  @override
  State<Starships> createState() => _StarshipsState();
}

class _StarshipsState extends State<Starships> {
  final String url = 'https://swapi.co/api/starships/';
  List starships;

  Future<String> getData() async {
    var res = await http.get(Uri.encodeFull(url), headers: {'Accept': 'application/json'});
    setState(() {
      var resBody = json.decode(res.body);
      starships = resBody['results'];
    });
    print('success');
    return 'Success!';
  }

  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Starships'),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: starships == null ? 0 : starships.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                title: Text(starships[index]['name']),
                subtitle: Text(starships[index]['model']),
              ),
            );
          },
        ),
      ),
    );
  }
}