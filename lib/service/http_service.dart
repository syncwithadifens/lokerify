import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lokerify/model/job_model/job_model.dart';

class HttpService {
  static const apiUrl = 'https://bwa-jobs.herokuapp.com';

  Future getAllJob() async {
    var response = await http.get(Uri.parse(apiUrl));
    try {
      if (response.statusCode == 200) {
        var parsedJson = json.decode(response.body);
        return JobModel.fromJson(parsedJson);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
