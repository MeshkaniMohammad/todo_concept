import 'package:flutter/material.dart';
import 'package:todo_concept/models/card_item_model.dart';
import 'package:todo_concept/models/work.dart';
import 'package:intl/intl.dart';
import 'package:todo_concept/widgets/custom_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  var appColors = [
    Color.fromRGBO(231, 129, 109, 1.0),
    Color.fromRGBO(99, 138, 223, 1.0),
    Color.fromRGBO(111, 194, 173, 1.0)
  ];
  int cardIndex = 0;
  ScrollController scrollController;
  Color currentColor = Color.fromRGBO(231, 129, 109, 1.0);

  List<CardItemModel> cardsList = [
    CardItemModel("Personal", Icons.account_circle, 9, 0.83),
    CardItemModel("Work", Icons.work, 12, 0.24),
    CardItemModel("Home", Icons.home, 7, 0.32)
  ];

  AnimationController animationController;
  ColorTween colorTween;
  CurvedAnimation curvedAnimation;

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: currentColor,
      appBar: new AppBar(
        title: new Text(
          "TODO",
          style: TextStyle(fontSize: 16.0),
        ),
        backgroundColor: currentColor,
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.search),
          ),
        ],
        elevation: 0.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 64.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Icon(
                      Icons.account_circle,
                      size: 45.0,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 12.0),
                    child: Text(
                      "Hello, Jane.",
                      style: TextStyle(
                          fontSize: 30.0, color: Colors.white, fontWeight: FontWeight.w400),
                    ),
                  ),
                  Text(
                    "Looks like feel good.",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "You have ${cardsList[0].tasksRemaining + todayWorks.length + cardsList[2].tasksRemaining} tasks to do today.",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 64.0, vertical: 16.0),
                child: Text(
                  "TODAY : ${formatDate(DateTime.now())}".toUpperCase(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                height: 350.0,
                child: ListView.builder(
                  itemCount: 3,
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, position) {
                    return GestureDetector(
                      onVerticalDragEnd: (d) {
                        print(cardsList[1].cardTitle);
                        if (position == 1) {
                          CardItemModel cardItemModel = CardItemModel(
                              cardsList[1].cardTitle,
                              cardsList[1].icon,
                              cardsList[1].tasksRemaining,
                              cardsList[1].taskCompletion);
                          Navigator.pushNamed(context, '/workScreen', arguments: cardItemModel);
                        }
                      },
                      child: CustomCard(
                        position: position,
                        appColors: appColors,
                        cardsList: cardsList,
                      ),
                      onHorizontalDragEnd: (details) {
                        animationController =
                            AnimationController(vsync: this, duration: Duration(milliseconds: 500));
                        curvedAnimation = CurvedAnimation(
                            parent: animationController, curve: Curves.fastOutSlowIn);
                        animationController.addListener(() {
                          setState(() {
                            currentColor = colorTween.evaluate(curvedAnimation);
                          });
                        });

                        if (details.velocity.pixelsPerSecond.dx > 0) {
                          if (cardIndex > 0) {
                            cardIndex--;
                            colorTween = ColorTween(begin: currentColor, end: appColors[cardIndex]);
                          }
                        } else {
                          if (cardIndex < 2) {
                            cardIndex++;
                            colorTween = ColorTween(begin: currentColor, end: appColors[cardIndex]);
                          }
                        }
                        setState(() {
                          scrollController.animateTo((cardIndex) * 256.0,
                              duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
                        });

                        colorTween.animate(curvedAnimation);

                        animationController.forward();
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      drawer: Drawer(),
    );
  }
}

String formatDate(DateTime date) => new DateFormat("MMMM d, y").format(date);
