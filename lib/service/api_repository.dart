import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lokerify/model/category_model/category_model.dart';
import 'package:lokerify/model/job_model/job_model.dart';

class ApiRepository {
  static const apiUrl = 'https://bwa-jobs.herokuapp.com';

  Future<List<JobModel>> getAllJob() async {
    var response = await http.get(Uri.parse('$apiUrl/jobs'));
    try {
      final parsedJson = json.decode(response.body) as List;
      final result = parsedJson.map((e) => JobModel.fromJson(e)).toList();
      return result;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<CategoryModel>> getAllCategory() async {
    var response = await http.get(Uri.parse('$apiUrl/categories'));
    try {
      final parsedJson = json.decode(response.body) as List;
      final result = parsedJson.map((e) => CategoryModel.fromJson(e)).toList();
      return result;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
