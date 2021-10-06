// import 'dart:async';
//
// import 'package:flutter/material.dart';
//
// class LocalDataAdd extends StatefulWidget {
//   @override
//   _LocalDataAddState createState() => _LocalDataAddState();
// }
//
// class _LocalDataAddState extends State<LocalDataAdd> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController ageController = TextEditingController();
//   GlobalKey<FormState> _form = GlobalKey<FormState>();
//   int val = 0;
//   String text = "";
//
//   StreamController<int> addStreamController;
//
//   void addItemToList() {
//     if (nameController.text.isNotEmpty) {
//       addStreamController.add(null);
//     }
//   }
//
//   @override
//   void initState() {
//     addStreamController = new StreamController();
//
//     // WidgetsBinding.instance.addPostFrameCallback((_) => listStreamController.add(''));
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           color: Colors.white,
//           height: MediaQuery.of(context).size.height,
//           child: Stack(
//             children: [
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Form(
//                     key: _form,
//                     child: Container(
//                       padding: EdgeInsets.all(20),
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
//                       ),
//                       child: Column(
//                         children: [
//                           TextFormField(
//                             controller: nameController,
//                             decoration: InputDecoration(
//                               hintText: 'Name',
//                               hintStyle: TextStyle(color: Colors.black38, fontWeight: FontWeight.w600, fontSize: 17),
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.all(Radius.circular(5)),
//                                 borderSide: BorderSide(
//                                   color: Colors.black38,
//                                   width: 1.5,
//                                 ),
//                               ),
//                               border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
//                             ),
//                             validator: (_name) {
//                               bool _emailValid = RegExp(r"^[a-zA-Z]+").hasMatch(_name);
//                               if (_name.isEmpty) return 'please enter your Name';
//                               if (!_emailValid) return 'please enter your valide Name';
//                               return null;
//                             },
//                             style: TextStyle(color: Colors.black),
//                           ),
//                           SizedBox(
//                             height: 20,
//                           ),
//                           TextFormField(
//                             controller: ageController,
//                             keyboardType: TextInputType.number,
//                             decoration: InputDecoration(
//                               hintText: 'Age',
//                               hintStyle: TextStyle(color: Colors.black38, fontWeight: FontWeight.w600, fontSize: 17),
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.all(Radius.circular(5)),
//                                 borderSide: BorderSide(
//                                   color: Colors.black38,
//                                   width: 1.5,
//                                 ),
//                               ),
//                               border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
//                             ),
//                             validator: (_age) {
//                               bool _passwordValid = RegExp(r"^[0-9]+$").hasMatch(_age);
//                               if (_age.isEmpty) return 'please enter your password';
//                               return null;
//                             },
//                             style: TextStyle(color: Colors.black),
//                           ),
//                           Column(
//                             children: <Widget>[
//                               ListTile(
//                                 title: Text("Male"),
//                                 leading: Radio(
//                                   value: 0,
//                                   groupValue: val,
//                                   onChanged: (value) {
//                                     setState(() {
//                                       print(val);
//                                       val = value;
//                                     });
//                                   },
//                                   activeColor: Colors.blue,
//                                 ),
//                               ),
//                               ListTile(
//                                 title: Text("Female"),
//                                 leading: Radio(
//                                   value: 1,
//                                   groupValue: val,
//                                   onChanged: (value) {
//                                     setState(() {
//                                       print(val);
//                                       val = value;
//                                     });
//                                   },
//                                   activeColor: Colors.blue,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 20,
//                           ),
//                           SizedBox(
//                             width: double.infinity,
//                             child: StreamBuilder(
//                                 // stream: addStreamController.stream,
//                                 builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
//                               // return ElevatedButton(
//                               //   onPressed: () async {
//                               //     await Navigator.push(
//                               //       context,
//                               //       MaterialPageRoute(
//                               //         builder: (context) => LocalDataProfileStream(
//                               //           name: nameController.text,
//                               //           age: ageController.text,
//                               //           gender: val == 0 ? 'male' : 'female',
//                               //         ),
//                               //       ),
//                               //     ).then((value) => nameController);
//                               //   },
//                               //   child: Text("Add Data"),
//                               // );
//                             }),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stream_builder/local_data_stream/data_helper.dart';
import 'package:stream_builder/local_data_stream/local_data_class.dart';
import 'package:stream_builder/local_data_stream/local_data_profile_stram.dart';

class TodoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TodoListState();
  }
}

class TodoListState extends State<TodoList> {
  StreamController<List<Todo>> listStreamController;

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Todo> todoList = [];
  int count = 0;

  void editItemToList(int index) {
    listStreamController.add(todoList);
  }

  @override
  void initState() {
    fetchList();
    // todoList = databaseHelper.getTodoMapList();
    listStreamController = new StreamController();
    if (listStreamController != null) {
      listStreamController.add(todoList);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (todoList == null) {
      todoList = List<Todo>();
      // updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('List'),
      ),
      body: StreamBuilder(
          stream: listStreamController.stream,
          builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
            todoList = snapshot.data;
            print(snapshot.data);
            if (todoList != null) {
              count = todoList.length;
            }
            return getTodoListView();
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('FAB clicked');
          navigateToDetail(Todo('', '', ''), 'Add Todo');
        },
        tooltip: 'Add Todo',
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getTodoListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.amber,
              child: Text(getFirstLetter(this.todoList[position].title), style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            title: Text(this.todoList[position].title, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(this.todoList[position].description),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onTap: () {
                    _delete(context, todoList[position]);
                  },
                ),
              ],
            ),
            onTap: () {
              debugPrint("ListTile Tapped");
              navigateToDetail(this.todoList[position], 'Edit Todo');
            },
          ),
        );
      },
    );
  }

  getFirstLetter(String title) {
    if (title != null && title != '') {
      return title.substring(0, 2);
    } else {
      return '';
    }
  }

  void _delete(BuildContext context, Todo todo) async {
    int result = await databaseHelper.deleteTodo(todo.id);
    if (result != 0) {
      _showSnackBar(context, 'Todo Deleted Successfully');
      // updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateToDetail(Todo todo, String title) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return TodoDetail(todo, title);
    }));
  }

  Future<void> fetchList() async {
    List<Map<String, dynamic>> temp = await databaseHelper.getTodoMapList();
    print(temp);
    if (temp != null) {
      temp.forEach((element) {
        Todo todo = Todo.fromMapObject(element);
        todoList.add(todo);
      });
    }
  }
}

// void updateListView() {
//   final Future<Database> dbFuture = databaseHelper.initializeDatabase();
//   dbFuture.then((database) {
//     Future<List<TodotodoListFuture = databaseHelper.getTodoList();
//     // todoListFuture.then((todoList) {
//     //   setState(() {
//     //     this.todoList = todoList;
//     //     print("=========${todoList.length}");
//     //     this.count = todoList.length;
//     //   });
//     // });
//   });
// }
