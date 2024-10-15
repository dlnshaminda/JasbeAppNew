import 'package:jasbe/jasbe/food/helper/coffee_sizes.dart';
import 'package:jasbe/jasbe/food/helper/milk_types.dart';
import 'package:jasbe/jasbe/food/model/food.dart';

class Coffee extends Food {
  CoffeeSizes size;
  int sugarPoint;
  MilkTypes type;

  Coffee({
    required int id,
    required String name,
    required String description,
    required double price,
   
    required String? image,
    required this.size,
    required this.sugarPoint,
    required this.type,
  }) : super(id: id, name: name, description: description, price: price, image: image);
  
  @override
  T fromJson<T extends Food>(Map<String,dynamic> json) {
   
    throw UnimplementedError();
  }
  
  @override
  Map<String, dynamic> toJson() {
  
    throw UnimplementedError();
  }
}
