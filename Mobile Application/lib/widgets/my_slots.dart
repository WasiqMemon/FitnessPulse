import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<String>> storedslots() async {
  final List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  List<String> lst = [];

  var any = await SharedPreferences.getInstance();

  for (int i = 0; i < days.length; i++) {
    var result = any.getString(days[i]);
    lst.add(result as String);
  }
  return lst;
}

class MySlotsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(20),
          child: Text(
            'My Slots',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
          ),
        ),
        Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              //SlotInfo('Monday', '7:00 PM - 7:59 PM'),
              Container(
                child: FutureBuilder(
                  future: storedslots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          SlotInfo('Monday', snapshot.data![0]),
                          Spacer(),
                          SlotInfo('Tuesday', snapshot.data![1]),
                          Spacer(),
                          SlotInfo('Wednesday', snapshot.data![2]),
                          Spacer(),
                          SlotInfo('Thursday', snapshot.data![3]),
                          Spacer(),
                          SlotInfo('Friday', snapshot.data![4]),
                          Spacer(),
                          SlotInfo('Saturday', snapshot.data![5]),
                          Spacer(),
                          SlotInfo('Sunday', snapshot.data![6]),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    // By default, show a loading spinner.
                    return Center(child: const CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Row SlotInfo(String day, String slot_time) {
  int diff = day.length + slot_time.length;
  return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    Container(
      child: Text(slot_time, style: TextStyle(fontSize: 18)),
    ),
    Container(
      alignment: Alignment.centerRight,
      child: Text(day,
          style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
              fontSize: 18)),
    ),
  ]);
}

Container Spacer() {
  return Container(
    child: Column(
      children: [
        Divider(
          thickness: 2,
        ),
        Container(
          height: 20,
          color: Colors.grey[200],
        ),
        Divider(
          thickness: 2,
        ),
      ],
    ),
  );
}
