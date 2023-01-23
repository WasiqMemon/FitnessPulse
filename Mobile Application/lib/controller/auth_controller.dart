import 'dart:convert';
import 'dart:async';

import '../widgets/login.dart';
import '../widgets/dashboard.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchMember(email, password) async {
  print("Initiating with ${email} and ${password}");
  final response = await http.get(
    Uri.parse(
        'https://10.0.2.2:44329/api/values/Get?email=${email}&password=${password}'),
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return json.decode(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print("Failed");
    throw Exception('Failed to load credentials from api');
  }
}

class AuthController {
  static login(Map userData) async {
    print(userData);

    Map<String, dynamic> result =
        await fetchMember(userData["email"], userData["password"]);
    print(result);

    if (result['Name'] != null) {
      var any = await SharedPreferences.getInstance();

      any.setString("userData", json.encode(result));
      any.setString('Monday', 'Empty Slot');
      any.setString('Tuesday', 'Empty Slot');
      any.setString('Wednesday', 'Empty Slot');
      any.setString('Thursday', 'Empty Slot');
      any.setString('Friday', 'Empty Slot');
      any.setString('Saturday', 'Empty Slot');
      any.setString('Sunday', 'Empty Slot');
      Get.off(() => Dashboard());
    }
  }

  Future<bool> tryAutoLogin() async {
    var any = await SharedPreferences.getInstance();
    if (!any.containsKey("userData")) {
      return false;
    } else {
      return true;
    }
  }

  static logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Get.off(() => LoginScreen2());
  }
}
