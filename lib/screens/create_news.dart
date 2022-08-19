import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/news_collection.dart';

class CreateNews extends StatefulWidget {
  static const routeName = '/create_news';
  @override
  State<CreateNews> createState() => _CreateNewsState();
}

class _CreateNewsState extends State<CreateNews> {
  final authorCont = TextEditingController();
  final titleCont = TextEditingController();
  final contentCont = TextEditingController();
  bool isLoading = false;

  void saveNews() async {
    if (authorCont.text.isEmpty || titleCont.text.isEmpty || contentCont.text.isEmpty) return;
    try {
      setState(() {
        isLoading = true;
      });
      await Provider.of<NewsCollection>(context, listen: false)
          .addNews(authorCont.text,titleCont.text, contentCont.text);
      Navigator.of(context).pop();
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // print(e);
      showDialog(
        context: context,
        builder: ((ctx) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text(
                'Failed to add news.Check your network connection and try again'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text('Dismiss'),
              ),
            ],
          );
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add News'),
        actions: [
          IconButton(
            onPressed: saveNews,
            icon: const Icon(Icons.save),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: saveNews,
        child: const Icon(Icons.save),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      TextField(
                        controller: authorCont,
                        decoration: const InputDecoration(labelText: 'Author'),
                      ),
                      TextField(
                        controller: titleCont,
                        decoration: const InputDecoration(labelText: 'Heading'),
                      ),
                      TextField(
                        controller: contentCont,
                        decoration: const InputDecoration(labelText: 'Content'),
                        maxLines: 6,
                      ),
                    ],
                  )),
            ),
    );
  }
}
