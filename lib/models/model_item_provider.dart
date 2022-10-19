import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_mall/models/mode_item.dart';

class ItemProvider with ChangeNotifier {
  late CollectionReference itemsReference;
  List<Item> items = [];
  List<Item> searchItems = []; //검색 결과를 담아 놓을 리스트

  ItemProvider({reference}) {
    itemsReference = reference ??
        FirebaseFirestore.instance
            .collection('items'); //Firestore 콘솔에서 만든 items컬렉션으로 접근하기위해 객체를 만듬
  }

  Future<void> fetchItems() async {
    //FirebaseFirestore.instance.collection('items')로부터 GET 요청을 보내 결과를 받아온다.
    try {
      items = await itemsReference.get().then((QuerySnapshot results) {
        return results.docs.map((DocumentSnapshot document) {
          return Item.fromSnapshot(document); //받아온 결과를 List<Item>으로 변환
        }).toList();
      });
    } catch (e) {
      print("what!!!!!!!!!!!!$e");
    }
    notifyListeners();
  }

  //검색어를 인자로 받아 전체 items에서 제목에 검색어를 포함한 상품을 저장
  Future<void> search(String query) async {
    searchItems = []; //검색할때마다 비워서 기존 검색결과 없애기
    if (query.length == 0) {
      return;
    }
    for (Item item in items) {
      if (item.title.contains(query)) {
        searchItems.add(item);
      }
    }
    notifyListeners(); //searchItems 값이 변화한 것을 알려주며 화면에 빌드
  }
}
