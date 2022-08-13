import 'package:arena_access/screens/sports_display_screen.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        AppBar(
          title: Text('Find your arena now!!'),
          automaticallyImplyLeading: false,
        ),
        Divider(),
        ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(SportsDisplay.routeName);
            }),
        Divider(),
        ListTile(
            leading: Icon(Icons.sports_tennis),
            title: Text('Badminton'),
            onTap: () {}),
        ListTile(
            leading: Icon(Icons.sports_basketball),
            title: Text('Basketball'),
            onTap: () {}),
        ListTile(
            leading: Icon(Icons.table_restaurant),
            title: Text('Table Tennis'),
            onTap: () {}),
        ListTile(
            leading: Icon(Icons.sports_soccer),
            title: Text('Football'),
            onTap: () {}),
        ListTile(
            leading: Icon(Icons.sports_tennis),
            title: Text('Tennis'),
            onTap: () {}),
        Divider(),
        ListTile(
            leading: Icon(Icons.newspaper), title: Text('News'), onTap: () {}),
        Divider(),
        ListTile(
            leading: Icon(Icons.login), title: Text('Login'), onTap: () {}),
      ]),
    );
  }
}
