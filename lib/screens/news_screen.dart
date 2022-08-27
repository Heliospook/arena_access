import 'package:arena_access/screens/login_screen.dart';
import 'package:arena_access/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/news_data.dart';
import '../providers/news_collection.dart';
import '../providers/auth.dart';

import '../widgets/news_item.dart';
import '../screens/create_news.dart';

import 'dart:math';

import 'user_screen.dart';

class NewsScreen extends StatefulWidget {
  static const routeName = '/news_screen';
  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
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
    final newsData = Provider.of<NewsCollection>(context);
    newsData.fetchAndSetData();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Text('News'),
            SizedBox(
              width: 10,
            ),
            Icon(Icons.newspaper),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bool auth = Provider.of<Auth>(context, listen: false).isAuth;
          if (!auth) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Authentication required to add announcement')));
            return;
          }
          Navigator.of(context).pushNamed(CreateNews.routeName);
        },
        child: const Icon(Icons.add),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/grass_texture1.webp'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [...newsData.items.map((e) => NewsItem(e)).toList()],
            ),
          ),
        ),
      ),
    );
  }
}
