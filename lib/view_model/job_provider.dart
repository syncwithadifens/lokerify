import 'package:flutter/foundation.dart';
import 'package:lokerify/model/job_model/job_model.dart';
import 'package:lokerify/service/api_repository.dart';

class JobProvider extends ChangeNotifier {
  final apiRepository = ApiRepository();
  List<JobModel> _result = [];
  List<JobModel> get result => _result;
  bool isLoading = false;

  Future<void> getjobs() async {
    isLoading = true;
    notifyListeners();

    final response = await apiRepository.getAllJob();
    _result = response;
    isLoading = false;
    notifyListeners();
  }
}
