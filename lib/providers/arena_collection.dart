import 'package:flutter/material.dart';
import './arena.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ArenaCollection with ChangeNotifier {
  // final String authToken;
  // ArenaCollection(this.authToken);

  final Map<String, Arena> _arenas = {
    'tt1': Arena(
      id: 'tt1',
      title: 'Table 1',
      imageAdd: 'assets/images/tt_table.jpg',
    ),
    'tt2': Arena(
      id: 'tt2',
      title: 'Table 2',
      imageAdd: 'assets/images/tt_table.jpg',
    ),
    'ttm': Arena(
      id: 'ttm',
      title: 'MPH Table',
      imageAdd: 'assets/images/tt_table.jpg',
    ),
    'bas': Arena(
      id: 'bas',
      title: 'Bskt. Court',
      imageAdd: 'assets/images/basketball_court.jpg',
    ),
    'bd1': Arena(
      id: 'bd1',
      title: 'Court 1',
      imageAdd: 'assets/images/tennis_court.jpg',
    ),
    'bd2': Arena(
      id: 'bd2',
      title: 'Court 2',
      imageAdd: 'assets/images/tennis_court.jpg',
    ),
    'bd3': Arena(
      id: 'bd3',
      title: 'Court 3',
      imageAdd: 'assets/images/tennis_court.jpg',
    ),
    'bdm': Arena(
      id: 'bdm',
      title: 'MPH Court',
      imageAdd: 'assets/images/tennis_court.jpg',
    ),
    'foo': Arena(
      id: 'foo',
      title: 'Ground',
      imageAdd: 'assets/images/football_ground.jpg',
    ),
    'ten': Arena(
      id: 'ten',
      title: 'Ten. Court',
      imageAdd: 'assets/images/tennis_court.jpg',
    ),
  };

  Map<String, Arena> get arenas {
    return {..._arenas};
  }

  Future<void> fetchAndSetData() async {
    final url = Uri.parse(
        'https://arenaaccess-cd9b4-default-rtdb.asia-southeast1.firebasedatabase.app/Arenas.json');
    final response = await http.get(url);
    final extractedData = json.decode(response.body);
    _arenas.forEach((key, value) {
      if (extractedData[key]['bookings'] != null) {
        _arenas[key]?.setbookings(extractedData[key]['bookings']);
      }
    });
    print('local persistence');
    notifyListeners();

    _arenas.forEach(((key, value) {
      final url = Uri.parse(
          'https://arenaaccess-cd9b4-default-rtdb.asia-southeast1.firebasedatabase.app/Arenas/${value.id}.json');
      http.patch(url,
          body: json.encode({
            'free': value.free,
            'bookings': value.bookings
                .map((e) => {
                      'hour': e.start.hour,
                      'minute': e.start.minute,
                      'player': e.player,
                    })
                .toList(),
          }));
    }));
    print('full persistence');
  }

  //only for creating the model.. not required hence
  void addtoDatabase() {
    _arenas.forEach((key, value) async {
      final url = Uri.parse(
          'https://arenaaccess-cd9b4-default-rtdb.asia-southeast1.firebasedatabase.app/Arenas/$key.json');
      final response = await http.put(url,
          body: json.encode({
            'id': value.id,
            'title': value.title,
            'free': value.free,
          }));
      print(json.decode(response.body));
    });
  }
}
