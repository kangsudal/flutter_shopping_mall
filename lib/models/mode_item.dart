import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  late String title;
  late String description;
  late String brand;
  late String imageUrl;
  late int price;
  late String registerDate;
  late String id;

  Item({
    required this.title,
    required this.description,
    required this.brand,
    required this.imageUrl,
    required this.price,
    required this.registerDate,
    required this.id,
  });

  //DocumentSnapshot 형태로 받아온 상품 데이터를 Item 형태로 바꿈
  Item.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    id = snapshot.id; //자동 생성 id값은 snapshot.id로 찾을 수 있다
    title = data['title'];
    description = data['description'];
    brand = data['brand'];
    imageUrl = data['imageUrl'];
    price = data['price'];
    registerDate = data['registerDate'];
  }
}
