import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stream_builder/demo.dart';
import 'package:stream_builder/user.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new HomeState();
}

class HomeState extends State<Home> {
  static int page = 0;
  ScrollController _sc = new ScrollController();
  bool isLoading = false;

  // List users = new List();
  final dio = new Dio();

  StreamController<List<User>> listStreamController;

  @override
  void initState() {
    listStreamController = new StreamController();
    this._getMoreData(page);
    super.initState();
    // _sc.addListener(() {
    //   if (_sc.position.pixels == _sc.position.maxScrollExtent) {
    //     _getMoreData(page);
    //   }
    // });
  }

  @override
  void dispose() {
    _sc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("List"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              icon: Icon(Icons.more_vert),
            ),
          ],
        ),
        body: Center(
          child: StreamBuilder(
            stream: listStreamController.stream,
            builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Center(
                    child: Text('None'),
                  );
                  break;
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                  break;
                case ConnectionState.active:
                  if (snapshot.hasData) {
                    return Center(
                      child: _buildList(snapshot.data),
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else {
                    return Text('Error');
                  }
                  break;
                case ConnectionState.done:
                  print('Done is fucking here ${snapshot.data}');
                  if (snapshot.hasData) {
                    return Center(
                      child: _buildList(snapshot.data),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Has Error');
                  } else {
                    return Text('Error');
                  }
                  break;
              }
              return Text('Non in Switch');
            },
          ),
        ));
  }

  Widget _buildList(List<User> data) {
    return ListView.builder(
        itemCount: data?.length, // Add one more item for progress indicator
        padding: EdgeInsets.symmetric(vertical: 8.0),
        itemBuilder: (BuildContext context, int index) {
          return new ListTile(
            leading: CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(
                data[index].picture,
              ),
            ),
            title: Text(data[index].name),
            subtitle: Text((data[index].email)),
          );
        });
  }

  void _getMoreData(data) async {
    var url = "https://www.iroidsolutions.com/interview/test.json";
    print(url);
    try {
      await dio.get(url).then((response) {
        List<User> tList = new List();
        for (int i = 0; i < response.data.length; i++) {
          tList.add(User.fromJson(response.data[i]));
        }
        listStreamController.add(tList);
      }).catchError((onError) {
        print(onError);
        listStreamController.addError(onError);
      });
    } catch (e) {
      print(e);
      listStreamController.addError(e);
    }
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }
}
