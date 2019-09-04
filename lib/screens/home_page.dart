import 'package:flutter/material.dart';
import 'package:todo_concept/models/card_item_model.dart';
import 'package:todo_concept/screens/work.dart';

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
                      onTap: () {
                        print(cardsList[1].cardTitle);
                        if (position == 1)
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => WorkScreen(
                                        cardTitle: cardsList[1].cardTitle,
                                        icon: cardsList[1].icon,
                                        taskCompletion: cardsList[1].taskCompletion,
                                        tasksRemaining: cardsList[1].tasksRemaining,
                                        color: appColors[1],
                                      )));
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

//class HomePage extends StatefulWidget {
//  @override
//  _HomePageState createState() => _HomePageState();
//}
//
//class _HomePageState extends State<HomePage> {
//
//
//  @override
//  Widget build(BuildContext context) {
//    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
//    return Scaffold(
//      body: Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
//        children: <Widget>[
//          Padding(
//            padding: const EdgeInsets.symmetric(vertical: 30),
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              children: <Widget>[
//                IconButton(
//                    icon: Icon(
//                      Icons.dehaze,
//                      color: Colors.white,
//                    ),
//                    onPressed: null),
//                Text(
//                  "TODO",
//                  style: TextStyle(
//                    fontWeight: FontWeight.bold,
//                    fontSize: 22,
//                    color: Colors.white,
//                  ),
//                ),
//                IconButton(
//                    icon: Icon(
//                      Icons.search,
//                      color: Colors.white,
//                    ),
//                    onPressed: null),
//              ],
//            ),
//          ),
//          Padding(
//            padding: const EdgeInsets.only(left: 40),
//            child: CircleAvatar(
//              child: Image.asset('assets/user.png'),
//              backgroundColor: Colors.white,
//            ),
//          ),
//          Padding(
//            padding: const EdgeInsets.only(left: 40, top: 30),
//            child: Text(
//              "Hello, Jane",
//              style: TextStyle(
//                fontSize: 22,
//                color: Colors.white,
//              ),
//            ),
//          ),
//          Padding(
//            padding: const EdgeInsets.only(left: 40, top: 10),
//            child: Text(
//              "Looks like feel good.",
//              style: TextStyle(
//                color: Colors.white70,
//              ),
//            ),
//          ),
//          Padding(
//            padding: const EdgeInsets.only(left: 40),
//            child: Text(
//              "You have 3 tasks to do today.",
//              style: TextStyle(
//                color: Colors.white70,
//              ),
//            ),
//          ),
//          Padding(
//            padding: const EdgeInsets.only(left: 40, top: 40, bottom: 10),
//            child: Text(
//              "TODAY : SEPTAMBER 12, 2017",
//              style: TextStyle(
//                color: Colors.white,
//              ),
//            ),
//          ),
//          Container(
//            height: 320,
//            child: Swiper(
//              onTap: (int index) => Navigator.push(context, MaterialPageRoute(builder: (_) => WorkScreen())),
//              itemCount: 3,
//              viewportFraction: 0.85,
//              onIndexChanged: (int index) {
//                print("index is: $index");
//                switch (index) {
//                  case 0:
//                    _themeChanger
//                        .setTheme(ThemeData(scaffoldBackgroundColor: Colors.lightGreenAccent));
//                    break;
//                  case 1:
//                    _themeChanger.setTheme(ThemeData(scaffoldBackgroundColor: Colors.orangeAccent));
//
//                    break;
//                  case 2:
//                    _themeChanger.setTheme(ThemeData(scaffoldBackgroundColor: Colors.lightBlue));
//
//                    break;
//                  default:
//                    _themeChanger
//                        .setTheme(ThemeData(scaffoldBackgroundColor: Colors.deepPurpleAccent));
//                }
//              },
//              itemBuilder: (BuildContext context, int index) {
//                return MainCard();
//              },
//            ),
//          )
//        ],
//      ),
//    );
//  }
//}
//
//class MainCard extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Card(
//      shape: RoundedRectangleBorder(
//        borderRadius: BorderRadius.all(
//          Radius.circular(10),
//        ),
//      ),
//      elevation: 4,
//      margin: EdgeInsets.symmetric(horizontal: 10),
//      child: Column(
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//        children: <Widget>[
//          Row(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            children: <Widget>[
//              Padding(
//                padding: const EdgeInsets.only(left: 8, top: 13),
//                child: CircleAvatar(
//                  child: Image.asset(
//                    'assets/work.png',
//                    color: Colors.lightBlueAccent,
//                    height: 20,
//                    width: 30,
//                  ),
//                  backgroundColor: Colors.white,
//                ),
//              ),
//              Padding(
//                padding: const EdgeInsets.only(top: 13, right: 8),
//                child: Image.asset(
//                  'assets/menu.png',
//                  width: 15,
//                  height: 30,
//                  color: Colors.grey,
//                ),
//              ),
//            ],
//          ),
//          Padding(
//            padding: const EdgeInsets.only(left: 8, right: 5, bottom: 10),
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                Padding(
//                  padding: const EdgeInsets.only(bottom: 5),
//                  child: Text("12 Tasks", style: TextStyle(color: Colors.grey)),
//                ),
//                Text(
//                  "Work",
//                  style:
//                      TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black54),
//                ),
//                SizedBox(
//                  height: 10,
//                ),
//                LinearProgressIndicator(
//                  value: 0.4,
//                  backgroundColor: Colors.white,
//                )
//              ],
//            ),
//          )
//        ],
//      ),
//    );
//  }
//}
