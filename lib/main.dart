import 'package:flutter/material.dart';
import 'package:todo_concept/screens/home_page.dart';
import 'package:provider/provider.dart';

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
      home: HomePage(),
    );
  }
}

//class MaterialAppWithTheme extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    final theme = Provider.of<ThemeChanger>(context);
//
//    return MaterialApp(
//      home: HomePage(),
//      theme: theme.getTheme(),
//    );
//  }
//}
