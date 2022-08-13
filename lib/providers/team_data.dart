import 'dart:math';

import 'package:flutter/cupertino.dart';

class TeamData with ChangeNotifier {
  List<String> _playas = [];
  List<List<String>> _teams = [];
  List<List<String>> _matches = [];
  bool doneTeam = false;
  bool doneMatch = false;

  List<String> get playas {
    return [..._playas];
  }

  List<List<String>> get teams {
    return [..._teams];
  }

  List<List<String>> get matches {
    return [..._matches];
  }

  void addPlaya(String playa) {
    _playas.add(playa);
    notifyListeners();
  }

  void removePlaya(String playa) {
    _playas.remove(playa);
    notifyListeners();
  }

  void makeTeam() {
    final k = _playas.length;
    List<String> clone = [..._playas];
    List<String> madeTeam = [];
    for (int i = 0; i < k / 2; i++) {
      int ind = Random(DateTime.now().millisecond).nextInt(clone.length);
      madeTeam.add(clone[ind]);
      clone.removeAt(ind);
    }
    _teams = [madeTeam, clone];
    doneTeam = true;
    notifyListeners();
  }

  void makeMatches() {
    makeTeam();
    List<String> a = [..._teams[0]];
    List<String> b = [..._teams[1]];

    List<List<String>> ret = [];
    while (a.isNotEmpty && b.isNotEmpty) {
      ret.add([a.last, b.last]);
      a.removeLast();
      b.removeLast();
    }
    _matches = ret;
    doneMatch = true;
    notifyListeners();
  }
}
