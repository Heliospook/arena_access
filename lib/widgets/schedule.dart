import 'package:arena_access/providers/arena.dart';
import 'package:flutter/material.dart';

class Schedule extends StatelessWidget {
  final List<Booking> bookings;
  Schedule(this.bookings);

  @override
  Widget build(BuildContext context) {
    final localizations = MaterialLocalizations.of(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            width: double.infinity,
            child: const Text(
              '  Bookings  ',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 24,color : Colors.black,fontWeight: FontWeight.bold,),
              
            ),
          ),
          ...bookings.map((e) {
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              elevation: 10,
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Text(
                    localizations.formatTimeOfDay(e.start),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(
                  e.player,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            );
          }).toList()
        ],
      ),
    );
  }
}
