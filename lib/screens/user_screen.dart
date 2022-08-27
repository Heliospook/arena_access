import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';

class UserScreen extends StatelessWidget {
  static const routeName = '/user_screen';
  @override
  Widget build(BuildContext context) {
    String? email = Provider.of<Auth>(context, listen: false).email;
    return Scaffold(
      appBar: AppBar(title: Text('Welcome')),
      body: Column(children: [
        Text(email!),
        ElevatedButton(
          onPressed: () {
            Provider.of<Auth>(context, listen: false).logout();
            Navigator.of(context).pop();
          },
          child: Text('Logout'),
        ),
      ]),
    );
  }
}
