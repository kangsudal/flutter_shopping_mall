import 'package:flutter/material.dart';
import 'package:flutter_shopping_mall/models/model_auth.dart';
import 'package:flutter_shopping_mall/models/model_cart.dart';
import 'package:provider/provider.dart';

//장바구니에 담긴 결과물
class CartTab extends StatelessWidget {
  const CartTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final authClient = Provider.of<FirebaseAuthProvider>(context);
    return FutureBuilder(
      future: cart.fetchCartItemOrAddCart(authClient.user),
      builder: (context, snapshot) {
        if (cart.cartItems.length == 0) {
          return Center(
            child: Text('장바구니가 텅비었어요'),
          );
        } else {
          return ListView.builder(
            itemCount: cart.cartItems.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Navigator.pushNamed(context, '/detail',
                      arguments: cart.cartItems[index]);
                },
                title: Text(cart.cartItems[index].title),
                subtitle: Text(cart.cartItems[index].price.toString()),
                leading: Image.network(cart.cartItems[index].imageUrl),
                trailing: InkWell(
                  onTap: () {
                    cart.removeItemFromCart(
                        authClient.user, cart.cartItems[index]);
                  },
                  child: Icon(Icons.delete),
                ),
              );
            },
          );
        }
      },
    );
  }
}
