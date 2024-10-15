// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:get/get.dart';
import 'package:jasbe/jasbe/order/model/cart_item.dart';
import 'package:jasbe/jasbe/order/model/venue.dart';

class CartController extends GetxController {
  static CartController get instance {
    return Get.find<CartController>();
  }

  RxList<CartItem> items = RxList();
  Rx<Venue> currentVenue = const Venue(
    name: "",
    detail: "",
    peroid: "",
    location: "",
    address: "",
    phone: "",
  ).obs;

  void setVenue(Venue venue) {
    currentVenue(venue);
  }

  double getAllTotal(List<CartItem> data) {
    double total = 0;
    items.forEach((element) {
      total += element.item.price * element.quantity;
    });
    
    return total;
  }

  void addItem(CartItem item) {
    final matched = items.firstWhereOrNull((element) => element.item.id == item.item.id);
    if (matched == null) {
      items.add(item);
      return;
    }
    matched.add();
  }

  void remove(CartItem item) {
    final matched = items.firstWhereOrNull((element) => element.item.id == item.item.id);
    if (matched == null) return;

    if (matched.quantity <= 0) {
      items.removeWhere((element) => element.id == item.id);
      return;
    }

    matched.remove();
  }

  void forceDelete(CartItem item) {
    items.removeWhere((element) => element.id == item.id);
  }

  void clear() {
    items.clear();
  }
}
