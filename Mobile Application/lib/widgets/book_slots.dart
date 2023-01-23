import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/slot.dart';

List<Slot> parseSlots(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Slot>((json) => Slot.fromJson(json)).toList();
}

Future<http.Response> book(String record, String sID, DateTime date,
    {String mID = '9'}) async {
  var any = await SharedPreferences.getInstance();
  if (any.containsKey("userData")) {
    var result = jsonDecode(any.getString("userData") as String);
    mID = result["MemberId"].toString();
    any.setString(DateFormat('EEEE').format(date), record);
  }
  return http.post(
    Uri.parse('https://10.0.2.2:44329/api/values'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "MemberID": mID,
      "Slotid": sID,
      "Date": DateFormat('YYYYMMDD').format(date).toString()
    }),
  );
}

Future<List<Slot>> fetchSlots({String day = 'Monday'}) async {
  print("Initiating with ${day}");
  final response = await http.get(
    Uri.parse('https://10.0.2.2:44329/api/values/GetSlots?day=${day}'),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(jsonDecode(response.body));
    return compute(parseSlots, response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print("Failed");
    throw Exception('Failed to get slots from api');
  }
}

class BookingPage extends StatefulWidget {
  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  late Future<List<Slot>> futureSlots;

  var selected_day = DateTime.now();

  @override
  void initState() {
    super.initState();
    futureSlots = fetchSlots();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 20),
            child: const Text(
              "Book Your Slots",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Text(
              "Select Day:",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.all(17),
            child: DatePicker(
              DateTime.now(),
              dayTextStyle: TextStyle(fontWeight: FontWeight.bold),
              dateTextStyle: TextStyle(fontSize: 17),
              monthTextStyle: TextStyle(fontWeight: FontWeight.bold),
              initialSelectedDate: DateTime.now(),
              selectionColor: Colors.deepPurple[300] as Color,
              selectedTextColor: Colors.white,
              daysCount: 7,
              width: 50,
              onDateChange: (date) {
                setState(() {
                  selected_day = date;
                });
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Text(
              "Choose Your Slot:",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            child: FutureBuilder(
              future: fetchSlots(day: DateFormat('EEEE').format(selected_day)),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    alignment: Alignment.center,
                    height: 490,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.deepPurple,
                          width: 4.0,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: ListView(
                      children: [
                        _createDataTable(context, snapshot.data!, selected_day)
                      ],
                    ),
                  );
                  // return Text(snapshot.data!.title);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return Center(child: const CircularProgressIndicator());
              },
            ),
          )
        ]);
  }
}

Container _createDataTable(context, slots, date) {
  return Container(
    margin: EdgeInsets.all(5),
    height: 470,
    child: DataTable(
      showCheckboxColumn: false,
      border: TableBorder(
        // borderRadius: BorderRadius.all(Radius.circular(10)),
        horizontalInside: BorderSide(color: Colors.deepPurple[300] as Color),
      ),
      columns: _createColumns(),
      rows: _createRows(context, slots, date),
    ),
  );
}

List<DataColumn> _createColumns() {
  return [
    DataColumn(
        label: Text('Start Time',
            style: TextStyle(
                fontStyle: FontStyle.italic, fontWeight: FontWeight.bold))),
    DataColumn(
        label: Text('End Time',
            style: TextStyle(
                fontStyle: FontStyle.italic, fontWeight: FontWeight.bold))),
    DataColumn(
        label: Text('Capacity',
            style: TextStyle(
                fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)))
  ];
}

List<DataRow> _createRows(context, slots, date) {
  return slots
      .map<DataRow>((slots) => DataRow(
              cells: [
                DataCell(Text(slots.start)),
                DataCell(Text(slots.end)),
                DataCell(Text((slots.cpty).toString())),
              ],
              selected: false,
              onSelectChanged: (bool? selected) {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Alert'),
                    content: const Text('Do you want to book this slot?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () async {
                          //book(slots.id, date);
                          var res = await book(slots.start + ' - ' + slots.end,
                              slots.id.toString(), date);
                          if (res.statusCode == 204) {
                            // If the server did return a 200 OK response,
                            // then parse the JSON.
                            print("Success");
                          } else {
                            // If the server did not return a 200 OK response,
                            // then throw an exception.
                            print("Failed");
                            // throw Exception(
                            //     'Failed to load credentials from api');
                          }
                          Navigator.pop(context, 'YES');
                        },
                        child: const Text('YES'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'NO'),
                        child: const Text('NO'),
                      ),
                    ],
                  ),
                );
              }))
      .toList();
}
