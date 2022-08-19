import 'package:arena_access/providers/arena.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewBooking extends StatefulWidget {
  @override
  State<NewBooking> createState() => _NewBookingState();
}

class _NewBookingState extends State<NewBooking> {
  final nameCont = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();

  void presentTimePicker() {
    setState(() {
      isAvailable = false;
    });
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      if (value == null) return;
      setState(() {
        selectedTime = value;
      });
    });
  }

  var alert = false;

  void addBooking() {
    if (!isAvailable) {
      setState(() {
        alert = true;
      });
      return;
    }
    final enteredName = nameCont.text;
    if (enteredName.isEmpty) return;
    Provider.of<Arena>(context, listen: false)
        .addBooking(selectedTime, enteredName, DateTime.now());
    Navigator.of(context).pop();
  }

  bool isAvailable = false;

  @override
  Widget build(BuildContext context) {
    final localizations = MaterialLocalizations.of(context);
    return SingleChildScrollView(
      child: Card(
        elevation: 10,
        child: Container(
          padding: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(children: [
            TextField(
              controller: nameCont,
              decoration: const InputDecoration(
                labelText: 'Name',
                icon: Icon(Icons.person),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Text(
                        'Picked Time :',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        '  ${localizations.formatTimeOfDay(selectedTime).toString()}',
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  onPressed: presentTimePicker,
                  child: Text("Choose Starting Time"),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    isAvailable ? '  Available' : '  Not Available',
                    style: TextStyle(
                        color: isAvailable ? Colors.green : Colors.red,
                        fontSize: 19),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.black,
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  onPressed: () async {
                    var avl = await Provider.of<Arena>(context, listen: false)
                        .checkAvail(selectedTime);
                    setState(() {
                      isAvailable = avl;
                      if (avl) alert = false;
                      print(isAvailable);
                    });
                  },
                  child: Text("Check Availability"),
                )
              ],
            ),
            ElevatedButton(
              onPressed: addBooking,
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  textStyle: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  )),
              child: const Text('Book Now for 30 min'),
            ),
            if (alert)
              Text(
                'Choose an available slot on the same day!',
                style: TextStyle(color: Colors.red),
              )
          ]),
        ),
      ),
    );
  }
}
