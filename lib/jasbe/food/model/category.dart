class FoodCategory {
  int id;
  String name;

  FoodCategory(this.id, this.name);

  factory FoodCategory.fromJson(Map<String, dynamic> json) {
    return FoodCategory(json["id"], json["name"] ?? "General");
  }
}
