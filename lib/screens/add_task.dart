import 'package:flutter/material.dart';
import 'package:todo_concept/models/card_item_model.dart';
import 'package:todo_concept/models/work.dart';
import 'package:todo_concept/screens/work.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  List<CardItemModel> cardsList = [
    CardItemModel("Personal", Icons.account_circle, 9, 0.83),
    CardItemModel("Work", Icons.work, 12, 0.24),
    CardItemModel("Home", Icons.home, 7, 0.32)
  ];
  TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

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
      bottomNavigationBar: Hero(
        tag: "add note",
        child: GestureDetector(
          onTap: () {
            CardItemModel cardItemModel = CardItemModel(cardsList[1].cardTitle, cardsList[1].icon,
                cardsList[1].tasksRemaining, cardsList[1].taskCompletion);
            Navigator.pushNamed(context, '/workScreen', arguments: cardItemModel);
          },
          child: Container(
            height: 65,
            color: Colors.lightBlue,
            child: Center(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
