import 'package:flutter/material.dart';
import 'package:todo_concept/models/card_item_model.dart';
import 'package:todo_concept/models/work.dart';

class CustomCard extends StatelessWidget {
  final int position;
  final List<CardItemModel> cardsList;
  final List<Color> appColors;

  const CustomCard({Key key, this.position, this.cardsList, this.appColors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Container(
          width: 250.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(
                      cardsList[position].icon,
                      color: appColors[position],
                    ),
                    Icon(
                      Icons.more_vert,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      child: Text(
                        position == 1
                            ? "${todayWorks.length} Tasks"
                            : "${cardsList[position].tasksRemaining} Tasks",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      child: Text(
                        "${cardsList[position].cardTitle}",
                        style: TextStyle(fontSize: 28.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LinearProgressIndicator(
                        value: cardsList[position].taskCompletion,
                        backgroundColor: Colors.grey.shade200,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
    );
  }
}
