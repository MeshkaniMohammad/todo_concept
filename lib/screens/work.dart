import 'package:flutter/material.dart';
import 'package:todo_concept/models/work.dart';
import 'package:todo_concept/screens/add_task.dart';
import 'package:todo_concept/screens/home_page.dart';

class WorkScreen extends StatefulWidget {
  final IconData icon;
  final int tasksRemaining;
  final double taskCompletion;
  final Color color;
  final String cardTitle;

  const WorkScreen(
      {Key key, this.cardTitle, this.icon, this.tasksRemaining, this.taskCompletion, this.color})
      : super(key: key);

  @override
  _WorkScreenState createState() => _WorkScreenState();
}

class _WorkScreenState extends State<WorkScreen> {
  final GlobalKey<AnimatedListState> _todayListKey = GlobalKey();
  final GlobalKey<AnimatedListState> _tomorrowListKey = GlobalKey();
  List<Work> todayWorks = [
    Work("Meet Clients"),
    Work("Desing Sprint"),
    Work("Icon Set Design for Mobile App"),
    Work("HTML/CSS Study"),
  ];

  List<Work> tomorrowWorks = [
    Work("Weekly Report"),
    Work("Desing Meeting"),
    Work("Quick Prototyping"),
    Work("UX Confrance"),
    Work("Learn JavaScript"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 10),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.grey,
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => HomePage(),
                ),
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(top: 15, right: 20),
            child: Image.asset(
              'assets/menu.png',
              width: 15,
              height: 30,
              color: Colors.grey,
            ),
          )
        ],
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: Icon(
                    widget.icon == null ? Icons.work : widget.icon,
                    color: widget.color == null ? Color.fromRGBO(99, 138, 223, 1.0) : widget.color,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: Text(
                    widget.tasksRemaining == null ? "12 Tasks" : "${widget.tasksRemaining} Tasks",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    widget.cardTitle == null ? "Work" : "${widget.cardTitle}",
                    style: TextStyle(fontSize: 28.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  child: LinearProgressIndicator(
                    value: widget.taskCompletion == null ? 0.6 : widget.taskCompletion,
                    backgroundColor: Colors.grey.shade200,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: Text(
                "Today",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            AnimatedList(
              shrinkWrap: true,
              key: _todayListKey,
              initialItemCount: todayWorks.length,
              itemBuilder: (BuildContext context, int index, Animation animation) {
                return FadeTransition(
                  opacity: animation,
                  child: Row(
                    children: <Widget>[
                      Checkbox(value: false, onChanged: (val) {}),
                      Text(todayWorks[index].work),
                    ],
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: Text(
                "Tomorrow",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            AnimatedList(
              shrinkWrap: true,
              key: _tomorrowListKey,
              initialItemCount: tomorrowWorks.length,
              itemBuilder: (BuildContext context, int index, Animation animation) {
                return FadeTransition(
                  opacity: animation,
                  child: Row(
                    children: <Widget>[
                      Checkbox(value: false, onChanged: (val) {}),
                      Text(tomorrowWorks[index].work),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AddTask())),
        child: Icon(Icons.add),
        backgroundColor: Colors.lightBlue,
        heroTag: "add note",
      ),
    );
  }
}
