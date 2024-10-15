import 'package:jasbe/jasbe/order/model/cart_item.dart';

class Order {
  int id;
  List<CartItem> orders;
  

  Order({
    required this.id,
    required this.orders,
  });
}
