import 'package:flutter/material.dart';

class WorkAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragEnd: (d) {
        Navigator.pushNamed(context, '/');
      },
      child: AppBar(
        backgroundColor: Colors.white,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 10),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.grey,
              ),
              onPressed: () => Navigator.pushNamed(context, '/'),
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
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}
