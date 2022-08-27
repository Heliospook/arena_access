import 'package:arena_access/screens/login_screen.dart';
import 'package:arena_access/screens/news_screen.dart';
import 'package:arena_access/screens/user_screen.dart';
import 'package:arena_access/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/first_page.dart';
import '../widgets/second_page.dart';
import '../widgets/third_page.dart';
import '../widgets/fourth_page.dart';

import '../providers/arena_collection.dart';
import '../providers/auth.dart';

class SportsDisplay extends StatefulWidget {
  static const routeName = '/sports_display';
  @override
  State<SportsDisplay> createState() => _SportsDisplayState();
}

class _SportsDisplayState extends State<SportsDisplay> {
  @override
  void initState() {
    Provider.of<ArenaCollection>(context, listen: false).fetchAndSetData();
    super.initState();
  }

  void handle_logout() {
    showDialog(
        context: context,
        builder: (bctx) {
          return AlertDialog(
            title: const Text('Confirm Logout'),
            content: const Text('Are you sure you wish to logout?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Provider.of<Auth>(context, listen: false).logout();
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    bool isAuth = Provider.of<Auth>(context).isAuth;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Arena Access'),
            const SizedBox(
              width: 10,
            ),
            Image.asset(
              'assets/images/multi_sport_logo.png',
              height: 40,
              width: 40,
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (isAuth) {
                handle_logout();
              } else {
                Navigator.of(context).pushNamed(LoginScreen.routeName);
              }
            },
            icon: Icon(
              isAuth ? Icons.logout : Icons.login,
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Provider.of<ArenaCollection>(context, listen: false)
              .fetchAndSetData();
        },
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/grass_texture1.webp'),
            fit: BoxFit.fitHeight,
          )),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                FirstPage(),
                SecondPage(),
                ThirdPage(),
                FourthPage(),
                const SizedBox(
                  width: 30,
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        elevation: 20.0,
        onPressed: () {
          Navigator.of(context).pushNamed(NewsScreen.routeName);
        },
        child: const Icon(Icons.newspaper),
      ),
      drawer: AppDrawer(),
    );
  }
}
