// ignore_for_file: prefer_const_constructors

import 'package:arena_access/providers/team_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MakeTeam extends StatefulWidget {
  final bool teamMethod;
  MakeTeam(this.teamMethod);

  @override
  State<MakeTeam> createState() => _MakeTeamState();
}

class _MakeTeamState extends State<MakeTeam> {
  final cont = TextEditingController();
  var showPlayas = false;
  @override
  Widget build(BuildContext context) {
    final team = Provider.of<TeamData>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Card(
              margin: const EdgeInsets.all(15),
              elevation: 10,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: const Text(
                          "Players",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              showPlayas = !showPlayas;
                            });
                          },
                          icon: Icon(showPlayas
                              ? Icons.expand_less
                              : Icons.expand_more))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (showPlayas)
                    Column(
                      children: [
                        ...team.playas.map((e) {
                          return Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                            child: Card(
                              elevation: 6,
                              color: Theme.of(context).primaryColor,
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        e,
                                        style: TextStyle(fontSize: 18),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        team.removePlaya(e);
                                      },
                                      icon: Icon(Icons.delete),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 20, top: 8, bottom: 8),
                                child: TextField(
                                  controller: cont,
                                  decoration:
                                      InputDecoration(hintText: 'New Player'),
                                  onSubmitted: (value) {
                                    if (cont.text.isEmpty) return;
                                    team.addPlaya(cont.text);
                                    cont.clear();
                                  },
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add_box),
                              onPressed: () {
                                if (cont.text.isEmpty) return;
                                team.addPlaya(cont.text);
                                cont.clear();
                              },
                              iconSize: 30,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              widget.teamMethod ? team.makeTeam() : team.makeMatches();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.teamMethod ? 'Make Teams' : 'Make Matches',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          if (widget.teamMethod ? team.doneTeam : team.doneMatch)
            widget.teamMethod
                ? Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TeamView(team.teams[0], Colors.red, 'Red Team'),
                        TeamView(team.teams[1], Colors.blue, 'Blue Team'),
                      ],
                    ),
                  )
                : MatchView(team.matches),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
}

class TeamView extends StatelessWidget {
  TeamView(this.team, this.color, this.teamName);
  final List<String> team;
  final Color color;
  final String teamName;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: color,
        margin: EdgeInsets.symmetric(horizontal: 10),
        elevation: 10,
        child: Column(
          children: [
            SizedBox(
              height: 12,
            ),
            Text(
              teamName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              softWrap: true,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Divider(
                color: Colors.white,
                thickness: 1,
              ),
            ),
            ...team
                .map((e) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        e,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        softWrap: true,
                        textAlign: TextAlign.center,
                      ),
                    ))
                .toList(),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}

class MatchView extends StatelessWidget {
  final List<List<String>> matches;
  MatchView(this.matches);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
              child: Text(
            '  Fixtures',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          )),
        SizedBox(
          height: 10,
        ),
        ...matches.map((e) {
          final String a = e[0], b = e[1];
          return Card(
            elevation: 6,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Row(
                  children: [
                    Expanded(child: Text(a,textAlign: TextAlign.center,softWrap: true,style: TextStyle(fontSize: 20),)),
                    CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Text('vs'),
                      foregroundColor: Colors.black,
                    ),
                    Expanded(child: Text(b,textAlign: TextAlign.center,softWrap: true,style: TextStyle(fontSize: 20),)),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}
