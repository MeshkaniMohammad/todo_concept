import 'package:flutter/material.dart';
import 'package:todo_concept/models/card_item_model.dart';
import 'package:todo_concept/screens/work.dart';
import 'package:slide_container/slide_container.dart';
import 'package:slide_container/slide_container_controller.dart';
import 'package:slide_container/extended_drag_gesture_recognizer.dart';

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
                    "You have 3 tasks to do today.",
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
                  "TODAY : SEPTAMBER 12, 2018",
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
                        "${cardsList[position].tasksRemaining} Tasks",
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

class SlideDownRoute extends PageRouteBuilder {
  final Widget widget;

  SlideDownRoute({this.widget})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionsBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation, Widget child) {
            var begin = Offset(0.0, 1.0);
            var end = Offset.zero;
            var curve = Curves.ease;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
}
