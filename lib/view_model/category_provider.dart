import 'package:flutter/foundation.dart';
import 'package:lokerify/model/category_model/category_model.dart';
import 'package:lokerify/service/api_repository.dart';

class CategoryProvider extends ChangeNotifier {
  final apiRepository = ApiRepository();
  List<CategoryModel> _result = [];
  List<CategoryModel> get result => _result;
  bool isLoading = false;

  Future<void> getCategories() async {
    isLoading = true;
    final response = await apiRepository.getAllCategory();
    _result = response;
    isLoading = false;
    notifyListeners();
  }
}
