import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping_mall/models/mode_item.dart';

//장바구니 기능을 제공하기 위한 모델로 총 4개의 함수가 선언돼있다.
class CartProvider with ChangeNotifier {
  late CollectionReference cartReference;
  List<Item> cartItems = [];

  CartProvider({reference}) {
    cartReference = reference ?? FirebaseFirestore.instance.collection('carts');
  }

  //해당 유저의 cart가 선언돼있다면 cart의 items를 가져오며, 그렇지 않다면 cart를 추가하는 함수
  Future<void> fetchCartItemOrAddCart(User? user) async {

    if (user == null) {
      print("##############호우 user없다 재로그인 해보삼");
      return;
    }
    final cartSnapshot =
        await cartReference.doc(user.uid).get(); //user.uid로 carts의 도큐먼트 검색
    if (cartSnapshot.exists) {
      //결과가 있다면
      Map<String, dynamic> cartItemsMap =
          cartSnapshot.data() as Map<String, dynamic>;
      List<Item> temp = [];
      for (var item in cartItemsMap['items']) {
        temp.add(Item.fromMap(item));
      } //해당 도큐먼트의 items를 Item 모델로 변환해 cartItems에 저장
      cartItems = temp;
      notifyListeners();
    } else {
      //결과가 없다면 새로운 도큐먼트를 user.uid로 생성
      await cartReference.doc(user.uid).set({'items': []});
      notifyListeners();
    }
  }

  //상품 추가
  Future<void> addItemToCart(User? user, Item item) async {
    cartItems.add(item); //리스트에 해당 상품을 추가한 후
    Map<String, dynamic> cartItemsMap = {
      'items': cartItems.map((item) => item.toSnapshot()).toList()
    };
    await cartReference.doc(user!.uid).set(cartItemsMap); //변경된 결과를 파이어베이스에 적용
    notifyListeners();
  }

  //상품 삭제
  Future<void> removeItemFromCart(User? user, Item item) async {
    cartItems.removeWhere((element) => element.id == item.id);
    Map<String, dynamic> cartItemsMap = {
      'items': cartItems.map((e) => e.toSnapshot()).toList()
    };
    await cartReference.doc(user!.uid).set(cartItemsMap);
    notifyListeners();
  }

  //상품이 cartItems에 존재하는지 결과를 반환하는 함수
  bool isItemInCart(Item item) {
    return cartItems.any((element) => element.id == item.id);
  }
}
