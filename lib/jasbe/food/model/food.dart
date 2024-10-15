abstract class Food {
  int id;
  String name;
  String description;
  double price;
  String? image;

  Food({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });

  T fromJson<T extends Food>(Map<String,dynamic> json);

  Map<String, dynamic> toJson();
}
