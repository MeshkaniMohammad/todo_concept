import 'package:flutter/material.dart';
import 'package:todo_concept/screens/home_page.dart';
import 'package:provider/provider.dart';
import 'package:todo_concept/screens/work.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    return ChangeNotifierProvider<ThemeChanger>(
//      builder: (_) => ThemeChanger(ThemeData.light()),
//      child: new MaterialAppWithTheme(),
//    );
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
