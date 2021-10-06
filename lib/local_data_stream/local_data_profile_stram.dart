// import 'dart:io';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// class ProfilePage1 extends StatefulWidget {
//   final String name;
//   final String age;
//   final String gender;
//
//   const ProfilePage1({
//     this.name,
//     this.age,
//     this.gender,
//   });
//
//   @override
//   _ProfilePage1State createState() => _ProfilePage1State();
// }
//
// class _ProfilePage1State extends State<ProfilePage1> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController ageController = TextEditingController();
//   TextEditingController genderController = TextEditingController();
//   int val = 0;
//   bool _status = true;
//   final FocusNode myFocusNode = FocusNode();
//   File _image;
//
//   _imgFromCamera() async {
//     File image = await ImagePicker.pickImage(source: ImageSource.camera, imageQuality: 50);
//
//     setState(() {
//       _image = image;
//     });
//   }
//
//   _imgFromGallery() async {
//     File image = await ImagePicker.pickImage(source: ImageSource.gallery, imageQuality: 50);
//
//     setState(() {
//       _image = image;
//     });
//   }
//
//   @override
//   void initState() {
//     nameController.text = widget.name;
//     ageController.text = widget.age;
//     genderController.text = widget.gender;
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: Container(
//           height: MediaQuery.of(context).size.height,
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Edit Profile',
//                         style: TextStyle(
//                           fontSize: 23,
//                         ),
//                       ),
//                       _status
//                           ? InkWell(
//                               onTap: () {
//                                 Navigator.pop(context);
//                               },
//                               child: Text(
//                                 'Save',
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                 ),
//                               ),
//                             )
//                           : Text(
//                               'Save',
//                               style: TextStyle(color: Colors.black45, fontSize: 20),
//                             )
//                     ],
//                   ),
//                   SizedBox(height: 25),
//                   Column(
//                     children: <Widget>[
//                       SizedBox(
//                         height: 32,
//                       ),
//                       Center(
//                         child: GestureDetector(
//                           onTap: () {
//                             _showPicker(context);
//                           },
//                           child: CircleAvatar(
//                             radius: 55,
//                             backgroundColor: Color(0xffFDCF09),
//                             child: _image != null
//                                 ? ClipRRect(
//                                     borderRadius: BorderRadius.circular(50),
//                                     child: Image.file(
//                                       _image,
//                                       width: 100,
//                                       height: 100,
//                                       fit: BoxFit.fitHeight,
//                                     ),
//                                   )
//                                 : Container(
//                                     decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(50)),
//                                     width: 100,
//                                     height: 100,
//                                     child: Icon(
//                                       Icons.camera_alt,
//                                       color: Colors.grey[800],
//                                     ),
//                                   ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 20),
//                   Stack(children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           'PROFILE PHOTO',
//                           style: TextStyle(fontSize: 18),
//                         ),
//                       ],
//                     ),
//                     new Column(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       mainAxisSize: MainAxisSize.min,
//                       children: <Widget>[
//                         _status ? _getEditIcon() : new Container(),
//                       ],
//                     ),
//                   ]),
//                   SizedBox(height: 20),
//                   Padding(
//                       padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
//                       child: new Row(
//                         mainAxisSize: MainAxisSize.max,
//                         children: <Widget>[
//                           new Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             mainAxisSize: MainAxisSize.min,
//                             children: <Widget>[
//                               new Text(
//                                 'Name',
//                                 style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                         ],
//                       )),
//                   Padding(
//                       padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
//                       child: new Row(
//                         mainAxisSize: MainAxisSize.max,
//                         children: <Widget>[
//                           new Flexible(
//                             child: new TextField(
//                               controller: nameController,
//                               decoration: const InputDecoration(
//                                 hintText: "Enter Name",
//                               ),
//                               enabled: !_status,
//                             ),
//                           ),
//                         ],
//                       )),
//                   Padding(
//                       padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
//                       child: new Row(
//                         mainAxisSize: MainAxisSize.max,
//                         children: <Widget>[
//                           new Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             mainAxisSize: MainAxisSize.min,
//                             children: <Widget>[
//                               new Text(
//                                 'Age',
//                                 style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                         ],
//                       )),
//                   Padding(
//                       padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
//                       child: new Row(
//                         mainAxisSize: MainAxisSize.max,
//                         children: <Widget>[
//                           new Flexible(
//                             child: new TextField(
//                               controller: ageController,
//                               decoration: const InputDecoration(
//                                 hintText: "Enter Name",
//                               ),
//                               enabled: !_status,
//                             ),
//                           ),
//                         ],
//                       )),
//                   Padding(
//                       padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
//                       child: new Row(
//                         mainAxisSize: MainAxisSize.max,
//                         children: <Widget>[
//                           new Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             mainAxisSize: MainAxisSize.min,
//                             children: <Widget>[
//                               new Text(
//                                 'Gender',
//                                 style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                         ],
//                       )),
//                   Padding(
//                     padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
//                     child: new Row(
//                       mainAxisSize: MainAxisSize.max,
//                       children: <Widget>[
//                         Text(widget.gender),
//                       ],
//                     ),
//                   ),
//                   !_status ? _getActionButtons() : new Container(),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     // Clean up the controller when the Widget is disposed
//     myFocusNode.dispose();
//     super.dispose();
//   }
//
//   Widget _getActionButtons() {
//     return Padding(
//       padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
//       child: new Row(
//         mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: <Widget>[
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.only(right: 10.0),
//               child: Container(
//                   child: new RaisedButton(
//                 child: new Text("Save"),
//                 textColor: Colors.white,
//                 color: Colors.green,
//                 onPressed: () {
//                   setState(() {
//                     _status = true;
//                     FocusScope.of(context).requestFocus(new FocusNode());
//                   });
//                 },
//                 shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
//               )),
//             ),
//             flex: 2,
//           ),
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.only(left: 10.0),
//               child: Container(
//                   child: new RaisedButton(
//                 child: new Text("Cancel"),
//                 textColor: Colors.white,
//                 color: Colors.red,
//                 onPressed: () {
//                   setState(() {
//                     _status = true;
//                     FocusScope.of(context).requestFocus(new FocusNode());
//                   });
//                 },
//                 shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
//               )),
//             ),
//             flex: 2,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _getEditIcon() {
//     return new GestureDetector(
//       child: new CircleAvatar(
//         backgroundColor: Colors.red,
//         radius: 14.0,
//         child: new Icon(
//           Icons.edit,
//           color: Colors.white,
//           size: 16.0,
//         ),
//       ),
//       onTap: () {
//         setState(() {
//           _status = false;
//         });
//       },
//     );
//   }
//
//   void _showPicker(context) {
//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext bc) {
//           return SafeArea(
//             child: Container(
//               child: new Wrap(
//                 children: <Widget>[
//                   new ListTile(
//                       leading: new Icon(Icons.photo_library),
//                       title: new Text('Photo Library'),
//                       onTap: () {
//                         _imgFromGallery();
//                         Navigator.of(context).pop();
//                       }),
//                   new ListTile(
//                     leading: new Icon(Icons.photo_camera),
//                     title: new Text('Camera'),
//                     onTap: () {
//                       _imgFromCamera();
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stream_builder/local_data_stream/data_helper.dart';
import 'package:stream_builder/local_data_stream/local_data_class.dart';

class TodoDetail extends StatefulWidget {
  final String appBarTitle;
  final Todo todo;

  TodoDetail(this.todo, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return TodoDetailState(this.todo, this.appBarTitle);
  }
}

class TodoDetailState extends State<TodoDetail> {
  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  Todo todo;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  TodoDetailState(this.todo, this.appBarTitle);

  StreamController<int> todoStreamController;
  StreamController<String> titleStreamController;
  StreamController<String> descriptionStreamController;

  @override
  void initState() {
    todoStreamController = new StreamController();
    titleStreamController = new StreamController();
    descriptionStreamController = new StreamController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.subtitle1;

    titleController.text = todo.title;
    descriptionController.text = todo.description;

    return WillPopScope(
      onWillPop: () async {
        moveToLastScreen();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                moveToLastScreen();
              }),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: StreamBuilder(
                    stream: titleStreamController.stream,
                    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                      return TextField(
                        controller: titleController,
                        style: textStyle,
                        onChanged: (value) {
                          debugPrint('Something changed in Title Text Field');
                          updateTitle();
                        },
                        decoration: InputDecoration(labelText: 'Title', labelStyle: textStyle, border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                      );
                    }),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: StreamBuilder(
                    stream: descriptionStreamController.stream,
                    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                      return TextField(
                        controller: descriptionController,
                        style: textStyle,
                        onChanged: (value) {
                          debugPrint('Something changed in Description Text Field');
                          updateDescription();
                        },
                        decoration: InputDecoration(labelText: 'Description', labelStyle: textStyle, border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                      );
                    }),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: StreamBuilder(
                          stream: todoStreamController.stream,
                          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                            return RaisedButton(
                              color: Theme.of(context).primaryColorDark,
                              textColor: Theme.of(context).primaryColorLight,
                              child: Text(
                                'Save',
                                textScaleFactor: 1.5,
                              ),
                              onPressed: () {
                                setState(
                                  () {
                                    debugPrint("Save button clicked");
                                    _save();
                                  },
                                );
                              },
                            );
                          }),
                    ),
                    Container(
                      width: 5.0,
                    ),
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Delete',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            debugPrint("Delete button clicked");
                            _delete();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void updateTitle() {
    todo.title = titleController.text;
  }

  void updateDescription() {
    todo.description = descriptionController.text;
  }

  void _save() async {
    todo.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (todo.id != null) {
      result = await helper.updateTodo(todo);
      moveToLastScreen();
    } else {
      result = await helper.insertTodo(todo);
      moveToLastScreen();
    }
  }

  void _delete() async {
    moveToLastScreen();

    int result = await helper.deleteTodo(todo.id);
  }
}
