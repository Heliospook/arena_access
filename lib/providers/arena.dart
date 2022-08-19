// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:math';

class Booking {
  final TimeOfDay start;
  final String player;
  final DateTime day;
  Booking(this.start, this.player, this.day);
}

class Arena with ChangeNotifier {
  final String id;
  final String title;
  final String imageAdd;
  bool free = true;

  Arena({required this.id, required this.title, required this.imageAdd});

  List<Booking> _bookings = [];

  List<Booking> get bookings {
    return [..._bookings];
  }

  void setbookings(List<dynamic> e) {
    if (e == null) return;
    _bookings = e.map((data) {
      TimeOfDay start = TimeOfDay(hour: data['hour'], minute: data['minute']);
      DateTime day = data['day'] == null ? DateTime.now() : DateTime.parse(data['day']);
      return Booking(start, data['player'], day);
    }).toList();

    double now = toDouble(TimeOfDay.now());
    _bookings.removeWhere((element) {
      if (element.day.day != DateTime.now().day) return false;
      double thistime = toDouble(element.start);
      if (thistime < now - 0.5) {
        return true;
      }
      return false;
    });

    _bookings.sort(((a, b) {
      final timea = toDouble(a.start);
      final timeb = toDouble(b.start);
      return timea.compareTo(timeb);
    }));

    free = checkIsFree();

    notifyListeners();
  }

  Future<void> setFree() async {
    free = true;
    final url = Uri.parse(
        'https://arenaaccess-cd9b4-default-rtdb.asia-southeast1.firebasedatabase.app/Arenas/$id.json');
    try {
      final response = await http.put(url,
          body: json.encode({
            'free': true,
          }));
    } catch (error) {
      free = false;
      throw (error);
    }
    notifyListeners();
  }

  Future<void> setOccupied() async {
    free = false;
    final url = Uri.parse(
        'https://arenaaccess-cd9b4-default-rtdb.asia-southeast1.firebasedatabase.app/Arenas/$id.json');
    try {
      final response = await http.patch(url,
          body: json.encode({
            'free': false,
          }));
    } catch (error) {
      free = true;
      throw (error);
    }
    notifyListeners();
  }

  // Future<void> refresh() async {
  //   var currFree = free;
  //   final url = Uri.parse(
  //       'https://arenaaccess-cd9b4-default-rtdb.asia-southeast1.firebasedatabase.app/Arenas/$id.json');
  //   try {
  //     final response = await http.get(url);
  //     free = json.decode(response.body)['free'];
  //   } catch (error) {
  //     free = currFree;
  //     throw (error);
  //   }
  //   notifyListeners();
  // }

  //for debugging purposes
  // Future<void> toggleFree() {
  //   if (free)
  //     return setOccupied();
  //   else
  //     return setFree();
  // }

  double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;

  bool checkAvail(TimeOfDay time) {
    var canBook = true;
    final thisTime = toDouble(time);
    final now = toDouble(TimeOfDay.now());
    if (thisTime < now - 0.5) {
      canBook = false;
    }
    for (var element in _bookings) {
      final thatTime = toDouble(element.start);
      if ((thisTime - thatTime).abs() <= 0.5) {
        canBook = false;
      }
    }
    return canBook;
  }

  bool checkIsFree() {
    // print(TimeOfDay.now().toString());
    return checkAvail(TimeOfDay.now());
  }

  Future<void> addBooking(TimeOfDay time, String person,DateTime day) async {
    _bookings.add(Booking(time, person, day));
    final oldFree = free;
    if (oldFree && !checkIsFree()) {
      free = false;
    }
    notifyListeners();

    final url = Uri.parse(
        'https://arenaaccess-cd9b4-default-rtdb.asia-southeast1.firebasedatabase.app/Arenas/$id.json');
    try {
      final response = await http.patch(url,
          body: json.encode({
            'free': free,
            'bookings': _bookings
                .map((e) => {
                      'hour': e.start.hour,
                      'minute': e.start.minute,
                      'player': e.player,
                    })
                .toList(),
            'day' : day.toIso8601String(),
          }));
    } catch (error) {
      _bookings.removeLast();
      free = oldFree;
      notifyListeners();
      print("nhi hua booking");
      throw (error);
    }
  }
}
