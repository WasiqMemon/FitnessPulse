import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/member.dart';

Future<Member> getMember() async {
  var any = await SharedPreferences.getInstance();
  if (!any.containsKey("userData")) {
    print('Failed Getter');
    throw Exception('Instance not found');
  } else {
    var result = jsonDecode(any.getString("userData") as String);
    return Member.fromJson(result);
  }
}

class MyHeaderDrawer extends StatefulWidget {
  @override
  _MyHeaderDrawerState createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  late Future<Member> futureMember;

  @override
  void initState() {
    super.initState();
    futureMember = getMember();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Member>(
      future: futureMember,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            color: Colors.white,
            width: double.infinity,
            height: 200,
            padding: EdgeInsets.only(top: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  height: 100,
                  child: Icon(Icons.account_circle, size: 90),
                ),
                Text(
                  snapshot.data!.name,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                Text(
                  snapshot.data!.email,
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Container(child: Text('${snapshot.error}'));
        }

        // By default, show a loading spinner.
        return Center(child: const CircularProgressIndicator());
      },
      //),
    );
  }
}
