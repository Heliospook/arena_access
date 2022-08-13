import 'package:arena_access/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/first_page.dart';
import '../widgets/second_page.dart';
import '../widgets/third_page.dart';
import '../widgets/fourth_page.dart';

import '../providers/arena_collection.dart';

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

  @override
  Widget build(BuildContext context) {
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
          IconButton(onPressed: () {}, icon: const Icon(Icons.login)),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: (){
          return Provider.of<ArenaCollection>(context,listen: false).fetchAndSetData();
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
        onPressed: () {},
        child: const Icon(Icons.newspaper),
      ),
      drawer: AppDrawer(),
    );
  }
}
