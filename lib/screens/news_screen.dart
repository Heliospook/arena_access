import 'package:arena_access/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/news_data.dart';
import '../providers/news_collection.dart';

import '../widgets/news_item.dart';
import '../screens/create_news.dart';

class NewsScreen extends StatefulWidget {
  static const routeName = '/news_screen';
  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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
