import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../models/news_data.dart';

class NewsItem extends StatelessWidget {
  final NewsData news;
  NewsItem(this.news);

  @override
  Widget build(BuildContext context) {
    return Card(
      // color: Theme.of(context).primaryColor,
      elevation: 6,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 15,right: 15,left: 15),
            child: Text(
              news.title,
              softWrap: true,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 15,right: 15,left: 15),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    news.author,
                    softWrap: true,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ),
                Expanded(
                  child: Text(
                    DateFormat('MMMM dd, HH:mm').format(
                      news.timestamp,
                    ),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(bottom: 20, right: 15, left: 15),
            child: Text(
              news.content,
              softWrap: true,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 17),
            ),
          )
        ],
      ),
    );
  }
}
