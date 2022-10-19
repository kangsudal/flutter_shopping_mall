import 'package:flutter/material.dart';

class SearchQuery with ChangeNotifier {
  //검색어 업데이트 실시간 적용
  String text = ''; //검색어 관리

  void updateText(String newText) {
    text = newText;
    notifyListeners();
  }
}
