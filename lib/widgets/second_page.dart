import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './single_arena.dart';
import '../providers/arena_collection.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final arenaData = Provider.of<ArenaCollection>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black38,
          ),
          padding: const EdgeInsets.all(20),
          child: const Text(
            'Basketball',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
         ChangeNotifierProvider.value(
          value: arenaData.arenas['bas'],
          child: SingleArena('bas'),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black38,
          ),
          padding: const EdgeInsets.all(20),
          child: const Text(
            'Tennis/Volleyball',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
         ChangeNotifierProvider.value(
          value: arenaData.arenas['ten'],
          child: SingleArena('ten'),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
