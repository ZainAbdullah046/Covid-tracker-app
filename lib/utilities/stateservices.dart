import 'dart:convert';

import 'package:covid_tracker_app/models/worldstatesmodel.dart';
import 'package:covid_tracker_app/utilities/url.dart';
import 'package:http/http.dart' as http;

class Statesservices {
  Future<worldstatesmodel> fetchworldstatesrecord() async {
    final response = await http.get(Uri.parse(appurl.worldstates));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return worldstatesmodel.fromJson(data);
    } else {
      throw Exception("Errow");
    }
  }

  Future<List> fetchcountrystatesrecord() async {
    final response = await http.get(Uri.parse(appurl.countiestates));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception("Errow");
    }
  }
}
