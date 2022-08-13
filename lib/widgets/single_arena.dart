import 'package:arena_access/providers/arena_collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/arena.dart';


class SingleArena extends StatefulWidget {
  final String id;
  SingleArena(this.id);

  @override
  State<SingleArena> createState() => _SingleArenaState();
}

class _SingleArenaState extends State<SingleArena> {
  @override
  Widget build(BuildContext context) {
    final arenaData = Provider.of<Arena>(context);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(widget.id).then((value) {
          Provider.of<ArenaCollection>(context,listen: false).fetchAndSetData();
        });
      },
      child: SizedBox(
        height: h * 0.15,
        child: Row(
          children: [
            Card(
              margin: EdgeInsets.only(left: w * 0.10),
              color: const Color.fromRGBO(0, 0, 0, 0),
              elevation: 20,
              child: Image.asset(
                arenaData.imageAdd,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            SizedBox(
              width: w * 0.5,
              child: Card(
                elevation: 20,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        arenaData.title,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 255, 242, 4),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CircleAvatar(
                              radius: 12,
                              backgroundColor:
                                  arenaData.free ? Colors.green : Colors.red,
                              child: arenaData.free
                                  ? const Icon(
                                      Icons.done,
                                      color: Colors.white,
                                    )
                                  : const Icon(
                                      Icons.error_outline,
                                      color: Colors.white,
                                    )),
                          if (!arenaData.free)
                            const SizedBox(
                              width: 10,
                            ),
                          Text(
                            arenaData.free ? ' Free' : 'Occupied',
                            softWrap: true,
                            style: TextStyle(
                              color: arenaData.free ? Colors.green : Colors.red,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (arenaData.free)
                            Expanded(
                              child: Text(
                                arenaData.free
                                    ? 'Play Now'
                                    : 'Check for future slots',
                                softWrap: true,
                                textAlign: TextAlign.end,
                              ),
                            )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
