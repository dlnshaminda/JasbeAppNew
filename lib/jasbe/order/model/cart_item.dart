import 'package:jasbe/jasbe/food/model/food.dart';

class CartItem<T extends Food> {
  int id;
  final T item;
  int quantity;

  CartItem({
    required this.id,
    required this.item,
    required this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json["id"],
      item: (T as Food).fromJson(json["item"]),
      quantity: json["quantity"] ?? 0,
    );
  }

  void remove() {
    if (quantity <= 0) return;
    quantity--;
  }

  void add() {
    quantity++;
  }
}
