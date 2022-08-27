import 'package:arena_access/screens/news_screen.dart';
import 'package:arena_access/screens/sports_display_screen.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class AppDrawer extends StatefulWidget {
  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  var showBdm = false;
  var showTT = false;

  List<String> bdm_arena = ['Court 1', 'Court 2', 'Court 3', 'MPH Court'];
  List<String> bdm_routes = ['bd1', 'bd2', 'bd3', 'bdm'];
  List<String> tt_arena = ['Table 1', 'Table 2', 'MPH Table'];
  List<String> tt_routes = ['tt1', 'tt2', 'ttm'];

  List<Widget> bdm_widgets = [];
  List<Widget> tt_widgets = [];
  @override
  void initState() {
    for (int i = 0; i < 4; i++) {
      bdm_widgets.add(ListTile(
        title: Text(bdm_arena[i]),
        onTap: () {
          Navigator.of(context).pushReplacementNamed(bdm_routes[i]);
        },
      ));
    }

    for (int i = 0; i < 3; i++) {
      tt_widgets.add(ListTile(
        title: Text(tt_arena[i]),
        onTap: () {
          Navigator.of(context).pushReplacementNamed(tt_routes[i]);
        },
      ));
    }
    super.initState();
  }

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
          onTap: () {
            setState(() {
              showBdm = !showBdm;
            });
          },
          trailing: Icon(showBdm ? Icons.expand_less : Icons.expand_more),
        ),
        if (showBdm)
          Column(
            children: [...bdm_widgets],
          ),
        ListTile(
            leading: Icon(Icons.sports_basketball),
            title: Text('Basketball'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('bas');
            }),
        ListTile(
          leading: Icon(Icons.table_restaurant),
          title: Text('Table Tennis'),
          onTap: () {
            setState(() {
              showTT = !showTT;
            });
          },
          trailing: Icon(showBdm ? Icons.expand_less : Icons.expand_more),
        ),
        if (showTT)
          Column(
            children: [...tt_widgets],
          ),
        ListTile(
            leading: Icon(Icons.sports_soccer),
            title: Text('Football'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('foo');
            }),
        ListTile(
            leading: Icon(Icons.sports_tennis),
            title: Text('Tennis'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('ten');
            }),
        Divider(),
        ListTile(
            leading: Icon(Icons.newspaper),
            title: Text('News'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(NewsScreen.routeName);
            }),
        Divider(),
        ListTile(
          tileColor: Theme.of(context).primaryColor,
          title: Text('Meet the dev'),
          subtitle: Text('Subhajeet Lahiri'),
          trailing: Image.asset(
            'assets/images/gitIcon.png',
            width: 30,
          ),
          onTap: () async{ 
            final  url = Uri.parse('https://github.com/Heliospook');
            await launchUrl(url);
          },
        )
        // Divider(),
        // ListTile(
        //     leading: Icon(Icons.login), title: Text('Login'), onTap: () {}),
      ]),
    );
  }
}
