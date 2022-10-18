import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_mall/models/mode_item.dart';

class ItemProvider with ChangeNotifier {
  late CollectionReference itemsReference;
  List<Item> items = [];
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
    }catch(e){
      print("what!!!!!!!!!!!!$e");
    }
    notifyListeners();
  }
}
