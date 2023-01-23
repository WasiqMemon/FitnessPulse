import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
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

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<Member> futureMember;

  @override
  void initState() {
    super.initState();
    //futureAlbum = fetchAlbum();
    futureMember = getMember();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<Member>(
          future: futureMember,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // return Text(snapshot.data!.name);
              return Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.all(20),
                    child: Text(
                      'My Profile',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 500,
                    padding: EdgeInsets.only(top: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          height: 200,
                          child: Icon(Icons.account_circle, size: 200),
                        ),
                        Text(
                          snapshot.data!.name,
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                        Text(
                          snapshot.data!.email,
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    height: 50,
                    child: null,
                  ),
                  Container(
                    child: Column(children: [
                      Text(
                        'Gender : ${snapshot.data!.gender}',
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'CNIC # ${snapshot.data!.cNIC}',
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 16,
                        ),
                      ),
                    ]),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
