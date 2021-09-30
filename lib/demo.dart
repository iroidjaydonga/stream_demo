import 'dart:async';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamController<List<String>> listStreamController;
  StreamController<String> nameStreamController;
  StreamController<int> addStreamController;

  final List<String> arrNames = [];
  final List<String> fieldNames = [];
  TextEditingController nameController = TextEditingController();

  void addItemToList() {
    if (nameController.text.isNotEmpty) {
      arrNames.add(nameController.text.toString());
      listStreamController.add(arrNames);
      nameStreamController.add("");
      addStreamController.add(null);
    }
  }

  void editItemToList(int index) {
    if (nameController.text.isNotEmpty) {
      arrNames[index] = nameController.text.toString();
      listStreamController.add(arrNames);
      nameStreamController.add("");
      addStreamController.add(null);
    }
  }

  @override
  void initState() {
    listStreamController = new StreamController();
    nameStreamController = new StreamController();
    addStreamController = new StreamController();

    // WidgetsBinding.instance.addPostFrameCallback((_) => listStreamController.add(''));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Data'),
        ),
        body: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: StreamBuilder(
              stream: nameStreamController.stream,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                nameController.text = snapshot.data;
                return Center(
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Contact Name',
                    ),
                  ),
                );
              },
            ),
          ),
          StreamBuilder(
              stream: addStreamController.stream,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                return RaisedButton(
                  child: Text(snapshot.data == null ? "Add" : 'Save'),
                  onPressed: () {
                    if (snapshot.data != null)
                      editItemToList(snapshot.data);
                    else
                      addItemToList();
                  },
                );
              }),
          Expanded(
            child: StreamBuilder(
              stream: listStreamController.stream,
              builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                return _buildList(arrNames);
              },
            ),
          )
        ]));
  }

  Widget _buildList(List<String> name) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: name.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '${name[index]} ',
                    style: TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    onPressed: () {
                      print(index);
                      nameStreamController.add(arrNames[index]);
                      addStreamController.add(index);
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      print(index);
                      arrNames.removeAt(index);
                      listStreamController.add(arrNames);

                      // _updateTextControllers(name); // new function here
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
