import 'package:arena_access/providers/auth.dart';
import 'package:arena_access/providers/news_collection.dart';
import 'package:arena_access/providers/team_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'screens/sports_display_screen.dart';
import 'screens/arena_details_screen.dart';
import 'screens/news_screen.dart';
import 'screens/create_news.dart';
import 'screens/login_screen.dart';
import 'screens/user_screen.dart';

import './providers/arena_collection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final arenaCollection = ArenaCollection();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider(create: (ctc) {
          return arenaCollection;
        }),
        ChangeNotifierProvider(create: (ctx) {
          return TeamData();
        }),
        ChangeNotifierProvider(create: (ctx) {
          return NewsCollection();
        }),
      ],
      child: MaterialApp(
        title: 'Arena Access',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.yellow,
            accentColor: Colors.black,
            fontFamily: 'Quicksand',
            textTheme: const TextTheme(
                headline6: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ))),
        home: SportsDisplay(),
        routes: {
          NewsScreen.routeName: (context) => NewsScreen(),
          CreateNews.routeName: ((context) => CreateNews()),
          SportsDisplay.routeName: (context) => SportsDisplay(),
          UserScreen.routeName : (context)=> UserScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
          'tt1': (context) => ChangeNotifierProvider.value(
                value: arenaCollection.arenas['tt1'],
                child: ArenaDetailScreen(),
              ),
          'tt1': (context) => ChangeNotifierProvider.value(
                value: arenaCollection.arenas['tt1'],
                child: ArenaDetailScreen(),
              ),
          'tt2': (context) => ChangeNotifierProvider.value(
                value: arenaCollection.arenas['tt2'],
                child: ArenaDetailScreen(),
              ),
          'ttm': (context) => ChangeNotifierProvider.value(
                value: arenaCollection.arenas['ttm'],
                child: ArenaDetailScreen(),
              ),
          'ten': (context) => ChangeNotifierProvider.value(
                value: arenaCollection.arenas['ten'],
                child: ArenaDetailScreen(),
              ),
          'bas': (context) => ChangeNotifierProvider.value(
                value: arenaCollection.arenas['bas'],
                child: ArenaDetailScreen(),
              ),
          'foo': (context) => ChangeNotifierProvider.value(
                value: arenaCollection.arenas['foo'],
                child: ArenaDetailScreen(),
              ),
          'bd1': (context) => ChangeNotifierProvider.value(
                value: arenaCollection.arenas['bd1'],
                child: ArenaDetailScreen(),
              ),
          'bd2': (context) => ChangeNotifierProvider.value(
                value: arenaCollection.arenas['bd2'],
                child: ArenaDetailScreen(),
              ),
          'bd3': (context) => ChangeNotifierProvider.value(
                value: arenaCollection.arenas['bd3'],
                child: ArenaDetailScreen(),
              ),
          'bdm': (context) => ChangeNotifierProvider.value(
                value: arenaCollection.arenas['bdm'],
                child: ArenaDetailScreen(),
              ),
        },
      ),
    );
  }
}
