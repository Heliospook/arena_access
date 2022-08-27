// ignore_for_file: unnecessary_const, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:arena_access/screens/login_screen.dart';
import 'package:arena_access/widgets/app_drawer.dart';
import 'package:arena_access/widgets/arena_status.dart';
import 'package:arena_access/widgets/make_team.dart';
import '../widgets/new_booking.dart';
import '../providers/auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/arena.dart';
import 'user_screen.dart';

class ArenaDetailScreen extends StatefulWidget {
  @override
  State<ArenaDetailScreen> createState() => _ArenaDetailScreenState();
}

class _ArenaDetailScreenState extends State<ArenaDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  var _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    _controller.addListener(() {
      if (!_controller.indexIsChanging) {
        setState(() {
          _selectedIndex = _controller.index;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void handle_logout() {
    showDialog(
        context: context,
        builder: (bctx) {
          return AlertDialog(
            title: const Text('Confirm Logout'),
            content: const Text('Are you sure you wish to logout?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Provider.of<Auth>(context, listen: false).logout();
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final arena = Provider.of<Arena>(context);
    var dowemaketeams = false;
    if (['foo', 'bas'].contains(arena.id)) dowemaketeams = true;
    bool isAuth = Provider.of<Auth>(context).isAuth;
    final actionButtons = [
      FloatingActionButton(
        onPressed: () {
          bool auth = Provider.of<Auth>(context, listen: false).isAuth;
          if (!auth) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Authentication required to add booking')));
            return;
          }
          showModalBottomSheet(
              context: context,
              builder: (bctx) {
                return ChangeNotifierProvider.value(
                    value: Provider.of<Arena>(context), child: NewBooking());
              });
        },
        child: Icon(Icons.add),
      ),
      FloatingActionButton(
        tooltip: 'Make Teams',
        onPressed: () {},
        child: Icon(
          Icons.group,
        ),
      ),
    ];

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              title: Row(
                children: [
                  Text(arena.title),
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    'assets/images/multi_sport_logo.png',
                    height: 40,
                    width: 40,
                  ),
                ],
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    if (isAuth) {
                      handle_logout();
                    } else {
                      Navigator.of(context).pushNamed(LoginScreen.routeName);
                    }
                  },
                  icon: Icon(
                    isAuth ? Icons.logout : Icons.login,
                  ),
                ),
              ],
              bottom: TabBar(
                controller: _controller,
                tabs: [
                  Tab(
                    icon: Icon(Icons.schedule),
                    text: 'Schedule',
                  ),
                  Tab(
                    icon: Icon(Icons.group),
                    text: 'Make teams',
                  ),
                ],
              )),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/grass_texture1.webp'),
                  fit: BoxFit.fill),
            ),
            child: TabBarView(controller: _controller, children: [
              ArenaStatus(),
              MakeTeam(dowemaketeams),
            ]),
          ),
          drawer: AppDrawer(),
          floatingActionButton: _selectedIndex == 0 ? actionButtons[0] : null,
        ));
  }
}
