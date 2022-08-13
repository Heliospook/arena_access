import 'package:arena_access/providers/arena_collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './single_arena.dart';

class ThirdPage extends StatelessWidget {
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
            'Badminton',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ChangeNotifierProvider.value(
          value: arenaData.arenas['bd1'],
          child: SingleArena('bd1'),
        ),
         ChangeNotifierProvider.value(
          value: arenaData.arenas['bd2'],
          child: SingleArena('bd2'),
        ),
         ChangeNotifierProvider.value(
          value: arenaData.arenas['bd3'],
          child: SingleArena('bd3'),
        ),
         ChangeNotifierProvider.value(
          value: arenaData.arenas['bdm'],
          child: SingleArena('bdm'),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
