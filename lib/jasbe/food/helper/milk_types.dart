// ignore_for_file: constant_identifier_names

enum MilkTypes {
  almond,
  goat_milk,
  cow_milk,
  bufflo_milk,
}

extension MilkTypesExtension on MilkTypes {
  String parsed() => _snakeParser(name);
}

String _snakeParser(String name) {
  final removeDash = name.split("_").map((e) {
    String first = e.substring(0, 1);
    return first.toUpperCase() + e.substring(1, e.length);
  }).join(" ");

  return removeDash;
}
