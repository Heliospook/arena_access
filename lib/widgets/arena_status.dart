import 'package:arena_access/providers/arena_collection.dart';
import 'package:arena_access/widgets/schedule.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/arena.dart';

class ArenaStatus extends StatefulWidget {
  @override
  State<ArenaStatus> createState() => _ArenaStatusState();
}

class _ArenaStatusState extends State<ArenaStatus> {
  var isLoading = false;

  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    final arenacoll = Provider.of<ArenaCollection>(context, listen: false);
    arenacoll.fetchAndSetData().then((value) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    final arena = Provider.of<Arena>(context);
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              width: 0.9 * w,
              child: Card(
                elevation: 10,
                color: (arena.free) ? Colors.green : Colors.red,
                child: Column(children: [
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(20),
                    child: Text(
                      (arena.free) ? 'Free' : 'Occupied',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(15),
                    child: Text(
                      (arena.free)
                          ? 'Hurry and reserve your spot now!'
                          : 'Sorry please look into another time',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                      ),
                      textAlign: TextAlign.end,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ]),
              ),
            ),
            Schedule(arena.bookings),
          ],
        );
  }
}
