import 'package:flutter/material.dart';
import 'package:todo_concept/screens/home_page.dart';
import 'package:todo_concept/screens/work.dart';
import 'package:todo_concept/utils/route_builder.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return SlideDownRoute(widget: HomePage());
            break;
        }
      },
      routes: <String, WidgetBuilder>{
        '/workScreen': (context) => WorkScreen(),
      },
      home: HomePage(),
    );
  }
}
