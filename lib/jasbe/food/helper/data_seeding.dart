import 'package:flutter/foundation.dart';
import 'package:jasbe/common/images.dart';
import 'package:jasbe/jasbe/food/helper/coffee_sizes.dart';
import 'package:jasbe/jasbe/food/helper/milk_types.dart';
import 'package:jasbe/jasbe/food/model/category.dart';
import 'package:jasbe/jasbe/food/model/coffee.dart';

List<Coffee> sampleCoffees = [
  Coffee(
    id: 1,
    name: "Espresso",
    description: "A small, strong shot of coffee that is made by forcing hot water through finely ground coffee beans",
    price: 1.5,
    image: "https://cdn.shopify.com/s/files/1/0020/3859/5683/articles/758214849ae27a07c55af11f0f0f633b_2048x2048.jpg?v=1623281348",
    size: CoffeeSizes.SMALL,
    sugarPoint: 1,
    type: MilkTypes.cow_milk,
  ),
  Coffee(
    id: 2,
    name: "Latte",
    description: "A popular coffee drink made with espresso and steamed milk, often topped with foam and flavored syrups",
    price: 3.5,
    image: "https://www.nescafe.com/mena/sites/default/files/desk.jpg",
    size: CoffeeSizes.SHORT,
    sugarPoint: 1,
    type: MilkTypes.cow_milk,
  ),
  Coffee(
    id: 3,
    name: "Cappuccino",
    description: "Similar to a latte, but with more foam and less milk",
    price: 3.0,
    image:
        "https://dairyfarmersofcanada.ca/sites/default/files/styles/recipe_image/public/image_file_browser/conso_recipe/2022/Capuccino.jpg.jpeg?itok=J1pWPwe2",
    size: CoffeeSizes.MED,
    sugarPoint: 1,
    type: MilkTypes.cow_milk,
  ),
];

List<Coffee> sampleCoffeesTwo = [
  Coffee(
    id: 1,
    name: "Peppermint Mocha",
    description: "A small, strong shot of coffee that is made by forcing hot water through finely ground coffee beans",
    price: 1.5,
    image: JasbeAssets().expressoIceCoffee,
    size: CoffeeSizes.LARGE,
    sugarPoint: 1,
    type: MilkTypes.cow_milk,
  ),
  Coffee(
    id: 2,
    name: "Caramel Macchisto",
    description: "A popular coffee drink made with espresso and steamed milk, often topped with foam and flavored syrups",
    price: 3.5,
    image: JasbeAssets().americanoCoffee,
    size: CoffeeSizes.TALL,
    sugarPoint: 1,
    type: MilkTypes.cow_milk,
  ),
  Coffee(
    id: 3,
    name: "Americano Maxico",
    description: "Similar to a latte, but with more foam and less milk",
    price: 3.0,
    image: JasbeAssets().americanoHotMediumCoffee,
    size: CoffeeSizes.SHORT,
    sugarPoint: 1,
    type: MilkTypes.cow_milk,
  ),
  Coffee(
    id: 4,
    name: "Americano Hot",
    description: "Similar to a latte, but with more foam and less milk",
    price: 4.0,
    image: JasbeAssets().americanohoteCoffee,
    size: CoffeeSizes.LARGE,
    sugarPoint: 1,
    type: MilkTypes.cow_milk,
  ),
];

List<FoodCategory> sampleCategories = [
  FoodCategory(1, "Coffee"),
  FoodCategory(2, "Drinks"),
  FoodCategory(3, "Food"),
  FoodCategory(4, "Snack"),
  FoodCategory(4, "Activity One"),
  FoodCategory(4, "Two"),
  FoodCategory(4, "Three"),
];
