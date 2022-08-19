import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../models/news_data.dart';

class NewsCollection with ChangeNotifier {
  List<NewsData> _items = [];

  List<NewsData> get items {
    return [..._items];
  }

  Future<void> addNews(String author,String title, String content) async {
    final url = Uri.parse(
        'https://arenaaccess-cd9b4-default-rtdb.asia-southeast1.firebasedatabase.app/News.json');

    final timestamp = DateTime.now();

    try {
      final response = await http.post(url,
          body: json.encode({
            'author' : author,
            'title': title,
            'content': content,
            'timestamp': timestamp.toIso8601String(),
          }));
      final data = json.decode(response.body);
      _items.add(NewsData(data['name'],author, title, content, timestamp));
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> fetchAndSetData() async {
    final url = Uri.parse(
        'https://arenaaccess-cd9b4-default-rtdb.asia-southeast1.firebasedatabase.app/News.json');
    try {
      final response = await http.get(url);
      if (response.body == 'null') {
        _items = [];
        notifyListeners();
        return;
      }
      final data = json.decode(response.body) as Map<String, dynamic>;
      List<NewsData> updatedList = [];
      data.forEach((key, value) {
        updatedList.add(NewsData(key,value['author'], value['title'], value['content'],
            DateTime.parse(value['timestamp'])));
      });
      _items = updatedList;
      // print(_items);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
