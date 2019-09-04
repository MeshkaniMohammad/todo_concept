import 'package:flutter/material.dart';
import 'package:todo_concept/screens/work.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController _textEditingController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
            color: Colors.black54,
          ),
          centerTitle: true,
          title: Text(
            "New Task",
            style: TextStyle(color: Colors.black54),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Text(
                "What tasks are you planing to perform?",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _textEditingController,
                style: TextStyle(fontSize: 25, color: Colors.black54),
                cursorColor: Colors.grey,
                autofocus: true,
                decoration: InputDecoration.collapsed(hintText: ""),
              ),
              SizedBox(
                height: 40,
              ),
              ListTile(
                leading: Icon(Icons.work),
                title: Text(
                  "Work",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              ListTile(
                leading: Icon(Icons.calendar_today),
                title: Text(
                  "Today",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton.extended(
          shape: RoundedRectangleBorder(),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => WorkScreen())),
          label: Container(
            width: 350,
            child: Icon(Icons.add),
          ),
          backgroundColor: Colors.lightBlue,
          heroTag: "add note",
        ));
  }
}
