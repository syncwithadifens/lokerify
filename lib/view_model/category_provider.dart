import 'package:flutter/foundation.dart';
import 'package:lokerify/model/category_model/category_model.dart';
import 'package:lokerify/service/api_repository.dart';

class CategoryProvider extends ChangeNotifier {
  final ApiRepository apiRepository;
  CategoryProvider({required this.apiRepository}) {
    getCategories();
  }
  List<CategoryModel> _result = [];
  List<CategoryModel> get result => _result;
  bool isLoading = false;
  bool success = false;

  Future<void> getCategories() async {
    try {
      isLoading = true;
      final response = await apiRepository.getAllCategory();
      _result = response;
      success = true;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      success = false;
      isLoading = false;
      notifyListeners();
    }
  }
}
