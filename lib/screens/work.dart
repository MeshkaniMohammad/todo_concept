import 'package:flutter/material.dart';
import 'package:todo_concept/models/card_item_model.dart';
import 'package:todo_concept/models/work.dart';
import 'package:todo_concept/screens/add_task.dart';
import 'package:todo_concept/widgets/custom_appbar.dart';

class WorkScreen extends StatefulWidget {
  final CardItemModel cardItemModel;

  const WorkScreen({Key key, this.cardItemModel}) : super(key: key);

  @override
  _WorkScreenState createState() => _WorkScreenState();
}

class _WorkScreenState extends State<WorkScreen> {
  CardItemModel _cardItemModel;
  final GlobalKey<AnimatedListState> _todayListKey = GlobalKey();
  final GlobalKey<AnimatedListState> _tomorrowListKey = GlobalKey();
  bool showDeleteIcon = false;

  void addWork() {
    int index = 0;

    _todayListKey.currentState.insertItem(index, duration: Duration(milliseconds: 500));
  }

  void deleteWork(int index) {
    var today = todayWorks.removeAt(index);
    _todayListKey.currentState.removeItem(
      index,
      (BuildContext context, Animation<double> animation) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Interval(0.0, 1.0)),
          child: SizeTransition(
            sizeFactor: CurvedAnimation(parent: animation, curve: Interval(0.0, 1.0)),
            axisAlignment: 0.0,
            child: _buildItemForRemove(today),
          ),
        );
      },
      duration: Duration(milliseconds: 1000),
    );
  }

  Widget _buildItem(Work todayWork, [int index]) {
    return Row(
      children: <Widget>[
        Checkbox(
            value: false,
            onChanged: (val) {
              if (val) {
                setState(() {
                  showDeleteIcon = true;
                });
                deleteWork(index);
              }
            }),
        Text(todayWork.work),
      ],
    );
  }

  Widget _buildItemForRemove(Work todayWork, [int index]) {
    return Row(
      children: <Widget>[
        Checkbox(
            value: false,
            onChanged: (val) {
              if (val) {
                setState(() {
                  showDeleteIcon = true;
                });
                deleteWork(index);
              }
            }),
        Stack(
          children: <Widget>[
            Text(
              todayWork.work,
            ),
            if (showDeleteIcon)
              Container(
                margin: EdgeInsets.only(top: 7),
                height: 2,
                width: 100,
                color: Colors.grey,
              )
          ],
        ),
        Spacer(),
        if (showDeleteIcon) Icon(Icons.delete)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    RouteSettings settings = ModalRoute.of(context).settings;
    _cardItemModel = settings.arguments;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: WorkAppBar(),
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
                    this._cardItemModel.icon == null ? Icons.work : this._cardItemModel.icon,
                    color: Color.fromRGBO(99, 138, 223, 1.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: Text(
                    "${todayWorks.length} Tasks",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    this._cardItemModel.cardTitle == null
                        ? "Work"
                        : "${this._cardItemModel.cardTitle}",
                    style: TextStyle(fontSize: 28.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  //currently only supports 10 tasks
                  child: LinearProgressIndicator(
                    value: todayWorks.length / 10.0,
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
                  child: _buildItem(todayWorks[index], index),
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
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AddTask(),
          ),
        ),
        child: Icon(Icons.add),
        backgroundColor: Colors.lightBlue,
        heroTag: "add note",
      ),
    );
  }
}
