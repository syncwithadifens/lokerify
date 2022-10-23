import 'package:flutter/foundation.dart';
import 'package:lokerify/model/job_model/job_model.dart';
import 'package:lokerify/service/api_repository.dart';

class JobProvider extends ChangeNotifier {
  final ApiRepository apiRepository;
  JobProvider({required this.apiRepository}) {
    getjobs();
  }
  List<JobModel> _result = [];
  List<JobModel> get result => _result;
  bool isLoading = false;
  bool isApplied = false;
  String message = 'Apply';

  Future<void> getjobs() async {
    isLoading = true;
    final response = await apiRepository.getAllJob();
    _result = response;
    isLoading = false;
    notifyListeners();
  }

  void appliedJob() {
    isApplied = !isApplied;
    isApplied ? message = 'Job already applied' : message = 'Apply';
    notifyListeners();
  }
}
