// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:band_names/models/bands.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Aventura', votes: 13),
    Band(id: '2', name: 'Frank Reyes', votes: 8),
    Band(id: '3', name: 'Juan Luis Guerra', votes: 16),
    Band(id: '4', name: 'El Alfa', votes: 30),
    Band(id: '5', name: 'Marc Anthony', votes: 4),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text('BandNames'),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: bands.length,
          itemBuilder: (context, i) => _bandTile(bands[i])),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewBand,
        elevation: 1,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {},
      background: Container(
        color: Colors.red,
        child: Align(
          child: Text(
            'Deleted Band..',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          alignment: Alignment.center,
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.amberAccent[150],
          child: Text(band.name.substring(0, 2)),
        ),
        title: Text(band.name),
        trailing: Text(
          '${band.votes}',
          style: TextStyle(fontSize: 18.0),
        ),
        onTap: () => print(band.name),
      ),
    );
  }

  _addNewBand() {
    final textcontroller = new TextEditingController();

    if (Platform.isAndroid) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('New Band Name'),
              content: TextField(
                controller: textcontroller,
              ),
              actions: [
                MaterialButton(
                  onPressed: () => _addBandToList(textcontroller.text),
                  elevation: 5,
                  textColor: Colors.blue[100],
                  child: Text('ADD'),
                ),
              ],
            );
          });
    }
  }

  void _addBandToList(String name) {
    if (name.length > 1) {
      this
          .bands
          .add(new Band(id: DateTime.now().toString(), name: name, votes: 0));
      setState(() {});
    }
    Navigator.pop(context);
  }
}
