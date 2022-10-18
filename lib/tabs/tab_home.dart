import 'package:flutter/material.dart';
import 'package:flutter_shopping_mall/models/model_item_provider.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context);//main.dart에서 선언한 ItemProvider를 제공받아 사용

    //상품 정보를 언제 전부 가져올지 모르기 때문에 FutureBuilde를 사용
    return FutureBuilder(
      future: itemProvider.fetchItems(),//Future함수와 연결
      builder: (context, snapshot) {
        if (itemProvider.items.length == 0) {//상품정보가 아직없고 로딩중이라면
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {//상품정보를 받아오면 화면 빌드
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 1 / 1.5),
            itemCount: itemProvider.items.length,
            itemBuilder: (context, index) {
              return GridTile(
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/detail',
                        arguments: itemProvider.items[index]);
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(itemProvider.items[index].imageUrl),
                        Text(
                          itemProvider.items[index].title,
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          itemProvider.items[index].price.toString() + '원',
                          style: TextStyle(fontSize: 16, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
