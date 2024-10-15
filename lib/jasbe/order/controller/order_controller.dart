import 'package:get/get.dart';
import 'package:jasbe/jasbe/order/model/order.dart';

final defaultOrder = Order(id: -1, orders: []);

class OrderController extends GetxController {
  static OrderController get instance {
    return Get.find<OrderController>();
  }

  final sampleSingletonOrder = Rx<Order>(defaultOrder);

  void setOrder(Order order) {
    sampleSingletonOrder(order);
  }

  void removeOrder() {
    sampleSingletonOrder(defaultOrder);
  }
}
